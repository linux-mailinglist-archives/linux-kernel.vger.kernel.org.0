Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688A7DA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 04:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfD2CQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Apr 2019 22:16:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:46364 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfD2CQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 22:16:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 19:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146537843"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 19:16:00 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] iommu/vt-d: Implement apply_resv_region iommu ops entry
Date:   Mon, 29 Apr 2019 10:09:19 +0800
Message-Id: <20190429020925.18136-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429020925.18136-1-baolu.lu@linux.intel.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Sewart <jamessewart@arista.com>

Used by iommu.c before creating identity mappings for reserved
ranges to ensure dma-ops won't ever remap these ranges.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e0c0febc6fa5..af025955f1bc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5568,6 +5568,19 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	return ret;
 }
 
+static void intel_iommu_apply_resv_region(struct device *dev,
+					  struct iommu_domain *domain,
+					  struct iommu_resv_region *region)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned long start, end;
+
+	start = IOVA_PFN(region->start);
+	end   = IOVA_PFN(region->start + region->length - 1);
+
+	WARN_ON_ONCE(!reserve_iova(&dmar_domain->iovad, start, end));
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 {
@@ -5733,6 +5746,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.remove_device		= intel_iommu_remove_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.apply_resv_region	= intel_iommu_apply_resv_region,
 	.device_group		= pci_device_group,
 	.dev_has_feat		= intel_iommu_dev_has_feat,
 	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
-- 
2.17.1

