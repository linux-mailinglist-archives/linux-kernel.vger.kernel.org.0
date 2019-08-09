Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E344884F7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfHIVie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 17:38:34 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55870 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfHIVie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:38:34 -0400
Received: by mail-pl1-f202.google.com with SMTP id q11so58099250pll.22
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xA4sS4X8FQOcKXsaLmxwZyVjI3eJo4lwqwVNVh8IS+4=;
        b=fA4UXBofzcCuH8Ox2KDQK0BxsPfpGm7973kzLcneUP3vYQowr/+NJ+nNUg5QRpKn8Y
         3W68DrLgQdzpAFciU5sYMCVnhzZ3KswD/8BJDIRwTo6TUjOLK3K2dZFE66tQSD1h2AA4
         zy9iDurswmTQS/NNCJWI6FZbV6Gsrb3Mqc6InzTFO79yVNpfuIbUNxPRqY4FC2nmTmdY
         VnfiDHzpltInJ88rHqirfJ54cJIn3QWGf1oDK3aJ3hNmClHJY5s8u8zC3zV37UtRnld7
         5pecTAQ3ygzGi1caKsDJgyonQMCEYGYntdtEeU8mX8Gy2zBk8VQ6zL2avzbsfAHoN2gH
         WrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xA4sS4X8FQOcKXsaLmxwZyVjI3eJo4lwqwVNVh8IS+4=;
        b=V+HWMXQIcB9QLG9EnmpcjvLg11Qmb3sMrLnS5gHX9l8jKEjyzdD/TXIs28/KM8mPne
         R+SvRuDuP42y0p1dDuTI6htqtXAnII0hVb3+/vprwC4qd9zANH9Dhmu+HBXlYLC/cFvg
         F5j5JqYxUCY94lxiRIGNZ5AsivJkeoYuHxT6vpbp6jJ2qWXy+qKFeguAQxf8QUbcHPKc
         LnpLzeJmxFSiIfTb7gDPeJT6O43FbFwKRqT4KXwLGMGzVt3mxyLtmF8yjvbYc2jBKPQL
         5PF6bD0aB6lbsd3q0V8M1Py4g9QGqsafzLr5NPk81ncSAQJUoR4jsgQn4oLF5UVWz/xm
         gtNA==
X-Gm-Message-State: APjAAAWAtyicCyk2t6MczqwGmgotXyDEg7o+COVZ3jbQ+mvvzWiQpJ8k
        p+TXMJradt2D3lxvpNgdRxCPXLGZ6wRrIvk1
X-Google-Smtp-Source: APXvYqwxBo8gk0xscIsZMbqcPDBwOjLUfEANF/KXXEv5uX61h79LJVfKhfhgmzb5/EeNB3vwZs2c8qk79C+kWMH0
X-Received: by 2002:a63:3281:: with SMTP id y123mr18805072pgy.72.1565386712674;
 Fri, 09 Aug 2019 14:38:32 -0700 (PDT)
Date:   Fri,  9 Aug 2019 14:38:28 -0700
Message-Id: <20190809213828.202833-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2] mm/z3fold.c: Fix race between migration and destruction
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In z3fold_destroy_pool() we call destroy_workqueue(&pool->compact_wq).
However, we have no guarantee that migration isn't happening in the
background at that time.

Migration directly calls queue_work_on(pool->compact_wq), if destruction
wins that race we are using a destroyed workqueue.

