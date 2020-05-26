Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46AD0199804
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbgCaOAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 10:00:15 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:48939 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730442AbgCaOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:00:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TuABiZr_1585663188;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TuABiZr_1585663188)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Mar 2020 21:59:57 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: move error checking into common path
Date:   Tue, 31 Mar 2020 21:59:48 +0800
Message-Id: <1585663188-114303-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move error checking into common path to be consistent with
drivers/iommu/arm-smmu.c.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/iommu/arm-smmu-v3.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index aa3ac2a..970f1c9 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3889,13 +3889,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
-	if (dev->of_node) {
+	if (dev->of_node)
 		ret = arm_smmu_device_dt_probe(pdev, smmu);
-	} else {
+	else
 		ret = arm_smmu_device_acpi_probe(pdev, smmu);
-		if (ret == -ENODEV)
-			return ret;
-	}
+
+	if (ret)
+		return ret;
 
 	/* Set bypass mode according to firmware probing result */
 	bypass = !!ret;
-- 
1.8.3.1

