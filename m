Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0217CC75
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 07:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgCGGXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 01:23:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:29697 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGGXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 01:23:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 22:23:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,525,1574150400"; 
   d="scan'208";a="352915171"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2020 22:23:19 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/6] iommu/vt-d: Don't force PCI sub-hierarchy to use DMA domain
Date:   Sat,  7 Mar 2020 14:20:12 +0800
Message-Id: <20200307062014.3288-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200307062014.3288-1-baolu.lu@linux.intel.com>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit fa954e6831789 ("iommu/vt-d: Delegate the dma domain
to upper layer"), Intel IOMMU started off with all devices in the
identity domain, and took them out later if it found they couldn't
access all of memory. This required devices behind a PCI bridge to
use a DMA domain at the beginning because all PCI devices behind
the bridge use the same source-id in their transactions and the
domain couldn't be changed at run-time.

Intel IOMMU driver is now aligned with the default domain framework,
there's no need to keep this requirement anymore.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c58ced848206..299ce175c096 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3048,31 +3048,6 @@ static int device_def_domain_type(struct device *dev)
 
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
-
-		/*
-		 * We want to start off with all devices in the 1:1 domain, and
-		 * take them out later if we find they can't access all of memory.
-		 *
-		 * However, we can't do this for PCI devices behind bridges,
-		 * because all PCI devices behind the same bridge will end up
-		 * with the same source-id on their transactions.
-		 *
-		 * Practically speaking, we can't change things around for these
-		 * devices at run-time, because we can't be sure there'll be no
-		 * DMA transactions in flight for any of their siblings.
-		 *
-		 * So PCI devices (unless they're on the root bus) as well as
-		 * their parent PCI-PCI or PCIe-PCI bridges must be left _out_ of
-		 * the 1:1 domain, just in _case_ one of their siblings turns out
-		 * not to be able to map all of memory.
-		 */
-		if (!pci_is_pcie(pdev)) {
-			if (!pci_is_root_bus(pdev->bus))
-				return IOMMU_DOMAIN_DMA;
-			if (pdev->class >> 8 == PCI_CLASS_BRIDGE_PCI)
-				return IOMMU_DOMAIN_DMA;
-		} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_PCI_BRIDGE)
-			return IOMMU_DOMAIN_DMA;
 	}
 
 	return 0;
-- 
2.17.1

