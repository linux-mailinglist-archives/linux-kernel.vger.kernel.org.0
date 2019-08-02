Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5417E7AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 03:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfHBBxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 21:53:44 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43931 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfHBBxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:53:43 -0400
Received: by mail-pf1-f202.google.com with SMTP id 6so47069659pfz.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XfqvSMY3vuMJZoSapTzecDIZKe5sCbQNfwsqgd7200k=;
        b=p5TIJ5f6MVFBRe3B9FceQm/4gs7Cvl3ZuFMo7cj8iq+4dzU4+OqUArk/lEreUbEL1U
         vrd8AcwS1VpLDTX3G3YZHTJdR1vm3GNllV3bkqUbnShlN0YcdvVRWjoTwckFozilANXm
         GlaMCVLuG+aHCjgQ7b6ydjMzG4m15noAOmkljX9L0K1u9RiRXjh4bvzDJs2o4RHUb+Oe
         cITeM+mkUafwR502ZAbpc+e8q5MU2jox9lwgbYqTBnXcQejQCQAwZgUghfk8PkE9oCGZ
         z5+BGjV+Ofkv3LA0OgmtGG8wWFCs6AIRYjwHDYYW9XIF/HMmNLestOUgLXfEuG0oTZr1
         vGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XfqvSMY3vuMJZoSapTzecDIZKe5sCbQNfwsqgd7200k=;
        b=DNDvbd515VwKL8YKpipa4V3mgrgIAbQYSYBNbecaVkQi/7FnMB39sRjuENqlQzwTkm
         ACPrAGe0QS0TZw3VN67cGilU8dRMfaiBum9wcuv5iKmGT0IOdInELXJgng7YToIEYhDf
         8rtRypHrUpamZZTluFJgKABJtsTakrWoZbAipNRCIk02yxQrBmdkDmCGaXRlhf10aYG+
         tw/2XptyDhykdr5I37veOzpDuccs68+FCjs10loBnKG5GfUMFN5wjZ2KKIbU2jYkuW4D
         1oiNFu1GUZi5WfIvpI3NKLj4K2ck9wmlNUQFBJzdf37rHxgr9yEdkUROsWazKLYR9js7
         XAnA==
X-Gm-Message-State: APjAAAVCOyJ+2ZL0upZmmU7GupXLYTBByoy1Q7b2Q8LYSkPcbAmDq+w2
        2jMb6N8OgsobAOno/08eEzJJ+p8J71rETC5M
X-Google-Smtp-Source: APXvYqyzw0qMysn2okVWhtirOPdv/rIXcjqzBGWclCKsHQco/P6X9P2iu4GWpUyUDJWzqjS57gIJJllTBFoWOcPY
X-Received: by 2002:a63:3c5:: with SMTP id 188mr119467762pgd.394.1564710821042;
 Thu, 01 Aug 2019 18:53:41 -0700 (PDT)
Date:   Thu,  1 Aug 2019 18:53:32 -0700
In-Reply-To: <20190802015332.229322-1-henryburns@google.com>
Message-Id: <20190802015332.229322-2-henryburns@google.com>
Mime-Version: 1.0
References: <20190802015332.229322-1-henryburns@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH 2/2] mm/zsmalloc.c: Fix race condition in zs_destroy_pool
From:   Henry Burns <henryburns@google.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In zs_destroy_pool() we call flush_work(&pool->free_work). However, we
have no guarantee that migration isn't happening in the background
at that time.

Since migration can't directly free pages, it relies on free_work
being scheduled to free the pages.  But there's nothing preventing an
in-progress migrate from queuing the work *after*
zs_unregister_migration() has called flush_work().  Which would mean
pages still pointing at the inode when we free it.

Since we know at destroy time all objects should be free, no new
migrations can come in (since zs_page_isolate() fails for fully-free
zspages).  This means it is sufficient to track a "# isolated zspages"
count by class, and have the destroy logic ensure all such pages have
drained before proceeding.  Keeping that state under the class
spinlock keeps the logic straightforward.

Signed-off-by: Henry Burns <henryburns@google.com>
---
 mm/zsmalloc.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index efa660a87787..1f16ed4d6a13 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -53,6 +53,7 @@
 #include <linux/zpool.h>
 #include <linux/mount.h>
 #include <linux/migrate.h>
