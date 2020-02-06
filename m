Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA41547F9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 16:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBFPYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 10:24:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46284 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgBFPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581002669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=MtAFk+g5ESPRHtMvJDNyoFWN17dCc7cvIBTkVPibP7k=;
        b=GvAU8IIbDwGxQUaE6xpfsW1LRlI60a1fP5wIqloFIKXTXssjBfEJqJU+f3oaznTYudAkPy
        gGpmaYtbwLaTmyjimzhbnRE91xtIk78MTYPI2MSQCLcgJMh31+syakVmhRwUrEOg9542cq
        XWq20c0iOODqwmA5hAu4/n37lE4PFT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9--1VsLu56No6U0uEiamp4Qw-1; Thu, 06 Feb 2020 10:24:28 -0500
X-MC-Unique: -1VsLu56No6U0uEiamp4Qw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18F0E10FC789;
        Thu,  6 Feb 2020 15:24:27 +0000 (UTC)
Received: from llong.com (ovpn-124-223.rdu2.redhat.com [10.10.124.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01B981001B05;
        Thu,  6 Feb 2020 15:24:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 5/6] locking/lockdep: Track number of zapped lock chains
Date:   Thu,  6 Feb 2020 10:24:07 -0500
Message-Id: <20200206152408.24165-6-longman@redhat.com>
In-Reply-To: <20200206152408.24165-1-longman@redhat.com>
References: <20200206152408.24165-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new counter nr_zapped_lock_chains to track the number lock chains
that have been removed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 2 ++
 kernel/locking/lockdep_internals.h | 1 +
 kernel/locking/lockdep_proc.c      | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ef2a6432dd10..a63976c75253 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2626,6 +2626,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+unsigned long nr_zapped_lock_chains;
 unsigned int nr_chain_hlocks;
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
@@ -4797,6 +4798,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	 */
 	hlist_del_rcu(&chain->entry);
 	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
+	nr_zapped_lock_chains++;
 #endif
 }
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 926bfa4b4564..af722ceeda33 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -131,6 +131,7 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
 extern unsigned long nr_lock_classes;
 extern unsigned long nr_zapped_classes;
+extern unsigned long nr_zapped_lock_chains;
 extern unsigned long nr_list_entries;
 long lockdep_next_lockchain(long i);
 unsigned long lock_chain_count(void);
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index ca735cb83f48..92fe0742453c 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -349,6 +349,10 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	seq_printf(m, " zapped classes:                %11lu\n",
 			nr_zapped_classes);
+#ifdef CONFIG_PROVE_LOCKING
+	seq_printf(m, " zapped lock chains:            %11lu\n",
+			nr_zapped_lock_chains);
+#endif
 	return 0;
 }
 
-- 
2.18.1

