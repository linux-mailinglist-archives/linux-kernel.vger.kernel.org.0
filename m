Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF4C633DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 12:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGIKCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 06:02:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:48556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbfGIKCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:02:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9C89B120;
        Tue,  9 Jul 2019 10:02:05 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        linux-ide@vger.kernel.org
Subject: [PATCH v2 2/3] ata: make qc_prep return an int
Date:   Tue,  9 Jul 2019 12:02:02 +0200
Message-Id: <20190709100203.19049-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190709100203.19049-1-jslaby@suse.cz>
References: <20190709100203.19049-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case a driver wants to return an error. sata_mv is one of those --
see the next patch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
---
 Documentation/driver-api/libata.rst |  2 +-
 drivers/ata/acard-ahci.c            |  6 ++++--
 drivers/ata/libahci.c               |  6 ++++--
 drivers/ata/libata-core.c           |  9 +++++++--
 drivers/ata/libata-sff.c            | 12 ++++++++----
 drivers/ata/pata_macio.c            |  6 ++++--
 drivers/ata/pata_pxa.c              |  8 +++++---
 drivers/ata/pdc_adma.c              |  7 ++++---
 drivers/ata/sata_fsl.c              |  4 +++-
 drivers/ata/sata_inic162x.c         |  4 +++-
 drivers/ata/sata_mv.c               | 26 +++++++++++++++-----------
 drivers/ata/sata_nv.c               | 18 +++++++++++-------
 drivers/ata/sata_promise.c          |  6 ++++--
 drivers/ata/sata_qstor.c            |  8 +++++---
 drivers/ata/sata_rcar.c             |  6 ++++--
 drivers/ata/sata_sil.c              |  8 +++++---
 drivers/ata/sata_sil24.c            |  6 ++++--
 drivers/ata/sata_sx4.c              |  6 ++++--
 include/linux/libata.h              | 12 ++++++------
 19 files changed, 101 insertions(+), 59 deletions(-)

diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
index c2ee38098e85..ec17fea6ca57 100644
--- a/Documentation/driver-api/libata.rst
+++ b/Documentation/driver-api/libata.rst
@@ -250,7 +250,7 @@ High-level taskfile hooks
 
 ::
 
-    void (*qc_prep) (struct ata_queued_cmd *qc);
+    int (*qc_prep) (struct ata_queued_cmd *qc);
     int (*qc_issue) (struct ata_queued_cmd *qc);
 
 
diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 85357f27a66b..17222dcd8132 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -56,7 +56,7 @@ struct acard_sg {
 	__le32			size;	 /* bit 31 (EOT) max==0x10000 (64k) */
 };
 
-static void acard_ahci_qc_prep(struct ata_queued_cmd *qc);
+static int acard_ahci_qc_prep(struct ata_queued_cmd *qc);
 static bool acard_ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
 static int acard_ahci_port_start(struct ata_port *ap);
 static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -241,7 +241,7 @@ static unsigned int acard_ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 	return si;
 }
 
-static void acard_ahci_qc_prep(struct ata_queued_cmd *qc)
+static int acard_ahci_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ahci_port_priv *pp = ap->private_data;
@@ -279,6 +279,8 @@ static void acard_ahci_qc_prep(struct ata_queued_cmd *qc)
 		opts |= AHCI_CMD_ATAPI | AHCI_CMD_PREFETCH;
 
 	ahci_fill_cmd_slot(pp, qc->hw_tag, opts);
+
+	return 0;
 }
 
 static bool acard_ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e4c45d3cca79..7190e2879414 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -57,7 +57,7 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
 static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
-static void ahci_qc_prep(struct ata_queued_cmd *qc);
+static int ahci_qc_prep(struct ata_queued_cmd *qc);
 static int ahci_pmp_qc_defer(struct ata_queued_cmd *qc);
 static void ahci_freeze(struct ata_port *ap);
 static void ahci_thaw(struct ata_port *ap);
@@ -1625,7 +1625,7 @@ static int ahci_pmp_qc_defer(struct ata_queued_cmd *qc)
 		return sata_pmp_qc_defer_cmd_switch(qc);
 }
 
