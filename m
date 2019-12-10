Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3439117EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 05:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLJE0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 23:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfLJE0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:38 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39EE524654;
        Tue, 10 Dec 2019 04:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951997;
        bh=sPFgIz3fLu8Ou+YZ5Q//dR6+97jnvTVPTDEC6o0YHQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khulCWv/XHdMBEmTiqls1MVCEpH8yG8UPD7Oc0hG0wLNJ0ZF543WNbLYat9e1KZ/m
         60V+/6lE1I+He1ivHK5i+gaS+WANhCyVGzpWcV89KPZzAcRcaDbm2YEKUj1xjK7Un+
         QPkntoO5kbaMNNpoQBE5e8EfFEqb1ELRb/zbIzgo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/11] rcu: Use READ_ONCE() for ->expmask in rcu_read_unlock_special()
Date:   Mon,  9 Dec 2019 20:26:27 -0800
Message-Id: <20191210042629.3808-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_node structure's ->expmask field is updated only when holding the
->lock, but is also accessed locklessly.  This means that all ->expmask
updates must use WRITE_ONCE() and all reads carried out without holding
->lock must use READ_ONCE().  This commit therefore changes the lockless
->expmask read in rcu_read_unlock_special() to use READ_ONCE().

Reported-by: syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c3a3271..698a7f1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -599,7 +599,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_node *rnp = rdp->mynode;
 
 		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
-		      (rdp->grpmask & rnp->expmask) ||
+		      (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
 		      tick_nohz_full_cpu(rdp->cpu);
 		// Need to defer quiescent state until everything is enabled.
 		if (irqs_were_disabled && use_softirq &&
-- 
2.9.5