Signed-off-by: Henry Burns <henryburns@google.com>
---
 Changelog since v1:
 - Fixed a bug where migration could still queue work after we have
   waited for it to drain. (added z3fold_pool->destroying in the
   process)

 mm/z3fold.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 78447cecfffa..6b32c94c4ca1 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -40,6 +40,7 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <linux/zpool.h>
 
 /*
@@ -143,6 +144,8 @@ struct z3fold_header {
  * @release_wq:	workqueue for safe page release
  * @work:	work_struct for safe page release
  * @inode:	inode for z3fold pseudo filesystem
+ * @destroying: bool to stop migration once we start destruction
+ * @isolated: int to count the number of pages currently in isolation
  *
  * This structure is allocated at pool creation time and maintains metadata
  * pertaining to a particular z3fold pool.
@@ -161,8 +164,11 @@ struct z3fold_pool {
 	const struct zpool_ops *zpool_ops;
 	struct workqueue_struct *compact_wq;
 	struct workqueue_struct *release_wq;
+	struct wait_queue_head isolate_wait;
 	struct work_struct work;
 	struct inode *inode;
+	bool destroying;
+	int isolated;
 };
 
 /*
@@ -772,6 +778,7 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 		goto out_c;
 	spin_lock_init(&pool->lock);
 	spin_lock_init(&pool->stale_lock);
+	init_waitqueue_head(&pool->isolate_wait);
 	pool->unbuddied = __alloc_percpu(sizeof(struct list_head)*NCHUNKS, 2);
 	if (!pool->unbuddied)
 		goto out_pool;
@@ -811,6 +818,15 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 	return NULL;
 }
 
+static bool pool_isolated_are_drained(struct z3fold_pool *pool)
+{
+	bool ret;
+
+	spin_lock(&pool->lock);
+	ret = pool->isolated == 0;
+	spin_unlock(&pool->lock);
+	return ret;
+}
 /**
  * z3fold_destroy_pool() - destroys an existing z3fold pool
  * @pool:	the z3fold pool to be destroyed
@@ -820,6 +836,22 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 static void z3fold_destroy_pool(struct z3fold_pool *pool)
 {
 	kmem_cache_destroy(pool->c_handle);
+	/*
+	 * We set pool-> destroying under lock to ensure that
+	 * z3fold_page_isolate() sees any changes to destroying. This way we
+	 * avoid the need for any memory barriers.
+	 */
+
+	spin_lock(&pool->lock);
+	pool->destroying = true;
+	spin_unlock(&pool->lock);
+
+	/*
+	 * We need to ensure that no pages are being migrated while we destroy
+	 * these workqueues, as migration can queue work on either of the
+	 * workqueues.
+	 */
+	wait_event(pool->isolate_wait, !pool_isolated_are_drained(pool));
 
 	/*
 	 * We need to destroy pool->compact_wq before pool->release_wq,
@@ -1317,6 +1349,28 @@ static u64 z3fold_get_pool_size(struct z3fold_pool *pool)
 	return atomic64_read(&pool->pages_nr);
 }
 
+/*
+ * z3fold_dec_isolated() expects to be called while pool->lock is held.
+ */
+static void z3fold_dec_isolated(struct z3fold_pool *pool)
+{
+	assert_spin_locked(&pool->lock);
+	VM_BUG_ON(pool->isolated <= 0);
+	pool->isolated--;
+
+	/*
+	 * If we have no more isolated pages, we have to see if
+	 * z3fold_destroy_pool() is waiting for a signal.
+	 */
+	if (pool->isolated == 0 && waitqueue_active(&pool->isolate_wait))
+		wake_up_all(&pool->isolate_wait);
+}
+
+static void z3fold_inc_isolated(struct z3fold_pool *pool)
+{
+	pool->isolated++;
+}
+
 static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	struct z3fold_header *zhdr;
@@ -1343,6 +1397,33 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 		spin_lock(&pool->lock);
 		if (!list_empty(&page->lru))
 			list_del(&page->lru);
+		/*
+		 * We need to check for destruction while holding pool->lock, as
+		 * otherwise destruction could see 0 isolated pages, and
+		 * proceed.
+		 */
+		if (unlikely(pool->destroying)) {
+			spin_unlock(&pool->lock);
+			/*
+			 * If this page isn't stale, somebody else holds a
+			 * reference to it. Let't drop our refcount so that they
+			 * can call the release logic.
+			 */
+			if (unlikely(kref_put(&zhdr->refcount,
+					      release_z3fold_page_locked))) {
+				/*
+				 * If we get here we have kref problems, so we
+				 * should freak out.
+				 */
+				WARN(1, "Z3fold is experiencing kref problems\n");
+				return false;
+			}
+			z3fold_page_unlock(zhdr);
+			return false;
+		}
+
+
+		z3fold_inc_isolated(pool);
 		spin_unlock(&pool->lock);
 		z3fold_page_unlock(zhdr);
 		return true;
@@ -1417,6 +1498,10 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
 
+	spin_lock(&pool->lock);
+	z3fold_dec_isolated(pool);
+	spin_unlock(&pool->lock);
+
 	page_mapcount_reset(page);
 	put_page(page);
 	return 0;
@@ -1436,10 +1521,14 @@ static void z3fold_page_putback(struct page *page)
 	INIT_LIST_HEAD(&page->lru);
 	if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
 		atomic64_dec(&pool->pages_nr);
+		spin_lock(&pool->lock);
+		z3fold_dec_isolated(pool);
+		spin_unlock(&pool->lock);
 		return;
 	}
 	spin_lock(&pool->lock);
 	list_add(&page->lru, &pool->lru);
+	z3fold_dec_isolated(pool);
 	spin_unlock(&pool->lock);
 	z3fold_page_unlock(zhdr);
 }
-- 
2.23.0.rc1.153.gdeed80330f-goog