-static void ahci_qc_prep(struct ata_queued_cmd *qc)
+static int ahci_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ahci_port_priv *pp = ap->private_data;
@@ -1661,6 +1661,8 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 		opts |= AHCI_CMD_ATAPI | AHCI_CMD_PREFETCH;
 
 	ahci_fill_cmd_slot(pp, qc->hw_tag, opts);
+
+	return 0;
 }
 
 static void ahci_fbs_dec_intr(struct ata_port *ap)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 28c492be0a57..236848595c8f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4980,7 +4980,10 @@ int ata_std_qc_defer(struct ata_queued_cmd *qc)
 	return ATA_DEFER_LINK;
 }
 
-void ata_noop_qc_prep(struct ata_queued_cmd *qc) { }
+int ata_noop_qc_prep(struct ata_queued_cmd *qc)
+{
+	return 0;
+}
 
 /**
  *	ata_sg_init - Associate command with scatter-gather table.
@@ -5443,7 +5446,9 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 		return;
 	}
 
-	ap->ops->qc_prep(qc);
+	qc->err_mask |= ap->ops->qc_prep(qc);
+	if (unlikely(qc->err_mask))
+		goto err;
 	trace_ata_qc_issue(qc);
 	qc->err_mask |= ap->ops->qc_issue(qc);
 	if (unlikely(qc->err_mask))
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 10aa27882142..f2752b909ac3 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2673,12 +2673,14 @@ static void ata_bmdma_fill_sg_dumb(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_bmdma_qc_prep(struct ata_queued_cmd *qc)
+int ata_bmdma_qc_prep(struct ata_queued_cmd *qc)
 {
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+		return 0;
 
 	ata_bmdma_fill_sg(qc);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_bmdma_qc_prep);
 
@@ -2691,12 +2693,14 @@ EXPORT_SYMBOL_GPL(ata_bmdma_qc_prep);
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_bmdma_dumb_qc_prep(struct ata_queued_cmd *qc)
+int ata_bmdma_dumb_qc_prep(struct ata_queued_cmd *qc)
 {
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+		return 0;
 
 	ata_bmdma_fill_sg_dumb(qc);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_bmdma_dumb_qc_prep);
 
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 57f2ec71cfc3..df402ee4974d 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -510,7 +510,7 @@ static int pata_macio_cable_detect(struct ata_port *ap)
 	return ATA_CBL_PATA40;
 }
 
-static void pata_macio_qc_prep(struct ata_queued_cmd *qc)
+static int pata_macio_qc_prep(struct ata_queued_cmd *qc)
 {
 	unsigned int write = (qc->tf.flags & ATA_TFLAG_WRITE);
 	struct ata_port *ap = qc->ap;
@@ -523,7 +523,7 @@ static void pata_macio_qc_prep(struct ata_queued_cmd *qc)
 		   __func__, qc, qc->flags, write, qc->dev->devno);
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+		return 0;
 
 	table = (struct dbdma_cmd *) priv->dma_table_cpu;
 
@@ -568,6 +568,8 @@ static void pata_macio_qc_prep(struct ata_queued_cmd *qc)
 	table->command = cpu_to_le16(DBDMA_STOP);
 
 	dev_dbgdma(priv->dev, "%s: %d DMA list entries\n", __func__, pi);
+
+	return 0;
 }
 
 
diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 4afcb8e63e21..6fc141440509 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -44,25 +44,27 @@ static void pxa_ata_dma_irq(void *d)
 /*
  * Prepare taskfile for submission.
  */
