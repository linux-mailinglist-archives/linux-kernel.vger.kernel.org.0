Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB55845D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfFNNAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 09:00:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59873 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfFNNAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:00:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5ECxeJf1697145
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 05:59:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5ECxeJf1697145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560517180;
        bh=znVSosMWUpOZr5tIWWZO5BXFmfb1NYml/HdVqK6ltCA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TuEpoO191ittH2em7YDRFQnuWMZUovmiyFcvh4/YXmGEZwjXVt7RvuZRG5uH70a0M
         diWPrs4x6rwEdwWeaVeagLrpil6rfENkqojtpZuITjWxm4X0d2CfIniEIh+ewN75hG
         diidk9SeQt+8JqL1SeWCpRZL6RMx+LFMhjuxKdJ2Ee1PpWTo9CN2Wm8DBXSTw6OHGy
         HMDRJFEBzq4A4UuifbWKaCfNwxEbGijRSvGmDYJNCdwkeI/GuI9GaSy5XNhdh7V9By
         Z5T3cv4edDcFYlQwL2uF2DH5kxMENg9k1Jfj7nTYp2uaNpijQTVsk3Tllr4ESVNzz3
         qgpaFxb0rultw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5ECxdMl1697142;
        Fri, 14 Jun 2019 05:59:39 -0700
Date:   Fri, 14 Jun 2019 05:59:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-634d61f45d6f668fe7e468b62d00ae469a583ca2@git.kernel.org>
Cc:     yang.shi@linux.alibaba.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, cai@gmx.us, akpm@linux-foundation.org,
        longman@redhat.com, zhongjiang@huawei.com
Reply-To: joel@joelfernandes.org, cai@gmx.us, zhongjiang@huawei.com,
          longman@redhat.com, akpm@linux-foundation.org,
          tglx@linutronix.de, mingo@kernel.org, yang.shi@linux.alibaba.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190520141450.7575-3-longman@redhat.com>
References: <20190520141450.7575-3-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Percpu pool lookahead
 freeing/allocation
Git-Commit-ID: 634d61f45d6f668fe7e468b62d00ae469a583ca2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,T_DATE_IN_FUTURE_96_Q autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  634d61f45d6f668fe7e468b62d00ae469a583ca2
Gitweb:     https://git.kernel.org/tip/634d61f45d6f668fe7e468b62d00ae469a583ca2
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 10:14:47 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 14:51:14 +0200

debugobjects: Percpu pool lookahead freeing/allocation

Most workloads will allocate a bunch of memory objects, work on them
and then freeing all or most of them. So just having a percpu free pool
may not reduce the pool_lock contention significantly if large number
of objects are being used.

To help those situations, we are now doing lookahead allocation and
freeing of the debug objects into and out of the percpu free pool. This
will hopefully reduce the number of times the pool_lock needs to be
taken and hence its contention level.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Qian Cai <cai@gmx.us>
Cc: Zhong Jiang <zhongjiang@huawei.com>
Link: https://lkml.kernel.org/r/20190520141450.7575-3-longman@redhat.com

---
 lib/debugobjects.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 38c23b528f6f..714459a8dc10 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -26,6 +26,7 @@
 #define ODEBUG_POOL_SIZE	1024
 #define ODEBUG_POOL_MIN_LEVEL	256
 #define ODEBUG_POOL_PERCPU_SIZE	64
+#define ODEBUG_BATCH_SIZE	16
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
@@ -203,11 +204,10 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 {
-	struct debug_percpu_free *percpu_pool;
+	struct debug_percpu_free *percpu_pool = this_cpu_ptr(&percpu_obj_pool);
 	struct debug_obj *obj;
 
 	if (likely(obj_cache)) {
-		percpu_pool = this_cpu_ptr(&percpu_obj_pool);
 		obj = __alloc_object(&percpu_pool->free_objs);
 		if (obj) {
 			percpu_pool->obj_free--;
@@ -219,10 +219,32 @@ alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
 	obj = __alloc_object(&obj_pool);
 	if (obj) {
 		obj_pool_used++;
+		obj_pool_free--;
+
+		/*
+		 * Looking ahead, allocate one batch of debug objects and
+		 * put them into the percpu free pool.
+		 */
+		if (likely(obj_cache)) {
+			int i;
+
+			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
+				struct debug_obj *obj2;
+
+				obj2 = __alloc_object(&obj_pool);
+				if (!obj2)
+					break;
+				hlist_add_head(&obj2->node,
+					       &percpu_pool->free_objs);
+				percpu_pool->obj_free++;
+				obj_pool_used++;
+				obj_pool_free--;
+			}
+		}
+
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
 
-		obj_pool_free--;
 		if (obj_pool_free < obj_pool_min_free)
 			obj_pool_min_free = obj_pool_free;
 	}
@@ -288,22 +310,39 @@ static void free_obj_work(struct work_struct *work)
 
 static bool __free_object(struct debug_obj *obj)
 {
+	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
+	struct debug_percpu_free *percpu_pool;
+	int lookahead_count = 0;
 	unsigned long flags;
 	bool work;
-	struct debug_percpu_free *percpu_pool;
 
 	local_irq_save(flags);
+	if (!obj_cache)
+		goto free_to_obj_pool;
+
 	/*
 	 * Try to free it into the percpu pool first.
 	 */
 	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
-	if (obj_cache && percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
+	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
 		hlist_add_head(&obj->node, &percpu_pool->free_objs);
 		percpu_pool->obj_free++;
 		local_irq_restore(flags);
 		return false;
 	}
 
+	/*
+	 * As the percpu pool is full, look ahead and pull out a batch
+	 * of objects from the percpu pool and free them as well.
+	 */
+	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
+		objs[lookahead_count] = __alloc_object(&percpu_pool->free_objs);
+		if (!objs[lookahead_count])
+			break;
+		percpu_pool->obj_free--;
+	}
+
+free_to_obj_pool:
 	raw_spin_lock(&pool_lock);
 	work = (obj_pool_free > debug_objects_pool_size) && obj_cache;
 	obj_pool_used--;
@@ -311,9 +350,25 @@ static bool __free_object(struct debug_obj *obj)
 	if (work) {
 		obj_nr_tofree++;
 		hlist_add_head(&obj->node, &obj_to_free);
+		if (lookahead_count) {
+			obj_nr_tofree += lookahead_count;
+			obj_pool_used -= lookahead_count;
+			while (lookahead_count) {
+				hlist_add_head(&objs[--lookahead_count]->node,
+					       &obj_to_free);
+			}
+		}
 	} else {
 		obj_pool_free++;
 		hlist_add_head(&obj->node, &obj_pool);
+		if (lookahead_count) {
+			obj_pool_free += lookahead_count;
+			obj_pool_used -= lookahead_count;
+			while (lookahead_count) {
+				hlist_add_head(&objs[--lookahead_count]->node,
+					       &obj_pool);
+			}
+		}
 	}
 	raw_spin_unlock(&pool_lock);
 	local_irq_restore(flags);
@@ -1228,7 +1283,7 @@ free:
  */
 void __init debug_objects_mem_init(void)
 {
-	int cpu;
+	int cpu, extras;
 
 	if (!debug_objects_enabled)
 		return;
@@ -1253,4 +1308,12 @@ void __init debug_objects_mem_init(void)
 		pr_warn("out of memory.\n");
 	} else
 		debug_objects_selftest();
+
+	/*
+	 * Increase the thresholds for allocating and freeing objects
+	 * according to the number of possible CPUs available in the system.
+	 */
+	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
+	debug_objects_pool_size += extras;
+	debug_objects_pool_min_level += extras;
 }
