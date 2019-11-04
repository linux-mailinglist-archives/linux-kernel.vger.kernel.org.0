Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341D8EDB77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 10:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfKDJRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 04:17:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54830 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfKDJRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QSkm+iTZDnaY7Ha0UV9TtpF/QRC1gh6q6dNIn2BxAc0=; b=FDFCbqlYiWn/9KJZ2ls4enAp2
        556pJGSonFKi6gDQma8hnKKoWNW+YN14weLOCcQXoScH18fEfWbqaJkw2dnssyp1FU2Ex0l9bGj+v
        aEhIxeE58mo+cpy9xzYDeVaR9mfhbvYAgIfJITDdVNP2wtEeWNOhxWXPWS83Fp/UlpXbLR8Dr268f
        OB1/xylimm45g3bcg+isg+IdpcrJNtf7dlMGz7xLiQTBUumaK2c20BXRVB6u3OYz52voCGJcaiE9W
        kxXaKi8RhZvw0H225zwfuZ7jlIw0OpHIpL7GQI267t8gjeiRjV+C7OWQvgvxMFqHfUmRE1XiMEOfS
        qBcd8Rbpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRYU0-0002Et-3b; Mon, 04 Nov 2019 09:17:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99291305EF2;
        Mon,  4 Nov 2019 10:16:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFEC323CEFEAF; Mon,  4 Nov 2019 10:16:58 +0100 (CET)
Date:   Mon, 4 Nov 2019 10:16:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        jiang.xuexin@zte.com.cn, Yang Tao <yang.tao172@zte.com.cn>
Subject: Re: [PATCH] Robust-futex wakes up the waiters will be missed
Message-ID: <20191104091658.GC4131@hirez.programming.kicks-ass.net>
References: <1572573789-16557-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572573789-16557-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:03:09AM +0800, Yi Wang wrote:
>  kernel/futex.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index bd18f60..c2fb590 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -3456,7 +3456,9 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
>   * Process a futex-list entry, check whether it's owned by the
>   * dying task, and do notification if so:
>   */
> -static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int pi)
> +static int handle_futex_death(u32 __user *uaddr,
> +			      struct task_struct *curr, int pi,
> +			      bool pending)
>  {
>  	u32 uval, uninitialized_var(nval), mval;
>  	int err;
> @@ -3469,6 +3471,10 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int p
>  	if (get_user(uval, uaddr))
>  		return -1;
>  
> +	/* Robust-futex wakes up the waiters will be missed*/
> +	if (pending && !pi && uval == 0)
> +		futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
> +

I'm thinking you're right and this should fix things, but that comment
is really terse and will not help us understand things the next time we
try and figure out what this code does.

>  	if ((uval & FUTEX_TID_MASK) != task_pid_vnr(curr))
>  		return 0;
>  
> @@ -3590,7 +3596,7 @@ void exit_robust_list(struct task_struct *curr)
>  		 */
>  		if (entry != pending)
>  			if (handle_futex_death((void __user *)entry + futex_offset,
> -						curr, pi))
> +						curr, pi, 0))
>  				return;
>  		if (rc)
>  			return;
> @@ -3607,7 +3613,7 @@ void exit_robust_list(struct task_struct *curr)
>  
>  	if (pending)
>  		handle_futex_death((void __user *)pending + futex_offset,
> -				   curr, pip);
> +				   curr, pip, 1);
>  }
>  
>  long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
> @@ -3784,7 +3790,7 @@ void compat_exit_robust_list(struct task_struct *curr)
>  		if (entry != pending) {
>  			void __user *uaddr = futex_uaddr(entry, futex_offset);
>  
> -			if (handle_futex_death(uaddr, curr, pi))
> +			if (handle_futex_death(uaddr, curr, pi, 0))
>  				return;
>  		}
>  		if (rc)
> @@ -3803,7 +3809,7 @@ void compat_exit_robust_list(struct task_struct *curr)
>  	if (pending) {
>  		void __user *uaddr = futex_uaddr(pending, futex_offset);
>  
> -		handle_futex_death(uaddr, curr, pip);
> +		handle_futex_death(uaddr, curr, pip, 1);
>  	}
>  }
>  
> -- 
> 2.15.2
> 