-static void pxa_qc_prep(struct ata_queued_cmd *qc)
+static int pxa_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct pata_pxa_data *pd = qc->ap->private_data;
 	struct dma_async_tx_descriptor *tx;
 	enum dma_transfer_direction dir;
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+		return 0;
 
 	dir = (qc->dma_dir == DMA_TO_DEVICE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
 	tx = dmaengine_prep_slave_sg(pd->dma_chan, qc->sg, qc->n_elem, dir,
 				     DMA_PREP_INTERRUPT);
 	if (!tx) {
 		ata_dev_err(qc->dev, "prep_slave_sg() failed\n");
-		return;
+		return 0;
 	}
 	tx->callback = pxa_ata_dma_irq;
 	tx->callback_param = pd;
 	pd->dma_cookie = dmaengine_submit(tx);
+
+	return 0;
 }
 
 /*
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index c5bbb07aa7d9..fc6fb163a765 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -116,7 +116,7 @@ static int adma_ata_init_one(struct pci_dev *pdev,
 				const struct pci_device_id *ent);
 static int adma_port_start(struct ata_port *ap);
 static void adma_port_stop(struct ata_port *ap);
-static void adma_qc_prep(struct ata_queued_cmd *qc);
+static int adma_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int adma_qc_issue(struct ata_queued_cmd *qc);
 static int adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void adma_freeze(struct ata_port *ap);
@@ -295,7 +295,7 @@ static int adma_fill_sg(struct ata_queued_cmd *qc)
 	return i;
 }
 
-static void adma_qc_prep(struct ata_queued_cmd *qc)
+static int adma_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct adma_port_priv *pp = qc->ap->private_data;
 	u8  *buf = pp->pkt;
@@ -306,7 +306,7 @@ static void adma_qc_prep(struct ata_queued_cmd *qc)
 
 	adma_enter_reg_mode(qc->ap);
 	if (qc->tf.protocol != ATA_PROT_DMA)
-		return;
+		return 0;
 
 	buf[i++] = 0;	/* Response flags */
 	buf[i++] = 0;	/* reserved */
@@ -371,6 +371,7 @@ static void adma_qc_prep(struct ata_queued_cmd *qc)
 			printk("%s\n", obuf);
 	}
 #endif
+	return 0;
 }
 
 static inline void adma_packet_start(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 8e9cb198fcd1..ccddf0730828 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -502,7 +502,7 @@ static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
 	return num_prde;
 }
 
-static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
+static int sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct sata_fsl_port_priv *pp = ap->private_data;
@@ -548,6 +548,8 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 
 	VPRINTK("SATA FSL : xx_qc_prep, di = 0x%x, ttl = %d, num_prde = %d\n",
 		desc_info, ttl_dwords, num_prde);
+
+	return 0;
 }
 
 static unsigned int sata_fsl_qc_issue(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 790968497dfe..78f5ae2f9b0a 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -478,7 +478,7 @@ static void inic_fill_sg(struct inic_prd *prd, struct ata_queued_cmd *qc)
 	prd[-1].flags |= PRD_END;
 }
 
-static void inic_qc_prep(struct ata_queued_cmd *qc)
+static int inic_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct inic_port_priv *pp = qc->ap->private_data;
 	struct inic_pkt *pkt = pp->pkt;
@@ -538,6 +538,8 @@ static void inic_qc_prep(struct ata_queued_cmd *qc)
 		inic_fill_sg(prd, qc);
 
 	pp->cpb_tbl[0] = pp->pkt_dma;
+
+	return 0;
 }
 
 static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index da585d2bded6..d6aac7b31c45 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -592,8 +592,8 @@ static int mv5_scr_write(struct ata_link *link, unsigned int sc_reg_in, u32 val)
 static int mv_port_start(struct ata_port *ap);
 static void mv_port_stop(struct ata_port *ap);
 static int mv_qc_defer(struct ata_queued_cmd *qc);
-static void mv_qc_prep(struct ata_queued_cmd *qc);
-static void mv_qc_prep_iie(struct ata_queued_cmd *qc);
+static int mv_qc_prep(struct ata_queued_cmd *qc);
+static int mv_qc_prep_iie(struct ata_queued_cmd *qc);
 static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
 static int mv_hardreset(struct ata_link *link, unsigned int *class,
 			unsigned long deadline);
@@ -2031,7 +2031,7 @@ static void mv_rw_multi_errata_sata24(struct ata_queued_cmd *qc)
  *      LOCKING:
  *      Inherited from caller.
  */
