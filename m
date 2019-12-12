Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0A11D96B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 23:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfLLWfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 17:35:04 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:37158 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730921AbfLLWfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:35:04 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ifX2s-0007l2-Ey; Thu, 12 Dec 2019 23:34:54 +0100
From:   Florian Westphal <fw@strlen.de>
To:     linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [PATCH] mm: remove __krealloc
Date:   Thu, 12 Dec 2019 23:34:42 +0100
Message-Id: <20191212223442.22141-1-fw@strlen.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 5.5-rc1 the last user of this function is gone, so remove the
functionality.

See commit
2ad9d7747c10 ("netfilter: conntrack: free extension area immediately")
for details.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/slab.h                    |  1 -
 mm/slab_common.c                        | 22 ----------------------
 scripts/coccinelle/free/devm_free.cocci |  4 ----
 3 files changed, 27 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 877a95c6a2d2..03a389358562 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -184,7 +184,6 @@ void memcg_deactivate_kmem_caches(struct mem_cgroup *, struct mem_cgroup *);
 /*
  * Common kmalloc functions provided by all allocators
  */
-void * __must_check __krealloc(const void *, size_t, gfp_t);
 void * __must_check krealloc(const void *, size_t, gfp_t);
 void kfree(const void *);
 void kzfree(const void *);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f0ab6d4ceb4c..87e8923cf0b6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1675,28 +1675,6 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
 	return ret;
 }
 
-/**
- * __krealloc - like krealloc() but don't free @p.
- * @p: object to reallocate memory for.
- * @new_size: how many bytes of memory are required.
- * @flags: the type of memory to allocate.
- *
- * This function is like krealloc() except it never frees the originally
- * allocated buffer. Use this if you don't want to free the buffer immediately
- * like, for example, with RCU.
- *
- * Return: pointer to the allocated memory or %NULL in case of error
- */
-void *__krealloc(const void *p, size_t new_size, gfp_t flags)
-{
-	if (unlikely(!new_size))
-		return ZERO_SIZE_PTR;
-
-	return __do_krealloc(p, new_size, flags);
-
-}
-EXPORT_SYMBOL(__krealloc);
-
 /**
  * krealloc - reallocate memory. The contents will remain unchanged.
  * @p: object to reallocate memory for.
diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
index 441799b5359b..66aaf68889a5 100644
--- a/scripts/coccinelle/free/devm_free.cocci
+++ b/scripts/coccinelle/free/devm_free.cocci
@@ -94,8 +94,6 @@ position p;
  kfree@p(x)
 |
  kzfree@p(x)
-|
- __krealloc@p(x, ...)
 |
  krealloc@p(x, ...)
 |
@@ -120,8 +118,6 @@ position p != safe.p;
 |
 * kzfree@p(x)
 |
-* __krealloc@p(x, ...)
-|
 * krealloc@p(x, ...)
 |
 * free_pages@p(x, ...)
-- 
2.23.0

