Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FC1A574C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 15:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfIBNIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 09:08:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbfIBNIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5y1O7KTPIhcgWpwUMW10Qm/8B4aqevpsq+Tc+hdiuQQ=; b=QSaXCxZNc0SSS4JsH1VMEcgFmo
        8Q503fZzyWJJbyFnE+wFF3P0coYYWRdENaS5Erz5G/egOTlhZvPcx7OYSj45PcHXJWcDAqjzGyIYV
        IdWGWovEt8e+izmuIBQogxekzkn5k5nz5UJASO/YlC4yNZ3hKjqNEhtkWfDGVuWXp/zdasr/ouUxI
        CxvGTgCNxczxZ1zSVv9/uBwN6g6oTx45/sg6ISlXCVJWxzcs6wBMvx0OK5I3P6LFBmT6+JsOLwVGN
        ZVSnAcFJtZ9nFGr2WeRaRfVhFgfoOx6cHwYBVI3pN2sGobPC07nYFymANLy0RKRBTrh0J1FyGv207
        fzBW+H8A==;
Received: from 213-225-38-191.nat.highway.a1.net ([213.225.38.191] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4m4T-0006ry-8K; Mon, 02 Sep 2019 13:08:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        gross@suse.com, boris.ostrovsky@oracle.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] swiotlb-xen: simplify cache maintainance
Date:   Mon,  2 Sep 2019 15:03:36 +0200
Message-Id: <20190902130339.23163-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902130339.23163-1-hch@lst.de>
References: <20190902130339.23163-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we know we always have the dma-noncoherent.h helpers available
if we are on an architecture with support for non-coherent devices,
we can just call them directly, and remove the calls to the dma-direct
routines, including the fact that we call the dma_direct_map_page
routines but ignore the value returned from it.  Instead we now have
Xen wrappers for the arch_sync_dma_for_{device,cpu} helpers that call
the special Xen versions of those routines for foreign pages.

Note that the new helpers get the physical address passed in addition
to the dma address to avoid another translation for the local cache
maintainance.  The pfn_valid checks remain on the dma address as in
the old code, even if that looks a little funny.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 arch/arm/xen/mm.c                        | 64 ++++++----------------
 arch/x86/include/asm/xen/page-coherent.h | 11 ----
 drivers/xen/swiotlb-xen.c                | 20 +++----
 include/xen/arm/page-coherent.h          | 69 ++----------------------
 4 files changed, 31 insertions(+), 133 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 9d73fa4a5991..2b2c208408bb 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -60,63 +60,33 @@ static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
 	} while (size);
 }
 
-static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir)
+/*
+ * Dom0 is mapped 1:1, and while the Linux page can span across multiple Xen
+ * pages, it is not possible for it to contain a mix of local and foreign Xen
+ * pages.  Calling pfn_valid on a foreign mfn will always return false, so if
+ * pfn_valid returns true the pages is local and we can use the native
+ * dma-direct functions, otherwise we call the Xen specific version.
+ */
+void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
+		phys_addr_t paddr, size_t size, enum dma_data_direction dir)
 {
-	if (dir != DMA_TO_DEVICE)
+	if (pfn_valid(PFN_DOWN(handle)))
+		arch_sync_dma_for_cpu(dev, paddr, size, dir);
+	else if (dir != DMA_TO_DEVICE)
 		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
 }
 
-static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir)
+void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
+		phys_addr_t paddr, size_t size, enum dma_data_direction dir)
 {
-	if (dir == DMA_FROM_DEVICE)
+	if (pfn_valid(PFN_DOWN(handle)))
+		arch_sync_dma_for_device(dev, paddr, size, dir);
+	else if (dir == DMA_FROM_DEVICE)
 		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
 	else
 		dma_cache_maint(handle, size, GNTTAB_CACHE_CLEAN);
 }
 
-void __xen_dma_map_page(struct device *hwdev, struct page *page,
-	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, unsigned long attrs)
-{
-	if (dev_is_dma_coherent(hwdev))
-		return;
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return;
-
-	__xen_dma_page_cpu_to_dev(hwdev, dev_addr, size, dir);
-}
-
-void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-
-{
-	if (dev_is_dma_coherent(hwdev))
-		return;
-	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-		return;
-
-	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
-}
-
-void __xen_dma_sync_single_for_cpu(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	if (dev_is_dma_coherent(hwdev))
-		return;
-	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
-}
-
-void __xen_dma_sync_single_for_device(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	if (dev_is_dma_coherent(hwdev))
-		return;
-	__xen_dma_page_cpu_to_dev(hwdev, handle, size, dir);
-}
-
 bool xen_arch_need_swiotlb(struct device *dev,
 			   phys_addr_t phys,
 			   dma_addr_t dev_addr)