-static void mv_qc_prep(struct ata_queued_cmd *qc)
+static int mv_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct mv_port_priv *pp = ap->private_data;
@@ -2043,15 +2043,15 @@ static void mv_qc_prep(struct ata_queued_cmd *qc)
 	switch (tf->protocol) {
 	case ATA_PROT_DMA:
 		if (tf->command == ATA_CMD_DSM)
-			return;
+			return 0;
 		/* fall-thru */
 	case ATA_PROT_NCQ:
 		break;	/* continue below */
 	case ATA_PROT_PIO:
 		mv_rw_multi_errata_sata24(qc);
-		return;
+		return 0;
 	default:
-		return;
+		return 0;
 	}
 
 	/* Fill in command request block
@@ -2116,8 +2116,10 @@ static void mv_qc_prep(struct ata_queued_cmd *qc)
 	mv_crqb_pack_cmd(cw++, tf->command, ATA_REG_CMD, 1);	/* last */
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+		return 0;
 	mv_fill_sg(qc);
+
+	return 0;
 }
 
 /**
@@ -2132,7 +2134,7 @@ static void mv_qc_prep(struct ata_queued_cmd *qc)
  *      LOCKING:
  *      Inherited from caller.
  */
-static void mv_qc_prep_iie(struct ata_queued_cmd *qc)
+static int mv_qc_prep_iie(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct mv_port_priv *pp = ap->private_data;
@@ -2143,9 +2145,9 @@ static void mv_qc_prep_iie(struct ata_queued_cmd *qc)
 
 	if ((tf->protocol != ATA_PROT_DMA) &&
 	    (tf->protocol != ATA_PROT_NCQ))
-		return;
+		return 0;
 	if (tf->command == ATA_CMD_DSM)
-		return;  /* use bmdma for this */
+		return 0;  /* use bmdma for this */
 
 	/* Fill in Gen IIE command request block */
 	if (!(tf->flags & ATA_TFLAG_WRITE))
@@ -2186,8 +2188,10 @@ static void mv_qc_prep_iie(struct ata_queued_cmd *qc)
 		);
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+		return 0;
 	mv_fill_sg(qc);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index b44b4b64354c..9269372ecddd 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -297,7 +297,7 @@ static void nv_ck804_freeze(struct ata_port *ap);
 static void nv_ck804_thaw(struct ata_port *ap);
 static int nv_adma_slave_config(struct scsi_device *sdev);
 static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc);
-static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
+static int nv_adma_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance);
 static void nv_adma_irq_clear(struct ata_port *ap);
@@ -319,7 +319,7 @@ static void nv_mcp55_freeze(struct ata_port *ap);
 static void nv_swncq_error_handler(struct ata_port *ap);
 static int nv_swncq_slave_config(struct scsi_device *sdev);
 static int nv_swncq_port_start(struct ata_port *ap);
-static void nv_swncq_qc_prep(struct ata_queued_cmd *qc);
+static int nv_swncq_qc_prep(struct ata_queued_cmd *qc);
 static void nv_swncq_fill_sg(struct ata_queued_cmd *qc);
 static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc);
 static void nv_swncq_irq_clear(struct ata_port *ap, u16 fis);
@@ -1348,7 +1348,7 @@ static int nv_adma_use_reg_mode(struct ata_queued_cmd *qc)
 	return 1;
 }
 
-static void nv_adma_qc_prep(struct ata_queued_cmd *qc)
+static int nv_adma_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct nv_adma_port_priv *pp = qc->ap->private_data;
 	struct nv_adma_cpb *cpb = &pp->cpb[qc->hw_tag];
@@ -1360,7 +1360,7 @@ static void nv_adma_qc_prep(struct ata_queued_cmd *qc)
 			(qc->flags & ATA_QCFLAG_DMAMAP));
 		nv_adma_register_mode(qc->ap);
 		ata_bmdma_qc_prep(qc);
-		return;
+		return 0;
 	}
 
 	cpb->resp_flags = NV_CPB_RESP_DONE;
@@ -1392,6 +1392,8 @@ static void nv_adma_qc_prep(struct ata_queued_cmd *qc)
 	cpb->ctl_flags = ctl_flags;
 	wmb();
 	cpb->resp_flags = 0;
+
+	return 0;
 }
 
 static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
@@ -1954,17 +1956,19 @@ static int nv_swncq_port_start(struct ata_port *ap)
 	return 0;
 }
 
