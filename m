Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647CC1440B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 16:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAUPlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 10:41:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27035 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729221AbgAUPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579621268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=NSV/sehxdIz/hK96hVgfVFsN1N7RBEL5Ts+BRFNGwCg=;
        b=Qkym0KOQltGCnjqzYCmtTcN2sj9Y6KAWIe12OnDQB5ZAuc8VrqbrwTsnKJwa+mjhwEXvH3
        rYQZljujMUd/KLXYtCmKfVJIprmq5yypKOwVZiRgooiik0LOoRJYwWMkbBKL/QXzhL5D+Z
        39IBjgg5FHCfbMkSWp6hgsBf/IDYApg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-eft0axTxNYW4dsnIqVhXdQ-1; Tue, 21 Jan 2020 10:41:06 -0500
X-MC-Unique: eft0axTxNYW4dsnIqVhXdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CCE31084445;
        Tue, 21 Jan 2020 15:41:00 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D60FB60FC1;
        Tue, 21 Jan 2020 15:40:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 4/7] locking/lockdep: Throw away all lock chains with zapped class
Date:   Tue, 21 Jan 2020 10:40:06 -0500
Message-Id: <20200121154009.11993-5-longman@redhat.com>
In-Reply-To: <20200121154009.11993-1-longman@redhat.com>
References: <20200121154009.11993-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a lock chain contains a class that is zapped, the whole lock chain is
likely to be invalid. If the zapped class is at the end of the chain,
the partial chain without the zapped class should have been stored
already as the current code will store all its predecessor chains. If
the zapped class is somewhere in the middle, there is no guarantee that
the partial chain will actually happen. It may just clutter up the hash
and make searching slower. I would rather prefer storing the chain only
when it actually happens.

So just dump the corresponding chain_hlocks entries for now. A latter
patch will try to reuse the freed chain_hlocks entries.

This patch also changes the type of nr_chain_hlocks to unsigned integer
to be consistent with the other counters.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 37 ++++--------------------------
 kernel/locking/lockdep_internals.h |  4 ++--
 kernel/locking/lockdep_proc.c      |  2 +-
 3 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48e8510529a7..a259f9e97e3b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2626,8 +2626,8 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
-int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+unsigned int nr_chain_hlocks;
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -4773,36 +4773,23 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 					 struct lock_class *class)
 {
 #ifdef CONFIG_PROVE_LOCKING
-	struct lock_chain *new_chain;
-	u64 chain_key;
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++) {
 		if (chain_hlocks[i] != class - lock_classes)
 			continue;
-		/* The code below leaks one chain_hlock[] entry. */
-		if (--chain->depth > 0) {
-			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
-				(chain->base + chain->depth - i) *
-				sizeof(chain_hlocks[0]));
-		}
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
 		 * we found a match we can break out of this loop.
 		 */
-		goto recalc;
+		goto free_lock_chain;
 	}
 	/* Since the chain has not been modified, return. */
 	return;
 
-recalc:
-	chain_key = INITIAL_CHAIN_KEY;
-	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
-	if (chain->depth && chain->chain_key == chain_key)
-		return;
+free_lock_chain:
 	/* Overwrite the chain key for concurrent RCU readers. */
-	WRITE_ONCE(chain->chain_key, chain_key);
+	WRITE_ONCE(chain->chain_key, INITIAL_CHAIN_KEY);
 	dec_chains(chain->irq_context);
 
 	/*
@@ -4811,22 +4798,6 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	 */
 	hlist_del_rcu(&chain->entry);
 	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
-	if (chain->depth == 0)
-		return;
-	/*
-	 * If the modified lock chain matches an existing lock chain, drop
-	 * the modified lock chain.
-	 */
-	if (lookup_chain_cache(chain_key))
-		return;
-	new_chain = alloc_lock_chain();
-	if (WARN_ON_ONCE(!new_chain)) {
-		debug_locks_off();
-		return;
-	}
-	*new_chain = *chain;
-	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
-	inc_chains(new_chain->irq_context);
 #endif
 }
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 76db80446a32..926bfa4b4564 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -134,14 +134,14 @@ extern unsigned long nr_zapped_classes;
 extern unsigned long nr_list_entries;
 long lockdep_next_lockchain(long i);
 unsigned long lock_chain_count(void);
-extern int nr_chain_hlocks;
 extern unsigned long nr_stack_trace_entries;
 
 extern unsigned int nr_hardirq_chains;
 extern unsigned int nr_softirq_chains;
 extern unsigned int nr_process_chains;
-extern unsigned int max_lockdep_depth;
+extern unsigned int nr_chain_hlocks;
 
+extern unsigned int max_lockdep_depth;
 extern unsigned int max_bfs_queue_depth;
 
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index bd853848832b..2457bc97924c 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -278,7 +278,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
 			lock_chain_count(), MAX_LOCKDEP_CHAINS);
-	seq_printf(m, " dependency chain hlocks:       %11d [max: %lu]\n",
+	seq_printf(m, " dependency chain hlocks:       %11u [max: %lu]\n",
 			nr_chain_hlocks, MAX_LOCKDEP_CHAIN_HLOCKS);
 #endif
 
-- 
2.18.1

