Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47F514218D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 03:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgATCCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 21:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgATCCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 21:02:37 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A7620678;
        Mon, 20 Jan 2020 02:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579485756;
        bh=IgWnmFG4IWCDZ7oFxlaJMqo1c+sGlwmV3F6Rqf7BC48=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XHWlK1OtrHCH+uzYyEW9WBn0OcAE7z/KrNkeW4ZdgQgSUKxkCIuPfhNsa5BOdxdHy
         XFca+kRq/mYPxdlrRRWoaRBqHfWxwsoFwFOMfrqJZ1Suda4wJIzTBoo9BGHN/k7cHv
         xJPxDMDEP6SmH4IsgZYupmw9IzpG7kDnoBXxU3O4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E4B9635227EF; Sun, 19 Jan 2020 18:02:35 -0800 (PST)
Date:   Sun, 19 Jan 2020 18:02:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Document (some) memory-ordering properties of
 {queue,schedule}_work()
Message-ID: <20200120020235.GA8126@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200118215820.7646-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118215820.7646-1-parri.andrea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 10:58:20PM +0100, Andrea Parri wrote:
> It's desirable to be able to rely on the following property:  All stores
> preceding (in program order) a call to a successful queue_work() will be
> visible from the CPU which will execute the queued work by the time such
> work executes, e.g.,
> 
>   { x is initially 0 }
> 
>     CPU0                              CPU1
> 
>     WRITE_ONCE(x, 1);                 [ "work" is being executed ]
>     r0 = queue_work(wq, work);          r1 = READ_ONCE(x);
> 
>   Forbids: r0 == true && r1 == 0
> 
> The current implementation of queue_work() provides such memory-ordering
> property:
> 
>   - In __queue_work(), the ->lock spinlock is acquired.
> 
>   - On the other side, in worker_thread(), this same ->lock is held
>     when dequeueing work.
> 
> So the locking ordering makes things work out.
> 
> Add this property to the DocBook headers of {queue,schedule}_work().
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

An alternative to Randy's suggestion of dropping the comma following
the "cf." is to just drop that whole phrase.  I will let you and Randy
work that one out, though.  ;-)

> ---
>  include/linux/workqueue.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 4261d1c6e87b1..4fef6c38b0536 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -487,6 +487,19 @@ extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
>   *
>   * We queue the work to the CPU on which it was submitted, but if the CPU dies
>   * it can be processed by another CPU.
> + *
> + * Memory-ordering properties:  If it returns %true, guarantees that all stores
> + * preceding the call to queue_work() in the program order will be visible from
> + * the CPU which will execute @work by the time such work executes, e.g.,
> + *
> + * { x is initially 0 }
> + *
> + *   CPU0				CPU1
> + *
> + *   WRITE_ONCE(x, 1);			[ @work is being executed ]
> + *   r0 = queue_work(wq, work);		  r1 = READ_ONCE(x);
> + *
> + * Forbids: r0 == true && r1 == 0
>   */
>  static inline bool queue_work(struct workqueue_struct *wq,
>  			      struct work_struct *work)
> @@ -546,6 +559,9 @@ static inline bool schedule_work_on(int cpu, struct work_struct *work)
>   * This puts a job in the kernel-global workqueue if it was not already
>   * queued and leaves it in the same position on the kernel-global
>   * workqueue otherwise.
> + *
> + * Shares the same memory-ordering properties of queue_work(), c.f., the
> + * DocBook header of queue_work().
>   */
>  static inline bool schedule_work(struct work_struct *work)
>  {
> -- 
> 2.24.0
> 
