Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA1F51C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfKHQ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:58:44 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:60969 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbfKHQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:58:11 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iT7aM-0002sR-KS; Fri, 08 Nov 2019 17:58:10 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH v2 02/11] irqchip/gic-v3-its: Factor out wait_for_syncr primitive
Date:   Fri,  8 Nov 2019 16:57:56 +0000
Message-Id: <20191108165805.3071-3-maz@kernel.org>
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

Waiting for a redistributor to have performed an operation is a
common thing to do, and the idiom is already spread around.
As we're going to make even more use of this, let's have a primitive
that does just that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191027144234.8395-3-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cc6aea602a7a..34eab323ea69 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1090,6 +1090,12 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 		dsb(ishst);
 }
 
+static void wait_for_syncr(void __iomem *rdbase)
+{
+	while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
+		cpu_relax();
+}
+
 static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -2772,8 +2778,7 @@ static void its_vpe_db_proxy_move(struct its_vpe *vpe, int from, int to)
 
 		rdbase = per_cpu_ptr(gic_rdists->rdist, from)->rd_base;
 		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_CLRLPIR);
-		while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-			cpu_relax();
+		wait_for_syncr(rdbase);
 
 		return;
 	}
@@ -2929,8 +2934,7 @@ static void its_vpe_send_inv(struct irq_data *d)
 
 		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
 		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_INVLPIR);
-		while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-			cpu_relax();
+		wait_for_syncr(rdbase);
 	} else {
 		its_vpe_send_cmd(vpe, its_send_inv);
 	}
@@ -2972,8 +2976,7 @@ static int its_vpe_set_irqchip_state(struct irq_data *d,
 			gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_SETLPIR);
 		} else {
 			gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_CLRLPIR);
-			while (gic_read_lpir(rdbase + GICR_SYNCR) & 1)
-				cpu_relax();
+			wait_for_syncr(rdbase);
 		}
 	} else {
 		if (state)
-- 
2.20.1

