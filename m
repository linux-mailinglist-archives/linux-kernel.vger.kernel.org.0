Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6EC9674
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfJCBrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfJCBrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2FC0222C8;
        Thu,  3 Oct 2019 01:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067251;
        bh=mWRW6EvmyH/GayqYkmkelp5SJD9Or8+VhvkH9hZvA98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TPsFcWiW9hJPLpkoSaeN9DeHb5hzznhInvh9RvQ9crnFUibiu9ZWUYuS7JdEStZXa
         v374m5SRvasqWkgAuyQMp8Wxv+CaB63uhe+WgBVk5RMPE55gfpjWt76a1ZZSdP6EIB
         fFIBt5ztJa6Qc2JyAgi/3T900fbTKnQn/7fkLLqQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 4/9] rcutorture: Emulate dyntick aspect of userspace nohz_full sojourn
Date:   Wed,  2 Oct 2019 18:47:23 -0700
Message-Id: <20191003014728.13496-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014710.GA13323@paulmck-ThinkPad-P72>
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

During an actual call_rcu() flood, there would be frequent trips to
userspace (in-kernel call_rcu() floods must be otherwise housebroken).
Userspace execution on nohz_full CPUs implies an RCU dyntick idle/not-idle
transition pair, so this commit adds emulation of that pair.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/rcutiny.h |  1 +
 kernel/rcu/rcutorture.c | 11 +++++++++++
 kernel/rcu/tree.c       |  1 +
 3 files changed, 13 insertions(+)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 9bf1dfe..37b6f0c 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -84,6 +84,7 @@ static inline void rcu_scheduler_starting(void) { }
 #endif /* #else #ifndef CONFIG_SRCU */
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_is_watching(void) { return true; }
+static inline void rcu_momentary_dyntick_idle(void) { }
 
 /* Avoid RCU read-side critical sections leaking across. */
 static inline void rcu_all_qs(void) { barrier(); }
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3c9feca..7dcb2b8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1759,6 +1759,11 @@ static unsigned long rcu_torture_fwd_prog_cbfree(void)
 		kfree(rfcp);
 		freed++;
 		rcu_torture_fwd_prog_cond_resched(freed);
+		if (tick_nohz_full_enabled()) {
+			local_irq_save(flags);
+			rcu_momentary_dyntick_idle();
+			local_irq_restore(flags);
+		}
 	}
 	return freed;
 }
@@ -1833,6 +1838,7 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 static void rcu_torture_fwd_prog_cr(void)
 {
 	unsigned long cver;
+	unsigned long flags;
 	unsigned long gps;
 	int i;
 	long n_launders;
@@ -1891,6 +1897,11 @@ static void rcu_torture_fwd_prog_cr(void)
 		}
 		cur_ops->call(&rfcp->rh, rcu_torture_fwd_cb_cr);
 		rcu_torture_fwd_prog_cond_resched(n_launders + n_max_cbs);
+		if (tick_nohz_full_enabled()) {
+			local_irq_save(flags);
+			rcu_momentary_dyntick_idle();
+			local_irq_restore(flags);
+		}
 	}
 	stoppedat = jiffies;
 	n_launders_cb_snap = READ_ONCE(n_launders_cb);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8110514..5692db5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -375,6 +375,7 @@ static void __maybe_unused rcu_momentary_dyntick_idle(void)
 	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
 	rcu_preempt_deferred_qs(current);
 }
+EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
 
 /**
  * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
-- 
2.9.5

