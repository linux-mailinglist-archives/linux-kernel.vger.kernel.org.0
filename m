Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE44C15FB67
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgBOATC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:19:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOATB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:19:01 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4412187F;
        Sat, 15 Feb 2020 00:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725940;
        bh=iVK3s2tfT6lPptAkJ01jWcx1WlzANXy4ULDzyR3GZYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uiTuOE9AvUQ8auI2BxyrRcnx2tJI0IcviphOm48mArMC66fwoK7rE1XrGLTE4NxSN
         Gmst4gZKrZpl/A+PCyiwtB52BhC2jNxnsSEmbmIqZRc4GeyHsTLRygfRg+P4E2Jh39
         uDAmQDODq0iXu3GIOez3OjZ7hcL6JS/rt8XvvKXs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/5] rcu: React to callback overload by boosting RCU readers
Date:   Fri, 14 Feb 2020 16:18:43 -0800
Message-Id: <20200215001845.15432-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215001816.GA15284@paulmck-ThinkPad-P72>
References: <20200215001816.GA15284@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

RCU priority boosting currently is not applied until the grace period
is at least 250 milliseconds old (or the number of milliseconds specified
by the CONFIG_RCU_BOOST_DELAY Kconfig option).  Although this has worked
well, it can result in OOM under conditions of RCU callback flooding.
One can argue that the real-time systems using RCU priority boosting
should carefully avoid RCU callback flooding, but one can just as well
argue that an OOM is a rather obnoxious error message.

This commit therefore disables the RCU priority boosting delay when
there are excessive numbers of callbacks queued.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0be8fad..4d4637c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1079,7 +1079,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	    (rnp->gp_tasks != NULL &&
 	     rnp->boost_tasks == NULL &&
 	     rnp->qsmask == 0 &&
-	     ULONG_CMP_GE(jiffies, rnp->boost_time))) {
+	     (ULONG_CMP_GE(jiffies, rnp->boost_time) || rcu_state.cbovld))) {
 		if (rnp->exp_tasks == NULL)
 			rnp->boost_tasks = rnp->gp_tasks;
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-- 
2.9.5

