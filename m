Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4419215FB74
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBOA3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:29:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgBOA3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:29:43 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 228B32082F;
        Sat, 15 Feb 2020 00:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726583;
        bh=pu4syCUkfKNbkI1k8KdZx2dw6f2OTqQqTg3NJHt2AXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YK8DEV1Heo92s2QTax+3clDgAFrBpQgV5ES5aWjKcAZau1hsmBy5Vhghr8iSiYu4w
         XZqapCgEX/WTAYUk+s+eivm7aHOSCqSfhwL4ThVnRebs7wVy6J/PsO5tUg/sjpqwZw
         Dj6nyIiuvReZCL2vmXWVRcEu4aMPpQyMp3/WQyY4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/4] srcu: Fix __call_srcu()/srcu_get_delay() datarace
Date:   Fri, 14 Feb 2020 16:29:30 -0800
Message-Id: <20200215002932.15976-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215002907.GA15895@paulmck-ThinkPad-P72>
References: <20200215002907.GA15895@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The srcu_struct structure's ->srcu_gp_seq_needed_exp field is accessed
locklessly, so updates must use WRITE_ONCE().  This commit therefore
adds the needed WRITE_ONCE() invocations.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b1edac9..79848f7d 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -534,7 +534,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	rcu_seq_end(&ssp->srcu_gp_seq);
 	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
-		ssp->srcu_gp_seq_needed_exp = gpseq;
+		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, gpseq);
 	spin_unlock_irq_rcu_node(ssp);
 	mutex_unlock(&ssp->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
@@ -614,7 +614,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 	}
 	spin_lock_irqsave_rcu_node(ssp, flags);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
-		ssp->srcu_gp_seq_needed_exp = s;
+		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
 	spin_unlock_irqrestore_rcu_node(ssp, flags);
 }
 
@@ -674,7 +674,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		smp_store_release(&ssp->srcu_gp_seq_needed, s); /*^^^*/
 	}
 	if (!do_norm && ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
-		ssp->srcu_gp_seq_needed_exp = s;
+		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
 
 	/* If grace period not already done and none in progress, start it. */
 	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
-- 
2.9.5

