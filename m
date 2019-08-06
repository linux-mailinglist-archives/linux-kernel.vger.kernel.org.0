Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6B83648
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfHFQGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 12:06:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbfHFQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SLYhAoIvzDqEf4YX6gjEiCAIywOZyrNyWp5yd9O/FEc=; b=ZNuLdRhAOMk24S174/yZdDV6qO
        lGDI8hj/2Sp6HzhN6L4ltpD8OkBMyBd8t54sr7xtN/Nm0X9aScPZNYbr6e24CdIcFY0ifRnqbhvSx
        g4e1gGltvFziBE4qSwzZL3Mpsx87iJegFvxi/T6uj3sYDUyXUrnVVrzbxRnMDWlxU6AJLWqgv2JK7
        H7WPXVEgRHKLJLJ2yCGHOBFynfDAy/39Yl1kWt9L1tZOkXaAWNOnFq/1380shWLbJiJpBGFU1D6Dq
        3N6XXfM9pTJqjDNxS7LuY57MTjTKAcw3aS1ggvk+SOq+w5ey5DAXmyTNXS5yU3KC4vdcf/IlskrE4
        GWrBdBhg==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yQ-0000XS-IJ; Tue, 06 Aug 2019 16:06:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Date:   Tue,  6 Aug 2019 19:05:42 +0300
Message-Id: <20190806160554.14046-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single place where the pgmap is passed over a function
call, so replace it with local variables in the places where we deal
with the pgmap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 62 ++++++++++++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 9a908902e4cc..d66fa29b42e0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -278,7 +278,6 @@ EXPORT_SYMBOL(hmm_mirror_unregister);
 
 struct hmm_vma_walk {
 	struct hmm_range	*range;
-	struct dev_pagemap	*pgmap;
 	unsigned long		last;
 	unsigned int		flags;
 };
@@ -475,6 +474,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
+	struct dev_pagemap *pgmap = NULL;
 	unsigned long pfn, npages, i;
 	bool fault, write_fault;
 	uint64_t cpu_flags;
@@ -490,17 +490,14 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 	pfn = pmd_pfn(pmd) + pte_index(addr);
 	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
 		if (pmd_devmap(pmd)) {
-			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
-					      hmm_vma_walk->pgmap);
-			if (unlikely(!hmm_vma_walk->pgmap))
+			pgmap = get_dev_pagemap(pfn, pgmap);
+			if (unlikely(!pgmap))
 				return -EBUSY;
 		}
 		pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
 	}
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
+	if (pgmap)
+		put_dev_pagemap(pgmap);
 	hmm_vma_walk->last = end;
 	return 0;
 #else
@@ -520,7 +517,7 @@ static inline uint64_t pte_to_hmm_pfn_flags(struct hmm_range *range, pte_t pte)
 
 static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			      unsigned long end, pmd_t *pmdp, pte_t *ptep,
-			      uint64_t *pfn)
+			      uint64_t *pfn, struct dev_pagemap **pgmap)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
@@ -591,9 +588,8 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		goto fault;
 
 	if (pte_devmap(pte)) {
-		hmm_vma_walk->pgmap = get_dev_pagemap(pte_pfn(pte),
-					      hmm_vma_walk->pgmap);
-		if (unlikely(!hmm_vma_walk->pgmap))
+		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
+		if (unlikely(!*pgmap))
 			return -EBUSY;
 	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
 		*pfn = range->values[HMM_PFN_SPECIAL];
@@ -604,10 +600,10 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	return 0;
 
 fault:
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
+	if (*pgmap)
+		put_dev_pagemap(*pgmap);
+	*pgmap = NULL;
+
 	pte_unmap(ptep);
 	/* Fault any virtual address we were asked to fault */
 	return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
@@ -620,6 +616,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
+	struct dev_pagemap *pgmap = NULL;
 	uint64_t *pfns = range->pfns;
 	unsigned long addr = start, i;
 	pte_t *ptep;
@@ -683,23 +680,21 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	for (; addr < end; addr += PAGE_SIZE, ptep++, i++) {
 		int r;
 
-		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, &pfns[i]);
+		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, &pfns[i],
+				&pgmap);
 		if (r) {
 			/* hmm_vma_handle_pte() did unmap pte directory */
 			hmm_vma_walk->last = addr;
 			return r;
 		}
 	}
-	if (hmm_vma_walk->pgmap) {
-		/*
-		 * We do put_dev_pagemap() here and not in hmm_vma_handle_pte()
-		 * so that we can leverage get_dev_pagemap() optimization which
-		 * will not re-take a reference on a pgmap if we already have
-		 * one.
-		 */
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
+	/*
+	 * We do put_dev_pagemap() here and not in hmm_vma_handle_pte() so that
+	 * we can leverage the get_dev_pagemap() optimization which will not
+	 * re-take a reference on a pgmap if we already have one.
+	 */
+	if (pgmap)
+		put_dev_pagemap(pgmap);
 	pte_unmap(ptep - 1);
 
 	hmm_vma_walk->last = addr;
@@ -714,6 +709,7 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long addr = start, next;
+	struct dev_pagemap *pgmap = NULL;
 	pmd_t *pmdp;
 	pud_t pud;
 	int ret;
@@ -744,17 +740,14 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 		for (i = 0; i < npages; ++i, ++pfn) {
-			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
-					      hmm_vma_walk->pgmap);
-			if (unlikely(!hmm_vma_walk->pgmap))
+			pgmap = get_dev_pagemap(pfn, pgmap);
+			if (unlikely(!pgmap))
 				return -EBUSY;
 			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				  cpu_flags;
 		}
-		if (hmm_vma_walk->pgmap) {
-			put_dev_pagemap(hmm_vma_walk->pgmap);
-			hmm_vma_walk->pgmap = NULL;
-		}
+		if (pgmap)
+			put_dev_pagemap(pgmap);
 		hmm_vma_walk->last = end;
 		return 0;
 	}
@@ -1002,7 +995,6 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 			return -EPERM;
 		}
 
-		hmm_vma_walk.pgmap = NULL;
 		hmm_vma_walk.last = start;
 		hmm_vma_walk.flags = flags;
 		hmm_vma_walk.range = range;
-- 
2.20.1

