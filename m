Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE91D45D52
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 15:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfFNNAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 09:00:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfFNNAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:00:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5ED0PB41697506
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 06:00:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5ED0PB41697506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560517226;
        bh=aaI51wmVkm7DOiq7bfQgJXe+bV8UkqwqsyP6atnUMKQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=JLZijTgcd9Jebl8v5yzJxdOJDbymiwDJpeB0UKLbvt6ucZniohkEbmslDPaXaXO9F
         KX3iMykrd/O+HOj8zeib1jYeA1PMj4fY1uQtmi0+obPVphjs3k/Sb+mzHiVmJ39nRb
         SXySPAQT/a56Aik9HBS32FzPJP5b3MJyV0mQ1e8I9Eu1RQaTsFVGpK9b3l3RMf+bdy
         xTInoY3ItVsggbQr9UdR/AGIvEtm2Ryth6PBysnrbShfkJqJLZe0aErET2sezPWbI/
         5/PB7tVA881Ti//RcuQwqBGWcy8MpNPN7YwiQjzQGuJEpwGEneRMrtySm6bRIegqp9
         091vMRMO6OXYw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5ED0PvD1697503;
        Fri, 14 Jun 2019 06:00:25 -0700
Date:   Fri, 14 Jun 2019 06:00:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-d26bf5056fc087d845bfbb8b651b4be2933ab7a6@git.kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, cai@gmx.us, longman@redhat.com,
        zhongjiang@huawei.com, joel@joelfernandes.org, mingo@kernel.org,
        yang.shi@linux.alibaba.com
Reply-To: tglx@linutronix.de, akpm@linux-foundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, cai@gmx.us, longman@redhat.com,
          zhongjiang@huawei.com, mingo@kernel.org,
          yang.shi@linux.alibaba.com, joel@joelfernandes.org
In-Reply-To: <20190520141450.7575-4-longman@redhat.com>
References: <20190520141450.7575-4-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: Reduce number of pool_lock
 acquisitions in fill_pool()
Git-Commit-ID: d26bf5056fc087d845bfbb8b651b4be2933ab7a6
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

Commit-ID:  d26bf5056fc087d845bfbb8b651b4be2933ab7a6
Gitweb:     https://git.kernel.org/tip/d26bf5056fc087d845bfbb8b651b4be2933ab7a6
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Mon, 20 May 2019 10:14:48 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 14:51:15 +0200

debugobjects: Reduce number of pool_lock acquisitions in fill_pool()

In fill_pool(), the pool_lock is acquired and then released once per debug
object. If many objects are to be filled, the constant lock and unlock
operations are extra overhead.

To reduce the overhead, batch them up and do an allocation of 4 objects per
lock/unlock sequence.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Qian Cai <cai@gmx.us>
Cc: Zhong Jiang <zhongjiang@huawei.com>
Link: https://lkml.kernel.org/r/20190520141450.7575-4-longman@redhat.com

---
 lib/debugobjects.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 714459a8dc10..7ea19fa63561 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -120,7 +120,7 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 static void fill_pool(void)
 {
 	gfp_t gfp = GFP_ATOMIC | __GFP_NORETRY | __GFP_NOWARN;
-	struct debug_obj *new, *obj;
+	struct debug_obj *obj;
 	unsigned long flags;
 
 	if (likely(obj_pool_free >= debug_objects_pool_min_level))
@@ -136,7 +136,7 @@ static void fill_pool(void)
 		 * Recheck with the lock held as the worker thread might have
 		 * won the race and freed the global free list already.
 		 */
-		if (obj_nr_tofree) {
+		while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
 			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
 			hlist_del(&obj->node);
 			obj_nr_tofree--;
@@ -150,15 +150,23 @@ static void fill_pool(void)
 		return;
 
 	while (obj_pool_free < debug_objects_pool_min_level) {
+		struct debug_obj *new[ODEBUG_BATCH_SIZE];
+		int cnt;
 
-		new = kmem_cache_zalloc(obj_cache, gfp);
-		if (!new)
+		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
+			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
+			if (!new[cnt])
+				break;
+		}
+		if (!cnt)
 			return;
 
 		raw_spin_lock_irqsave(&pool_lock, flags);
-		hlist_add_head(&new->node, &obj_pool);
-		debug_objects_allocated++;
-		obj_pool_free++;
+		while (cnt) {
+			hlist_add_head(&new[--cnt]->node, &obj_pool);
+			debug_objects_allocated++;
+			obj_pool_free++;
+		}
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
 }
@@ -280,7 +288,7 @@ static void free_obj_work(struct work_struct *work)
 	/*
 	 * The objs on the pool list might be allocated before the work is
 	 * run, so recheck if pool list it full or not, if not fill pool
-	 * list from the global free list
+	 * list from the global free list.
 	 */
 	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
 		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
