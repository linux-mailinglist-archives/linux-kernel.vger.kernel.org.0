Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6666188C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 18:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCQRnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 13:43:16 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59924 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgCQRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:43:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tstzj4p_1584466980;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tstzj4p_1584466980)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Mar 2020 01:43:07 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     shakeelb@google.com, vbabka@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/2] mm: swap: use smp_mb__after_atomic() to order LRU bit set
Date:   Wed, 18 Mar 2020 01:42:51 +0800
Message-Id: <1584466971-110029-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584466971-110029-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1584466971-110029-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory barrier is needed after setting LRU bit, but smp_mb() is too
strong.  Some architectures, i.e. x86, imply memory barrier with atomic
operations, so replacing it with smp_mb__after_atomic() sounds better,
which is nop on strong ordered machines, and full memory barriers on
others.  With this change the vm-calability cases would perform better
on x86, I saw total 6% improvement with this patch and previous inline
fix.

The test data (lru-file-readtwice throughput) against v5.6-rc4:
	mainline	w/ inline fix	w/ both (adding this)
	150MB		154MB		159MB

Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-and-Tested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v3: * Added Shakeel's review-and-test signature.
v2: * Solved the comment from Vlastimil and added his Ack.

 mm/swap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index cf39d24..74ea08a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -931,7 +931,6 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
-	SetPageLRU(page);
 	/*
 	 * Page becomes evictable in two ways:
 	 * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
@@ -958,7 +957,8 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 	 * looking at the same page) and the evictable page will be stranded
 	 * in an unevictable LRU.
 	 */
-	smp_mb();
+	SetPageLRU(page);
+	smp_mb__after_atomic();
 
 	if (page_evictable(page)) {
 		lru = page_lru(page);
-- 
1.8.3.1