-static void nv_swncq_qc_prep(struct ata_queued_cmd *qc)
+static int nv_swncq_qc_prep(struct ata_queued_cmd *qc)
 {
 	if (qc->tf.protocol != ATA_PROT_NCQ) {
 		ata_bmdma_qc_prep(qc);
-		return;
+		return 0;
 	}
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+		return 0;
 
 	nv_swncq_fill_sg(qc);
+
+	return 0;
 }
 
 static void nv_swncq_fill_sg(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index f4dfec3b6e42..ca5780983029 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -139,7 +139,7 @@ static int pdc_sata_scr_write(struct ata_link *link, unsigned int sc_reg, u32 va
 static int pdc_ata_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static int pdc_common_port_start(struct ata_port *ap);
 static int pdc_sata_port_start(struct ata_port *ap);
-static void pdc_qc_prep(struct ata_queued_cmd *qc);
+static int pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static int pdc_check_atapi_dma(struct ata_queued_cmd *qc);
@@ -633,7 +633,7 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
 	prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
 
-static void pdc_qc_prep(struct ata_queued_cmd *qc)
+static int pdc_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct pdc_port_priv *pp = qc->ap->private_data;
 	unsigned int i;
@@ -665,6 +665,8 @@ static void pdc_qc_prep(struct ata_queued_cmd *qc)
 	default:
 		break;
 	}
+
+	return 0;
 }
 
 static int pdc_is_sataii_tx4(unsigned long flags)
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 865e5c58bd94..ff2325f90055 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -100,7 +100,7 @@ static int qs_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
 static int qs_ata_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static int qs_port_start(struct ata_port *ap);
 static void qs_host_stop(struct ata_host *host);
-static void qs_qc_prep(struct ata_queued_cmd *qc);
+static int qs_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int qs_qc_issue(struct ata_queued_cmd *qc);
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc);
 static void qs_freeze(struct ata_port *ap);
@@ -260,7 +260,7 @@ static unsigned int qs_fill_sg(struct ata_queued_cmd *qc)
 	return si;
 }
 
-static void qs_qc_prep(struct ata_queued_cmd *qc)
+static int qs_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct qs_port_priv *pp = qc->ap->private_data;
 	u8 dflags = QS_DF_PORD, *buf = pp->pkt;
@@ -272,7 +272,7 @@ static void qs_qc_prep(struct ata_queued_cmd *qc)
 
 	qs_enter_reg_mode(qc->ap);
 	if (qc->tf.protocol != ATA_PROT_DMA)
-		return;
+		return 0;
 
 	nelem = qs_fill_sg(qc);
 
@@ -295,6 +295,8 @@ static void qs_qc_prep(struct ata_queued_cmd *qc)
 
 	/* frame information structure (FIS) */
 	ata_tf_to_fis(&qc->tf, 0, 1, &buf[32]);
+
+	return 0;
 }
 
 static inline void qs_packet_start(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 3495e1733a8e..8b0f363c86ac 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -550,12 +550,14 @@ static void sata_rcar_bmdma_fill_sg(struct ata_queued_cmd *qc)
 	prd[si - 1].addr |= cpu_to_le32(SATA_RCAR_DTEND);
 }
 
-static void sata_rcar_qc_prep(struct ata_queued_cmd *qc)
+static int sata_rcar_qc_prep(struct ata_queued_cmd *qc)
 {
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+		return 0;
 
 	sata_rcar_bmdma_fill_sg(qc);
+
+	return 0;
 }
 
 static void sata_rcar_bmdma_setup(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 25b6a52be5ab..a1806a0b3420 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -103,7 +103,7 @@ static void sil_dev_config(struct ata_device *dev);
 static int sil_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int sil_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
 static int sil_set_mode(struct ata_link *link, struct ata_device **r_failed);
-static void sil_qc_prep(struct ata_queued_cmd *qc);
+static int sil_qc_prep(struct ata_queued_cmd *qc);
 static void sil_bmdma_setup(struct ata_queued_cmd *qc);
 static void sil_bmdma_start(struct ata_queued_cmd *qc);
 static void sil_bmdma_stop(struct ata_queued_cmd *qc);
@@ -317,12 +317,14 @@ static void sil_fill_sg(struct ata_queued_cmd *qc)
 		last_prd->flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
 
-static void sil_qc_prep(struct ata_queued_cmd *qc)
+static int sil_qc_prep(struct ata_queued_cmd *qc)
 {
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
-		return;
+		return 0;
 
 	sil_fill_sg(qc);
+
+	return 0;
 }
 
 static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 98aad8206921..17bb01fe3186 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -326,7 +326,7 @@ static void sil24_dev_config(struct ata_device *dev);
 static int sil24_scr_read(struct ata_link *link, unsigned sc_reg, u32 *val);
 static int sil24_scr_write(struct ata_link *link, unsigned sc_reg, u32 val);
 static int sil24_qc_defer(struct ata_queued_cmd *qc);
-static void sil24_qc_prep(struct ata_queued_cmd *qc);
+static int sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static bool sil24_qc_fill_rtf(struct ata_queued_cmd *qc);
 static void sil24_pmp_attach(struct ata_port *ap);
@@ -830,7 +830,7 @@ static int sil24_qc_defer(struct ata_queued_cmd *qc)
 	return ata_std_qc_defer(qc);
 }
 
