Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A523119727B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 04:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgC3Cds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 22:33:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34208 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgC3Cdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:45 -0400
Received: by mail-qk1-f195.google.com with SMTP id i6so17556284qke.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgdGPXJPeX9SnpInGUH6EZTenlvWX+9TvCWRBUF+hwk=;
        b=dequhaQuCg4Eqs8SK1mEtFVEs26FepKbkbjAt/iTUd8AcqAnOYSdUPNVsOcRcFnf3c
         uSKJuhhwPHGFaJXWfClV3neUpzuC75KU5hQe/5GnHKw4jSU1iuKJYl1LlCOdsVWxjcxp
         sutV85pSCaoLahQrMd9R+DAWXDHWhmg94iVyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgdGPXJPeX9SnpInGUH6EZTenlvWX+9TvCWRBUF+hwk=;
        b=MSi96Hl3fQOLURVNUlSKZB15zNX90Jiw3sv4WwpkgZDqYXOuI/9OnT47S7EOHPDqh6
         6OK4TUFM1Dh/w5bd7GkzAEnNsk9xfKwix6RxWfM46fdtW3UW1WXwZNwOmVA0XEfpEOFw
         EsIjys/X2i9dpGnvB4MFdCQ9rM4M0eiLaXfyniUJ/KeMHPZpZYnEAvHMwBG5Wdf4/4P1
         zuYlk/jxWcSrDDEP7lV5RKHJc7I5LODW4oyc2Rt7VsrKHFLG4aBCbuMiPO3jivGT+VEx
         32/JvyU5DbY6B08LyUu2iEm0yB86pa3k5vidBoUfPHKrOxleOnv37hmEXcymRd7H1L+B
         VBcQ==
X-Gm-Message-State: ANhLgQ2oyFB8B69VUWMNNwh0XaL9Q+o+AA8pf+2L17uNIUhC9aoNkWNP
        cg7yptdUa03MS/dJ+L7qHQ5V260P3D4=
X-Google-Smtp-Source: ADFU+vt87q8g9W1XSLYZFPTn1haQJjHn0TkgzZRXHxTEV8TU+ZBXSX5+SoNzrFUyyKBnb65yliV9Vg==
X-Received: by 2002:a37:4548:: with SMTP id s69mr10199428qka.63.1585535623472;
        Sun, 29 Mar 2020 19:33:43 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:43 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 12/18] rcu/tree: Support reclaim for head-less object
Date:   Sun, 29 Mar 2020 22:32:42 -0400
Message-Id: <20200330023248.164994-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Update the kvfree_call_rcu() with head-less support, it
means an object without any rcu_head structure can be
reclaimed after GP.

To store pointers there are two chain-arrays maintained
one for SLAB and another one is for vmalloc. Both types
of objects(head-less variant and regular one) are placed
there based on the type.

It can be that maintaining of arrays becomes impossible
due to high memory pressure. For such reason there is an
emergency path. In that case objects with rcu_head inside
are just queued building one way list. Later on that list
is drained.

As for head-less variant. Such objects do not have any
rcu_head helper inside. Thus it is dynamically attached.
As a result an object consists of back-pointer and regular
rcu_head. It implies that emergency path can detect such
object type, therefore they are tagged. So a back-pointer
could be freed as well as dynamically attached wrapper.

Even though such approach requires dynamic memory it needs
only sizeof(unsigned long *) + sizeof(struct rcu_head) bytes,
thus SLAB is used to obtain it. Finally if attaching of the
rcu_head and queuing get failed, the current context has
to follow might_sleep() annotation, thus below steps could
be applied:
   a) wait until a grace period has elapsed;
   b) direct inlining of the kvfree() call.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 93 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3b94526f490cb..204292378101b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2959,19 +2959,34 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * when we could not allocate a bulk array.
 	 *
 	 * Under that condition an object is queued to the
-	 * list instead.
+	 * list instead. Please note that head-less objects
+	 * have dynamically attached rcu_head, so they also
+	 * contain a back-pointer that has to be freed.
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
-		void *ptr = (void *)head - offset;
+		bool headless;
+		void *ptr;
 
 		next = head->next;
+
+		/* We tag the headless object, if so adjust offset. */
+		headless = (((unsigned long) head - offset) & BIT(0));
+		if (headless)
+			offset -= 1;
+
+		ptr = (void *) head - offset;
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
+
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset))) {
+			if (headless)
+				kvfree((void *) *((unsigned long *) ptr));
+
 			kvfree(ptr);
+		}
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3120,6 +3135,24 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 	return true;
 }
 
+static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
+{
+	unsigned long *ptr;
+
+	ptr = kmalloc(sizeof(unsigned long *) +
+			sizeof(struct rcu_head), GFP_NOWAIT | __GFP_NOWARN);
+
+	if (!ptr)
+		ptr = kmalloc(sizeof(unsigned long *) +
+				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
+
+	if (!ptr)
+		return NULL;
+
+	ptr[0] = (unsigned long) obj;
+	return ((struct rcu_head *) ++ptr);
+}
+
 /*
  * Queue a request for lazy invocation of appropriate free routine after a
  * grace period. Please note there are three paths are maintained, two are the
@@ -3138,20 +3171,37 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
 	bool expedited_drain = false;
+	bool success;
 	void *ptr;
 
+	if (head) {
+		ptr = (void *) head - (unsigned long) func;
+	} else {
+		/*
+		 * Please note there is a limitation for the head-less
+		 * variant, that is why there is a clear rule for such
+		 * objects:
+		 *
+		 * use it from might_sleep() context only. For other
+		 * places please embed an rcu_head to your structures.
+		 */
+		might_sleep();
+		ptr = (unsigned long *) func;
+	}
+
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
 		spin_lock(&krcp->lock);
 
-	ptr = (void *)head - (unsigned long)func;
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
+
+		/* Mark as success and leave. */
+		success = true;
 		goto unlock_return;
 	}
 
@@ -3159,7 +3209,22 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr)) {
+	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	if (!success) {
+		/* Is headless object? */
+		if (head == NULL) {
+			head = attach_rcu_head_to_object(ptr);
+			if (head == NULL)
+				goto unlock_return;
+
+			/*
+			 * Tag the headless object. Such objects have a back-pointer
+			 * to the original allocated memory, that has to be freed as
+			 * well as dynamically attached wrapper/head.
+			 */
+			func = (rcu_callback_t) (sizeof(unsigned long *) + 1);
+		}
+
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
@@ -3171,15 +3236,15 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		 * appropriate free calls.
 		 */
 		expedited_drain = true;
+		success = true;
 	}
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-	    !krcp->monitor_todo) {
+			!krcp->monitor_todo) {
 		krcp->monitor_todo = true;
-
 		schedule_delayed_work(&krcp->monitor_work,
 			expedited_drain ? 0 : KFREE_DRAIN_JIFFIES);
 	}
@@ -3188,6 +3253,18 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	if (krcp->initialized)
 		spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
+
+	/*
+	 * High memory pressure, so inline kvfree() after
+	 * synchronize_rcu(). We can do it from might_sleep()
+	 * context only, so the current CPU can pass the QS
+	 * state.
+	 */
+	if (!success) {
+		debug_rcu_head_unqueue(ptr);
+		synchronize_rcu();
+		kvfree(ptr);
+	}
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

