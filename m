Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3904150D2F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 17:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbgBCQmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 11:42:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43718 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731648AbgBCQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580748130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=MtAFk+g5ESPRHtMvJDNyoFWN17dCc7cvIBTkVPibP7k=;
        b=NslK7cNhuDhkYwJ6a9LJCUIfBjE2wJZraX+wiwDkG6G+qle/2OGUWBbiYN+9nApwl9s3iQ
        NBXMOJtRGnjtzGQwf5ZCNfEnGJWRy1xMh0d48edSiRdOAr0nQsvTpiOgaqJ9gCYR4cqFVx
        agE513+b50RxM8kwArJPuIMR9DdTM2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-JyrqO9_qMvqKdPJWjALvEw-1; Mon, 03 Feb 2020 11:42:04 -0500
X-MC-Unique: JyrqO9_qMvqKdPJWjALvEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62BDB800D41;
        Mon,  3 Feb 2020 16:42:03 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8E161001B28;
        Mon,  3 Feb 2020 16:42:02 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 5/7] locking/lockdep: Track number of zapped lock chains
Date:   Mon,  3 Feb 2020 11:41:45 -0500
Message-Id: <20200203164147.17990-6-longman@redhat.com>
In-Reply-To: <20200203164147.17990-1-longman@redhat.com>
References: <20200203164147.17990-1-longman@redhat.com>
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

