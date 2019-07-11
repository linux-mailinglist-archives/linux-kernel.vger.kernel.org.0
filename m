Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD6660AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 22:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfGKUaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 16:30:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:56638 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbfGKUao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:30:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 13:30:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="189625234"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2019 13:30:43 -0700
From:   thor.thayer@linux.intel.com
To:     mdf@kernel.org, richard.gong@intel.com, agust@denx.de
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH 1/3] fpga: altera-cvp: Discover Vendor Specific offset
Date:   Thu, 11 Jul 2019 15:32:48 -0500
Message-Id: <1562877170-23931-2-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562877170-23931-1-git-send-email-thor.thayer@linux.intel.com>
References: <1562877170-23931-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Newer Intel FPGAs have different Vendor Specific offsets than
legacy parts. Use PCI discovery to find the CvP registers.
Since the register positions remain the same, change the hard
coded address to a more flexible way of indexing registers
from the offset.
Adding new PCI read and write abstraction functions to
handle the offset (altera_read_config_dword() and
altera_write_config_dword()).

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/fpga/altera-cvp.c | 91 +++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 35 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 770915fb97f9..04f2b2a072a7 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -22,10 +22,10 @@
 #define TIMEOUT_US	2000	/* CVP STATUS timeout for USERMODE polling */
 
 /* Vendor Specific Extended Capability Registers */
-#define VSE_PCIE_EXT_CAP_ID		0x200
+#define VSE_PCIE_EXT_CAP_ID		0x0
 #define VSE_PCIE_EXT_CAP_ID_VAL		0x000b	/* 16bit */
 
-#define VSE_CVP_STATUS			0x21c	/* 32bit */
+#define VSE_CVP_STATUS			0x1c	/* 32bit */
 #define VSE_CVP_STATUS_CFG_RDY		BIT(18)	/* CVP_CONFIG_READY */
 #define VSE_CVP_STATUS_CFG_ERR		BIT(19)	/* CVP_CONFIG_ERROR */
 #define VSE_CVP_STATUS_CVP_EN		BIT(20)	/* ctrl block is enabling CVP */
@@ -33,18 +33,18 @@
 #define VSE_CVP_STATUS_CFG_DONE		BIT(23)	/* CVP_CONFIG_DONE */
 #define VSE_CVP_STATUS_PLD_CLK_IN_USE	BIT(24)	/* PLD_CLK_IN_USE */
 
-#define VSE_CVP_MODE_CTRL		0x220	/* 32bit */
+#define VSE_CVP_MODE_CTRL		0x20	/* 32bit */
 #define VSE_CVP_MODE_CTRL_CVP_MODE	BIT(0)	/* CVP (1) or normal mode (0) */
 #define VSE_CVP_MODE_CTRL_HIP_CLK_SEL	BIT(1) /* PMA (1) or fabric clock (0) */
 #define VSE_CVP_MODE_CTRL_NUMCLKS_OFF	8	/* NUMCLKS bits offset */
 #define VSE_CVP_MODE_CTRL_NUMCLKS_MASK	GENMASK(15, 8)
 
-#define VSE_CVP_DATA			0x228	/* 32bit */
-#define VSE_CVP_PROG_CTRL		0x22c	/* 32bit */
+#define VSE_CVP_DATA			0x28	/* 32bit */
+#define VSE_CVP_PROG_CTRL		0x2c	/* 32bit */
 #define VSE_CVP_PROG_CTRL_CONFIG	BIT(0)
 #define VSE_CVP_PROG_CTRL_START_XFER	BIT(1)
 
-#define VSE_UNCOR_ERR_STATUS		0x234	/* 32bit */
+#define VSE_UNCOR_ERR_STATUS		0x34	/* 32bit */
 #define VSE_UNCOR_ERR_CVP_CFG_ERR	BIT(5)	/* CVP_CONFIG_ERROR_LATCHED */
 
 #define DRV_NAME		"altera-cvp"
@@ -60,14 +60,27 @@ struct altera_cvp_conf {
 	void			(*write_data)(struct altera_cvp_conf *, u32);
 	char			mgr_name[64];
 	u8			numclks;
+	u32			vsec_offset;
 };
 
