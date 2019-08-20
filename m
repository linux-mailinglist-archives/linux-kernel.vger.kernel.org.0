Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44AF1966E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfHTQ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 12:57:32 -0400
Received: from enpas.org ([46.38.239.100]:40156 "EHLO mail.enpas.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfHTQ5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:57:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id E8469100070;
        Tue, 20 Aug 2019 16:57:27 +0000 (UTC)
From:   Max Staudt <max@enpas.org>
To:     b.zolnierkie@samsung.com, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        schmitzmic@gmail.com, geert@linux-m68k.org,
        Max Staudt <max@enpas.org>
Subject: [PATCH v6] ata/pata_buddha: Probe via modalias instead of initcall
Date:   Tue, 20 Aug 2019 18:57:15 +0200
Message-Id: <20190820165715.15185-1-max@enpas.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, the pata_buddha driver would only check for cards on
initcall time. Now, the kernel will call its probe function as soon
as a compatible card is detected.

v6: Only do the drvdata workaround for X-Surf (remove breaks otherwise)
    Style

v5: Remove module_exit(): There's no good way to handle the X-Surf hack.
    Also include a workaround to save X-Surf's drvdata in case zorro8390
    is active.

v4: Clean up pata_buddha_probe() by using ent->driver_data.
    Support X-Surf via late_initcall()

v3: Clean up devm_*, implement device removal.

v2: Rename 'zdev' to 'z' to make the patch easy to analyse with
    git diff --ignore-space-change

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/ata/pata_buddha.c | 231 +++++++++++++++++++++++++++-------------------
 1 file changed, 138 insertions(+), 93 deletions(-)

diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
index 11a8044ff..9e1b57866 100644
--- a/drivers/ata/pata_buddha.c
+++ b/drivers/ata/pata_buddha.c
@@ -18,7 +18,9 @@
 #include <linux/kernel.h>
 #include <linux/libata.h>
 #include <linux/mm.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/types.h>
 #include <linux/zorro.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -29,7 +31,7 @@
 #include <asm/setup.h>
 
 #define DRV_NAME "pata_buddha"
-#define DRV_VERSION "0.1.0"
+#define DRV_VERSION "0.1.1"
 
 #define BUDDHA_BASE1	0x800
 #define BUDDHA_BASE2	0xa00
@@ -47,11 +49,11 @@ enum {
 	BOARD_XSURF
 };
 
-static unsigned int buddha_bases[3] __initdata = {
+static unsigned int buddha_bases[3] = {
 	BUDDHA_BASE1, BUDDHA_BASE2, BUDDHA_BASE3
 };
 
-static unsigned int xsurf_bases[2] __initdata = {
+static unsigned int xsurf_bases[2] = {
 	XSURF_BASE1, XSURF_BASE2
 };
 
@@ -145,111 +147,154 @@ static struct ata_port_operations pata_xsurf_ops = {
 	.set_mode	= pata_buddha_set_mode,
 };
 
-static int __init pata_buddha_init_one(void)
+static int pata_buddha_probe(struct zorro_dev *z,
+			     const struct zorro_device_id *ent)
 {
-	struct zorro_dev *z = NULL;
+	static const char * const board_name[] = {
+		"Buddha", "Catweasel", "X-Surf"
+	};
+	struct ata_host *host;
+	void __iomem *buddha_board;
+	unsigned long board;
+	unsigned int type = ent->driver_data;
+	unsigned int nr_ports = (type == BOARD_CATWEASEL) ? 3 : 2;
+	void *old_drvdata;
+	int i;
+
+	dev_info(&z->dev, "%s IDE controller\n", board_name[type]);
+
+	board = z->resource.start;
+
+	if (type != BOARD_XSURF) {
+		if (!devm_request_mem_region(&z->dev,
+					     board + BUDDHA_BASE1,
+					     0x800, DRV_NAME))
+			return -ENXIO;
+	} else {
+		if (!devm_request_mem_region(&z->dev,
+					     board + XSURF_BASE1,
+					     0x1000, DRV_NAME))
+			return -ENXIO;
+		if (!devm_request_mem_region(&z->dev,
+					     board + XSURF_BASE2,
+					     0x1000, DRV_NAME)) {
+		}
+	}
+
+	/* Workaround for X-Surf: Save drvdata in case zorro8390 has set it */
+	if (type == BOARD_XSURF)
+		old_drvdata = dev_get_drvdata(&z->dev);
+
+	/* allocate host */
+	host = ata_host_alloc(&z->dev, nr_ports);
+	if (type == BOARD_XSURF)
+		dev_set_drvdata(&z->dev, old_drvdata);
+	if (!host)
+		return -ENXIO;
+
+	buddha_board = ZTWO_VADDR(board);
+
+	/* enable the board IRQ on Buddha/Catweasel */
+	if (type != BOARD_XSURF)
+		z_writeb(0, buddha_board + BUDDHA_IRQ_MR);
 
-	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-		static const char *board_name[]
-			= { "Buddha", "Catweasel", "X-Surf" };
-		struct ata_host *host;
-		void __iomem *buddha_board;
-		unsigned long board;
-		unsigned int type, nr_ports = 2;
-		int i;
-
-		if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
-			type = BOARD_BUDDHA;
-		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL) {
-			type = BOARD_CATWEASEL;
-			nr_ports++;
-		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF) {
-			type = BOARD_XSURF;
-		} else
-			continue;
-
-		dev_info(&z->dev, "%s IDE controller\n", board_name[type]);
-
-		board = z->resource.start;
+	for (i = 0; i < nr_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		void __iomem *base, *irqport;
+		unsigned long ctl = 0;
 
 		if (type != BOARD_XSURF) {
-			if (!devm_request_mem_region(&z->dev,
-						     board + BUDDHA_BASE1,
-						     0x800, DRV_NAME))
-				continue;
+			ap->ops = &pata_buddha_ops;
+			base = buddha_board + buddha_bases[i];
+			ctl = BUDDHA_CONTROL;
+			irqport = buddha_board + BUDDHA_IRQ + i * 0x40;
 		} else {
-			if (!devm_request_mem_region(&z->dev,
-						     board + XSURF_BASE1,
-						     0x1000, DRV_NAME))
-				continue;
-			if (!devm_request_mem_region(&z->dev,
-						     board + XSURF_BASE2,
-						     0x1000, DRV_NAME))
-				continue;
+			ap->ops = &pata_xsurf_ops;
+			base = buddha_board + xsurf_bases[i];
+			/* X-Surf has no CS1* (Control/AltStat) */
+			irqport = buddha_board + XSURF_IRQ;
 		}
 
-		/* allocate host */
-		host = ata_host_alloc(&z->dev, nr_ports);
-		if (!host)
-			continue;
-
-		buddha_board = ZTWO_VADDR(board);
-
-		/* enable the board IRQ on Buddha/Catweasel */
-		if (type != BOARD_XSURF)
-			z_writeb(0, buddha_board + BUDDHA_IRQ_MR);
-
-		for (i = 0; i < nr_ports; i++) {
-			struct ata_port *ap = host->ports[i];
-			void __iomem *base, *irqport;
-			unsigned long ctl = 0;
-
-			if (type != BOARD_XSURF) {
-				ap->ops = &pata_buddha_ops;
-				base = buddha_board + buddha_bases[i];
-				ctl = BUDDHA_CONTROL;
-				irqport = buddha_board + BUDDHA_IRQ + i * 0x40;
-			} else {
-				ap->ops = &pata_xsurf_ops;
-				base = buddha_board + xsurf_bases[i];
-				/* X-Surf has no CS1* (Control/AltStat) */
-				irqport = buddha_board + XSURF_IRQ;
-			}
-
-			ap->pio_mask = ATA_PIO4;
-			ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
-
-			ap->ioaddr.data_addr		= base;
-			ap->ioaddr.error_addr		= base + 2 + 1 * 4;
-			ap->ioaddr.feature_addr		= base + 2 + 1 * 4;
-			ap->ioaddr.nsect_addr		= base + 2 + 2 * 4;
-			ap->ioaddr.lbal_addr		= base + 2 + 3 * 4;
-			ap->ioaddr.lbam_addr		= base + 2 + 4 * 4;
-			ap->ioaddr.lbah_addr		= base + 2 + 5 * 4;
-			ap->ioaddr.device_addr		= base + 2 + 6 * 4;
-			ap->ioaddr.status_addr		= base + 2 + 7 * 4;
-			ap->ioaddr.command_addr		= base + 2 + 7 * 4;
-
-			if (ctl) {
-				ap->ioaddr.altstatus_addr = base + ctl;
-				ap->ioaddr.ctl_addr	  = base + ctl;
-			}
-
-			ap->private_data = (void *)irqport;
-
-			ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", board,
-				      ctl ? board + buddha_bases[i] + ctl : 0);
+		ap->pio_mask = ATA_PIO4;
+		ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
+
+		ap->ioaddr.data_addr		= base;
+		ap->ioaddr.error_addr		= base + 2 + 1 * 4;
+		ap->ioaddr.feature_addr		= base + 2 + 1 * 4;
+		ap->ioaddr.nsect_addr		= base + 2 + 2 * 4;
+		ap->ioaddr.lbal_addr		= base + 2 + 3 * 4;
+		ap->ioaddr.lbam_addr		= base + 2 + 4 * 4;
+		ap->ioaddr.lbah_addr		= base + 2 + 5 * 4;
+		ap->ioaddr.device_addr		= base + 2 + 6 * 4;
+		ap->ioaddr.status_addr		= base + 2 + 7 * 4;
+		ap->ioaddr.command_addr		= base + 2 + 7 * 4;
+
+		if (ctl) {
+			ap->ioaddr.altstatus_addr = base + ctl;
+			ap->ioaddr.ctl_addr	  = base + ctl;
 		}
 
-		ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
-				  IRQF_SHARED, &pata_buddha_sht);
+		ap->private_data = (void *)irqport;
 
+		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", board,
+			      ctl ? board + buddha_bases[i] + ctl : 0);
 	}
 
+	ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
+			  IRQF_SHARED, &pata_buddha_sht);
+
 	return 0;
 }
 
