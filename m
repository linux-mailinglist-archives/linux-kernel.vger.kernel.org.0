Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C39F4F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 16:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKHPQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 10:16:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfKHPQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:16:26 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4612222C9;
        Fri,  8 Nov 2019 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573226185;
        bh=Jt4zDx9Zw6bm/De+bvs+7nLVRvQ+umN66VOrNXeB3lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u45KmJF+a/PqKLMwTdUXriHt1lGZ3Sqkymh5MXx5NRKiWZ7jGRcMB2fRNoMKOT6M2
         2Z/M5bq5aQ74aqn1pYWzRDzTLX3aUfwgxjZD1UpdzQeWTwZzcKjh79oKboEYerQA4Q
         oKr26vXNfJp9uJz6cIoAPODvNwB111nZTl+vxVTo=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 4/9] drivers/iommu: Take a ref to the IOMMU driver prior to ->add_device()
Date:   Fri,  8 Nov 2019 15:16:03 +0000
Message-Id: <20191108151608.20932-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108151608.20932-1-will@kernel.org>
References: <20191108151608.20932-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid accidental removal of an active IOMMU driver module, take a
reference to the driver module in 'iommu_probe_device()' immediately
prior to invoking the '->add_device()' callback and hold it until the
after the device has been removed by '->remove_device()'.

Suggested-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++--
 include/linux/iommu.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c1aadb570145..4bfecfbbe2cf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
+#include <linux/module.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -185,10 +186,21 @@ int iommu_probe_device(struct device *dev)
 	if (!iommu_get_dev_param(dev))
 		return -ENOMEM;
 
+	if (!try_module_get(ops->owner)) {
+		ret = -EINVAL;
+		goto err_free_dev_param;
+	}
+
 	ret = ops->add_device(dev);
 	if (ret)
-		iommu_free_dev_param(dev);
+		goto err_module_put;
+
+	return 0;
 
+err_module_put:
+	module_put(ops->owner);
+err_free_dev_param:
+	iommu_free_dev_param(dev);
 	return ret;
 }
 
@@ -199,7 +211,10 @@ void iommu_release_device(struct device *dev)
 	if (dev->iommu_group)
 		ops->remove_device(dev);
 
-	iommu_free_dev_param(dev);
+	if (dev->iommu_param) {
+		module_put(ops->owner);
+		iommu_free_dev_param(dev);
+	}
 }
 
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 29bac5345563..d9dab5a3e912 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -245,6 +245,7 @@ struct iommu_iotlb_gather {
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @owner: Driver module providing these ops
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -308,6 +309,7 @@ struct iommu_ops {
 			     struct iommu_page_response *msg);
 
 	unsigned long pgsize_bitmap;
+	struct module *owner;
 };
 
 /**
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

