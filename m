Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021331969C5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 23:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgC1WRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 18:17:16 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]:40631 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgC1WRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 18:17:15 -0400
Received: by mail-qv1-f41.google.com with SMTP id bp12so2931798qvb.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xfNPr5WFIiLX+x0UIy9/MN3FHS6KSSVTYOGNWa2ADGI=;
        b=FrNItR+paeaDGrTRVq24QQFHwSo3w1KzWqrRw5NR5R7iDfWHB1S5nIszaI0Elbi/2g
         qjqqX79Y4R6YqbYDelsP5z3Uzh3eJ8xTyxA72wQM6AQCAzvthqVjWGXQKZ4GQwdz2mZW
         rb2mi+SQWTKZaSPz6rsAl4Dp6JeZrdrXPNCaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xfNPr5WFIiLX+x0UIy9/MN3FHS6KSSVTYOGNWa2ADGI=;
        b=lb4zteU74z1+HnbD52LndtG9YHctgSXK8sofjFV+ANzTUTT579C8p53NAG3Zd8QWC5
         BUz3CY0kHGme0pnoT/r/+fhIvmQnQrsa6hFODPy+JkzAFfS0dThhOURVIgaDtCqSKOMO
         Uiv9MfgCF96NcuCQHOxvbQEKKjAbFvAsgGszbonaEC7tFdLKr4Gb+JmWslRBj8o68xxc
         XF615jUFwnGGbOtnNA0+/AVAnuGEv7FT2V/eZxk8UfnGGoZ5HNg18/Olm5pqpWqkL0ac
         LvPgdnwSW0xhAGaVZH9jW6pgD+Ot5iqjy2lgxgCKBYteILqgSn7I0j920Yruos3YptoS
         Ddvg==
X-Gm-Message-State: ANhLgQ0QbkZilOCPJRs6qURQw2ZqE5X1HjLRk0FZU9eNCXEvoBOJzx9e
        jXnfZ+Yylk3PRJcfJo+qhDD+VKvspm4=
X-Google-Smtp-Source: ADFU+vsbupzQinEI1IPbEw9qoLOqCci1fEE6Tfdm6cpEUDFS+Hocnnxz+32TzJLLZbOpu6qBw1QgfQ==
X-Received: by 2002:a05:6214:11e1:: with SMTP id e1mr5623128qvu.176.1585433833709;
        Sat, 28 Mar 2020 15:17:13 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k66sm6742950qke.10.2020.03.28.15.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 15:17:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        Petr Mladek <pmladek@suse.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, vpillai@digitalocean.com
Subject: [PATCH v2 3/4] rcu/tree: Clean up dynticks counter usage
Date:   Sat, 28 Mar 2020 18:17:02 -0400
Message-Id: <20200328221703.48171-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200328221703.48171-1-joel@joelfernandes.org>
References: <20200328221703.48171-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dynticks counter are confusing due to crowbar writes of
DYNTICK_IRQ_NONIDLE whose purpose is to detect half-interrupts (i.e. we
see rcu_irq_enter() but not rcu_irq_exit() due to a usermode upcall) and
if so then do a reset of the dyntick_nmi_nesting counters. This patch
tries to get rid of DYNTICK_IRQ_NONIDLE while still keeping the code
working, fully functional, and less confusing. The confusion recently
has even led to patches forgetting that DYNTICK_IRQ_NONIDLE was written
to which wasted lots of time.

The patch has the following changes:

(1) Use dynticks_nesting instead of dynticks_nmi_nesting for determining
outer most "EQS exit". This is needed to detect in
rcu_nmi_enter_common() if we have already EQS-exited, such as because of
a syscall. Currently we rely on a forced write of DYNTICK_IRQ_NONIDLE
from rcu_eqs_exit() for this purpose. This is one purpose of the
DYNTICK_IRQ_NONIDLE write (other than detecting half-interrupts).
However, we do not need to do that. dyntick_nesting already tells us that
we have EQS-exited so just use that thus removing the dependence of
dynticks_nmi_nesting for this purpose.

(2) Keep dynticks_nmi_nesting around because:

  (a) rcu_is_cpu_rrupt_from_idle() needs to be able to detect first
      interrupt nesting level.

  (b) We need to detect half-interrupts till we are sure they're not an
      issue. However, change the comparison to DYNTICK_IRQ_NONIDLE with 0.

