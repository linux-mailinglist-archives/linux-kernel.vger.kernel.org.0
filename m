Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A381126189
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 13:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLSMEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 07:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfLSMEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:05 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DA624679;
        Thu, 19 Dec 2019 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757043;
        bh=QdE5VQsaHq4GwEedYCHV6BEpuWZqci2hcNRG0yFf+I0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzOq0T3l028Kv+Hb4cVFj66WVFsamPG6aWhNRV70KCS9BzCU+2yzFF3WqwbPjylX1
         7vyQKsdTP1UbK/77vuVrBojIXGp/WTmlM3hpdFfETel/ZD311CzHxCOjMcbZWhbgRv
         Okyp9Gm/U3NwD0m9F90s96DIpmrfKw1srNfkJUiI=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 01/16] drivers/iommu: Export core IOMMU API symbols to permit modular drivers
Date:   Thu, 19 Dec 2019 12:03:37 +0000
Message-Id: <20191219120352.382-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building IOMMU drivers as modules requires that the core IOMMU API
symbols are exported as GPL symbols.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu-sysfs.c | 5 +++++
 drivers/iommu/iommu.c       | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index e436ff813e7e..99869217fbec 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -87,6 +87,7 @@ int iommu_device_sysfs_add(struct iommu_device *iommu,
 	put_device(iommu->dev);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iommu_device_sysfs_add);
 
 void iommu_device_sysfs_remove(struct iommu_device *iommu)
 {
@@ -94,6 +95,8 @@ void iommu_device_sysfs_remove(struct iommu_device *iommu)
 	device_unregister(iommu->dev);
 	iommu->dev = NULL;
 }
+EXPORT_SYMBOL_GPL(iommu_device_sysfs_remove);
+
 /*
  * IOMMU drivers can indicate a device is managed by a given IOMMU using
  * this interface.  A link to the device will be created in the "devices"
@@ -119,6 +122,7 @@ int iommu_device_link(struct iommu_device *iommu, struct device *link)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iommu_device_link);
 
 void iommu_device_unlink(struct iommu_device *iommu, struct device *link)
 {
@@ -128,3 +132,4 @@ void iommu_device_unlink(struct iommu_device *iommu, struct device *link)
 	sysfs_remove_link(&link->kobj, "iommu");
 	sysfs_remove_link_from_group(&iommu->dev->kobj, "devices", dev_name(link));
 }
+EXPORT_SYMBOL_GPL(iommu_device_unlink);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index db7bfd4f2d20..7c92197d53f3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -141,6 +141,7 @@ int iommu_device_register(struct iommu_device *iommu)
 	spin_unlock(&iommu_device_lock);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iommu_device_register);
 
 void iommu_device_unregister(struct iommu_device *iommu)
 {
@@ -148,6 +149,7 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	list_del(&iommu->list);
 	spin_unlock(&iommu_device_lock);
 }
+EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
 static struct iommu_param *iommu_get_dev_param(struct device *dev)
 {
@@ -886,6 +888,7 @@ struct iommu_group *iommu_group_ref_get(struct iommu_group *group)
 	kobject_get(group->devices_kobj);
 	return group;
 }
+EXPORT_SYMBOL_GPL(iommu_group_ref_get);
 
 /**
  * iommu_group_put - Decrement group reference
@@ -1259,6 +1262,7 @@ struct iommu_group *generic_device_group(struct device *dev)
 {
 	return iommu_group_alloc();
 }
+EXPORT_SYMBOL_GPL(generic_device_group);
 
 /*
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
@@ -1326,6 +1330,7 @@ struct iommu_group *pci_device_group(struct device *dev)
 	/* No shared group found, allocate new */
 	return iommu_group_alloc();
 }
+EXPORT_SYMBOL_GPL(pci_device_group);
 
 /* Get the IOMMU group for device on fsl-mc bus */
 struct iommu_group *fsl_mc_device_group(struct device *dev)
@@ -1338,6 +1343,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 		group = iommu_group_alloc();
 	return group;
 }
+EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
@@ -1406,6 +1412,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 
 	return group;
 }
+EXPORT_SYMBOL(iommu_group_get_for_dev);
 
 struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 {
@@ -2246,6 +2253,7 @@ struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 	region->type = type;
 	return region;
 }
+EXPORT_SYMBOL_GPL(iommu_alloc_resv_region);
 
 static int
 request_default_domain_for_dev(struct device *dev, unsigned long type)
-- 
2.24.1.735.g03f4e72817-goog

