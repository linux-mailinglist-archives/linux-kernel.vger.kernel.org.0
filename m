Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54312A31B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 07:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfEYFtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 01:49:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfEYFs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:48:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:48:57 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:54 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 05/15] iommu/vt-d: Add device_def_domain_type() helper
Date:   Sat, 25 May 2019 13:41:26 +0800
Message-Id: <20190525054136.27810-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper returns the default domain type that the device
requires.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 40 +++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bac226dc8360..e1663af4e01b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2958,29 +2958,37 @@ static bool device_is_rmrr_locked(struct device *dev)
 	return true;
 }
 
-static int iommu_should_identity_map(struct device *dev, int startup)
+/*
+ * Return the required default domain type for a specific device.
+ *
+ * @dev: the device in query
+ * @startup: true if this is during early boot
+ *
+ * Returns:
+ *  - IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain
+ *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
+ *  - 0: both identity and dynamic domains work for this device
+ */
+static int device_def_domain_type(struct device *dev, int startup)
 {
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
 		if (device_is_rmrr_locked(dev))
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 
 		/*
 		 * Prevent any device marked as untrusted from getting
 		 * placed into the statically identity mapping domain.
 		 */
 		if (pdev->untrusted)
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 
 		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
-			return 1;
+			return IOMMU_DOMAIN_IDENTITY;
 
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
-			return 1;
-
-		if (!(iommu_identity_mapping & IDENTMAP_ALL))
-			return 0;
+			return IOMMU_DOMAIN_IDENTITY;
 
 		/*
 		 * We want to start off with all devices in the 1:1 domain, and
@@ -3001,14 +3009,14 @@ static int iommu_should_identity_map(struct device *dev, int startup)
 		 */
 		if (!pci_is_pcie(pdev)) {
 			if (!pci_is_root_bus(pdev->bus))
-				return 0;
+				return IOMMU_DOMAIN_DMA;
 			if (pdev->class >> 8 == PCI_CLASS_BRIDGE_PCI)
-				return 0;
+				return IOMMU_DOMAIN_DMA;
 		} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_PCI_BRIDGE)
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 	} else {
 		if (device_has_rmrr(dev))
-			return 0;
+			return IOMMU_DOMAIN_DMA;
 	}
 
 	/*
@@ -3030,7 +3038,13 @@ static int iommu_should_identity_map(struct device *dev, int startup)
 		return dma_mask >= dma_get_required_mask(dev);
 	}
 
-	return 1;
+	return (iommu_identity_mapping & IDENTMAP_ALL) ?
+			IOMMU_DOMAIN_IDENTITY : 0;
+}
+
+static inline int iommu_should_identity_map(struct device *dev, int startup)
+{
+	return device_def_domain_type(dev, startup) == IOMMU_DOMAIN_IDENTITY;
 }
 
 static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw)
-- 
2.17.1