diff --git a/arch/x86/include/asm/xen/page-coherent.h b/arch/x86/include/asm/xen/page-coherent.h
index 8ee33c5edded..c9c8398a31ff 100644
--- a/arch/x86/include/asm/xen/page-coherent.h
+++ b/arch/x86/include/asm/xen/page-coherent.h
@@ -2,17 +2,6 @@
 #ifndef _ASM_X86_XEN_PAGE_COHERENT_H
 #define _ASM_X86_XEN_PAGE_COHERENT_H
 
-#include <asm/page.h>
-#include <linux/dma-mapping.h>
-
-static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
-	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, unsigned long attrs) { }
-
-static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs) { }
-
 static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index f9dd4cb6e4b3..a642e284f1e2 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -28,6 +28,7 @@
 
 #include <linux/memblock.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/export.h>
 #include <xen/swiotlb-xen.h>
 #include <xen/page.h>
@@ -390,6 +391,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
+	phys = map;
 	dev_addr = xen_phys_to_bus(map);
 
 	/*
@@ -401,14 +403,9 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 		return DMA_MAPPING_ERROR;
 	}
 
-	page = pfn_to_page(map >> PAGE_SHIFT);
-	offset = map & ~PAGE_MASK;
 done:
-	/*
-	 * we are not interested in the dma_addr returned by xen_dma_map_page,
-	 * only in the potential cache flushes executed by the function.
-	 */
-	xen_dma_map_page(dev, page, dev_addr, offset, size, dir, attrs);
+	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		xen_dma_sync_for_device(dev, dev_addr, phys, size, dir);
 	return dev_addr;
 }
 
@@ -428,7 +425,8 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	xen_dma_unmap_page(hwdev, dev_addr, size, dir, attrs);
+	if (!dev_is_dma_coherent(hwdev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		xen_dma_sync_for_cpu(hwdev, dev_addr, paddr, size, dir);
 
 	/* NOTE: We use dev_addr here, not paddr! */
 	if (is_xen_swiotlb_buffer(dev_addr))
@@ -448,7 +446,8 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 {
 	phys_addr_t paddr = xen_bus_to_phys(dma_addr);
 
-	xen_dma_sync_single_for_cpu(dev, dma_addr, size, dir);
+	if (!dev_is_dma_coherent(dev))
+		xen_dma_sync_for_cpu(dev, dma_addr, paddr, size, dir);
 
 	if (is_xen_swiotlb_buffer(dma_addr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
@@ -463,7 +462,8 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 	if (is_xen_swiotlb_buffer(dma_addr))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
 
-	xen_dma_sync_single_for_device(dev, dma_addr, size, dir);
+	if (!dev_is_dma_coherent(dev))
+		xen_dma_sync_for_device(dev, dma_addr, paddr, size, dir);
 }
 
 /*
diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
index 07c104dbc21f..635492d41ebe 100644
--- a/include/xen/arm/page-coherent.h
+++ b/include/xen/arm/page-coherent.h
@@ -2,70 +2,9 @@
 #ifndef _XEN_ARM_PAGE_COHERENT_H
 #define _XEN_ARM_PAGE_COHERENT_H
 
-#include <linux/dma-mapping.h>
-#include <asm/page.h>
-
-void __xen_dma_map_page(struct device *hwdev, struct page *page,
-	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, unsigned long attrs);
-void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs);
-void __xen_dma_sync_single_for_cpu(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir);
-void __xen_dma_sync_single_for_device(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir);
-
-static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	unsigned long pfn = PFN_DOWN(handle);
-
-	if (pfn_valid(pfn))
-		dma_direct_sync_single_for_cpu(hwdev, handle, size, dir);
-	else
-		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
-}
-
-static inline void xen_dma_sync_single_for_device(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	unsigned long pfn = PFN_DOWN(handle);
-	if (pfn_valid(pfn))
-		dma_direct_sync_single_for_device(hwdev, handle, size, dir);
-	else
-		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
-}
-
-static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
-	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, unsigned long attrs)
-{
-	unsigned long pfn = PFN_DOWN(dev_addr);
-
-	/*
-	 * Dom0 is mapped 1:1, and while the Linux page can span across multiple
-	 * Xen pages, it is not possible for it to contain a mix of local and
-	 * foreign Xen pages.  Calling pfn_valid on a foreign mfn will always
-	 * return false, so if pfn_valid returns true the pages is local and we
-	 * can use the native dma-direct functions, otherwise we call the Xen
-	 * specific version.
-	 */
-	if (pfn_valid(pfn))
-		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
-	else
-		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
-}
-
-static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	unsigned long pfn = PFN_DOWN(handle);
-
-	if (pfn_valid(pfn))
-		dma_direct_unmap_page(hwdev, handle, size, dir, attrs);
-	else
-		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
-}
+void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
+		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
+void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
+		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
 
 #endif /* _XEN_ARM_PAGE_COHERENT_H */
-- 
2.20.1

