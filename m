Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9315E15FB30
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgBNX5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:57:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgBNX5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:57:49 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F1F217F4;
        Fri, 14 Feb 2020 23:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724669;
        bh=qRRh5Agxw3Cdv0BFc1IX8vg+cGz30FuwpDd+N1DuXho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nM0KYy6fg12WJAqvtXKnMao8wZ1+YBuoW51YTguCObvpIxIC5vQq122DMie5+OOGJ
         VkoYm1lIe3AFN3f4l6lyESA/RaDHCUvFDc806OGijkXO9SEuj/MbFPZ+0liivCR92Y
         uEgfXDNElQv7PRmO0j310OLg2anplEDBovPHVvWM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 27/30] rcu: Make nocb_gp_wait() double-check unexpected-callback warning
Date:   Fri, 14 Feb 2020 15:56:04 -0800
Message-Id: <20200214235607.13749-27-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, nocb_gp_wait() unconditionally complains if there is a
callback not already associated with a grace period.  This assumes that
either there was no such callback initially on the one hand, or that
the rcu_advance_cbs() function assigned all such callbacks to a grace
period on the other.  However, in theory there are some situations that
would prevent rcu_advance_cbs() from assigning all of the callbacks.

This commit therefore checks for unassociated callbacks immediately after
rcu_advance_cbs() returns, while the corresponding rcu_node structure's
->lock is still held.  If there are unassociated callbacks at that point,
the subsequent WARN_ON_ONCE() is disabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 70b3c0f..36e71c9 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1931,6 +1931,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	unsigned long wait_gp_seq = 0; // Suppress "use uninitialized" warning.
+	bool wasempty = false;
 
 	/*
 	 * Each pass through the following loop checks for CBs and for the
@@ -1970,10 +1971,13 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq))) {
 			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
 			needwake_gp = rcu_advance_cbs(rnp, rdp);
+			wasempty = rcu_segcblist_restempty(&rdp->cblist,
+							   RCU_NEXT_READY_TAIL);
 			raw_spin_unlock_rcu_node(rnp); /* irqs disabled. */
 		}
 		// Need to wait on some grace period?
-		WARN_ON_ONCE(!rcu_segcblist_restempty(&rdp->cblist,
+		WARN_ON_ONCE(wasempty &&
+			     !rcu_segcblist_restempty(&rdp->cblist,
 						      RCU_NEXT_READY_TAIL));
 		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
 			if (!needwait_gp ||
-- 
2.9.5

