Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846E6E514
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfD2Oox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 10:44:53 -0400
Received: from foss.arm.com ([217.140.101.70]:58982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbfD2Oop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:44:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F35880D;
        Mon, 29 Apr 2019 07:44:45 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 208FB3F5C1;
        Mon, 29 Apr 2019 07:44:42 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v2 3/7] irqchip/gicv2m: Don't map the MSI page in gicv2m_compose_msi_msg()
Date:   Mon, 29 Apr 2019 15:44:24 +0100
Message-Id: <20190429144428.29254-4-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429144428.29254-1-julien.grall@arm.com>
References: <20190429144428.29254-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gicv2m_compose_msi_msg() may be called from non-preemptible context.
However, on RT, iommu_dma_map_msi_msg() requires to be called from a
preemptible context.

A recent change split iommu_dma_map_msi_msg() in two new functions:
one that should be called in preemptible context, the other does
not have any requirement.

The GICv2m driver is reworked to avoid executing preemptible code in
non-preemptible context. This can be achieved by preparing the MSI
mapping when allocating the MSI interrupt.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Rework the commit message to use imperative mood
---
 drivers/irqchip/irq-gic-v2m.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f5fe0100f9ff..4359f0583377 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -110,7 +110,7 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
 		msg->data -= v2m->spi_offset;
 
-	iommu_dma_map_msi_msg(data->irq, msg);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
 
 static struct irq_chip gicv2m_irq_chip = {
@@ -167,6 +167,7 @@ static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq,
 static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct v2m_data *v2m = NULL, *tmp;
 	int hwirq, offset, i, err = 0;
 
@@ -186,6 +187,11 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	hwirq = v2m->spi_start + offset;
 
+	err = iommu_dma_prepare_msi(info->desc,
+				    v2m->res.start + V2M_MSI_SETSPI_NS);
+	if (err)
+		return err;
+
 	for (i = 0; i < nr_irqs; i++) {
 		err = gicv2m_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
-- 
2.11.0

