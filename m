Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00F12A0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 12:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLXLks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 06:40:48 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:57662 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726407AbfLXLkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:40:47 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji64-000169-Ks; Tue, 24 Dec 2019 12:11:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v3 19/32] irqchip/gic-v4.1: Add initial SGI configuration
Date:   Tue, 24 Dec 2019 11:10:42 +0000
Message-Id: <20191224111055.11836-20-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224111055.11836-1-maz@kernel.org>
References: <20191224111055.11836-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GICv4.1 ITS has yet another new command (VSGI) which allows
a VPE-targeted SGI to be configured (or have its pending state
cleared). Add support for this command and plumb it into the
activate irqdomain callback so that it is ready to be used.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 76 +++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v3.h |  3 +-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b38823b9c27f..9ca2ad6000d8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -354,6 +354,15 @@ struct its_cmd_desc {
 		struct {
 			struct its_vpe *vpe;
 		} its_invdb_cmd;
+
+		struct {
+			struct its_vpe *vpe;
+			u8 sgi;
+			u8 priority;
+			bool enable;
+			bool group;
+			bool clear;
+		} its_vsgi_cmd;
 	};
 };
 
@@ -502,6 +511,31 @@ static void its_encode_db(struct its_cmd_block *cmd, bool db)
 	its_mask_encode(&cmd->raw_cmd[2], db, 63, 63);
 }
 
+static void its_encode_sgi_intid(struct its_cmd_block *cmd, u8 sgi)
+{
+	its_mask_encode(&cmd->raw_cmd[0], sgi, 35, 32);
+}
+
+static void its_encode_sgi_priority(struct its_cmd_block *cmd, u8 prio)
+{
+	its_mask_encode(&cmd->raw_cmd[0], prio >> 4, 23, 20);
+}
+
+static void its_encode_sgi_group(struct its_cmd_block *cmd, bool grp)
+{
+	its_mask_encode(&cmd->raw_cmd[0], grp, 10, 10);
+}
+
+static void its_encode_sgi_clear(struct its_cmd_block *cmd, bool clr)
+{
+	its_mask_encode(&cmd->raw_cmd[0], clr, 9, 9);
+}
+
+static void its_encode_sgi_enable(struct its_cmd_block *cmd, bool en)
+{
+	its_mask_encode(&cmd->raw_cmd[0], en, 8, 8);
+}
+
 static inline void its_fixup_cmd(struct its_cmd_block *cmd)
 {
 	/* Let's fixup BE commands */
@@ -867,6 +901,26 @@ static struct its_vpe *its_build_invdb_cmd(struct its_node *its,
 	return valid_vpe(its, desc->its_invdb_cmd.vpe);
 }
 
+static struct its_vpe *its_build_vsgi_cmd(struct its_node *its,
+					  struct its_cmd_block *cmd,
+					  struct its_cmd_desc *desc)
+{
+	if (WARN_ON(!is_v4_1(its)))
+		return NULL;
+
+	its_encode_cmd(cmd, GITS_CMD_VSGI);
+	its_encode_vpeid(cmd, desc->its_vsgi_cmd.vpe->vpe_id);
+	its_encode_sgi_intid(cmd, desc->its_vsgi_cmd.sgi);
+	its_encode_sgi_priority(cmd, desc->its_vsgi_cmd.priority);
+	its_encode_sgi_group(cmd, desc->its_vsgi_cmd.group);
+	its_encode_sgi_clear(cmd, desc->its_vsgi_cmd.clear);
+	its_encode_sgi_enable(cmd, desc->its_vsgi_cmd.enable);
+
+	its_fixup_cmd(cmd);
+
+	return valid_vpe(its, desc->its_vsgi_cmd.vpe);
+}
+
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
 				 struct its_cmd_block *ptr)
 {
@@ -3740,6 +3794,21 @@ static struct irq_chip its_vpe_4_1_irq_chip = {
 	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
 };
 
+static void its_configure_sgi(struct irq_data *d, bool clear)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	struct its_cmd_desc desc;
+
+	desc.its_vsgi_cmd.vpe = vpe;
+	desc.its_vsgi_cmd.sgi = d->hwirq;
+	desc.its_vsgi_cmd.priority = vpe->sgi_config[d->hwirq].priority;
+	desc.its_vsgi_cmd.enable = vpe->sgi_config[d->hwirq].enabled;
+	desc.its_vsgi_cmd.group = vpe->sgi_config[d->hwirq].group;
+	desc.its_vsgi_cmd.clear = clear;
+
+	its_send_single_vcommand(find_4_1_its(), its_build_vsgi_cmd, &desc);
+}
+
 static int its_sgi_set_affinity(struct irq_data *d,
 				const struct cpumask *mask_val,
 				bool force)
@@ -3785,13 +3854,18 @@ static void its_sgi_irq_domain_free(struct irq_domain *domain,
 static int its_sgi_irq_domain_activate(struct irq_domain *domain,
 				       struct irq_data *d, bool reserve)
 {
+	/* Write out the initial SGI configuration */
+	its_configure_sgi(d, false);
 	return 0;
 }
 
 static void its_sgi_irq_domain_deactivate(struct irq_domain *domain,
 					  struct irq_data *d)
 {
-	/* Nothing to do */
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+
+	vpe->sgi_config[d->hwirq].enabled = false;
+	its_configure_sgi(d, true);
 }
 
 static struct irq_domain_ops its_sgi_domain_ops = {
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index a30ea5294784..64818ed4c238 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -502,8 +502,9 @@
 #define GITS_CMD_VMAPTI			GITS_CMD_GICv4(GITS_CMD_MAPTI)
 #define GITS_CMD_VMOVI			GITS_CMD_GICv4(GITS_CMD_MOVI)
 #define GITS_CMD_VSYNC			GITS_CMD_GICv4(GITS_CMD_SYNC)
-/* VMOVP and INVDB are the odd ones, as they dont have a physical counterpart */
+/* VMOVP, VSGI and INVDB are the odd ones, as they dont have a physical counterpart */
 #define GITS_CMD_VMOVP			GITS_CMD_GICv4(2)
+#define GITS_CMD_VSGI			GITS_CMD_GICv4(3)
 #define GITS_CMD_INVDB			GITS_CMD_GICv4(0xe)
 
 /*
-- 
2.20.1

