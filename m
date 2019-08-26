Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B0D9D97F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 00:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfHZWvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 18:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfHZWvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:51:16 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E37206BB;
        Mon, 26 Aug 2019 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566859875;
        bh=VlaZ8ZJr1G7uDtnRByR9cGYYfsoatF5ODaQaZhozhEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRTwsJQP8RGTo8M9ORr7lvtIsQStl6JxjHBxsVaMcjR2ubN709RPFGG6xQ9vcghaT
         xcDFDeGY1Bu2tAKO6htDlxz5HcEtp4MRs+CV9jwDyjnTQ8q9Io3muBkUv3A3kVTg13
         /o13BVXEzajJNBDVPerq8XfDmTMJ3Zfevc0Nuvr0=
Date:   Tue, 27 Aug 2019 00:51:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 34/38] posix-cpu-timers: Get rid of 64bit divisions
Message-ID: <20190826225111.GI14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.458286860@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192922.458286860@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:21PM +0200, Thomas Gleixner wrote:
> Instead of dividing A to match the units of B it's more efficient to
> multiply B to match the units of A.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Fix the dropped update of the expiry cache when the soft limit increased
> ---
>  kernel/time/posix-cpu-timers.c |   24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -798,10 +798,11 @@ static void check_thread_timers(struct t
>  	 */
>  	soft = task_rlimit(tsk, RLIMIT_RTTIME);
>  	if (soft != RLIM_INFINITY) {
> +		/* Task RT timeout is accounted in jiffies. RTTIME is usec */
> +		unsigned long rtim = tsk->rt.timeout * (USEC_PER_SEC / HZ);

jiffies_to_usecs() ?

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
