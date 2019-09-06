Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C01AB254
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 08:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391583AbfIFGQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 02:16:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:4005 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388719AbfIFGQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 02:16:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 23:16:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="383159428"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2019 23:16:47 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com,
        kevin.tian@intel.com, mika.westerberg@linux.intel.com,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v9 5/5] iommu/vt-d: Use bounce buffer for untrusted devices
Date:   Fri,  6 Sep 2019 14:14:52 +0800
Message-Id: <20190906061452.30791-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906061452.30791-1-baolu.lu@linux.intel.com>
References: <20190906061452.30791-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel VT-d hardware uses paging for DMA remapping.
The minimum mapped window is a page size. The device
drivers may map buffers not filling the whole IOMMU
window. This allows the device to access to possibly
unrelated memory and a malicious device could exploit
this to perform DMA attacks. To address this, the
Intel IOMMU driver will use bounce pages for those
buffers which don't fill whole IOMMU pages.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-iommu.c | 258 ++++++++++++++++++++++++++++++++++++
 1 file changed, 258 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0720fd7b262b..c6935172df81 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -41,9 +41,11 @@
 #include <linux/dma-direct.h>
 #include <linux/crash_dump.h>
 #include <linux/numa.h>
+#include <linux/swiotlb.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
+#include <trace/events/intel_iommu.h>
 
 #include "irq_remapping.h"
 #include "intel-pasid.h"
@@ -346,6 +348,8 @@ static int domain_detach_iommu(struct dmar_domain *domain,
 static bool device_is_rmrr_locked(struct device *dev);
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev);
+static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
+					    dma_addr_t iova);
 
 #ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
 int dmar_disabled = 0;
@@ -3783,6 +3787,252 @@ static const struct dma_map_ops intel_dma_ops = {
 	.dma_supported = dma_direct_supported,
 };
 
