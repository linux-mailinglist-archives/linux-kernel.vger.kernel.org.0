Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D909A15FB1C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgBNX4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgBNX4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:36 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D6C624670;
        Fri, 14 Feb 2020 23:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724595;
        bh=f3Tn3xPjKHcw7qbEA4Ah425M6HfJtwTb8IVSi9j9KuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9AQ5i6Vj/Hoc3YL0ouEhaeYdxxh56QEAcMCPZlqAoZClhGkKRQ/so/c7q77oEyqq
         OCbj7K14X3r1HOwJXYb5K5eITa4lWt+Gh3WVUIyIUqKu5W7t/WGHex0WZ6kJguFh5j
         fGB/iw4AVKtyLNrsiqlu59hWtAQaCnzIge0Y0xgc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/30] rcu: Add READ_ONCE() to rcu_node ->gp_seq
Date:   Fri, 14 Feb 2020 15:55:44 -0800
Message-Id: <20200214235607.13749-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_node structure's ->gp_seq field is read locklessly, so this
commit adds the READ_ONCE() to several loads in order to avoid
destructive compiler optimizations.

This data race was reported by KCSAN.  Not appropriate for backporting
because this affects only tracing and warnings.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bb57c24..236692d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1126,8 +1126,9 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 			      unsigned long gp_seq_req, const char *s)
 {
-	trace_rcu_future_grace_period(rcu_state.name, rnp->gp_seq, gp_seq_req,
-				      rnp->level, rnp->grplo, rnp->grphi, s);
+	trace_rcu_future_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
+				      gp_seq_req, rnp->level,
+				      rnp->grplo, rnp->grphi, s);
 }
 
 /*
@@ -1904,7 +1905,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 		rnp_c = rnp;
 		rnp = rnp->parent;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		oldmask = rnp_c->qsmask;
+		oldmask = READ_ONCE(rnp_c->qsmask);
 	}
 
 	/*
@@ -2052,7 +2053,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 		return 0;
 
 	blkd = !!(rnp->qsmask & rdp->grpmask);
-	trace_rcu_grace_period(rcu_state.name, rnp->gp_seq,
+	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
 			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
 	return 0;
 }
-- 
2.9.5

