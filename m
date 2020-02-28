Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9265D173AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 16:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgB1PIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 10:08:32 -0500
Received: from 8bytes.org ([81.169.241.247]:56016 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgB1PIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:08:31 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 98A183C3; Fri, 28 Feb 2020 16:08:28 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 01/14] ACPI/IORT: Remove direct access of dev->iommu_fwspec
Date:   Fri, 28 Feb 2020 16:08:07 +0100
Message-Id: <20200228150820.15340-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150820.15340-1-joro@8bytes.org>
References: <20200228150820.15340-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Use the accessor functions instead of directly dereferencing
dev->iommu_fwspec.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/arm64/iort.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ed3d2d1a7ae9..0e981d7f3c7d 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1015,6 +1015,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		return ops;
 
 	if (dev_is_pci(dev)) {
+		struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
 		struct iort_pci_alias_info info = { .dev = dev };
 
@@ -1028,7 +1029,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 					     iort_pci_iommu_init, &info);
 
 		if (!err && iort_pci_rc_supports_ats(node))
-			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
 	} else {
 		int i = 0;
 
-- 
2.17.1

