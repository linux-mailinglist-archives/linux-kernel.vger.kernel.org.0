Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3988232
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437296AbfHISSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 14:18:43 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49110 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfHISSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:18:42 -0400
Received: by mail-pf1-f201.google.com with SMTP id u21so61970815pfn.15
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vCc93vaFXwMRZ3fSZ6FSA2GqVkDbS0j1jfgTmaZ8aBc=;
        b=rP5d8uUtgyhIBDjs3pOQIuKA7CqPkZD87wr6U31d5zfiCN3+zpqMplqHMlAAaxJv5Y
         mtLjOGMMCHDiDW4eRm5ZqTb8YJp+nUsl6X/dXmaQ6YKC99OzzbfXbosMyYikyKx+YxMK
         WddcEWcZjamXOX0SzMHQLdh6BYQBctAuMgDwUuBx680TIuZbqFChFDUmuzsNIgJUX4V1
         RnVJoLfKEjC50m/1xX+078kcG9btrDBeIVgagoOHFJ/JTOZdPj65IWvBOIniw94xrSA6
         8LmhqGentKO3nOnsG63CBC0FeconSn075YP0D8gwkVY5TLhtdAab5zV1IozxKfU/txpL
         c6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vCc93vaFXwMRZ3fSZ6FSA2GqVkDbS0j1jfgTmaZ8aBc=;
        b=jg/leGkmgh+jfhL1dAZ4tPzLtXxPne6hc8eZKFfqKRzkClmDf+VfjXH44C5PMhCqfE
         PDOkKxQ2voMrc1GsXj3fOJKpQS3HuTNnqbc8Ney/682RctLkTaQDNAIL4qAjkzPwNZRm
         CjzDlM4loa6C2M3ye8krDbxi8p/9XZJWOJ4raSL8nkkoD0h8PHi5l+B8rzJw7x57+sCR
         rseot0dRkwVFkB5/L4zVZVCYcCPqI3RwpjTk6Y6KYX/gRTWh67ibXntVu6LQAMiMklSv
         7aV855id8ppbB3DTgE/Gl4YDaUMw3H/wYi3FOHGcEyXNd+5Q/xYXHtDFY4+pPu/kf20B
         LlSQ==
X-Gm-Message-State: APjAAAWDstw0YJ+hQwzgdplBRVXAoXekagi10GpmwOPNPiuR+iAIWbIJ
        1xSPZucGOsjE1DCgrrJXQFPyQdn04Oe7rWa+
X-Google-Smtp-Source: APXvYqyg54n0lDkaOi6YoNCD+Q2chFnQmSkX+NV/dn8iBvhAgc9UN9MRDpw/360/Y3bVmdFJO7zx9N1Mqe5obIpC
X-Received: by 2002:a63:e807:: with SMTP id s7mr18031604pgh.194.1565374721199;
 Fri, 09 Aug 2019 11:18:41 -0700 (PDT)
Date:   Fri,  9 Aug 2019 11:17:51 -0700
In-Reply-To: <20190809181751.219326-1-henryburns@google.com>
Message-Id: <20190809181751.219326-2-henryburns@google.com>
Mime-Version: 1.0
References: <20190809181751.219326-1-henryburns@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 2/2 v2] mm/zsmalloc.c: Fix race condition in zs_destroy_pool
From:   Henry Burns <henryburns@google.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        HenryBurns <henrywolfeburns@gmail.com>, linux-mm@kvack.org,
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

Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
Signed-off-by: Henry Burns <henryburns@google.com>
---
 Changelog since v1:
 - Changed the class level isolated count to a pool level isolated count
   (of zspages). Also added a pool level flag for when destruction
   starts and a memory barrier to ensure this flag has global
   visibility.

 mm/zsmalloc.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5105b9b66653..08def3a0d200 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -54,6 +54,7 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/migrate.h>
