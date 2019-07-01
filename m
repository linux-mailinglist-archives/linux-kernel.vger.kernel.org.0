Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC374520B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 04:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfFYCll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 22:41:41 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:55776 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730538AbfFYCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 22:41:41 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 25 Jun 2019 11:41:38 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 25 Jun 2019 11:41:38 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 25 Jun 2019 11:41:00 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [RFC] rcu: Warn that rcu ktheads cannot be spawned
Message-ID: <20190625024100.GA10912@X58A-UD3R>
References: <1561364852-5113-1-git-send-email-byungchul.park@lge.com>
 <20190624164624.GA41314@google.com>
 <20190624172551.GI26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624172551.GI26519@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:25:51AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 24, 2019 at 12:46:24PM -0400, Joel Fernandes wrote:
> > On Mon, Jun 24, 2019 at 05:27:32PM +0900, Byungchul Park wrote:
> > > Hello rcu folks,
> > > 
> > > I thought it'd better to announce it if those spawnings fail because of
> > > !rcu_scheduler_fully_active.
> > > 
> > > Of course, with the current code, it never happens though.
> > > 
> > > Thoughts?
> > 
> > It seems in the right spirit, but with your patch a warning always fires.
> > rcu_prepare_cpu() is called multiple times, once from rcu_init() and then
> > from hotplug paths.
> > 
> > Warning splat stack looks like:
> > 
> > [    0.398767] Call Trace:
> > [    0.398775]  rcu_init+0x6aa/0x724
> > [    0.398779]  start_kernel+0x220/0x4a2
> > [    0.398780]  ? copy_bootdata+0x12/0xac
> > [    0.398782]  secondary_startup_64+0xa4/0xb0
> 
> Thank you both, and I will remove this from my testing queue.
> 
> As Joel says, this is called at various points in the boot sequence, not
> all of which are far enough along to support spawning kthreads.
> 
> The real question here is "What types of bugs are we trying to defend
> against?"  But keeping in mind existing diagnostics.  For example, are
> there any kthreads for which a persistent failure to spawn would not
> emit any error message.  My belief is that any such persistent failure
> would result in either an in-kernel diagnostic or an rcutorture failure,
> but I might well be missing something.
> 
> Thoughts?  Or, more to the point, tests demonstrating silence in face
> of such a persistent failure?

You are right. There wouldn't be a persistent failure because the path
turning cpus on always tries to spawn them, *even* in case that the
booting sequence is wrong. The current code anyway goes right though.

I thought a hole can be there if the code changes so that those kthreads
cannot be spawned until the cpu being up, which is the case I was
interested in. Again, it's gonna never happen with the current code
because it spawns them after setting rcu_scheduler_fully_active to 1 in
rcu_spawn_gp_kthead().

And I wrongly thought you placed the rcu_scheduler_fully_active check on
spawning just in case. But it seems to be not the case.

So I'd better stop working on the warning patch. :) Instead, please
check the following trivial fix.

Thanks,
Byungchul

---8<---
From 1293d19bb7abf7553d656c81182118eff54e7dc9 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Mon, 24 Jun 2019 16:22:11 +0900
Subject: [PATCH] rcu: Make rcu_spawn_one_boost_kthread() return void

The return value of rcu_spawn_one_boost_kthread() is not used any
longer. Change the return type from int to void.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree_plugin.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1102765..4e11aa4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1131,7 +1131,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
  * already exist.  We only create this kthread for preemptible RCU.
  * Returns zero if all is well, a negated errno otherwise.
  */
-static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
+static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 	int rnp_index = rnp - rcu_get_root();
 	unsigned long flags;
@@ -1139,25 +1139,24 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	struct task_struct *t;
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
-		return 0;
+		return;
 
 	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
-		return 0;
+		return;
 
 	rcu_state.boost = 1;
 	if (rnp->boost_kthread_task != NULL)
-		return 0;
+		return;
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
 	if (IS_ERR(t))
-		return PTR_ERR(t);
+		return;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->boost_kthread_task = t;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	sp.sched_priority = kthread_prio;
 	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
-	return 0;
 }
 
 static void rcu_cpu_kthread_setup(unsigned int cpu)
@@ -1265,7 +1264,7 @@ static void __init rcu_spawn_boost_kthreads(void)
 	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__))
 		return;
 	rcu_for_each_leaf_node(rnp)
-		(void)rcu_spawn_one_boost_kthread(rnp);
+		rcu_spawn_one_boost_kthread(rnp);
 }
 
 static void rcu_prepare_kthreads(int cpu)
@@ -1275,7 +1274,7 @@ static void rcu_prepare_kthreads(int cpu)
 
 	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
 	if (rcu_scheduler_fully_active)
-		(void)rcu_spawn_one_boost_kthread(rnp);
+		rcu_spawn_one_boost_kthread(rnp);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
-- 
1.9.1