-module_init(pata_buddha_init_one);
+static void pata_buddha_remove(struct zorro_dev *z)
+{
+	struct ata_host *host = dev_get_drvdata(&z->dev);
+
+	ata_host_detach(host);
+}
+
+static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
+	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, BOARD_BUDDHA},
+	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, BOARD_CATWEASEL},
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(zorro, pata_buddha_zorro_tbl);
+
+static struct zorro_driver pata_buddha_driver = {
+	.name           = "pata_buddha",
+	.id_table       = pata_buddha_zorro_tbl,
+	.probe          = pata_buddha_probe,
+	.remove         = pata_buddha_remove,
+	.driver  = {
+		.suppress_bind_attrs = true,
+	},
+};
+
+/*
+ * We cannot have a modalias for X-Surf boards, as it competes with the
+ * zorro8390 network driver. As a stopgap measure until we have proper
+ * MFD support for this board, we manually attach to it late after Zorro
+ * has enumerated its boards.
+ */
+static int __init pata_buddha_late_init(void)
+{
+	struct zorro_dev *z = NULL;
+
+	/* Auto-bind to regular boards */
+	zorro_register_driver(&pata_buddha_driver);
+
+	/* Manually bind to all X-Surf boards */
+	while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {
+		static struct zorro_device_id xsurf_ent = {
+			ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, BOARD_XSURF
+		};
+
+		pata_buddha_probe(z, &xsurf_ent);
+	}
+
+	return 0;
+}
+late_initcall(pata_buddha_late_init);
 
 MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
 MODULE_DESCRIPTION("low-level driver for Buddha/Catweasel/X-Surf PATA");
-- 
2.11.0

