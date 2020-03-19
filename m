Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7504818A9A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 01:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgCSALc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 20:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbgCSALI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15ED20A8B;
        Thu, 19 Mar 2020 00:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576667;
        bh=/lNK+4AM9ncCFxX+MXSXM9gMwQMVbCsWMIAl06YFsLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N03b92lE/zMh4l3V4ifhQMgPHwnMkRpH0Q6dON4fpatIKPgXxfMV1W7lPpL+XG3YL
         B3NoIFH2c//ufCcWhhtXSugLxKpTNUvzn4XtU/fFJXmjZxlXN9jl7iw5LUcObGGuD2
         tYd+81SiWM4Jxj3XztdnHG6SZYJPRuchDIiZ4X2c=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 tip/core/rcu 17/22] rcu-tasks: Move #ifdef into tasks.h
Date:   Wed, 18 Mar 2020 17:10:55 -0700
Message-Id: <20200319001100.24917-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit pushes the #ifdef CONFIG_TASKS_RCU_GENERIC from
kernel/rcu/update.c to kernel/rcu/tasks.h in order to improve
readability as more APIs are added.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h  | 5 +++++
 kernel/rcu/update.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e6ef98e..220f264 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -5,6 +5,7 @@
  * Copyright (C) 2020 Paul E. McKenney
  */
 
+#ifdef CONFIG_TASKS_RCU_GENERIC
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -976,3 +977,7 @@ core_initcall(rcu_spawn_tasks_trace_kthread);
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
+
+#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
+static inline void rcu_tasks_bootup_oddness(void) {}
+#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 16058a5..0fb2a9e 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -559,11 +559,7 @@ late_initcall(rcu_verify_early_boot_tests);
 void rcu_early_boot_tests(void) {}
 #endif /* CONFIG_PROVE_RCU */
 
-#ifdef CONFIG_TASKS_RCU_GENERIC
 #include "tasks.h"
-#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
-static inline void rcu_tasks_bootup_oddness(void) {}
-#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
 #ifndef CONFIG_TINY_RCU
 
-- 
2.9.5

