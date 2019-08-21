Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C3F987FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 01:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfHUXk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 19:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbfHUXk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:40:28 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD7C20679;
        Wed, 21 Aug 2019 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566430828;
        bh=+CNXH/YxO0+xYUHfQSQYl0jxnaQ4+3blOslpsgjcy3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLTM+GdYCppcfSlbg3BT1PvIHeY+zwCwjTBswS5Rjcj1j8sY58qhk4NPLOC8iHezM
         MyYO0D8ZhiWmdcJleScK3F7OleSyuJRVL/yoeMUSX1OD3UbeHNyvaUg8cs8CKekzYB
         bA5kNXSAI67djFP9i0oGl+d3FqnJm/3bsj8sshfk=
Date:   Thu, 22 Aug 2019 01:40:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 02/38] posix-cpu-timers: Use common permission check
 in posix_cpu_clock_get()
Message-ID: <20190821234024.GE22020@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192919.414813172@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192919.414813172@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:08:49PM +0200, Thomas Gleixner wrote:
> Replace the next slightly different copy of permission checks. That also
> removes the necessarity to check the return value of the sample functions
> because the clock id is already validated.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |   61 ++++++++++-------------------------------
>  1 file changed, 16 insertions(+), 45 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -289,53 +289,24 @@ static int cpu_clock_sample_group(const
>  	return 0;
>  }
>  
> -static int posix_cpu_clock_get_task(struct task_struct *tsk,
> -				    const clockid_t which_clock,
> -				    struct timespec64 *tp)
> +static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
>  {
> -	int err = -EINVAL;
> -	u64 rtn;
> +	const clockid_t clkid = CPUCLOCK_WHICH(clock);

So I guess you later remove the CPUCLOCK_WHICH() from cpu_clock_sample*()
and turn them to void.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
