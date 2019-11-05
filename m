Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36868F08F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 23:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfKEWCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 17:02:42 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52663 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387510AbfKEWCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:02:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ThIYtiy_1572991352;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0ThIYtiy_1572991352)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Nov 2019 06:02:38 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: shmem: use proper gfp flags for shmem_writepage()
Date:   Wed,  6 Nov 2019 06:02:31 +0800
Message-Id: <1572991351-86061-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shmem_writepage() uses GFP_ATOMIC to allocate swap cache.
GFP_ATOMIC used to mean __GFP_HIGH, but now it means __GFP_HIGH |
__GFP_ATOMIC | __GFP_KSWAPD_RECLAIM.  However, shmem_writepage() should
write out to swap only in response to memory pressure, so
__GFP_KSWAPD_RECLAIM looks useless since the caller may be kswapd itself
or in direct reclaim already.

In addition, XArray node allocations from PF_MEMALLOC contexts could
completely exhaust the page allocator, __GFP_NOMEMALLOC stops emergency
reserves from being allocated.

Here just copy the gfp flags used by add_to_swap().

Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 220be9f..9691dec 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1369,7 +1369,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	if (list_empty(&info->swaplist))
 		list_add(&info->swaplist, &shmem_swaplist);
 
-	if (add_to_swap_cache(page, swap, GFP_ATOMIC) == 0) {
+	if (add_to_swap_cache(page, swap,
+			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN) == 0) {
 		spin_lock_irq(&info->lock);
 		shmem_recalc_inode(inode);
 		info->swapped++;
-- 
1.8.3.1

