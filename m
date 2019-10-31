Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5B5EAD1B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 11:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfJaKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 06:08:36 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:6317 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbfJaKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:08:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgmBgR._1572516510;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TgmBgR._1572516510)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 18:08:30 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 02/11] rcu: fix bug when rcu_exp_handler() in nested interrupt
Date:   Thu, 31 Oct 2019 10:07:57 +0000
Message-Id: <20191031100806.1326-3-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100806.1326-1-laijs@linux.alibaba.com>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These is a possible bug (although which I can't triger yet)
since 2015 8203d6d0ee78
(rcu: Use single-stage IPI algorithm for RCU expedited grace period)

 rcu_read_unlock()
  ->rcu_read_lock_nesting = -RCU_NEST_BIAS;
  interrupt(); // before or after rcu_read_unlock_special()
   rcu_read_lock()
    fetch some rcu protected pointers
    // exp GP starts in other cpu.
    some works
    NESTED interrupt for rcu_exp_handler();
      report exp qs! BUG!
    // exp GP completes and pointers are freed in other cpu
    some works with the pointers. BUG
   rcu_read_unlock();
  ->rcu_read_lock_nesting = 0;

Although rcu_sched_clock_irq() can be in nested interrupt,
there is no such similar bug since special.b.need_qs
can only be set when ->rcu_read_lock_nesting > 0

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_exp.h    | 5 +++--
 kernel/rcu/tree_plugin.h | 9 ++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6dec21909b30..c0d06bce35ea 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -664,8 +664,9 @@ static void rcu_exp_handler(void *unused)
 	 * Otherwise, force a context switch after the CPU enables everything.
 	 */
 	rdp->exp_deferred_qs = true;
-	if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
-	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs())) {
+	if (rcu_preempt_need_deferred_qs(t) &&
+	    (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
+	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs()))) {
 		rcu_preempt_deferred_qs(t);
 	} else {
 		set_tsk_need_resched(t);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d4c482490589..59ef10da1e39 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -549,9 +549,12 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  */
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
-	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
-		READ_ONCE(t->rcu_read_unlock_special.s)) &&
-	       t->rcu_read_lock_nesting <= 0;
+	return (__this_cpu_read(rcu_data.exp_deferred_qs) &&
+		(!t->rcu_read_lock_nesting ||
+		 t->rcu_read_lock_nesting == -RCU_NEST_BIAS))
+		||
+		(READ_ONCE(t->rcu_read_unlock_special.s) &&
+		 t->rcu_read_lock_nesting <= 0);
 }
 
 /*
-- 
2.20.1

