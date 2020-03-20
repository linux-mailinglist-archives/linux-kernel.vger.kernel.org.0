Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97FA18C9BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 10:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgCTJO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 05:14:26 -0400
Received: from 8bytes.org ([81.169.241.247]:54146 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbgCTJOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:14:25 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8CC33385; Fri, 20 Mar 2020 10:14:20 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, guohanjun@huawei.com,
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
Subject: [PATCH v3 07/15] iommu/arm-smmu: Fix uninitilized variable warning
Date:   Fri, 20 Mar 2020 10:14:06 +0100
Message-Id: <20200320091414.3941-8-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320091414.3941-1-joro@8bytes.org>
References: <20200320091414.3941-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Some unrelated changes in the iommu code caused a new warning to
appear in the arm-smmu driver:

  CC      drivers/iommu/arm-smmu.o
drivers/iommu/arm-smmu.c: In function 'arm_smmu_add_device':
drivers/iommu/arm-smmu.c:1441:2: warning: 'smmu' may be used uninitialized in this function [-Wmaybe-uninitialized]
  arm_smmu_rpm_put(smmu);
  ^~~~~~~~~~~~~~~~~~~~~~

The warning is a false positive, but initialize the variable to NULL
to get rid of it.

Tested-by: Will Deacon <will@kernel.org> # arm-smmu
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 16c4b87af42b..980aae73b45b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1383,7 +1383,7 @@ struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 
 static int arm_smmu_add_device(struct device *dev)
 {
-	struct arm_smmu_device *smmu;
+	struct arm_smmu_device *smmu = NULL;
 	struct arm_smmu_master_cfg *cfg;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int i, ret;
-- 
2.17.1