+#include <linux/wait.h>
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 
@@ -268,6 +269,10 @@ struct zs_pool {
 #ifdef CONFIG_COMPACTION
 	struct inode *inode;
 	struct work_struct free_work;
+	/* A wait queue for when migration races with async_free_zspage() */
+	struct wait_queue_head migration_wait;
+	atomic_long_t isolated_pages;
+	bool destroying;
 #endif
 };
 
@@ -1874,6 +1879,19 @@ static void putback_zspage_deferred(struct zs_pool *pool,
 
 }
 
+static inline void zs_pool_dec_isolated(struct zs_pool *pool)
+{
+	VM_BUG_ON(atomic_long_read(&pool->isolated_pages) <= 0);
+	atomic_long_dec(&pool->isolated_pages);
+	/*
+	 * There's no possibility of racing, since wait_for_isolated_drain()
+	 * checks the isolated count under &class->lock after enqueuing
+	 * on migration_wait.
+	 */
+	if (atomic_long_read(&pool->isolated_pages) == 0 && pool->destroying)
+		wake_up_all(&pool->migration_wait);
+}
+
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct page *newpage, struct page *oldpage)
 {
@@ -1943,6 +1961,7 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	 */
 	if (!list_empty(&zspage->list) && !is_zspage_isolated(zspage)) {
 		get_zspage_mapping(zspage, &class_idx, &fullness);
+		atomic_long_inc(&pool->isolated_pages);
 		remove_zspage(class, zspage, fullness);
 	}
 
@@ -2042,8 +2061,16 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	 * Page migration is done so let's putback isolated zspage to
 	 * the list if @page is final isolated subpage in the zspage.
 	 */
-	if (!is_zspage_isolated(zspage))
+	if (!is_zspage_isolated(zspage)) {
+		/*
+		 * We cannot race with zs_destroy_pool() here because we wait
+		 * for isolation to hit zero before we start destroying.
+		 * Also, we ensure that everyone can see pool->destroying before
+		 * we start waiting.
+		 */
 		putback_zspage_deferred(pool, class, zspage);
+		zs_pool_dec_isolated(pool);
+	}
 
 	reset_page(page);
 	put_page(page);
@@ -2094,8 +2121,8 @@ static void zs_page_putback(struct page *page)
 		 * so let's defer.
 		 */
 		putback_zspage_deferred(pool, class, zspage);
+		zs_pool_dec_isolated(pool);
 	}
-
 	spin_unlock(&class->lock);
 }
 
@@ -2118,8 +2145,36 @@ static int zs_register_migration(struct zs_pool *pool)
 	return 0;
 }
 
+static bool pool_isolated_are_drained(struct zs_pool *pool)
+{
+	return atomic_long_read(&pool->isolated_pages) == 0;
+}
+
+/* Function for resolving migration */
+static void wait_for_isolated_drain(struct zs_pool *pool)
+{
+
+	/*
+	 * We're in the process of destroying the pool, so there are no
+	 * active allocations. zs_page_isolate() fails for completely free
+	 * zspages, so we need only wait for the zs_pool's isolated
+	 * count to hit zero.
+	 */
+	wait_event(pool->migration_wait,
+		   pool_isolated_are_drained(pool));
+}
+
 static void zs_unregister_migration(struct zs_pool *pool)
 {
+	pool->destroying = true;
+	/*
+	 * We need a memory barrier here to ensure global visibility of
+	 * pool->destroying. Thus pool->isolated pages will either be 0 in which
+	 * case we don't care, or it will be > 0 and pool->destroying will
+	 * ensure that we wake up once isolation hits 0.
+	 */
+	smp_mb();
+	wait_for_isolated_drain(pool); /* This can block */
 	flush_work(&pool->free_work);
 	iput(pool->inode);
 }
@@ -2357,6 +2412,8 @@ struct zs_pool *zs_create_pool(const char *name)
 	if (!pool->name)
 		goto err;
 
+	init_waitqueue_head(&pool->migration_wait);
+
 	if (create_cache(pool))
 		goto err;
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