+static void
+bounce_sync_single(struct device *dev, dma_addr_t addr, size_t size,
+		   enum dma_data_direction dir, enum dma_sync_target target)
+{
+	struct dmar_domain *domain;
+	phys_addr_t tlb_addr;
+
+	domain = find_domain(dev);
+	if (WARN_ON(!domain))
+		return;
+
+	tlb_addr = intel_iommu_iova_to_phys(&domain->domain, addr);
+	if (is_swiotlb_buffer(tlb_addr))
+		swiotlb_tbl_sync_single(dev, tlb_addr, size, dir, target);
+}
+
+static dma_addr_t
+bounce_map_single(struct device *dev, phys_addr_t paddr, size_t size,
+		  enum dma_data_direction dir, unsigned long attrs,
+		  u64 dma_mask)
+{
+	size_t aligned_size = ALIGN(size, VTD_PAGE_SIZE);
+	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
+	unsigned long iova_pfn;
+	unsigned long nrpages;
+	phys_addr_t tlb_addr;
+	int prot = 0;
+	int ret;
+
+	domain = find_domain(dev);
+	if (WARN_ON(dir == DMA_NONE || !domain))
+		return DMA_MAPPING_ERROR;
+
+	iommu = domain_get_iommu(domain);
+	if (WARN_ON(!iommu))
+		return DMA_MAPPING_ERROR;
+
+	nrpages = aligned_nrpages(0, size);
+	iova_pfn = intel_alloc_iova(dev, domain,
+				    dma_to_mm_pfn(nrpages), dma_mask);
+	if (!iova_pfn)
+		return DMA_MAPPING_ERROR;
+
+	/*
+	 * Check if DMAR supports zero-length reads on write only
+	 * mappings..
+	 */
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL ||
+			!cap_zlr(iommu->cap))
+		prot |= DMA_PTE_READ;
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		prot |= DMA_PTE_WRITE;
+
+	/*
+	 * If both the physical buffer start address and size are
+	 * page aligned, we don't need to use a bounce page.
+	 */
+	if (!IS_ALIGNED(paddr | size, VTD_PAGE_SIZE)) {
+		tlb_addr = swiotlb_tbl_map_single(dev,
+				__phys_to_dma(dev, io_tlb_start),
+				paddr, size, aligned_size, dir, attrs);
+		if (tlb_addr == DMA_MAPPING_ERROR) {
+			goto swiotlb_error;
+		} else {
+			/* Cleanup the padding area. */
+			void *padding_start = phys_to_virt(tlb_addr);
+			size_t padding_size = aligned_size;
+
+			if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+			    (dir == DMA_TO_DEVICE ||
+			     dir == DMA_BIDIRECTIONAL)) {
+				padding_start += size;
+				padding_size -= size;
+			}
+
+			memset(padding_start, 0, padding_size);
+		}
+	} else {
+		tlb_addr = paddr;
+	}
+
+	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
+				 tlb_addr >> VTD_PAGE_SHIFT, nrpages, prot);
+	if (ret)
+		goto mapping_error;
+
+	trace_bounce_map_single(dev, iova_pfn << PAGE_SHIFT, paddr, size);
+
+	return (phys_addr_t)iova_pfn << PAGE_SHIFT;
+
+mapping_error:
+	if (is_swiotlb_buffer(tlb_addr))
+		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
+					 aligned_size, dir, attrs);
+swiotlb_error:
+	free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(nrpages));
+	dev_err(dev, "Device bounce map: %zx@%llx dir %d --- failed\n",
+		size, (unsigned long long)paddr, dir);
+
+	return DMA_MAPPING_ERROR;
+}
+
+static void
+bounce_unmap_single(struct device *dev, dma_addr_t dev_addr, size_t size,
+		    enum dma_data_direction dir, unsigned long attrs)
+{
+	size_t aligned_size = ALIGN(size, VTD_PAGE_SIZE);
+	struct dmar_domain *domain;
+	phys_addr_t tlb_addr;
+
+	domain = find_domain(dev);
+	if (WARN_ON(!domain))
+		return;
+
+	tlb_addr = intel_iommu_iova_to_phys(&domain->domain, dev_addr);
+	if (WARN_ON(!tlb_addr))
+		return;
+
+	intel_unmap(dev, dev_addr, size);
+	if (is_swiotlb_buffer(tlb_addr))
+		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
+					 aligned_size, dir, attrs);
+
+	trace_bounce_unmap_single(dev, dev_addr, size);
+}
+
+static dma_addr_t
+bounce_map_page(struct device *dev, struct page *page, unsigned long offset,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	return bounce_map_single(dev, page_to_phys(page) + offset,
+				 size, dir, attrs, *dev->dma_mask);
+}
+
+static dma_addr_t
+bounce_map_resource(struct device *dev, phys_addr_t phys_addr, size_t size,
+		    enum dma_data_direction dir, unsigned long attrs)
+{
+	return bounce_map_single(dev, phys_addr, size,
+				 dir, attrs, *dev->dma_mask);
+}
+
+static void
+bounce_unmap_page(struct device *dev, dma_addr_t dev_addr, size_t size,
+		  enum dma_data_direction dir, unsigned long attrs)
+{
+	bounce_unmap_single(dev, dev_addr, size, dir, attrs);
+}
+
+static void
+bounce_unmap_resource(struct device *dev, dma_addr_t dev_addr, size_t size,
+		      enum dma_data_direction dir, unsigned long attrs)
+{
+	bounce_unmap_single(dev, dev_addr, size, dir, attrs);
+}
+
+static void
+bounce_unmap_sg(struct device *dev, struct scatterlist *sglist, int nelems,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sglist, sg, nelems, i)
+		bounce_unmap_page(dev, sg->dma_address,
+				  sg_dma_len(sg), dir, attrs);
+}
+
+static int
+bounce_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
+	      enum dma_data_direction dir, unsigned long attrs)
+{
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(sglist, sg, nelems, i) {
+		sg->dma_address = bounce_map_page(dev, sg_page(sg),
+						  sg->offset, sg->length,
+						  dir, attrs);
+		if (sg->dma_address == DMA_MAPPING_ERROR)
+			goto out_unmap;
+		sg_dma_len(sg) = sg->length;
+	}
+
+	return nelems;
+
+out_unmap:
+	bounce_unmap_sg(dev, sglist, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
+	return 0;
+}
+
+static void
+bounce_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+			   size_t size, enum dma_data_direction dir)
+{
+	bounce_sync_single(dev, addr, size, dir, SYNC_FOR_CPU);
+}
+
+static void
+bounce_sync_single_for_device(struct device *dev, dma_addr_t addr,
+			      size_t size, enum dma_data_direction dir)
+{
+	bounce_sync_single(dev, addr, size, dir, SYNC_FOR_DEVICE);
+}
+
+static void
+bounce_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist,
+		       int nelems, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sglist, sg, nelems, i)
+		bounce_sync_single(dev, sg_dma_address(sg),
+				   sg_dma_len(sg), dir, SYNC_FOR_CPU);
+}
+
+static void
+bounce_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
+			  int nelems, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sglist, sg, nelems, i)
+		bounce_sync_single(dev, sg_dma_address(sg),
+				   sg_dma_len(sg), dir, SYNC_FOR_DEVICE);
+}
+
+static const struct dma_map_ops bounce_dma_ops = {
+	.alloc			= intel_alloc_coherent,
+	.free			= intel_free_coherent,
+	.map_sg			= bounce_map_sg,
+	.unmap_sg		= bounce_unmap_sg,
+	.map_page		= bounce_map_page,
+	.unmap_page		= bounce_unmap_page,
+	.sync_single_for_cpu	= bounce_sync_single_for_cpu,
+	.sync_single_for_device	= bounce_sync_single_for_device,
+	.sync_sg_for_cpu	= bounce_sync_sg_for_cpu,
+	.sync_sg_for_device	= bounce_sync_sg_for_device,
+	.map_resource		= bounce_map_resource,
+	.unmap_resource		= bounce_unmap_resource,
+	.dma_supported		= dma_direct_supported,
+};
+
 static inline int iommu_domain_cache_init(void)
 {
 	int ret = 0;
@@ -5376,6 +5626,11 @@ static int intel_iommu_add_device(struct device *dev)
 		}
 	}
 
+	if (device_needs_bounce(dev)) {
+		dev_info(dev, "Use Intel IOMMU bounce page dma_ops\n");
+		set_dma_ops(dev, &bounce_dma_ops);
+	}
+
 	return 0;
 }
 
@@ -5393,6 +5648,9 @@ static void intel_iommu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 
 	iommu_device_unlink(&iommu->iommu, dev);
+
+	if (device_needs_bounce(dev))
+		set_dma_ops(dev, NULL);
 }
 
 static void intel_iommu_get_resv_regions(struct device *device,
-- 
2.17.1

