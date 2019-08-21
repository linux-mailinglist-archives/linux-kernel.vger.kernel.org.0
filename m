Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34F198769
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 00:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfHUWeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 18:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbfHUWeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 18:34:01 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C223D2332A;
        Wed, 21 Aug 2019 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566426840;
        bh=FhOdoG+uEuNHTTDbXbY6PhmljoTde5UcyxI0dUGbGzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpcOoxbyCTO6OSPIk4s4E2UpgZeFQ8vkv4gGyDGHcZblGTO1LITs2QVeZuWns9jgZ
         Yi9WeMrSwxLt/fH2vkrmemWxZGdFFInP+wcCL9ef6y2KV+4ZnKhflgzcXWkPV2fP/v
         CK7FZ3lJ5A6ULzhIRV0uQT/3wC2HrQpblirbrWBM=
Date:   Thu, 22 Aug 2019 00:33:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 01/38] posix-cpu-timers: Provide task validation
 functions
Message-ID: <20190821223356.GC22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192919.326097175@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192919.326097175@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:48PM +0200, Thomas Gleixner wrote:
> The code contains three slightly different copies of validating whether a
> given clock resolves to a valid task and whether the current caller has
> permissions to access it.
> 
> Create central functions. Replace check_clock() as a first step and rename
> it to something sensible.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |   65 +++++++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 21 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -35,27 +35,52 @@ void update_rlimit_cpu(struct task_struc
>  	spin_unlock_irq(&task->sighand->siglock);
>  }
>  
> -static int check_clock(const clockid_t which_clock)
> +/*
> + * Functions for validating access to tasks.
> + */
> +static struct task_struct *lookup_task(const pid_t pid, bool thread)
>  {
> -	int error = 0;
>  	struct task_struct *p;
> -	const pid_t pid = CPUCLOCK_PID(which_clock);
>  
> -	if (CPUCLOCK_WHICH(which_clock) >= CPUCLOCK_MAX)
> -		return -EINVAL;
> +	if (!pid)
> +		return thread ? current : current->group_leader;
>  
> -	if (pid == 0)
> -		return 0;
> +	p = find_task_by_vpid(pid);
> +	if (!p || p == current)
> +		return p;

What if (p == current && !thread && !has_group_leader_pid(p)) ?

> +	if (thread)
> +		return same_thread_group(p, current) ? p : NULL;
> +	if (p == current)
> +		return p;

You already checked that above.

> +	return has_group_leader_pid(p) ? p : NULL;
> +}
