Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FB5E519
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfD2OpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 10:45:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbfD2Oox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:44:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36EAE80D;
        Mon, 29 Apr 2019 07:44:53 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA67E3F5C1;
        Mon, 29 Apr 2019 07:44:50 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v2 6/7] irqchip/gic-v3-mbi: Don't map the MSI page in mbi_compose_m{b, s}i_msg()
Date:   Mon, 29 Apr 2019 15:44:27 +0100
Message-Id: <20190429144428.29254-7-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429144428.29254-1-julien.grall@arm.com>
References: <20190429144428.29254-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions mbi_compose_m{b, s}i_msg may be called from non-preemptible
context. However, on RT, iommu_dma_map_msi_msg() requires to be called
from a preemptible context.

A recent patch split iommu_dma_map_msi_msg in two new functions:
one that should be called in preemptible context, the other does
not have any requirement.

The GICv3 MSI driver is reworked to avoid executing preemptible code in
non-preemptible context. This can be achieved by preparing the two MSI
mappings when allocating the MSI interrupt.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Rework the commit message to use imperative mood
---
 drivers/irqchip/irq-gic-v3-mbi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index fbfa7ff6deb1..d50f6cdf043c 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -84,6 +84,7 @@ static void mbi_free_msi(struct mbi_range *mbi, unsigned int hwirq,
 static int mbi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct mbi_range *mbi = NULL;
 	int hwirq, offset, i, err = 0;
 
@@ -104,6 +105,16 @@ static int mbi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	hwirq = mbi->spi_start + offset;
 
+	err = iommu_dma_prepare_msi(info->desc,
+				    mbi_phys_base + GICD_CLRSPI_NSR);
+	if (err)
+		return err;
+
+	err = iommu_dma_prepare_msi(info->desc,
+				    mbi_phys_base + GICD_SETSPI_NSR);
+	if (err)
+		return err;
+
 	for (i = 0; i < nr_irqs; i++) {
 		err = mbi_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
@@ -142,7 +153,7 @@ static void mbi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg[0].address_lo = lower_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
 	msg[0].data = data->parent_data->hwirq;
 
-	iommu_dma_map_msi_msg(data->irq, msg);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
 
 #ifdef CONFIG_PCI_MSI
@@ -202,7 +213,7 @@ static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg[1].address_lo = lower_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
 	msg[1].data = data->parent_data->hwirq;
 
-	iommu_dma_map_msi_msg(data->irq, &msg[1]);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
 }
 
 /* Platform-MSI specific irqchip */
-- 
2.11.0

