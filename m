Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4779278DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfG2OZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 10:25:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46904 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfG2OZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r2R3bvPPA7z+Zk5Z5T/eRlqnLR0fPm6kMZLrDw0T1mM=; b=VDIZSjBOQQ5VujuzGXLUd8ztg
        s9lZP8iQA6DasO0eCjfCdN66UHKmyiRi268O6wWJUP/0aANp/x59QPcYqoSJh4IQgpSRF/DL6KxWH
        0kgwwmK2eRnOAE0i+uA7PqX2cxYVQVHKzmsRWBOClTrWQfNY4Q8lOsTlLHBoT0MAKh23KApH1NXDP
        9wewptlleUm83XE3JiybClJJZMT0obX31Swo2M25QwiC+YOSR2hf83+aWTCGjpQYy0EgbryP7TBgU
        cSenMrQzb/jwtG5VGK6iivMyfYv4imx8GubCaG31CtFlipADI9USL2jpugr46Sz83fOplbiTV39Ir
        /bWQ4t3xA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs6a4-0002qo-N7; Mon, 29 Jul 2019 14:24:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 130FF20AFFEAD; Mon, 29 Jul 2019 16:24:50 +0200 (CEST)
Date:   Mon, 29 Jul 2019 16:24:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, riel@surriel.com,
        luto@kernel.org, mathieu.desnoyers@efficios.com
Subject: [PATCH] sched: Clean up active_mm reference counting
Message-ID: <20190729142450.GE31425@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729085235.GT31381@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729085235.GT31381@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:52:35AM +0200, Peter Zijlstra wrote:
> On Sat, Jul 27, 2019 at 01:10:47PM -0400, Waiman Long wrote:

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2b037f195473..923a63262dfd 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3233,13 +3233,22 @@ context_switch(struct rq *rq, struct task_struct *prev,
> >  	 * Both of these contain the full memory barrier required by
> >  	 * membarrier after storing to rq->curr, before returning to
> >  	 * user-space.
> > +	 *
> > +	 * If mm is NULL and oldmm is dying (!owner), we switch to
> > +	 * init_mm instead to make sure that oldmm can be freed ASAP.
> >  	 */
> > -	if (!mm) {
> > +	if (!mm && !mm_dying(oldmm)) {
> >  		next->active_mm = oldmm;
> >  		mmgrab(oldmm);
> >  		enter_lazy_tlb(oldmm, next);
> > -	} else
> > +	} else {
> > +		if (!mm) {
> > +			mm = &init_mm;
> > +			next->active_mm = mm;
> > +			mmgrab(mm);
> > +		}
> >  		switch_mm_irqs_off(oldmm, mm, next);
> > +	}
> >  
> >  	if (!prev->mm) {
> >  		prev->active_mm = NULL;
> 
> Bah, I see we _still_ haven't 'fixed' that code. And you're making an
> even bigger mess of it.
> 
> Let me go find where that cleanup went.

---
Subject: sched: Clean up active_mm reference counting
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Jul 29 16:05:15 CEST 2019

The current active_mm reference counting is confusing and sub-optimal.

Rewrite the code to explicitly consider the 4 separate cases:

    user -> user

	When switching between two user tasks, all we need to consider
	is switch_mm().

    user -> kernel

	When switching from a user task to a kernel task (which
	doesn't have an associated mm) we retain the last mm in our
	active_mm. Increment a reference count on active_mm.

  kernel -> kernel

	When switching between kernel threads, all we need to do is
	pass along the active_mm reference.

  kernel -> user

	When switching between a kernel and user task, we must switch
	from the last active_mm to the next mm, hoping of course that
	these are the same. Decrement a reference on the active_mm.

The code keeps a different order, because as you'll note, both 'to
user' cases require switch_mm().

And where the old code would increment/decrement for the 'kernel ->
kernel' case, the new code observes this is a neutral operation and
avoids touching the reference count.

Cc: riel@surriel.com
Cc: luto@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3214,12 +3214,8 @@ static __always_inline struct rq *
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
 {
-	struct mm_struct *mm, *oldmm;
-
 	prepare_task_switch(rq, prev, next);
 
-	mm = next->mm;
-	oldmm = prev->active_mm;
 	/*
 	 * For paravirt, this is coupled with an exit in switch_to to
 	 * combine the page table reload and the switch backend into
@@ -3228,22 +3224,37 @@ context_switch(struct rq *rq, struct tas
 	arch_start_context_switch(prev);
 
 	/*
-	 * If mm is non-NULL, we pass through switch_mm(). If mm is
-	 * NULL, we will pass through mmdrop() in finish_task_switch().
-	 * Both of these contain the full memory barrier required by
-	 * membarrier after storing to rq->curr, before returning to
-	 * user-space.
+	 * kernel -> kernel   lazy + transfer active
+	 *   user -> kernel   lazy + mmgrab() active
+	 *
+	 * kernel ->   user   switch + mmdrop() active
+	 *   user ->   user   switch
 	 */
-	if (!mm) {
-		next->active_mm = oldmm;
-		mmgrab(oldmm);
-		enter_lazy_tlb(oldmm, next);
-	} else
-		switch_mm_irqs_off(oldmm, mm, next);
-
-	if (!prev->mm) {
-		prev->active_mm = NULL;
-		rq->prev_mm = oldmm;
+	if (!next->mm) {                                // to kernel
+		enter_lazy_tlb(prev->active_mm, next);
+
+		next->active_mm = prev->active_mm;
+		if (prev->mm)                           // from user
+			mmgrab(prev->active_mm);
+		else
+			prev->active_mm = NULL;
+	} else {                                        // to user
+		/*
+		 * sys_membarrier() requires an smp_mb() between setting
+		 * rq->curr and returning to userspace.
+		 *
+		 * The below provides this either through switch_mm(), or in
+		 * case 'prev->active_mm == next->mm' through
+		 * finish_task_switch()'s mmdrop().
+		 */
+
+		switch_mm_irqs_off(prev->active_mm, next->mm, next);
+
+		if (!prev->mm) {                        // from kernel
+			/* will mmdrop() in finish_task_switch(). */
+			rq->prev_mm = prev->active_mm;
+			prev->active_mm = NULL;
+		}
 	}
 
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
