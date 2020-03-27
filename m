Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635261960FE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 23:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgC0WZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 18:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbgC0WZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A17AC21655;
        Fri, 27 Mar 2020 22:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347906;
        bh=z0cDMWPHjda8S1DQ/YXhUKhufGNi2+4CB+bAP+nrCxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9RiKNwpLGjZX4S+C4uJ2yOq5NrLQJa126vyZ8+yYfVwuOIcUMUdCdRRc2wSLkZUK
         uWB4i16ak+OUOSl3s4tZA4PSBImE2rF5+BxGGo+C/8Egjm4us3hEJcBbQIJM8LN390
         bFPh7JmqXdt0TPoOKlxZcioeTtg0NOP4LZ+MngXo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 25/34] rcu-tasks: Add Kconfig option to mediate smp_mb() vs. IPI
Date:   Fri, 27 Mar 2020 15:24:47 -0700
Message-Id: <20200327222456.12470-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit provides a new TASKS_TRACE_RCU_READ_MB Kconfig option that
enables use of read-side memory barriers by both rcu_read_lock_trace()
and rcu_read_unlock_trace() when the are executed with the
current->trc_reader_special.b.need_mb flag set.  This flag is currently
never set.  Doing that is the subject of a later commit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h |  3 ++-
 kernel/rcu/Kconfig             | 18 ++++++++++++++++++
 kernel/rcu/tasks.h             |  3 ++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index c42b365c..4c25a41 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -50,7 +50,8 @@ static inline void rcu_read_lock_trace(void)
 	struct task_struct *t = current;
 
 	WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
-	if (t->trc_reader_special.b.need_mb)
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
+	    t->trc_reader_special.b.need_mb)
 		smp_mb(); // Pairs with update-side barriers
 	rcu_lock_acquire(&rcu_trace_lock_map);
 }
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index cb1d18e..0ebe15a 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -234,4 +234,22 @@ config RCU_NOCB_CPU
 	  Say Y here if you want to help to debug reduced OS jitter.
 	  Say N here if you are unsure.
 
+config TASKS_TRACE_RCU_READ_MB
+	bool "Tasks Trace RCU readers use memory barriers in user and idle"
+	depends on RCU_EXPERT
+	default PREEMPT_RT || NR_CPUS < 8
+	help
+	  Use this option to further reduce the number of IPIs sent
+	  to CPUs executing in userspace or idle during tasks trace
+	  RCU grace periods.  Given that a reasonable setting of
+	  the rcupdate.rcu_task_ipi_delay kernel boot parameter
+	  eliminates such IPIs for many workloads, proper setting
+	  of this Kconfig option is important mostly for aggressive
+	  real-time installations and for battery-powered devices,
+	  hence the default chosen above.
+
+	  Say Y here if you hate IPIs.
+	  Say N here if you hate read-side memory barriers.
+	  Take the default if you are unsure.
+
 endmenu # "RCU Subsystem"
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f9a828c..b18298b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -734,7 +734,8 @@ void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
 	int nq = t->trc_reader_special.b.need_qs;
 
-	if (t->trc_reader_special.b.need_mb)
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
+	    t->trc_reader_special.b.need_mb)
 		smp_mb(); // Pairs with update-side barriers.
 	// Update .need_qs before ->trc_reader_nesting for irq/NMI handlers.
 	if (nq)
-- 
2.9.5

