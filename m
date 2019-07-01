Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4620327
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 12:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfEPKIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 06:08:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEPKIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:08:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93F0E307CB37;
        Thu, 16 May 2019 10:08:36 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A803A5D6A9;
        Thu, 16 May 2019 10:08:33 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v3 3/7] iommu/vt-d: Introduce is_downstream_to_pci_bridge helper
Date:   Thu, 16 May 2019 12:08:13 +0200
Message-Id: <20190516100817.12076-4-eric.auger@redhat.com>
In-Reply-To: <20190516100817.12076-1-eric.auger@redhat.com>
References: <20190516100817.12076-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 16 May 2019 10:08:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several call sites are about to check whether a device belongs
to the PCI sub-hierarchy of a candidate PCI-PCI bridge.
Introduce an helper to perform that check.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-iommu.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 590a0e78d11d..15c2f9677491 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -736,12 +736,39 @@ static int iommu_dummy(struct device *dev)
 	return dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
 }
 
+/* is_downstream_to_pci_bridge - test if a device belongs to the
+ * PCI sub-hierarchy of a candidate PCI-PCI bridge
+ *
+ * @dev: candidate PCI device belonging to @bridge PCI sub-hierarchy
+ * @bridge: the candidate PCI-PCI bridge
+ *
+ * Return: true if @dev belongs to @bridge PCI sub-hierarchy
+ */
+static bool
+is_downstream_to_pci_bridge(struct device *dev, struct device *bridge)
+{
+	struct pci_dev *pdev, *pbridge;
+
+	if (!dev_is_pci(dev) || !dev_is_pci(bridge))
+		return false;
+
+	pdev = to_pci_dev(dev);
+	pbridge = to_pci_dev(bridge);
+
+	if (pbridge->subordinate &&
+	    pbridge->subordinate->number <= pdev->bus->number &&
+	    pbridge->subordinate->busn_res.end >= pdev->bus->number)
+		return true;
+
+	return false;
+}
+
 static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn)
 {
 	struct dmar_drhd_unit *drhd = NULL;
 	struct intel_iommu *iommu;
 	struct device *tmp;
-	struct pci_dev *ptmp, *pdev = NULL;
+	struct pci_dev *pdev = NULL;
 	u16 segment = 0;
 	int i;
 
@@ -787,13 +814,7 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 				goto out;
 			}
 
-			if (!pdev || !dev_is_pci(tmp))
-				continue;
-
-			ptmp = to_pci_dev(tmp);
-			if (ptmp->subordinate &&
-			    ptmp->subordinate->number <= pdev->bus->number &&
-			    ptmp->subordinate->busn_res.end >= pdev->bus->number)
+			if (is_downstream_to_pci_bridge(dev, tmp))
 				goto got_pdev;
 		}
 
-- 
2.20.1

