Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383EA73158
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGXOQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:16:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfGXOQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:16:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 69C3A31B2A1EFBD16A29;
        Wed, 24 Jul 2019 22:16:08 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 22:15:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <jglisse@redhat.com>,
        <kirill.shutemov@linux.intel.com>, <mike.kravetz@oracle.com>,
        <rcampbell@nvidia.com>, <ktkhai@virtuozzo.com>,
        <colin.king@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] mm/rmap.c: remove set but not used variable 'cstart'
Date:   Wed, 24 Jul 2019 22:14:53 +0800
Message-ID: <20190724141453.38536-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

mm/rmap.c: In function page_mkclean_one:
mm/rmap.c:906:17: warning: variable cstart set but not used [-Wunused-but-set-variable]

It is not used any more since
commit cdb07bdea28e ("mm/rmap.c: remove redundant variable cend")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/rmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index ec1af8b..40e4def 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -903,10 +903,9 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
-		unsigned long cstart;
 		int ret = 0;
 
-		cstart = address = pvmw.address;
+		address = pvmw.address;
 		if (pvmw.pte) {
 			pte_t entry;
 			pte_t *pte = pvmw.pte;
@@ -933,7 +932,6 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 			entry = pmd_wrprotect(entry);
 			entry = pmd_mkclean(entry);
 			set_pmd_at(vma->vm_mm, address, pmd, entry);
-			cstart &= PMD_MASK;
 			ret = 1;
 #else
 			/* unexpected pmd-mapped page? */
-- 
2.7.4


