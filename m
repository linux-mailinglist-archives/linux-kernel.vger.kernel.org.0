Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A448DECEB8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 13:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKBMr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 08:47:26 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:52006 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbfKBMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 08:47:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Th-eIi4_1572698841;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Th-eIi4_1572698841)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Nov 2019 20:47:22 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH V2 6/7] rcu: clear the special.b.need_qs in rcu_note_context_switch()
Date:   Sat,  2 Nov 2019 12:45:58 +0000
Message-Id: <20191102124559.1135-7-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191102124559.1135-1-laijs@linux.alibaba.com>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
Reply-To: <20191101162109.GN20975@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to clear the special.b.need_qs when it is
replaced by special.b.blocked or it is really fulfill its
goal in rcu_preempt_deferred_qs_irqrestore().

It makes rcu_qs() easier to be understood, and also prepares for
the percpu rcu_preempt_depth patch, which reqires rcu_special
bits to be clearred in irq-disable context.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_plugin.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index eb5906c55c8d..e16c3867d2ff 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -264,8 +264,6 @@ static void rcu_qs(void)
 				       __this_cpu_read(rcu_data.gp_seq),
 				       TPS("cpuqs"));
 		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
-		barrier(); /* Coordinate with rcu_flavor_sched_clock_irq(). */
-		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, false);
 	}
 }
 
@@ -297,6 +295,7 @@ void rcu_note_context_switch(bool preempt)
 		/* Possibly blocking in an RCU read-side critical section. */
 		rnp = rdp->mynode;
 		raw_spin_lock_rcu_node(rnp);
+		t->rcu_read_unlock_special.b.need_qs = false;
 		t->rcu_read_unlock_special.b.blocked = true;
 		t->rcu_blocked_node = rnp;
 
-- 
2.20.1

