Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD07DDB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 16:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfHAOVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 10:21:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfHAOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mpHyjnJR17EzfHojRb2JoLPTrVjdaNl1TnjSHWzORXw=; b=NtiYtJVEmDfDxmTbI5QbPew0xT
        zEQbgiotyyVtl+/aNeJqPjLDkgyw4xpO15KvT7vfKK9pncilCrG1v7qLtwzbBn//rNMTVvBaozUJS
        H5AzJslFkM8k8ljq1UrrfmIhWdKAXaLxQz9G6E0jUN8QLV1XUDdGEvV3HaANH/N5oU46TicGUJGXP
        IbfJcEF0D32Wgd8ZSL0Zpu5bJEp12MEZLb5JIsiNCz3RptGT2CIrOj9qApxv0OGQsUkbxXBSj01B0
        6JYc12+UjSGY9cHW/PJuj6m12u6LSGvygP9z1CPj7bq5yZn2XPNbk8jM86THnubHsqC5NBcPobQkK
        Osll/wtQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htBxT-0006Ja-DI; Thu, 01 Aug 2019 14:21:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Date:   Thu,  1 Aug 2019 17:21:18 +0300
Message-Id: <20190801142118.21225-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801142118.21225-1-hch@lst.de>
References: <20190801142118.21225-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the way back to introducing dma_common_mmap we've defaulyed to mark
the pages as uncached.  But this is wrong for DMA coherent devices or
if using DMA_ATTR_NON_CONSISTENT.  Later on DMA_ATTR_WRITE_COMBINE
also got incorrect treatment as that flag is only treated special on
the alloc side for non-coherent devices.

Introduce a new dma_mmap_pgprot helper that deals with the check
for coherent devices and DMA_ATTR_NON_CONSISTENT so that only the
remapping cases even reach arch_dma_mmap_pgprot and we thus ensure
no aliasing of page attributes happens.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c        |  4 +---
 arch/arm64/mm/dma-mapping.c      |  4 +---
 arch/powerpc/kernel/Makefile     |  3 +--
 arch/powerpc/kernel/dma-common.c | 17 -----------------
 drivers/iommu/dma-iommu.c        |  6 +++---
 include/linux/dma-mapping.h      |  1 +
 include/linux/dma-noncoherent.h  |  5 -----
 kernel/dma/mapping.c             | 11 ++++++++++-
 kernel/dma/remap.c               |  2 +-
 9 files changed, 18 insertions(+), 35 deletions(-)
 delete mode 100644 arch/powerpc/kernel/dma-common.c

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9c9a23e5600d..cfe44df169c5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2397,9 +2397,7 @@ long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
 pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
 		unsigned long attrs)
 {
-	if (!dev_is_dma_coherent(dev))
-		return __get_dma_pgprot(attrs, prot);
-	return prot;
+	return __get_dma_pgprot(attrs, prot);
 }
 
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 1d3f0b5a9940..bd2b039f43a6 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -14,9 +14,7 @@
 pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
 		unsigned long attrs)
 {
-	if (!dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_WRITE_COMBINE))
-		return pgprot_writecombine(prot);
-	return prot;
+	return pgprot_writecombine(prot);
 }
 
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ea0c69236789..56dfa7a2a6f2 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -49,8 +49,7 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
-				   of_platform.o prom_parse.o \
-				   dma-common.o
+				   of_platform.o prom_parse.o
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o nvram_64.o firmware.o
diff --git a/arch/powerpc/kernel/dma-common.c b/arch/powerpc/kernel/dma-common.c
deleted file mode 100644
index dc7ef6b17b69..000000000000
--- a/arch/powerpc/kernel/dma-common.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Contains common dma routines for all powerpc platforms.
- *
- * Copyright (C) 2019 Shawn Anastasio.
- */
-
-#include <linux/mm.h>
-#include <linux/dma-noncoherent.h>
-
-pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
-		unsigned long attrs)
-{
-	if (!dev_is_dma_coherent(dev))
-		return pgprot_noncached(prot);
-	return prot;
-}
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a7f9c3edbcb2..703de9a7553f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -574,7 +574,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	struct iova_domain *iovad = &cookie->iovad;
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
-	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+	pgprot_t prot = dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
 	struct page **pages;
 	struct sg_table sgt;
@@ -975,7 +975,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 		return NULL;
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && (!coherent || PageHighMem(page))) {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+		pgprot_t prot = dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
 		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
 				VM_USERMAP, prot, __builtin_return_address(0));
@@ -1035,7 +1035,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn, off = vma->vm_pgoff;
 	int ret;
 
-	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
+	vma->vm_page_prot = dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 633dae466097..c61d7870277f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -611,6 +611,7 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
 #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
 
+pgprot_t dma_mmap_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs);
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 3813211a9aad..9ae5cee543c4 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -42,13 +42,8 @@ void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
 long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
 		dma_addr_t dma_addr);
-
-#ifdef CONFIG_ARCH_HAS_DMA_MMAP_PGPROT
 pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
 		unsigned long attrs);
-#else
-# define arch_dma_mmap_pgprot(dev, prot, attrs)	pgprot_noncached(prot)
-#endif
 
 #ifdef CONFIG_DMA_NONCOHERENT_CACHE_SYNC
 void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 815446f76995..357ae5cdb91b 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -162,6 +162,15 @@ int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
 }
 EXPORT_SYMBOL(dma_get_sgtable_attrs);
 
+pgprot_t dma_mmap_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
+{
+	if (dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_NON_CONSISTENT))
+		return prot;
+	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_MMAP_PGPROT))
+		return arch_dma_mmap_pgprot(dev, prot, attrs);
+	return pgprot_noncached(prot);
+}
+
 /*
  * Create userspace mapping for the DMA-coherent memory.
  */
@@ -175,7 +184,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn;
 	int ret = -ENXIO;
 
-	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
+	vma->vm_page_prot = dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index a594aec07882..3d75c79b124c 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -218,7 +218,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	/* create a coherent mapping */
 	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
-			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
+			dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
 			__builtin_return_address(0));
 	if (!ret) {
 		__dma_direct_free_pages(dev, size, page);
-- 
2.20.1

