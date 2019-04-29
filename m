Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5367E517
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 16:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfD2Ooz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 10:44:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59018 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbfD2Oov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:44:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99DD3165C;
        Mon, 29 Apr 2019 07:44:50 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AE1D3F5C1;
        Mon, 29 Apr 2019 07:44:48 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v2 5/7] irqchip/ls-scfg-msi: Don't map the MSI page in ls_scfg_msi_compose_msg()
Date:   Mon, 29 Apr 2019 15:44:26 +0100
Message-Id: <20190429144428.29254-6-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429144428.29254-1-julien.grall@arm.com>
References: <20190429144428.29254-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ls_scfg_msi_compose_msg() may be called from non-preemptible context.
However, on RT, iommu_dma_map_msi_msg() requires to be called from a
preemptible context.

A recent patch split iommu_dma_map_msi_msg() in two new functions:
one that should be called in preemptible context, the other does
not have any requirement.

The FreeScale SCFG MSI driver is reworked to avoid executing preemptible
code in non-preemptible context. This can be achieved by preparing the
MSI maping when allocating the MSI interrupt.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Rework the commit message to use imperative mood
---
 drivers/irqchip/irq-ls-scfg-msi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index c671b3212010..669d29105772 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -100,7 +100,7 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 		msg->data |= cpumask_first(mask);
 	}
 
-	iommu_dma_map_msi_msg(data->irq, msg);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
 
 static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
@@ -141,6 +141,7 @@ static int ls_scfg_msi_domain_irq_alloc(struct irq_domain *domain,
 					unsigned int nr_irqs,
 					void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct ls_scfg_msi *msi_data = domain->host_data;
 	int pos, err = 0;
 
@@ -157,6 +158,10 @@ static int ls_scfg_msi_domain_irq_alloc(struct irq_domain *domain,
 	if (err)
 		return err;
 
+	err = iommu_dma_prepare_msi(info->desc, msi_data->msiir_addr);
+	if (err)
+		return err;
+
 	irq_domain_set_info(domain, virq, pos,
 			    &ls_scfg_msi_parent_chip, msi_data,
 			    handle_simple_irq, NULL, NULL);
-- 
2.11.0

