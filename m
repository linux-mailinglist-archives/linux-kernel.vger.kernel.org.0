Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1FBBB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 20:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502420AbfIWS2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 14:28:25 -0400
Received: from foss.arm.com ([217.140.110.172]:47224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfIWS2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:28:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 668392A68;
        Mon, 23 Sep 2019 11:28:21 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DD6E3F694;
        Mon, 23 Sep 2019 11:28:18 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH 31/35] irqchip/gic-v4.1: Eagerly vmap vPEs
Date:   Mon, 23 Sep 2019 19:26:02 +0100
Message-Id: <20190923182606.32100-32-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have HW-accelerated SGIs being delivered to VPEs, it
becomes required to map the VPEs on all ITSs instead of relying
on the lazy approach that we would use when using the ITS-list
mechanism.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 39 +++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4aae9582182b..a1e8c4c2598a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1417,12 +1417,31 @@ static int its_irq_set_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+/*
+ * Two favourable cases:
+ *
+ * (a) Either we have a GICv4.1, and all vPEs have to be mapped at all times
+ *     for vSGI delivery
+ *
+ * (b) Or the ITSs do not use a list map, meaning that VMOVP is cheap enough
+ *     and we're better off mapping all VPEs always
+ *
+ * If neither (a) nor (b) is true, then we map VLPIs on demand.
+ *
+ */
+static bool gic_requires_eager_mapping(void)
+{
+	if (!its_list_map || gic_rdists->has_rvpeid)
+		return true;
+
+	return false;
+}
+
 static void its_map_vm(struct its_node *its, struct its_vm *vm)
 {
 	unsigned long flags;
 
-	/* Not using the ITS list? Everything is always mapped. */
-	if (!its_list_map)
+	if (gic_requires_eager_mapping())
 		return;
 
 	raw_spin_lock_irqsave(&vmovp_lock, flags);
@@ -1456,7 +1475,7 @@ static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
 	unsigned long flags;
 
 	/* Not using the ITS list? Everything is always mapped. */
-	if (!its_list_map)
+	if (gic_requires_eager_mapping())
 		return;
 
 	raw_spin_lock_irqsave(&vmovp_lock, flags);
@@ -3957,8 +3976,12 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 	struct its_node *its;
 
-	/* If we use the list map, we issue VMAPP on demand... */
-	if (its_list_map)
+	/*
+	 * If we use the list map, we issue VMAPP on demand... Unless
+	 * we're on a GICv4.1 and we eagerly map the VPE on all ITSs
+	 * so that VSGIs can work.
+	 */
+	if (!gic_requires_eager_mapping())
 		return 0;
 
 	/* Map the VPE to the first possible CPU */
@@ -3984,10 +4007,10 @@ static void its_vpe_irq_domain_deactivate(struct irq_domain *domain,
 	struct its_node *its;
 
 	/*
-	 * If we use the list map, we unmap the VPE once no VLPIs are
-	 * associated with the VM.
+	 * If we use the list map on GICv4.0, we unmap the VPE once no
+	 * VLPIs are associated with the VM.
 	 */
-	if (its_list_map)
+	if (!gic_requires_eager_mapping())
 		return;
 
 	list_for_each_entry(its, &its_nodes, entry) {
-- 
2.20.1

