Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE43F028C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 17:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390207AbfKEQXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 11:23:16 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:46819 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390084AbfKEQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:23:13 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iS1br-0001q9-OA; Tue, 05 Nov 2019 17:23:11 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH 03/11] irqchip/gic-v3-its: Allow LPI invalidation via the DirectLPI interface
Date:   Tue,  5 Nov 2019 16:22:50 +0000
Message-Id: <20191105162258.22214-4-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105162258.22214-1-maz@kernel.org>
References: <20191105162258.22214-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, guoheyi@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently don't make much use of the DirectLPI feature, and it would
be beneficial to do this more, if only because it becomes a mandatory
feature for GICv4.1.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 40 +++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d71741d302b4..b9e9314ed702 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -191,6 +191,12 @@ static u16 get_its_list(struct its_vm *vm)
 	return (u16)its_list;
 }
 
+static inline u32 its_get_event_id(struct irq_data *d)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	return d->hwirq - its_dev->event_map.lpi_base;
+}
+
 static struct its_collection *dev_event_to_col(struct its_device *its_dev,
 					       u32 event)
 {
@@ -199,6 +205,13 @@ static struct its_collection *dev_event_to_col(struct its_device *its_dev,
 	return its->collections + its_dev->event_map.col_map[event];
 }
 
+static struct its_collection *irq_to_col(struct irq_data *d)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+
+	return dev_event_to_col(its_dev, its_get_event_id(d));
+}
+
 static struct its_collection *valid_col(struct its_collection *col)
 {
 	if (WARN_ON_ONCE(col->target_address & GENMASK_ULL(15, 0)))
@@ -1046,12 +1059,6 @@ static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
  * irqchip functions - assumes MSI, mostly.
  */
 
-static inline u32 its_get_event_id(struct irq_data *d)
-{
-	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	return d->hwirq - its_dev->event_map.lpi_base;
-}
-
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
 	irq_hw_number_t hwirq;
@@ -1096,12 +1103,28 @@ static void wait_for_syncr(void __iomem *rdbase)
 		cpu_relax();
 }
 
+static void direct_lpi_inv(struct irq_data *d)
+{
+	struct its_collection *col;
+	void __iomem *rdbase;
+
+	/* Target the redistributor this LPI is currently routed to */
+	col = irq_to_col(d);
+	rdbase = per_cpu_ptr(gic_rdists->rdist, col->col_id)->rd_base;
+	gic_write_lpir(d->hwirq, rdbase + GICR_INVLPIR);
+
+	wait_for_syncr(rdbase);
+}
+
 static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 
 	lpi_write_config(d, clr, set);
-	its_send_inv(its_dev, its_get_event_id(d));
+	if (gic_rdists->has_direct_lpi && !irqd_is_forwarded_to_vcpu(d))
+		direct_lpi_inv(d);
+	else
+		its_send_inv(its_dev, its_get_event_id(d));
 }
 
 static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
@@ -2933,8 +2956,9 @@ static void its_vpe_send_inv(struct irq_data *d)
 	if (gic_rdists->has_direct_lpi) {
 		void __iomem *rdbase;
 
+		/* Target the redistributor this VPE is currently known on */
 		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
-		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_INVLPIR);
+		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
 		wait_for_syncr(rdbase);
 	} else {
 		its_vpe_send_cmd(vpe, its_send_inv);
-- 
2.20.1

