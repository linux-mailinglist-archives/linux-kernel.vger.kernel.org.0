Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91AD175A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 13:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCBMVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 07:21:39 -0500
Received: from foss.arm.com ([217.140.110.172]:60156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgCBMVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:21:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C29C82F;
        Mon,  2 Mar 2020 04:21:38 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C34393F534;
        Mon,  2 Mar 2020 04:21:37 -0800 (PST)
Date:   Mon, 2 Mar 2020 12:21:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        shan.gavin@gmail.com
Subject: Re: [PATCH] arm64/kernel: Simplify __cpu_up() by bailing out early
Message-ID: <20200302122135.GB56497@lakrids.cambridge.arm.com>
References: <20200302020340.119588-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302020340.119588-1-gshan@redhat.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 01:03:40PM +1100, Gavin Shan wrote:
> The function __cpu_up() is invoked to bring up the target CPU through
> the backend, PSCI for example. The nested if statements won't be needed
> if we bail out early on the following two conditions where the status
> won't be checked. The code looks simplified in that case.
> 
>    * Error returned from the backend (e.g. PSCI)
>    * The target CPU has been marked as onlined
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

FWIW, this looks like a nice cleanup to me:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

While this patch leaves secondary_data.{task,stack} stale on a
successful onlining, that was already the case for a timeout, and should
be fine (since the next attempt at onlining will configure those before
poking the CPU).

Thanks,
Mark.

> ---
>  arch/arm64/kernel/smp.c | 79 +++++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d4ed9a19d8fe..2a9d8f39dc58 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -115,60 +115,55 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  	update_cpu_boot_status(CPU_MMU_OFF);
>  	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
>  
> -	/*
> -	 * Now bring the CPU into our world.
> -	 */
> +	/* Now bring the CPU into our world */
>  	ret = boot_secondary(cpu, idle);
> -	if (ret == 0) {
> -		/*
> -		 * CPU was successfully started, wait for it to come online or
> -		 * time out.
> -		 */
> -		wait_for_completion_timeout(&cpu_running,
> -					    msecs_to_jiffies(5000));
> -
> -		if (!cpu_online(cpu)) {
> -			pr_crit("CPU%u: failed to come online\n", cpu);
> -			ret = -EIO;
> -		}
> -	} else {
> +	if (ret) {
>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  		return ret;
>  	}
>  
> +	/*
> +	 * CPU was successfully started, wait for it to come online or
> +	 * time out.
> +	 */
> +	wait_for_completion_timeout(&cpu_running,
> +				    msecs_to_jiffies(5000));
> +	if (cpu_online(cpu))
> +		return 0;
> +
> +	pr_crit("CPU%u: failed to come online\n", cpu);
>  	secondary_data.task = NULL;
>  	secondary_data.stack = NULL;
>  	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
>  	status = READ_ONCE(secondary_data.status);
> -	if (ret && status) {
> -
> -		if (status == CPU_MMU_OFF)
> -			status = READ_ONCE(__early_cpu_boot_status);
> +	if (status == CPU_MMU_OFF)
> +		status = READ_ONCE(__early_cpu_boot_status);
>  
> -		switch (status & CPU_BOOT_STATUS_MASK) {
> -		default:
> -			pr_err("CPU%u: failed in unknown state : 0x%lx\n",
> -					cpu, status);
> -			cpus_stuck_in_kernel++;
> -			break;
> -		case CPU_KILL_ME:
> -			if (!op_cpu_kill(cpu)) {
> -				pr_crit("CPU%u: died during early boot\n", cpu);
> -				break;
> -			}
> -			pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
> -			/* Fall through */
> -		case CPU_STUCK_IN_KERNEL:
> -			pr_crit("CPU%u: is stuck in kernel\n", cpu);
> -			if (status & CPU_STUCK_REASON_52_BIT_VA)
> -				pr_crit("CPU%u: does not support 52-bit VAs\n", cpu);
> -			if (status & CPU_STUCK_REASON_NO_GRAN)
> -				pr_crit("CPU%u: does not support %luK granule \n", cpu, PAGE_SIZE / SZ_1K);
> -			cpus_stuck_in_kernel++;
> +	switch (status & CPU_BOOT_STATUS_MASK) {
> +	default:
> +		pr_err("CPU%u: failed in unknown state : 0x%lx\n",
> +		       cpu, status);
> +		cpus_stuck_in_kernel++;
> +		break;
> +	case CPU_KILL_ME:
> +		if (!op_cpu_kill(cpu)) {
> +			pr_crit("CPU%u: died during early boot\n", cpu);
>  			break;
> -		case CPU_PANIC_KERNEL:
> -			panic("CPU%u detected unsupported configuration\n", cpu);
>  		}
> +		pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
> +		/* Fall through */
> +	case CPU_STUCK_IN_KERNEL:
> +		pr_crit("CPU%u: is stuck in kernel\n", cpu);
> +		if (status & CPU_STUCK_REASON_52_BIT_VA)
> +			pr_crit("CPU%u: does not support 52-bit VAs\n", cpu);
> +		if (status & CPU_STUCK_REASON_NO_GRAN) {
> +			pr_crit("CPU%u: does not support %luK granule\n",
> +				cpu, PAGE_SIZE / SZ_1K);
> +		}
> +		cpus_stuck_in_kernel++;
> +		break;
> +	case CPU_PANIC_KERNEL:
> +		panic("CPU%u detected unsupported configuration\n", cpu);
>  	}
>  
>  	return ret;
> -- 
> 2.23.0
> 
