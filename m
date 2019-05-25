Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432C02A320
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 07:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfEYFtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 01:49:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfEYFtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:49:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:49:14 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:49:12 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 14/15] iommu/vt-d: Remove duplicated code for device hotplug
Date:   Sat, 25 May 2019 13:41:35 +0800
Message-Id: <20190525054136.27810-15-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu generic code has handled the device hotplug cases.
Remove the duplicated code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ba425db8cfc6..7c7230ae6967 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4568,39 +4568,6 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 	return 0;
 }
 
-/*
- * Here we only respond to action of unbound device from driver.
- *
- * Added device is not attached to its DMAR domain here yet. That will happen
- * when mapping the device to iova.
- */
-static int device_notifier(struct notifier_block *nb,
-				  unsigned long action, void *data)
-{
-	struct device *dev = data;
-	struct dmar_domain *domain;
-
-	if (iommu_dummy(dev))
-		return 0;
-
-	if (action == BUS_NOTIFY_REMOVED_DEVICE) {
-		domain = find_domain(dev);
-		if (!domain)
-			return 0;
-
-		dmar_remove_one_dev_info(dev);
-	} else if (action == BUS_NOTIFY_ADD_DEVICE) {
-		if (iommu_should_identity_map(dev))
-			domain_add_dev_info(si_domain, dev);
-	}
-
-	return 0;
-}
-
-static struct notifier_block device_nb = {
-	.notifier_call = device_notifier,
-};
-
 static int intel_iommu_memory_notifier(struct notifier_block *nb,
 				       unsigned long val, void *v)
 {
@@ -4975,7 +4942,6 @@ int __init intel_iommu_init(void)
 	}
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
-	bus_register_notifier(&pci_bus_type, &device_nb);
 	if (si_domain && !hw_pass_through)
 		register_memory_notifier(&intel_iommu_memory_nb);
 	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
-- 
2.17.1