-static void sil24_qc_prep(struct ata_queued_cmd *qc)
+static int sil24_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct sil24_port_priv *pp = ap->private_data;
@@ -874,6 +874,8 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
 		sil24_fill_sg(qc, sge);
+
+	return 0;
 }
 
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index ae8e374d0a77..4d726dca957a 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -202,7 +202,7 @@ static void pdc_error_handler(struct ata_port *ap);
 static void pdc_freeze(struct ata_port *ap);
 static void pdc_thaw(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
-static void pdc20621_qc_prep(struct ata_queued_cmd *qc);
+static int pdc20621_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static unsigned int pdc20621_dimm_init(struct ata_host *host);
@@ -530,7 +530,7 @@ static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
 	VPRINTK("ata pkt buf ofs %u, mmio copied\n", i);
 }
 
-static void pdc20621_qc_prep(struct ata_queued_cmd *qc)
+static int pdc20621_qc_prep(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -542,6 +542,8 @@ static void pdc20621_qc_prep(struct ata_queued_cmd *qc)
 	default:
 		break;
 	}
+
+	return 0;
 }
 
 static void __pdc20621_push_hdma(struct ata_queued_cmd *qc,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 207e7ee764ce..76d855244a4d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -891,9 +891,9 @@ struct ata_port_operations {
 	/*
 	 * Command execution
 	 */
-	int  (*qc_defer)(struct ata_queued_cmd *qc);
-	int  (*check_atapi_dma)(struct ata_queued_cmd *qc);
-	void (*qc_prep)(struct ata_queued_cmd *qc);
+	int (*qc_defer)(struct ata_queued_cmd *qc);
+	int (*check_atapi_dma)(struct ata_queued_cmd *qc);
+	int (*qc_prep)(struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue)(struct ata_queued_cmd *qc);
 	bool (*qc_fill_rtf)(struct ata_queued_cmd *qc);
 
@@ -1161,7 +1161,7 @@ extern int ata_xfer_mode2shift(unsigned long xfer_mode);
 extern const char *ata_mode_string(unsigned long xfer_mask);
 extern unsigned long ata_id_xfermask(const u16 *id);
 extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
-extern void ata_noop_qc_prep(struct ata_queued_cmd *qc);
+extern int ata_noop_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem);
 extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
@@ -1893,9 +1893,9 @@ extern const struct ata_port_operations ata_bmdma_port_ops;
 	.sg_tablesize		= LIBATA_MAX_PRD,		\
 	.dma_boundary		= ATA_DMA_BOUNDARY
 
-extern void ata_bmdma_qc_prep(struct ata_queued_cmd *qc);
+extern int ata_bmdma_qc_prep(struct ata_queued_cmd *qc);
 extern unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc);
-extern void ata_bmdma_dumb_qc_prep(struct ata_queued_cmd *qc);
+extern int ata_bmdma_dumb_qc_prep(struct ata_queued_cmd *qc);
 extern unsigned int ata_bmdma_port_intr(struct ata_port *ap,
 				      struct ata_queued_cmd *qc);
 extern irqreturn_t ata_bmdma_interrupt(int irq, void *dev_instance);
-- 
2.22.0

