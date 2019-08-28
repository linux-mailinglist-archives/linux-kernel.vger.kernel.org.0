Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5AAA08C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfH1Riu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 13:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfH1Rit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:38:49 -0400
Received: from sstabellini-ThinkPad-T480s.xilinx.com (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69D4F2077B;
        Wed, 28 Aug 2019 17:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567013928;
        bh=RIt/H8XgVifTEhugC1lEufb4AZAcq59OXKgKcWpAXrM=;
        h=From:To:Cc:Subject:Date:From;
        b=mFFmsoI2WrO9CnnAGYaAzhzpXYFxVVg9B1B5BCL83R/9wuur9d4dRBFfL8iMMd4hi
         W+BLxOuQOCNffysulPuuGslQVUWOHw/40PAdmxLOV9uTxovYH9PTbypJI5oSdu+TUL
         pr+4j0JgPlICgAjAu0M7l4Q5vmQfBvVbBboU8gl0=
From:   Stefano Stabellini <sstabellini@kernel.org>
To:     will@kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com, sstabellini@kernel.org, git@xilinx.com,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: [PATCH] arm-smmu: check for generic bindings first
Date:   Wed, 28 Aug 2019 10:38:37 -0700
Message-Id: <20190828173837.29617-1-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

Today, the arm-smmu driver checks for mmu-masters on device tree, the
legacy property, if it is absent it assumes that we are using the new
bindings. If it is present it assumes that we are using the legacy
bindings. All arm-smmus need to use the same bindings: legacy or new.

There are two issues with this:

- we are not actually checking for the new bindings explicitly
It would be better to have an explicit check for the new bindings rather
than assuming we must be using the new if the old are not there.

- old and new bindings cannot coexist
It would be nice to be able to provide both old and new bindings so
that software that hasn't been updated yet is still able to get IOMMU
information from the legacy bindings while at the same time newer
software can get the latest information via the new bindings. (Xen has
not been updated to use the new binding yet for instance.) The current
code breaks under these circumstances because if the old bindings are
present, the new are not even checked.

This patch changes the scheme by checking for #iommu-cells, which is
only present with the new bindings, before checking for mmu-masters.
The new bindings are always favored when present. All SMMUs still need
to use the same bindings: mix-and-matching new and old bindings between
different SMMUs is not allowed.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---

Let me know if you'd like me to turn the two using_*_binding variables
into a single one.

Also, please note that this is not meant as an excuse not to get Xen
updated to use the new binding.

 drivers/iommu/arm-smmu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 64977c131ee6..79b518ff215c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2118,7 +2118,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 {
 	const struct arm_smmu_match_data *data;
 	struct device *dev = &pdev->dev;
-	bool legacy_binding;
+	bool legacy_binding, generic_binding;
 
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
@@ -2132,16 +2132,20 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 
 	parse_driver_options(smmu);
 
-	legacy_binding = of_find_property(dev->of_node, "mmu-masters", NULL);
-	if (legacy_binding && !using_generic_binding) {
-		if (!using_legacy_binding)
-			pr_notice("deprecated \"mmu-masters\" DT property in use; DMA API support unavailable\n");
-		using_legacy_binding = true;
-	} else if (!legacy_binding && !using_legacy_binding) {
+	generic_binding = of_find_property(dev->of_node, "#iommu-cells", NULL);
+	if (generic_binding && !using_legacy_binding) {
 		using_generic_binding = true;
 	} else {
-		dev_err(dev, "not probing due to mismatched DT properties\n");
-		return -ENODEV;
+		legacy_binding = of_find_property(dev->of_node, "mmu-masters",
+						  NULL);
+		if (legacy_binding && !using_generic_binding) {
+			if (!using_legacy_binding)
+				pr_notice("deprecated \"mmu-masters\" DT property in use; DMA API support unavailable\n");
+			using_legacy_binding = true;
+		} else {
+			dev_err(dev, "not probing due to mismatched DT properties\n");
+			return -ENODEV;
+		}
 	}
 
 	if (of_dma_is_coherent(dev->of_node))
-- 
2.17.1

