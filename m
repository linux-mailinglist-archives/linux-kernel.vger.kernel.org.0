Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8AEB10895
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfEAN64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 09:58:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59756 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfEAN6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:58:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7424AA78;
        Wed,  1 May 2019 06:58:54 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00E743F5AF;
        Wed,  1 May 2019 06:58:51 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org,
        Julien Grall <julien.grall@arm.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v3 7/7] iommu/dma-iommu: Remove iommu_dma_map_msi_msg()
Date:   Wed,  1 May 2019 14:58:24 +0100
Message-Id: <20190501135824.25586-8-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190501135824.25586-1-julien.grall@arm.com>
References: <20190501135824.25586-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change split iommu_dma_map_msi_msg() in two new functions. The
function was still implemented to avoid modifying all the callers at
once.

Now that all the callers have been reworked, iommu_dma_map_msi_msg() can
be removed.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

---
    Changes in v3:
        - Add Robin's and Eric's reviewed-by

    Changes in v2:
        - Rework the commit message
---
 drivers/iommu/dma-iommu.c | 20 --------------------
 include/linux/dma-iommu.h |  5 -----
 2 files changed, 25 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f847904098f7..13916fefeb27 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -935,23 +935,3 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
 	msg->address_lo += lower_32_bits(msi_page->iova);
 }
-
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
-{
-	struct msi_desc *desc = irq_get_msi_desc(irq);
-	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
-
-	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
-		/*
-		 * We're called from a void callback, so the best we can do is
-		 * 'fail' by filling the message with obviously bogus values.
-		 * Since we got this far due to an IOMMU being present, it's
-		 * not like the existing address would have worked anyway...
-		 */
-		msg->address_hi = ~0U;
-		msg->address_lo = ~0U;
-		msg->data = ~0U;
-	} else {
-		iommu_dma_compose_msi_msg(desc, msg);
-	}
-}
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 0b781a98ee73..476e0c54de2d 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -84,7 +84,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
 void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 			       struct msi_msg *msg);
 
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 #else
@@ -124,10 +123,6 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 {
 }
 
-static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
-{
-}
-
 static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 }
-- 
2.11.0

