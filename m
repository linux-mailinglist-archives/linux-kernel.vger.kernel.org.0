Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3751D1332
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfJIPpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 11:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbfJIPpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:45:36 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C70221848;
        Wed,  9 Oct 2019 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570635935;
        bh=fqRA7bxG+u+c3SSwyc+1nQ2zFFrpGn+Q8lVwO0fJFH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bx8bSZXG4payXs37Cc7jg1ZFPeT6LcdbGLtMg94gUtvdoc5ElYiq7/G+TsKYdDO7f
         EQbF7kAoLXj8lusMdkX+fsGMJvBYEJpyb3juFzWdMNDr0NeS6aLa0jU1YNmCAf5r3O
         Q0pk1Nm74uBqlMgUqdFE7khnCCyrMQU82p/M0s+U=
Date:   Wed, 9 Oct 2019 17:45:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick-sched: Update nohz load even if tick already stopped
Message-ID: <20191009154528.GA18287@lenoir>
References: <1570056935-12442-1-git-send-email-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570056935-12442-1-git-send-email-swood@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 06:55:35PM -0400, Scott Wood wrote:
> The way loadavg is tracked during nohz only pays attention to the load
> upon entering nohz.  This can be particularly noticeable if nohz is
> entered while non-idle, and then the cpu goes idle and stays that way for
> a long time.  We've had reports of a loadavg near 150 on a mostly idle
> system.
> 
> Calling calc_load_nohz_start() regardless of whether the tick is already
> stopped addresses the issue when going idle.  Tracking load changes when
> not going idle (e.g. multiple SCHED_FIFO tasks coming and going) is not
> addressed by this patch.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/time/tick-sched.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 955851748dc3..f177d8168400 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -763,6 +763,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  		ts->do_timer_last = 0;
>  	}
>  
> +	/* Even if the tick was already stopped, load may have changed */
> +	calc_load_nohz_start();
> +
>  	/* Skip reprogram of event if its not changed */
>  	if (ts->tick_stopped && (expires == ts->next_tick)) {
>  		/* Sanity check: make sure clockevent is actually programmed */
> @@ -783,7 +786,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	 * the scheduler tick in nohz_restart_sched_tick.
>  	 */
>  	if (!ts->tick_stopped) {
> -		calc_load_nohz_start();
>  		quiet_vmstat();
>  
>  		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);


Thanks. I've pondered over your patch to try to avoid calling
calc_load_nohz_start() unconditionally like that. But in the end the
fast path of this function shouldn't bring much overhead and does pretty
much the same as what I would do to call it conditionally.

So I'm applying it.
