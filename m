Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73656A3BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfH3QXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 12:23:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36571 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfH3QXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:23:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so3796542pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aACRDaRRRgyNMJa4GNZcRAy/BViO849VvZSxVxExkCY=;
        b=YVM/3gxkAV5lYtZ2inMFLXJTwdI/cMxJBkwVfmWmZUrDmVPunc21WsOEEj6NS3k8IH
         rfrPuGP60q0gsMyMAC91wqvEXowqt1daeQ7g9Azxk+tEnLxUyMXF1ZaRspuDiEKzqLuR
         llLzNiReTBqTio6c/ZUlqOgF2V/sKCw/dSJpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aACRDaRRRgyNMJa4GNZcRAy/BViO849VvZSxVxExkCY=;
        b=AqxONz3r4bkOX7euN3XLuNgQGmYxAnGeLgQ3ow7w+syDyTT8ZZJ1l8f49d18ZHj9To
         VU+iuaQGdyrCBT7/65lX7Cl6C7lzaXURcN8R29sndtLG7TIJ19mZb2nxmHO2MoNnXxQp
         0uKWAZcbDNKZj9ILaPlTeYxN0N8ok7FsGuWCBqS8EGCcXasTOSpv0YhA6RQMFvdeD9AN
         kDdknMHylniFC9vbn74q/24/DPEkG2kN+n+4gi/Rfo+RYO88FUiHWMG8LCqK4x8yN6AB
         jf7ijWUaZg5WWizYyFXjdWw7yXXRGmOgO4X6c7EE8sGq+OmbFDKZMt7n6txGLLV6qvcE
         kKRQ==
X-Gm-Message-State: APjAAAVJvCoMRsAEsF0mx5EOwc4eozKr8zcnHakc/4ujyR1N7Dyr9y7j
        nF5Agy89To16VaahjELLyKG/YoHdv7E=
X-Google-Smtp-Source: APXvYqzQgFFN1jXgpTrEv33BfPi6fTFtOxdoSoJcj+qDrjJb/bydQIA0giDz4C+IDFQepSPwlqgHaA==
X-Received: by 2002:a63:fe17:: with SMTP id p23mr13624563pgh.103.1567182233298;
        Fri, 30 Aug 2019 09:23:53 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t9sm5646109pgj.89.2019.08.30.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:23:52 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH -rcu dev 1/2] Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks counter")
Date:   Fri, 30 Aug 2019 12:23:47 -0400
Message-Id: <20190830162348.192303-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is unused and can be removed now. Revert was straightforward.

Tested with light rcutorture.

Link: http://lore.kernel.org/r/CALCETrWNPOOdTrFabTDd=H7+wc6xJ9rJceg6OL1S0rTV5pfSsA@mail.gmail.com
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 include/linux/rcutiny.h |  3 --
 kernel/rcu/tree.c       | 82 ++++++++++-------------------------------
 2 files changed, 19 insertions(+), 66 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index b7607e2667ae..b3f689711289 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -14,9 +14,6 @@
 
 #include <asm/param.h> /* for HZ */
 
-/* Never flag non-existent other CPUs! */
-static inline bool rcu_eqs_special_set(int cpu) { return false; }
-
 static inline unsigned long get_state_synchronize_rcu(void)
 {
 	return 0;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 68ebf0eb64c8..417dd00b9e87 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -69,20 +69,10 @@
 
 /* Data structures. */
 
-/*
- * Steal a bit from the bottom of ->dynticks for idle entry/exit
- * control.  Initially this is for TLB flushing.
- */
-#define RCU_DYNTICK_CTRL_MASK 0x1
-#define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
-#ifndef rcu_eqs_special_exit
-#define rcu_eqs_special_exit() do { } while (0)
-#endif
-
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
-	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
+	.dynticks = ATOMIC_INIT(1),
 };
 struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
