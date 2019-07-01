Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193954491A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfFMRON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 13:14:13 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46714 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728939AbfFLV5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:57:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TU0Hbt._1560376624;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU0Hbt._1560376624)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jun 2019 05:57:14 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/4] mm: move mem_cgroup_uncharge out of __page_cache_release()
Date:   Thu, 13 Jun 2019 05:56:47 +0800
Message-Id: <1560376609-113689-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The later patch would make THP deferred split shrinker memcg aware, but
it needs page->mem_cgroup information in THP destructor, which is called
after mem_cgroup_uncharge() now.

So, move mem_cgroup_uncharge() from __page_cache_release() to compound
page destructor, which is called by both THP and other compound pages
except HugeTLB.  And call it in __put_single_page() for single order
page.

Suggested-by: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/page_alloc.c | 1 +
 mm/swap.c       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a82104a..7f27f4e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -623,6 +623,7 @@ static void bad_page(struct page *page, const char *reason,
 
 void free_compound_page(struct page *page)
 {
+	mem_cgroup_uncharge(page);
 	__free_pages_ok(page, compound_order(page));
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index 3a75722..982bd79 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -70,12 +70,12 @@ static void __page_cache_release(struct page *page)
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
 	__ClearPageWaiters(page);
-	mem_cgroup_uncharge(page);
 }
 
 static void __put_single_page(struct page *page)
 {
 	__page_cache_release(page);
+	mem_cgroup_uncharge(page);
 	free_unref_page(page);
 }
 
-- 
1.8.3.1

