Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63086184EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 19:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCMSfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 14:35:06 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50132 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727279AbgCMSfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:35:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TsUkHy3_1584124485;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TsUkHy3_1584124485)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 14 Mar 2020 02:34:53 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     shakeelb@google.com, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: swap: use smp_mb__after_atomic() to order LRU bit set
Date:   Sat, 14 Mar 2020 02:34:36 +0800
Message-Id: <1584124476-76534-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
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
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/swap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index cf39d24..118bac4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -945,20 +945,20 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 	 * #0: __pagevec_lru_add_fn		#1: clear_page_mlock
 	 *
 	 * SetPageLRU()				TestClearPageMlocked()
-	 * smp_mb() // explicit ordering	// above provides strict
+	 * MB() 	// explicit ordering	// above provides strict
 	 *					// ordering
 	 * PageMlocked()			PageLRU()
 	 *
 	 *
 	 * if '#1' does not observe setting of PG_lru by '#0' and fails
 	 * isolation, the explicit barrier will make sure that page_evictable
-	 * check will put the page in correct LRU. Without smp_mb(), SetPageLRU
+	 * check will put the page in correct LRU. Without MB(), SetPageLRU
 	 * can be reordered after PageMlocked check and can make '#1' to fail
 	 * the isolation of the page whose Mlocked bit is cleared (#0 is also
 	 * looking at the same page) and the evictable page will be stranded
 	 * in an unevictable LRU.
 	 */
-	smp_mb();
+	smp_mb__after_atomic();
 
 	if (page_evictable(page)) {
 		lru = page_lru(page);
-- 
1.8.3.1

