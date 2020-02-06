Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E41547F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 16:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgBFPY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 10:24:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24087 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727637AbgBFPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581002666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=fUxgDMv84smLBrHrslyiv97KoxXkzHnJ/+b36HUgohw=;
        b=Ud1TPaZdzR6DUt+C2QuC6n5dNZmZphn3m4Yp+eiZGCKoNWvT7DU6ub1UTXCkDqQ/SVF1XW
        HCvLvLh1eIHuAQ07eSioDAkmMBeLj3CORjv5B+dpWJwhxnSRXeLsCfMaxoVCr2A9yyhX75
        ejOTU3lVj2d/pbvWB3PsAaVKTAHl7Hw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-WtYFF4WDOWGMX7AUucoGVA-1; Thu, 06 Feb 2020 10:24:23 -0500
X-MC-Unique: WtYFF4WDOWGMX7AUucoGVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3531D18A6EFC;
        Thu,  6 Feb 2020 15:24:22 +0000 (UTC)
Received: from llong.com (ovpn-124-223.rdu2.redhat.com [10.10.124.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD801001B05;
        Thu,  6 Feb 2020 15:24:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 1/6] locking/lockdep: Decrement irq context counters when removing lock chain
Date:   Thu,  6 Feb 2020 10:24:03 -0500
Message-Id: <20200206152408.24165-2-longman@redhat.com>
In-Reply-To: <20200206152408.24165-1-longman@redhat.com>
References: <20200206152408.24165-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently three counters to track the irq context of a lock
chain - nr_hardirq_chains, nr_softirq_chains and nr_process_chains.
They are incremented when a new lock chain is added, but they are
not decremented when a lock chain is removed. That causes some of the
statistic counts reported by /proc/lockdep_stats to be incorrect.

Fix that by decrementing the right counter when a lock chain is removed.

Since inc_chains() no longer accesses hardirq_context and softirq_context
directly, it is moved out from the CONFIG_TRACE_IRQFLAGS conditional
compilation block.

Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 40 +++++++++++++++++-------------
 kernel/locking/lockdep_internals.h |  6 +++++
 2 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32406ef0d6a2..35449f5b79fb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2298,18 +2298,6 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	return 0;
 }
 
-static void inc_chains(void)
-{
-	if (current->hardirq_context)
-		nr_hardirq_chains++;
-	else {
-		if (current->softirq_context)
-			nr_softirq_chains++;
-		else
-			nr_process_chains++;
-	}
-}
-
 #else
 
 static inline int check_irq_usage(struct task_struct *curr,
@@ -2317,13 +2305,27 @@ static inline int check_irq_usage(struct task_struct *curr,
 {
 	return 1;
 }
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
-static inline void inc_chains(void)
+static void inc_chains(int irq_context)
 {
-	nr_process_chains++;
+	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
+		nr_hardirq_chains++;
+	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
+		nr_softirq_chains++;
+	else
+		nr_process_chains++;
 }
 
-#endif /* CONFIG_TRACE_IRQFLAGS */
+static void dec_chains(int irq_context)
+{
+	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
+		nr_hardirq_chains--;
+	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
+		nr_softirq_chains--;
+	else
+		nr_process_chains--;
+}
 
 static void
 print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
@@ -2843,7 +2845,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
-	inc_chains();
+	inc_chains(chain->irq_context);
 
 	return 1;
 }
@@ -3596,7 +3598,8 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 
 static inline unsigned int task_irq_context(struct task_struct *task)
 {
-	return 2 * !!task->hardirq_context + !!task->softirq_context;
+	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!task->hardirq_context +
+	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
 }
 
 static int separate_irq_context(struct task_struct *curr,
@@ -4798,6 +4801,8 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 		return;
 	/* Overwrite the chain key for concurrent RCU readers. */
 	WRITE_ONCE(chain->chain_key, chain_key);
+	dec_chains(chain->irq_context);
+
 	/*
 	 * Note: calling hlist_del_rcu() from inside a
 	 * hlist_for_each_entry_rcu() loop is safe.
@@ -4819,6 +4824,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	}
 	*new_chain = *chain;
 	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
+	inc_chains(new_chain->irq_context);
 #endif
 }
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 18d85aebbb57..a525368b8cf6 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -106,6 +106,12 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 #define STACK_TRACE_HASH_SIZE	16384
 #endif
 
+/*
+ * Bit definitions for lock_chain.irq_context
+ */
+#define LOCK_CHAIN_SOFTIRQ_CONTEXT	(1 << 0)
+#define LOCK_CHAIN_HARDIRQ_CONTEXT	(1 << 1)
+
 #define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
 
 #define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
-- 
2.18.1

