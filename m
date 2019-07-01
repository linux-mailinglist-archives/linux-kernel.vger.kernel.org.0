Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517C651C17
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfFXUO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 16:14:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:33841 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfFXUO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:14:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 13:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="336610673"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 24 Jun 2019 13:14:27 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] irq_remapping/vt-d: cleanup unused variable
Date:   Mon, 24 Jun 2019 13:17:42 -0700
Message-Id: <1561407462-23083-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux IRQ number virq is not used in IRTE allocation. Remove it.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel_irq_remapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 4160aa9..4786ca0 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -101,7 +101,7 @@ static void init_ir_status(struct intel_iommu *iommu)
 		iommu->flags |= VTD_FLAG_IRQ_REMAP_PRE_ENABLED;
 }
 
-static int alloc_irte(struct intel_iommu *iommu, int irq,
+static int alloc_irte(struct intel_iommu *iommu,
 		      struct irq_2_iommu *irq_iommu, u16 count)
 {
 	struct ir_table *table = iommu->ir_table;
@@ -1374,7 +1374,7 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 		goto out_free_parent;
 
 	down_read(&dmar_global_lock);
-	index = alloc_irte(iommu, virq, &data->irq_2_iommu, nr_irqs);
+	index = alloc_irte(iommu, &data->irq_2_iommu, nr_irqs);
 	up_read(&dmar_global_lock);
 	if (index < 0) {
 		pr_warn("Failed to allocate IRTE\n");
-- 
2.7.4

