Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83659443
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 08:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfF1GhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 02:37:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfF1GhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A4nnro33SKS+ZoxJK6myk3dsDChwFEmD9jdqdxtTrC8=; b=WQKOm/WutKj04mSDVdGqGK3Wo
        uNF9+bnGiUNW7V6mRxcH+rGVo/VaL4ge9gUA2b76bkocG51WkjHZtt59qTl6okdZdD9dnfFcBcBFy
        nMaTuGpW1bLutr+wcHU2wRRW4mG+fQQGkyIIiojSMuXc7fxqy0vdItDAcsk3rs1sYez9kbBJu8i3R
        3FnvnivWe82VAAsLZxiXP30Gdq4ps7COZe0/bT+eidTIrIxDe16GNATKLXylSOi73EepXnxVsy0PZ
        NGKm68Bfo0HPiIoGgm9qp5sWM5gUZl0KLjQtIaINakTxARvG1B2k2U9rz3S0lwgkfA35I9DjZZJGW
        R+/iCYl1Q==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgkVW-0006vr-5p; Fri, 28 Jun 2019 06:37:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: use the generic dma coherent remap allocator
Date:   Fri, 28 Jun 2019 08:37:12 +0200
Message-Id: <20190628063712.11281-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches to using common code for the DMA allocations, including
potential use of the CMA allocator if configured.  Also add a
comment where the existing behavior seems to be lacking.

Switching to the generic code enables DMA allocations from atomic
context, which is required by the DMA API documentation, and also
adds various other minor features drivers start relying upon.  It
also makes sure we have on tested code base for all architectures
that require uncached pte bits for coherent DMA allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig               |  2 ++
 arch/sh/kernel/dma-coherent.c | 51 ++---------------------------------
 2 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index b77f512bb176..414e175f1826 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -155,7 +155,9 @@ config DMA_COHERENT
 
 config DMA_NONCOHERENT
 	def_bool !DMA_COHERENT
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_DIRECT_REMAP
 
 config PGTABLE_LEVELS
 	default 3 if X2TLB
diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
index b17514619b7e..232594fc180f 100644
--- a/arch/sh/kernel/dma-coherent.c
+++ b/arch/sh/kernel/dma-coherent.c
@@ -3,60 +3,13 @@
  * Copyright (C) 2004 - 2007  Paul Mundt
  */
 #include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/dma-noncoherent.h>
-#include <linux/module.h>
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
+void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	void *ret, *ret_nocache;
-	int order = get_order(size);
-
-	gfp |= __GFP_ZERO;
-
-	ret = (void *)__get_free_pages(gfp, order);
-	if (!ret)
-		return NULL;
-
-	/*
-	 * Pages from the page allocator may have data present in
-	 * cache. So flush the cache before using uncached memory.
-	 */
-	arch_sync_dma_for_device(dev, virt_to_phys(ret), size,
-			DMA_BIDIRECTIONAL);
-
-	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
-	if (!ret_nocache) {
-		free_pages((unsigned long)ret, order);
-		return NULL;
-	}
-
-	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
-
-	*dma_handle = virt_to_phys(ret);
-	if (!WARN_ON(!dev))
-		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
-
-	return ret_nocache;
-}
-
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
-{
-	int order = get_order(size);
-	unsigned long pfn = (dma_handle >> PAGE_SHIFT);
-	int k;
-
-	if (!WARN_ON(!dev))
-		pfn += dev->dma_pfn_offset;
-
-	for (k = 0; k < (1 << order); k++)
-		__free_pages(pfn_to_page(pfn + k), 0);
-
-	iounmap(vaddr);
+	__flush_purge_region(sh_cacheop_vaddr(page_to_phys(page)), size);
 }
 
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
-- 
2.20.1