+static inline void altera_read_config_dword(struct altera_cvp_conf *conf,
+					    int where, u32 *val)
+{
+	pci_read_config_dword(conf->pci_dev, conf->vsec_offset + where, val);
+}
+
+static inline void altera_write_config_dword(struct altera_cvp_conf *conf,
+					     int where, u32 val)
+{
+	pci_write_config_dword(conf->pci_dev, conf->vsec_offset + where, val);
+}
+
 static enum fpga_mgr_states altera_cvp_state(struct fpga_manager *mgr)
 {
 	struct altera_cvp_conf *conf = mgr->priv;
 	u32 status;
 
-	pci_read_config_dword(conf->pci_dev, VSE_CVP_STATUS, &status);
+	altera_read_config_dword(conf, VSE_CVP_STATUS, &status);
 
 	if (status & VSE_CVP_STATUS_CFG_DONE)
 		return FPGA_MGR_STATE_OPERATING;
@@ -85,7 +98,8 @@ static void altera_cvp_write_data_iomem(struct altera_cvp_conf *conf, u32 val)
 
 static void altera_cvp_write_data_config(struct altera_cvp_conf *conf, u32 val)
 {
-	pci_write_config_dword(conf->pci_dev, VSE_CVP_DATA, val);
+	pci_write_config_dword(conf->pci_dev, conf->vsec_offset + VSE_CVP_DATA,
+			       val);
 }
 
 /* switches between CvP clock and internal clock */
@@ -95,10 +109,10 @@ static void altera_cvp_dummy_write(struct altera_cvp_conf *conf)
 	u32 val;
 
 	/* set 1 CVP clock cycle for every CVP Data Register Write */
-	pci_read_config_dword(conf->pci_dev, VSE_CVP_MODE_CTRL, &val);
+	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
 	val &= ~VSE_CVP_MODE_CTRL_NUMCLKS_MASK;
 	val |= 1 << VSE_CVP_MODE_CTRL_NUMCLKS_OFF;
-	pci_write_config_dword(conf->pci_dev, VSE_CVP_MODE_CTRL, val);
+	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
 
 	for (i = 0; i < CVP_DUMMY_WR; i++)
 		conf->write_data(conf, 0); /* dummy data, could be any value */
@@ -115,7 +129,7 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
 		retries++;
 
 	do {
-		pci_read_config_dword(conf->pci_dev, VSE_CVP_STATUS, &val);
+		altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
 		if ((val & status_mask) == status_val)
 			return 0;
 
@@ -130,18 +144,17 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
 			       struct fpga_image_info *info)
 {
 	struct altera_cvp_conf *conf = mgr->priv;
-	struct pci_dev *pdev = conf->pci_dev;
 	int ret;
 	u32 val;
 
 	/* STEP 12 - reset START_XFER bit */
-	pci_read_config_dword(pdev, VSE_CVP_PROG_CTRL, &val);
+	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
 	val &= ~VSE_CVP_PROG_CTRL_START_XFER;
-	pci_write_config_dword(pdev, VSE_CVP_PROG_CTRL, val);
+	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
 
 	/* STEP 13 - reset CVP_CONFIG bit */
 	val &= ~VSE_CVP_PROG_CTRL_CONFIG;
-	pci_write_config_dword(pdev, VSE_CVP_PROG_CTRL, val);
+	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
 
 	/*
 	 * STEP 14
@@ -163,7 +176,6 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 				 const char *buf, size_t count)
 {
 	struct altera_cvp_conf *conf = mgr->priv;
-	struct pci_dev *pdev = conf->pci_dev;
 	u32 iflags, val;
 	int ret;
 
@@ -183,7 +195,7 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 		conf->numclks = 1; /* for uncompressed and unencrypted images */
 
 	/* STEP 1 - read CVP status and check CVP_EN flag */
-	pci_read_config_dword(pdev, VSE_CVP_STATUS, &val);
+	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
 	if (!(val & VSE_CVP_STATUS_CVP_EN)) {
 		dev_err(&mgr->dev, "CVP mode off: 0x%04x\n", val);
 		return -ENODEV;
@@ -201,14 +213,14 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 	 * - set HIP_CLK_SEL and CVP_MODE (must be set in the order mentioned)
 	 */
 	/* switch from fabric to PMA clock */
-	pci_read_config_dword(pdev, VSE_CVP_MODE_CTRL, &val);
+	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
 	val |= VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
-	pci_write_config_dword(pdev, VSE_CVP_MODE_CTRL, val);
+	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
 
 	/* set CVP mode */
-	pci_read_config_dword(pdev, VSE_CVP_MODE_CTRL, &val);
+	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
 	val |= VSE_CVP_MODE_CTRL_CVP_MODE;
-	pci_write_config_dword(pdev, VSE_CVP_MODE_CTRL, val);
+	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
 
 	/*
 	 * STEP 3
@@ -217,10 +229,10 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 	altera_cvp_dummy_write(conf);
 
 	/* STEP 4 - set CVP_CONFIG bit */
-	pci_read_config_dword(pdev, VSE_CVP_PROG_CTRL, &val);
+	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
 	/* request control block to begin transfer using CVP */
 	val |= VSE_CVP_PROG_CTRL_CONFIG;
-	pci_write_config_dword(pdev, VSE_CVP_PROG_CTRL, val);
+	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
 
 	/* STEP 5 - poll CVP_CONFIG READY for 1 with 10us timeout */
 	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY,
@@ -237,15 +249,15 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 	altera_cvp_dummy_write(conf);
 
 	/* STEP 7 - set START_XFER */
-	pci_read_config_dword(pdev, VSE_CVP_PROG_CTRL, &val);
+	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
 	val |= VSE_CVP_PROG_CTRL_START_XFER;
-	pci_write_config_dword(pdev, VSE_CVP_PROG_CTRL, val);
+	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
 
 	/* STEP 8 - start transfer (set CVP_NUMCLKS for bitstream) */
-	pci_read_config_dword(pdev, VSE_CVP_MODE_CTRL, &val);
+	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
 	val &= ~VSE_CVP_MODE_CTRL_NUMCLKS_MASK;
 	val |= conf->numclks << VSE_CVP_MODE_CTRL_NUMCLKS_OFF;
-	pci_write_config_dword(pdev, VSE_CVP_MODE_CTRL, val);
+	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
 
 	return 0;
 }
@@ -256,7 +268,7 @@ static inline int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
 	u32 val;
 
 	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
-	pci_read_config_dword(conf->pci_dev, VSE_CVP_STATUS, &val);
+	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
 	if (val & VSE_CVP_STATUS_CFG_ERR) {
 		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
 			bytes);
@@ -315,7 +327,6 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 				     struct fpga_image_info *info)
 {
 	struct altera_cvp_conf *conf = mgr->priv;
-	struct pci_dev *pdev = conf->pci_dev;
 	int ret;
 	u32 mask;
 	u32 val;
@@ -325,17 +336,17 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 		return ret;
 
 	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
-	pci_read_config_dword(pdev, VSE_UNCOR_ERR_STATUS, &val);
+	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
 	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
 		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
 		return -EPROTO;
 	}
 
 	/* STEP 17 - reset CVP_MODE and HIP_CLK_SEL bit */
-	pci_read_config_dword(pdev, VSE_CVP_MODE_CTRL, &val);
+	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
 	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
 	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
-	pci_write_config_dword(pdev, VSE_CVP_MODE_CTRL, val);
+	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
 
 	/* STEP 18 - poll PLD_CLK_IN_USE and USER_MODE bits */
 	mask = VSE_CVP_STATUS_PLD_CLK_IN_USE | VSE_CVP_STATUS_USERMODE;
@@ -396,20 +407,27 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	struct fpga_manager *mgr;
 	u16 cmd, val;
 	u32 regval;
-	int ret;
+	int ret, offset;
+
+	/* Discover the Vendor Specific Offset for this device */
+	offset = pci_find_next_ext_capability(pdev, 0, PCI_EXT_CAP_ID_VNDR);
+	if (!offset) {
+		dev_err(&pdev->dev, "No Vendor Specific Offset.\n");
+		return -ENODEV;
+	}
 
 	/*
 	 * First check if this is the expected FPGA device. PCI config
 	 * space access works without enabling the PCI device, memory
 	 * space access is enabled further down.
 	 */
-	pci_read_config_word(pdev, VSE_PCIE_EXT_CAP_ID, &val);
+	pci_read_config_word(pdev, offset + VSE_PCIE_EXT_CAP_ID, &val);
 	if (val != VSE_PCIE_EXT_CAP_ID_VAL) {
 		dev_err(&pdev->dev, "Wrong EXT_CAP_ID value 0x%x\n", val);
 		return -ENODEV;
 	}
 
-	pci_read_config_dword(pdev, VSE_CVP_STATUS, &regval);
+	pci_read_config_dword(pdev, offset + VSE_CVP_STATUS, &regval);
 	if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
 		dev_err(&pdev->dev,
 			"CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
@@ -421,6 +439,9 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	if (!conf)
 		return -ENOMEM;
 
+	conf->vsec_offset = offset;
+	dev_dbg(&pdev->dev, "Vendor Specific Data Offset at 0x%x\n", offset);
+
 	/*
 	 * Enable memory BAR access. We cannot use pci_enable_device() here
 	 * because it will make the driver unusable with FPGA devices that
-- 
2.7.4

