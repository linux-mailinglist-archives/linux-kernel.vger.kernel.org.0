Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6152815FB6D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBOAZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOAZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:25:28 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551EB206D7;
        Sat, 15 Feb 2020 00:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726327;
        bh=oRIAumjNHqmn10LWc9qa0Ieb2wE58818JG+Ees1xFYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5a2cI0RoFbXLbi3BUcg7ch60zm/r2BbVzRxLKpoftdCAFFJUS4cwMaphe6DVh28x
         T79Q1sNM18K/A7Rp+zF2ulJXSi3yWP6joesu0MO3xfCrPslsYDNnaCdOjhxzpGBJ1K
         hcinhyVJDUKl09nLvxOPtryfHCQ7OpXRjP1qJnGE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for rcu_tasks_cbs_head
Date:   Fri, 14 Feb 2020 16:25:18 -0800
Message-Id: <20200215002520.15746-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215002446.GA15663@paulmck-ThinkPad-P72>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The RCU tasks list of callbacks, rcu_tasks_cbs_head, is sampled locklessly
by rcu_tasks_kthread() when waiting for work to do.  This commit therefore
applies READ_ONCE() to that lockless sampling and WRITE_ONCE() to the
single potential store outside of rcu_tasks_kthread.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 6c4b862..a27df76 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -528,7 +528,7 @@ void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
 	rhp->func = func;
 	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
 	needwake = !rcu_tasks_cbs_head;
-	*rcu_tasks_cbs_tail = rhp;
+	WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
 	rcu_tasks_cbs_tail = &rhp->next;
 	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
 	/* We can't create the thread unless interrupts are enabled. */
@@ -658,7 +658,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		/* If there were none, wait a bit and start over. */
 		if (!list) {
 			wait_event_interruptible(rcu_tasks_cbs_wq,
-						 rcu_tasks_cbs_head);
+						 READ_ONCE(rcu_tasks_cbs_head));
 			if (!rcu_tasks_cbs_head) {
 				WARN_ON(signal_pending(current));
 				schedule_timeout_interruptible(HZ/10);
-- 
2.9.5

