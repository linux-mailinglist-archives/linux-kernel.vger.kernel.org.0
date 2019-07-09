Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1975562D8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 03:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfGIBjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 21:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfGIBjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:39:19 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E22F2166E;
        Tue,  9 Jul 2019 01:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636358;
        bh=NdqN7nUCxosEDUsckfY0qXRbot79tzRn5eckqyGU71A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1xB/HPtMJnbSQvR8ihDP188UQuFSfIw/UInw97Bq1TWgChVIP4o1uxJREMq7obqI
         8xwTpMQfScNPAUeCMGZdRO8CMiU/RMM1r7UShjnJdX8V93QrefE3+WylydaeL2lV7f
         eiujMjbrfAJoZVPEOoJxb7uyj+6yTthVls84BOYY=
Date:   Tue, 9 Jul 2019 03:39:16 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/core: Cache timer busy housekeeping target
Message-ID: <20190709013914.GA23714@lenoir>
References: <1561983877-4727-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561983877-4727-1-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:24:37PM +0800, Wanpeng Li wrote:
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 41dfff2..0d49bef 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -195,8 +195,10 @@ struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
>  					 int pinned)
>  {
>  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
> -	if (static_branch_likely(&timers_migration_enabled) && !pinned)
> -		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
> +	if (static_branch_likely(&timers_migration_enabled) && !pinned) {
> +		base->last_target_cpu = get_nohz_timer_target(base->last_target_cpu);
> +		return &per_cpu(hrtimer_bases, base->last_target_cpu);


I'm not sure this is exactly what we intend to cache here.

This doesn't return the last CPU for a given timer
(that would be timer->flags & TIMER_CPUMASK) but the last CPU that
was returned when "base" was passed.

First of all, it's always initialized to CPU 0, which is perhaps
not exactly what we want.

Also the result can be very stale and awkward. If for some reason we have:

        base(CPU 5)->last_target_cpu = 255

then later a timer is enqueued to CPU 5, the next time we re-enqueue that
timer will be to CPU 255, then the second re-enqueue will be to whatever
value we have in base(CPU 255)->last_target_cpu, etc...

For example imagine that:

	base(CPU 255)->last_target_cpu = 5

the timer will bounce between those two very distant CPU 5 and 255. So I think
you rather want "timer->flags & TIMER_CPUMASK". But note that those flags
can also be initialized to zero and therefore CPU 0, while we actually want
the CPU of the timer enqueuer for a first use. And I can't think of a
simple solution to solve that :-(  Perhaps keeping the enqueuer CPU as the
first choice (as we do upstream) is still the best thing we have.

Thanks.