@@ -229,20 +219,15 @@ void rcu_softirq_qs(void)
 static void rcu_dynticks_eqs_enter(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	int seq;
+	int special;
 
 	/*
-	 * CPUs seeing atomic_add_return() must see prior RCU read-side
+	 * CPUs seeing atomic_inc_return() must see prior RCU read-side
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
-	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
-	/* Better be in an extended quiescent state! */
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     (seq & RCU_DYNTICK_CTRL_CTR));
-	/* Better not have special action (TLB flush) pending! */
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     (seq & RCU_DYNTICK_CTRL_MASK));
+	special = atomic_inc_return(&rdp->dynticks);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && special & 0x1);
 }
 
 /*
@@ -252,22 +237,15 @@ static void rcu_dynticks_eqs_enter(void)
 static void rcu_dynticks_eqs_exit(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	int seq;
+	int special;
 
 	/*
-	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
+	 * CPUs seeing atomic_inc_return() must see prior idle sojourns,
 	 * and we also must force ordering with the next RCU read-side
 	 * critical section.
 	 */
-	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     !(seq & RCU_DYNTICK_CTRL_CTR));
-	if (seq & RCU_DYNTICK_CTRL_MASK) {
-		atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
-		smp_mb__after_atomic(); /* _exit after clearing mask. */
-		/* Prefer duplicate flushes to losing a flush. */
-		rcu_eqs_special_exit();
-	}
+	special = atomic_inc_return(&rdp->dynticks);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(special & 0x1));
 }
 
 /*
@@ -284,9 +262,9 @@ static void rcu_dynticks_eqs_online(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	if (atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR)
+	if (atomic_read(&rdp->dynticks) & 0x1)
 		return;
-	atomic_add(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	atomic_add(0x1, &rdp->dynticks);
 }
 
 /*
@@ -298,7 +276,7 @@ bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	return !(atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
+	return !(atomic_read(&rdp->dynticks) & 0x1);
 }
 
 /*
@@ -309,7 +287,7 @@ int rcu_dynticks_snap(struct rcu_data *rdp)
 {
 	int snap = atomic_add_return(0, &rdp->dynticks);
 
-	return snap & ~RCU_DYNTICK_CTRL_MASK;
+	return snap;
 }
 
 /*
@@ -318,7 +296,7 @@ int rcu_dynticks_snap(struct rcu_data *rdp)
  */
 static bool rcu_dynticks_in_eqs(int snap)
 {
-	return !(snap & RCU_DYNTICK_CTRL_CTR);
+	return !(snap & 0x1);
 }
 
 /*
@@ -331,28 +309,6 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 	return snap != rcu_dynticks_snap(rdp);
 }
 
-/*
- * Set the special (bottom) bit of the specified CPU so that it
- * will take special action (such as flushing its TLB) on the
- * next exit from an extended quiescent state.  Returns true if
- * the bit was successfully set, or false if the CPU was not in
- * an extended quiescent state.
- */
-bool rcu_eqs_special_set(int cpu)
-{
-	int old;
-	int new;
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-
-	do {
-		old = atomic_read(&rdp->dynticks);
-		if (old & RCU_DYNTICK_CTRL_CTR)
-			return false;
-		new = old | RCU_DYNTICK_CTRL_MASK;
-	} while (atomic_cmpxchg(&rdp->dynticks, old, new) != old);
-	return true;
-}
-
 /*
  * Let the RCU core know that this CPU has gone through the scheduler,
  * which is a quiescent state.  This is called when the need for a
@@ -366,13 +322,13 @@ bool rcu_eqs_special_set(int cpu)
  */
 void rcu_momentary_dyntick_idle(void)
 {
-	int special;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	int special = atomic_add_return(2, &rdp->dynticks);
 
-	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
-	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR,
-				    &this_cpu_ptr(&rcu_data)->dynticks);
 	/* It is illegal to call this from idle state. */
-	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
+	WARN_ON_ONCE(!(special & 0x1));
+
+	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
 	rcu_preempt_deferred_qs(current);
 }
 EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
-- 
2.23.0.187.g17f5b7556c-goog

