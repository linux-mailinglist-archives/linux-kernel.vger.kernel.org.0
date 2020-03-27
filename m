Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D01960F8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 23:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgC0WZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 18:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgC0WZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3EB20848;
        Fri, 27 Mar 2020 22:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347900;
        bh=hSbQDuf8vTlOMjI6rgIo5X6FzzD0x98qmRWJGH4U1u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZz8x2vxqphiEoRCJJvKduyp1ubYwTV3PIUNII8/V6r+6c4/osMQMCNsyE39Y+aR4
         0n5WT8u7UmxibCa/e6RR41OPZaS1c/p+HW3rMSZQHh6tLBMWJWW+PkiB1KkbjKjbCd
         Aqa7mIqHDpPHCuUwMdIENFs5MfNWhZodjspTUZm8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 06/34] rcu: Reinstate synchronize_rcu_mult()
Date:   Fri, 27 Mar 2020 15:24:28 -0700
Message-Id: <20200327222456.12470-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

With the advent and likely usage of synchronize_rcu_rude(), there is
again a need to wait on multiple types of RCU grace periods, for
example, call_rcu_tasks() and call_rcu_tasks_rude().  This commit
therefore reinstates synchronize_rcu_mult() in order to allow these
grace periods to be straightforwardly waited on concurrently.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_wait.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index c0578ba..699b938 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -31,4 +31,23 @@ do {									\
 
 #define wait_rcu_gp(...) _wait_rcu_gp(false, __VA_ARGS__)
 
+/**
+ * synchronize_rcu_mult - Wait concurrently for multiple grace periods
+ * @...: List of call_rcu() functions for different grace periods to wait on
+ *
+ * This macro waits concurrently for multiple types of RCU grace periods.
+ * For example, synchronize_rcu_mult(call_rcu, call_rcu_tasks) would wait
+ * on concurrent RCU and RCU-tasks grace periods.  Waiting on a given SRCU
+ * domain requires you to write a wrapper function for that SRCU domain's
+ * call_srcu() function, with this wrapper supplying the pointer to the
+ * corresponding srcu_struct.
+ *
+ * The first argument tells Tiny RCU's _wait_rcu_gp() not to
+ * bother waiting for RCU.  The reason for this is because anywhere
+ * synchronize_rcu_mult() can be called is automatically already a full
+ * grace period.
+ */
+#define synchronize_rcu_mult(...) \
+	_wait_rcu_gp(IS_ENABLED(CONFIG_TINY_RCU), __VA_ARGS__)
+
 #endif /* _LINUX_SCHED_RCUPDATE_WAIT_H */
-- 
2.9.5

