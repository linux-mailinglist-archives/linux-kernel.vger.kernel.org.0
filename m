Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDDC18715B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 18:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbgCPRmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 13:42:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34359 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbgCPRmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:42:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id f3so27694285qkh.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ID3H30czz/FP3Uv6UAzC/d4Q+G/GcberRTPzu1ZMo3E=;
        b=pUjrMXS0RNct/9Enu86BqiyDEyDA19V03PxzPGB6D8+iM2iV7UoDhLF8BPum0uzAyr
         T/IufEnDOIte1DkXg/9yRlJhtFt8uoXQCuWg9Czdg7Ow+DEVIAOhl/Zj2NnOrEHNhuXG
         bR9IifFrczz8icm/pyp4HFEjqnfA/Mhi0e1ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ID3H30czz/FP3Uv6UAzC/d4Q+G/GcberRTPzu1ZMo3E=;
        b=MytV7uIY42T9fJxtnmOaOvABbssUb3oDQxAP/jT1y9jVWpnFxWlAx58jf9jz1qB70Y
         QssorblLQNQo5Sbm0GTotFXIys5t+GXlc9clJ/TxthCJZNdYLor7kpcmy6DZIII/u+1B
         2jSKgbSwfnzN3qcjn2sC5HhZ5vs5A3qLxxSpe2/bzFRHEaZKC7UP51VTpMcfvAGgM738
         M52E9vpGO1nFrY/67mW6gZ7wUzZ29nANxsYV50a0WtlWZpx+TNIxdOOEMA4TG2vdUDLp
         c6zZLjA1332hWAbVCUGkZUnS/Fe7Be0p26j9UfLOJECIdjRU7QRz5iAZ0AbOzkX8ys/+
         szig==
X-Gm-Message-State: ANhLgQ0K1smk6VPuiKcIMm0Ajz3N0nlQdIvb3ggWtFN9j1XI5WW+mrv3
        siQVxV6WGS5sRd+oKfV6zkK0vODMdAk=
X-Google-Smtp-Source: ADFU+vsUqZ3usZr2Eg81VF8mEAQnj3RaqBD5qL05O2zypbQOSU/izpiqRllh9ZyhbPi+zjBxCqAQdg==
X-Received: by 2002:a37:e47:: with SMTP id 68mr807305qko.17.1584380542178;
        Mon, 16 Mar 2020 10:42:22 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h138sm205962qke.86.2020.03.16.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 10:42:21 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC] Simplify debug_objects handling in kfree_rcu
Date:   Mon, 16 Mar 2020 13:42:18 -0400
Message-Id: <20200316174218.154090-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for future changes to headless RCU support, make the
debug_objects handling in kfree_rcu use the final 'pointer' value of the
object, instead of depending on the head.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Paul, Vlad, I am adding this to my rcu/kfree tree for further testing. Let me know any
comments. I have only build-tested this patch.

 kernel/rcu/tree.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 32152be9a09ac..0e2632622176b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2758,7 +2758,6 @@ struct kfree_rcu_bulk_data {
 	unsigned long nr_records;
 	void *records[KFREE_BULK_MAX_ENTR];
 	struct kfree_rcu_bulk_data *next;
-	struct rcu_head *head_free_debug;
 };
 
 /**
@@ -2808,11 +2807,11 @@ struct kfree_rcu_cpu {
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
 
 static __always_inline void
-debug_rcu_head_unqueue_bulk(struct rcu_head *head)
+debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
 {
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-	for (; head; head = head->next)
-		debug_rcu_head_unqueue(head);
+	for (int i = 0; i < bhead->nr_records; i++)
+		debug_rcu_head_unqueue((struct rcu_head *)(bhead->records[i]));
 #endif
 }
 
@@ -2842,7 +2841,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	for (; bhead; bhead = bnext) {
 		bnext = bhead->next;
 
-		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
+		debug_rcu_bhead_unqueue(bhead);
 
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
@@ -2864,14 +2863,15 @@ static void kfree_rcu_work(struct work_struct *work)
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
+		void *ptr = (void *)head - offset;
 
 		next = head->next;
-		debug_rcu_head_unqueue(head);
+		debug_rcu_head_unqueue((struct rcu_head *)ptr);
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
-			kvfree((void *)head - offset);
+			kvfree(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -2995,18 +2995,11 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 		/* Initialize the new block. */
 		bnode->nr_records = 0;
 		bnode->next = krcp->bhead;
-		bnode->head_free_debug = NULL;
 
 		/* Attach it to the head. */
 		krcp->bhead = bnode;
 	}
 
-#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-	head->func = func;
-	head->next = krcp->bhead->head_free_debug;
-	krcp->bhead->head_free_debug = head;
-#endif
-
 	/* Finally insert. */
 	krcp->bhead->records[krcp->bhead->nr_records++] =
 		(void *) head - (unsigned long) func;
@@ -3030,14 +3023,17 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	void *ptr;
 
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
 		spin_lock(&krcp->lock);
 
+	ptr = (void *)head - (unsigned long)func;
+
 	// Queue the object but don't yet schedule the batch.
-	if (debug_rcu_head_queue(head)) {
+	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
@@ -3054,8 +3050,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (is_vmalloc_addr((void *) head - (unsigned long) func) ||
-			!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func)) {
+	if (is_vmalloc_addr(ptr) ||
+	    !kfree_call_rcu_add_ptr_to_bulk(krcp, head, func)) {
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
-- 
2.25.1.481.gfbce0eb801-goog
