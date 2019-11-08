Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162C1F51BC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKHQ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:58:17 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:36267 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727903AbfKHQ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:58:14 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iT7aP-0002sR-8v; Fri, 08 Nov 2019 17:58:13 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH v2 08/11] irqchip/gic-v3-its: Synchronise INV command targetting a VLPI using VSYNC
Date:   Fri,  8 Nov 2019 16:58:02 +0000
Message-Id: <20191108165805.3071-9-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108165805.3071-1-maz@kernel.org>
References: <20191108165805.3071-1-maz@kernel.org>
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

We have so far alwways invalidated VLPIs usinc an INV+SYNC
sequence, but that's pretty wrong for two reasons:

- SYNC only synchronises physical LPIs
- The collection ID that for the associated LPI doesn't match
  the redistributor the vPE is associated with

Instead, send an INV+VSYNC for forwarded LPIs, ensuring that
the ITS can properly synchronise the invalidation of VLPIs.

Fixes: 015ec0386ab6 ("irqchip/gic-v3-its: Add VLPI configuration handling")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 36 +++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cad8fd18bab7..427496b7baf6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -700,6 +700,24 @@ static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
 	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
 }
 
+static struct its_vpe *its_build_vinv_cmd(struct its_node *its,
+					  struct its_cmd_block *cmd,
+					  struct its_cmd_desc *desc)
+{
+	struct its_vlpi_map *map;
+
+	map = dev_event_to_vlpi_map(desc->its_inv_cmd.dev,
+				    desc->its_inv_cmd.event_id);
+
+	its_encode_cmd(cmd, GITS_CMD_INV);
+	its_encode_devid(cmd, desc->its_inv_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_inv_cmd.event_id);
+
+	its_fixup_cmd(cmd);
+
+	return valid_vpe(its, map->vpe);
+}
+
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
 				 struct its_cmd_block *ptr)
 {
@@ -1066,6 +1084,20 @@ static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
 	its_send_single_vcommand(its, its_build_vinvall_cmd, &desc);
 }
 
+static void its_send_vinv(struct its_device *dev, u32 event_id)
+{
+	struct its_cmd_desc desc;
+
+	/*
+	 * There is no real VINV command. This is just a normal INV,
+	 * with a VSYNC instead of a SYNC.
+	 */
+	desc.its_inv_cmd.dev = dev;
+	desc.its_inv_cmd.event_id = event_id;
+
+	its_send_single_vcommand(dev->its, its_build_vinv_cmd, &desc);
+}
+
 /*
  * irqchip functions - assumes MSI, mostly.
  */
@@ -1140,8 +1172,10 @@ static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 	lpi_write_config(d, clr, set);
 	if (gic_rdists->has_direct_lpi && !irqd_is_forwarded_to_vcpu(d))
 		direct_lpi_inv(d);
-	else
+	else if (!irqd_is_forwarded_to_vcpu(d))
 		its_send_inv(its_dev, its_get_event_id(d));
+	else
+		its_send_vinv(its_dev, its_get_event_id(d));
 }
 
 static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
-- 
2.20.1