(3) Since we got rid of DYNTICK_IRQ_NONIDLE, we also do cheaper
comparisons with zero instead for the code that keeps the tick on in
rcu_nmi_enter_common().

In the next patch, both of the concerns of (2) will be addressed and
then we can get rid of dynticks_nmi_nesting, however one step at a time.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h  |  4 ----
 kernel/rcu/tree.c | 60 +++++++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 05f936ed167a7..429065a75e05f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -12,10 +12,6 @@
 
 #include <trace/events/rcu.h>
 
-/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
-#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
-
-
 /*
  * Grace-period counter management.
  */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0e5304bad705a..f1c7cbad97d09 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -71,7 +71,6 @@
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
-	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(1),
 };
 static struct rcu_state rcu_state = {
@@ -504,17 +503,19 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 /*
  * Enter an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
- *
- * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
- * the possibility of usermode upcalls having messed up our count
- * of interrupt nesting level during the prior busy period.
  */
 static void rcu_eqs_enter(bool user)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+	/*
+	 * Entering usermode/idle from interrupt is not handled. These would
+	 * mean usermode upcalls or idle exit happened from interrupts. Remove
+	 * the warning by 2020.
+	 */
+	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
+		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
+
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdp->dynticks_nesting == 0);
 	if (rdp->dynticks_nesting != 1) {
@@ -589,26 +590,29 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
+	WARN_ON_ONCE(rdp->dynticks_nesting <= 0);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
 	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
 
+	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
+		   rdp->dynticks_nmi_nesting - 1);
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
 	 * leave it in non-RCU-idle state.
 	 */
-	if (rdp->dynticks_nmi_nesting != 1) {
+	if (rdp->dynticks_nesting != 1) {
 		trace_rcu_dyntick(TPS("StillNonIdle"), TPS("IRQ"),
-				  rdp->dynticks_nmi_nesting,
-				  rdp->dynticks_nmi_nesting - 2, atomic_read(&rdp->dynticks));
-		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
-			   rdp->dynticks_nmi_nesting - 2);
+				  rdp->dynticks_nesting,
+				  rdp->dynticks_nesting - 2, atomic_read(&rdp->dynticks));
+		WRITE_ONCE(rdp->dynticks_nesting, /* No store tearing. */
+			   rdp->dynticks_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nmi_nesting,
+	trace_rcu_dyntick(TPS("Start"), TPS("IRQ"), rdp->dynticks_nesting,
 			  0, atomic_read(&rdp->dynticks));
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
 		rcu_prepare_for_idle();
@@ -673,10 +677,6 @@ void rcu_irq_exit_irqson(void)
 /*
  * Exit an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
- *
- * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
- * allow for the possibility of usermode upcalls messing up our count of
- * interrupt nesting level during the busy period that is just now starting.
  */
 static void rcu_eqs_exit(bool user)
 {
@@ -698,8 +698,14 @@ static void rcu_eqs_exit(bool user)
 			  rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
-	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
-	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
+
+	/*
+	 * Exiting usermode/idle from interrupt is not handled. These would
+	 * mean usermode upcalls or idle exit happened from interrupts. Remove
+	 * the warning by 2020.
+	 */
+	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
+		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
 }
 
 /**
@@ -755,6 +761,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	/* Complain about underflow. */
+	WARN_ON_ONCE(rdp->dynticks_nesting < 0);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
 
 	/*
@@ -777,8 +784,8 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 
 		incby = 1;
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
-		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
-		   READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
+		   !rdp->dynticks_nmi_nesting && READ_ONCE(rdp->rcu_urgent_qs)
+		   && !rdp->rcu_forced_tick) {
 		raw_spin_lock_rcu_node(rdp->mynode);
 		// Recheck under lock.
 		if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
@@ -789,11 +796,14 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	}
 
 	trace_rcu_dyntick(incby == 1 ? TPS("End") : TPS("StillNonIdle"),
-			  TPS("IRQ"), rdp->dynticks_nmi_nesting,
-			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
+			  TPS("IRQ"), rdp->dynticks_nesting,
+			  rdp->dynticks_nesting + incby, atomic_read(&rdp->dynticks));
+
+	WRITE_ONCE(rdp->dynticks_nesting, /* Prevent store tearing. */
+		   rdp->dynticks_nesting + incby);
 
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
-		   rdp->dynticks_nmi_nesting + incby);
+		   rdp->dynticks_nmi_nesting + 1);
 	barrier();
 }
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

