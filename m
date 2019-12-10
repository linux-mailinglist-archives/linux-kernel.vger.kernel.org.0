Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1474117EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 05:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfLJE0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 23:26:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfLJE0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:39 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8573524655;
        Tue, 10 Dec 2019 04:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951999;
        bh=nGo2kmgXIxoagRTq8l20EvB15yLGsqGpyLAdga1D6qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTupLXawxvHRe+E6B1i1MuklKexXcPE6KHn0gCFE/yM4+ztBGT54oZmqw/aNn/oP6
         vRtYscRB/81ss4h5PD9W4HdXxw9I4zso2Mgekvr2+RrvfiMGRxWsLk3wsna6h88PoE
         oT8TgR+KmEoHr0CLRTKIS6Yhvit93397lN1mosx8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/11] rcu: Avoid tick_dep_set_cpu() misordering
Date:   Mon,  9 Dec 2019 20:26:29 -0800
Message-Id: <20191210042629.3808-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In the current code, rcu_nmi_enter_common() might decide to turn on
the tick using tick_dep_set_cpu(), but be delayed just before doing so.
Then the grace-period kthread might notice that the CPU in question had
in fact gone through a quiescent state, thus turning off the tick using
tick_dep_clear_cpu().  The later invocation of tick_dep_set_cpu() would
then incorrectly leave the tick on.

This commit therefore enlists the aid of the leaf rcu_node structure's
->lock to ensure that decisions to enable or disable the tick are
carried out before they can be reversed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5445da2..b0e0612 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -800,8 +800,8 @@ void rcu_user_exit(void)
  */
 static __always_inline void rcu_nmi_enter_common(bool irq)
 {
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	long incby = 2;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	/* Complain about underflow. */
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
@@ -828,8 +828,13 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
 		   READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
-		rdp->rcu_forced_tick = true;
-		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
+		raw_spin_lock_rcu_node(rdp->mynode);
+		// Recheck under lock.
+		if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+			rdp->rcu_forced_tick = true;
+			tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
+		}
+		raw_spin_unlock_rcu_node(rdp->mynode);
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
@@ -898,6 +903,7 @@ void rcu_irq_enter_irqson(void)
  */
 static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 {
+	raw_lockdep_assert_held_rcu_node(rdp->mynode);
 	WRITE_ONCE(rdp->rcu_urgent_qs, false);
 	WRITE_ONCE(rdp->rcu_need_heavy_qs, false);
 	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
-- 
2.9.5

