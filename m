Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05594EAD21
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 11:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfJaKIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 06:08:52 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:61424 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727283AbfJaKIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:08:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TgmBgRY_1572516511;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TgmBgRY_1572516511)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Oct 2019 18:08:32 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 04/11] rcu: cleanup rcu_preempt_deferred_qs()
Date:   Thu, 31 Oct 2019 10:07:59 +0000
Message-Id: <20191031100806.1326-5-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100806.1326-1-laijs@linux.alibaba.com>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't need to set ->rcu_read_lock_nesting negative, irq-protected
rcu_preempt_deferred_qs_irqrestore() doesn't expect
->rcu_read_lock_nesting to be negative to work, it even
doesn't access to ->rcu_read_lock_nesting any more.

It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
may access to ->rcu_read_lock_nesting, but it is still safe
since rcu_read_unlock_special() can protect itself from NMI.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_plugin.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 82595db04eec..9fe8138ed3c3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -555,16 +555,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 static void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
-	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
 
 	if (!rcu_preempt_need_deferred_qs(t))
 		return;
-	if (couldrecurse)
-		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
-	if (couldrecurse)
-		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
 }
 
 /*
-- 
2.20.1