+#include <linux/wait.h>
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 
@@ -206,6 +207,10 @@ struct size_class {
 	int objs_per_zspage;
 	/* Number of PAGE_SIZE sized pages to combine to form a 'zspage' */
 	int pages_per_zspage;
+#ifdef CONFIG_COMPACTION
+	/* Number of zspages currently isolated by compaction */
+	int isolated;
+#endif
 
 	unsigned int index;
 	struct zs_size_stat stats;
@@ -267,6 +272,8 @@ struct zs_pool {
 #ifdef CONFIG_COMPACTION
 	struct inode *inode;
 	struct work_struct free_work;
+	/* A workqueue for when migration races with async_free_zspage() */
+	struct wait_queue_head migration_wait;
 #endif
 };
 
@@ -1917,6 +1924,21 @@ static void putback_zspage_deferred(struct zs_pool *pool,
 
 }
 
+static inline void zs_class_dec_isolated(struct zs_pool *pool,
+					 struct size_class *class)
+{
+	assert_spin_locked(&class->lock);
+	VM_BUG_ON(class->isolated <= 0);
+	class->isolated--;
+	/*
+	 * There's no possibility of racing, since wait_for_isolated_drain()
+	 * checks the isolated count under &class->lock after enqueuing
+	 * on migration_wait.
+	 */
+	if (class->isolated == 0 && waitqueue_active(&pool->migration_wait))
+		wake_up_all(&pool->migration_wait);
+}
+
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct page *newpage, struct page *oldpage)
 {
@@ -1986,6 +2008,7 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	 */
 	if (!list_empty(&zspage->list) && !is_zspage_isolated(zspage)) {
 		get_zspage_mapping(zspage, &class_idx, &fullness);
+		class->isolated++;
 		remove_zspage(class, zspage, fullness);
 	}
 
@@ -2085,8 +2108,14 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	 * Page migration is done so let's putback isolated zspage to
 	 * the list if @page is final isolated subpage in the zspage.
 	 */
-	if (!is_zspage_isolated(zspage))
+	if (!is_zspage_isolated(zspage)) {
+		/*
+		 * We still hold the class lock while all of this is happening,
+		 * so we cannot race with zs_destroy_pool()
+		 */
 		putback_zspage_deferred(pool, class, zspage);
+		zs_class_dec_isolated(pool, class);
+	}
 
 	reset_page(page);
 	put_page(page);
@@ -2131,9 +2160,11 @@ static void zs_page_putback(struct page *page)
 
 	spin_lock(&class->lock);
 	dec_zspage_isolation(zspage);
-	if (!is_zspage_isolated(zspage))
-		putback_zspage_deferred(pool, class, zspage);
 
+	if (!is_zspage_isolated(zspage)) {
+		putback_zspage_deferred(pool, class, zspage);
+		zs_class_dec_isolated(pool, class);
+	}
 	spin_unlock(&class->lock);
 }
 
@@ -2156,8 +2187,36 @@ static int zs_register_migration(struct zs_pool *pool)
 	return 0;
 }
 
+static bool class_isolated_are_drained(struct size_class *class)
+{
+	bool ret;
+
+	spin_lock(&class->lock);
+	ret = class->isolated == 0;
+	spin_unlock(&class->lock);
+	return ret;
+}
+
+/* Function for resolving migration */
+static void wait_for_isolated_drain(struct zs_pool *pool)
+{
+	int i;
+
+	/*
+	 * We're in the process of destroying the pool, so there are no
+	 * active allocations. zs_page_isolate() fails for completely free
+	 * zspages, so we need only wait for each size_class's isolated
+	 * count to hit zero.
+	 */
+	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
+		wait_event(pool->migration_wait,
+			   class_isolated_are_drained(pool->size_class[i]));
+	}
+}
+
 static void zs_unregister_migration(struct zs_pool *pool)
 {
+	wait_for_isolated_drain(pool); /* This can block */
 	flush_work(&pool->free_work);
 	iput(pool->inode);
 }
@@ -2401,6 +2460,8 @@ struct zs_pool *zs_create_pool(const char *name)
 	if (!pool->name)
 		goto err;
 
+	init_waitqueue_head(&pool->migration_wait);
+
 	if (create_cache(pool))
 		goto err;
 
@@ -2466,6 +2527,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		class->index = i;
 		class->pages_per_zspage = pages_per_zspage;
 		class->objs_per_zspage = objs_per_zspage;
+		class->isolated = 0;
 		spin_lock_init(&class->lock);
 		pool->size_class[i] = class;
 		for (fullness = ZS_EMPTY; fullness < NR_ZS_FULLNESS;
-- 
2.22.0.770.g0f2c4a37fd-goog

