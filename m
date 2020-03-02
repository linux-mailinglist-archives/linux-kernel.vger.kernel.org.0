Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED99175C8D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 15:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCBOGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 09:06:44 -0500
Received: from foss.arm.com ([217.140.110.172]:33164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgCBOGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:06:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF8BE2F;
        Mon,  2 Mar 2020 06:06:43 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEEDF3F534;
        Mon,  2 Mar 2020 06:06:42 -0800 (PST)
Date:   Mon, 2 Mar 2020 14:06:40 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        shan.gavin@gmail.com
Subject: Re: [PATCH] arm64/kernel: Simplify __cpu_up() by bailing out early
Message-ID: <20200302140640.GC56497@lakrids.cambridge.arm.com>
References: <20200302020340.119588-1-gshan@redhat.com>
 <20200302122135.GB56497@lakrids.cambridge.arm.com>
 <ddbb5cb2-e8b6-ab1c-d283-fb0f402d2a4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddbb5cb2-e8b6-ab1c-d283-fb0f402d2a4f@redhat.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:38:48AM +1100, Gavin Shan wrote:
> On 3/2/20 11:21 PM, Mark Rutland wrote:
> > On Mon, Mar 02, 2020 at 01:03:40PM +1100, Gavin Shan wrote:
> > > The function __cpu_up() is invoked to bring up the target CPU through
> > > the backend, PSCI for example. The nested if statements won't be needed
> > > if we bail out early on the following two conditions where the status
> > > won't be checked. The code looks simplified in that case.
> > > 
> > >     * Error returned from the backend (e.g. PSCI)
> > >     * The target CPU has been marked as onlined
> > > 
> > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > 
> > FWIW, this looks like a nice cleanup to me:
> > 
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > While this patch leaves secondary_data.{task,stack} stale on a
> > successful onlining, that was already the case for a timeout, and should
> > be fine (since the next attempt at onlining will configure those before
> > poking the CPU).
> > 
> > Thanks,
> > Mark.
> > 
> 
> Thanks, Mark. Yeah, it should be fine as you said. There are something else,
> which might be not relevant. @secondary_data could be accessed by multiple CPUs
> in parallel. For example, the master CPU boots CPU#1 and timeouts to wait it
> to be online in 5 seconds. CPU#1 isn't necessarily stuck in somewhere. After
> that, CPU#2 is brought up and might be accessing @secondary_data. At this point,
> CPU#1 can come back to access it either. However, @secondary_data isn't valid
> for CPU#1 anymore.

Sure; I'm aware of improvements that could be made here, but I don't
think they need to block this patch.

> I was thinking of something to improve the situation, but not sure if it makes
> any sense to do so. There are several options: (1) Make @secondary_data per-cpu
> variable, which looks a nature way to go. (2) To shutdown the CPU on timeout.
> The shutdown request can be failed to be served in theory, but it seems still
> an improvement.

I think #2 is a bad idea, since if the CPU gets into the kernel at all,
it may have done stuff (e.g. acquiring locks), and ripping it out is
liable to cause more problems.

I think doing #1 might be nice, but some caveats apply.

I'd like to clean up the secondary stack/task hand-over to use an atomic
cmpxchg pair, so that we can detect when the secondary has possibly
tried to use the stack/task. That requires splitting that from the
MMU-off bits from the MMU-on bits, and I'm not sure how well that
interacts with #1. It might mean that the per-cpu part isn't that
worthwhile.

Thanks,
Mark.

> 
> Thanks,
> Gavin
> 
> > > ---
> > >   arch/arm64/kernel/smp.c | 79 +++++++++++++++++++----------------------
> > >   1 file changed, 37 insertions(+), 42 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > > index d4ed9a19d8fe..2a9d8f39dc58 100644
> > > --- a/arch/arm64/kernel/smp.c
> > > +++ b/arch/arm64/kernel/smp.c
> > > @@ -115,60 +115,55 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
> > >   	update_cpu_boot_status(CPU_MMU_OFF);
> > >   	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
> > > -	/*
> > > -	 * Now bring the CPU into our world.
> > > -	 */
> > > +	/* Now bring the CPU into our world */
> > >   	ret = boot_secondary(cpu, idle);
> > > -	if (ret == 0) {
> > > -		/*
> > > -		 * CPU was successfully started, wait for it to come online or
> > > -		 * time out.
> > > -		 */
> > > -		wait_for_completion_timeout(&cpu_running,
> > > -					    msecs_to_jiffies(5000));
> > > -
> > > -		if (!cpu_online(cpu)) {
> > > -			pr_crit("CPU%u: failed to come online\n", cpu);
> > > -			ret = -EIO;
> > > -		}
> > > -	} else {
> > > +	if (ret) {
> > >   		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
> > >   		return ret;
> > >   	}
> > > +	/*
> > > +	 * CPU was successfully started, wait for it to come online or
> > > +	 * time out.
> > > +	 */
> > > +	wait_for_completion_timeout(&cpu_running,
> > > +				    msecs_to_jiffies(5000));
> > > +	if (cpu_online(cpu))
> > > +		return 0;
> > > +
> > > +	pr_crit("CPU%u: failed to come online\n", cpu);
> > >   	secondary_data.task = NULL;
> > >   	secondary_data.stack = NULL;
> > >   	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
> > >   	status = READ_ONCE(secondary_data.status);
> > > -	if (ret && status) {
> > > -
> > > -		if (status == CPU_MMU_OFF)
> > > -			status = READ_ONCE(__early_cpu_boot_status);
> > > +	if (status == CPU_MMU_OFF)
> > > +		status = READ_ONCE(__early_cpu_boot_status);
> > > -		switch (status & CPU_BOOT_STATUS_MASK) {
> > > -		default:
> > > -			pr_err("CPU%u: failed in unknown state : 0x%lx\n",
> > > -					cpu, status);
> > > -			cpus_stuck_in_kernel++;
> > > -			break;
> > > -		case CPU_KILL_ME:
> > > -			if (!op_cpu_kill(cpu)) {
> > > -				pr_crit("CPU%u: died during early boot\n", cpu);
> > > -				break;
> > > -			}
> > > -			pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
> > > -			/* Fall through */
> > > -		case CPU_STUCK_IN_KERNEL:
> > > -			pr_crit("CPU%u: is stuck in kernel\n", cpu);
> > > -			if (status & CPU_STUCK_REASON_52_BIT_VA)
> > > -				pr_crit("CPU%u: does not support 52-bit VAs\n", cpu);
> > > -			if (status & CPU_STUCK_REASON_NO_GRAN)
> > > -				pr_crit("CPU%u: does not support %luK granule \n", cpu, PAGE_SIZE / SZ_1K);
> > > -			cpus_stuck_in_kernel++;
> > > +	switch (status & CPU_BOOT_STATUS_MASK) {
> > > +	default:
> > > +		pr_err("CPU%u: failed in unknown state : 0x%lx\n",
> > > +		       cpu, status);
> > > +		cpus_stuck_in_kernel++;
> > > +		break;
> > > +	case CPU_KILL_ME:
> > > +		if (!op_cpu_kill(cpu)) {
> > > +			pr_crit("CPU%u: died during early boot\n", cpu);
> > >   			break;
> > > -		case CPU_PANIC_KERNEL:
> > > -			panic("CPU%u detected unsupported configuration\n", cpu);
> > >   		}
> > > +		pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
> > > +		/* Fall through */
> > > +	case CPU_STUCK_IN_KERNEL:
> > > +		pr_crit("CPU%u: is stuck in kernel\n", cpu);
> > > +		if (status & CPU_STUCK_REASON_52_BIT_VA)
> > > +			pr_crit("CPU%u: does not support 52-bit VAs\n", cpu);
> > > +		if (status & CPU_STUCK_REASON_NO_GRAN) {
> > > +			pr_crit("CPU%u: does not support %luK granule\n",
> > > +				cpu, PAGE_SIZE / SZ_1K);
> > > +		}
> > > +		cpus_stuck_in_kernel++;
> > > +		break;
> > > +	case CPU_PANIC_KERNEL:
> > > +		panic("CPU%u detected unsupported configuration\n", cpu);
> > >   	}
> > >   	return ret;
> > > -- 
> > > 2.23.0
> > > 
> > 
> 
