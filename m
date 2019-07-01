Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228C510890
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 15:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfEAN6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 09:58:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59632 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfEAN6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:58:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50277EBD;
        Wed,  1 May 2019 06:58:38 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D117B3F5AF;
        Wed,  1 May 2019 06:58:35 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org,
        Julien Grall <julien.grall@arm.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v3 1/7] genirq/msi: Add a new field in msi_desc to store an IOMMU cookie
Date:   Wed,  1 May 2019 14:58:18 +0100
Message-Id: <20190501135824.25586-2-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190501135824.25586-1-julien.grall@arm.com>
References: <20190501135824.25586-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an MSI doorbell is located downstream of an IOMMU, it is required
to swizzle the physical address with an appropriately-mapped IOVA for any
device attached to one of our DMA ops domain.

At the moment, the allocation of the mapping may be done when composing
the message. However, the composing may be done in non-preemtible
context while the allocation requires to be called from preemptible
context.

A follow-up change will split the current logic in two functions
requiring to keep an IOMMU cookie per MSI.

A new field is introduced in msi_desc to store an IOMMU cookie. As the
cookie may not be required in some configuration, the field is protected
under a new config CONFIG_IRQ_MSI_IOMMU.

A pair of helpers has also been introduced to access the field.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

---
    Changes in v3:
        - Add Robin's and Eric's reviewed-by

    Changes in v2:
        - Update the commit message to use imperative mood
        - Protect the field with a new config that will be selected by
        IOMMU_DMA later on
        - Add a set of helpers to access the new field
---
 include/linux/msi.h | 26 ++++++++++++++++++++++++++
 kernel/irq/Kconfig  |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7e9b81c3b50d..82a308c19222 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,6 +77,9 @@ struct msi_desc {
 	struct device			*dev;
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	const void			*iommu_cookie;
+#endif
 
 	union {
 		/* PCI MSI/X specific data */
@@ -119,6 +122,29 @@ struct msi_desc {
 #define for_each_msi_entry_safe(desc, tmp, dev)	\
 	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
 
+#ifdef CONFIG_IRQ_MSI_IOMMU
+static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
+{
+	return desc->iommu_cookie;
+}
+
+static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
+					     const void *iommu_cookie)
+{
+	desc->iommu_cookie = iommu_cookie;
+}
+#else
+static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
+{
+	return NULL;
+}
+
+static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
+					     const void *iommu_cookie)
+{
+}
+#endif
+
 #ifdef CONFIG_PCI_MSI
 #define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
 #define for_each_pci_msi_entry(desc, pdev)	\
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 5f3e2baefca9..8fee06625c37 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -91,6 +91,9 @@ config GENERIC_MSI_IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 
+config IRQ_MSI_IOMMU
+	bool
+
 config HANDLE_DOMAIN_IRQ
 	bool
 
-- 
2.11.0

