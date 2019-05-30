Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55644304BB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 00:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfE3WXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 18:23:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40514 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3WXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:23:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id r18so10317667edo.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T3N4h0dd1g4eImz2VJjO/VLzKH6Oo3mPTeCW7MahZFg=;
        b=DJ2xQQj3Wv5aqtiVGdC8ig1iBpw+w1kN+HslWeWF/gIuLsdA6EM5M94ErpdQHwj1LA
         qICkmzSQ7wUcLe8jcPoeKpyTI+LMO85ztQMH5nk+qNqwT5CRiieidfa0ApiKVpOIjZNa
         aZLHuoZjnodUIH4jQtz22KBnJq7Vg32jmamVkRO6Zjp4HdCcoMb5fG9Z03LikKwYFUPu
         l+PXZW55rIYg/2qZt0L3ZHV+KG6CWg7NLKkxNU4vIZ9dXQqLy4pIm9572myIapCcQslf
         d2cPv8NrR5l5buHFjSgkGTLsJchO8VM1FWBX0YPiNJ3QfrbQueRwOmFJgCwmBJtrIcfF
         4nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T3N4h0dd1g4eImz2VJjO/VLzKH6Oo3mPTeCW7MahZFg=;
        b=D3I33d4h4rku6rEJxqM4qUm+aoAl/nNlkh/rKwK1S8asbLOf+ipklZw0iIkBuoNEzI
         1yWV7MwJg4oh175Qf5+zfT/OJLIZfrFhwP1kvKjtkCGYnu7GbCsGJdM5mC7M1hIcYMA6
         tSNuxNcyWN0KWmDtSfrKIANPwnk4i1pRR7Uz45EzogW0oqWPmtWIel1pC/JPCW9rK5D/
         ad1FBBqeNdtnPXSq1buSRyEpPlUgVtcDWNcFbdS53or/iMSPC+SRl5wO9QJQfUunKX56
         bJak28+nESvSlS/H1nKm9tHt/oJ5+Gxlk2MnDxndjuvsYpx6rf/rQ/+KpGsWsP3/dHI2
         RoXw==
X-Gm-Message-State: APjAAAVOYyzf/PiyIhKKHERmT826CX87gvEAeYDZYIJY96TwSuTQLTO/
        AM3RH2b1tNfv5LZZCVsVyGYfAjDk
X-Google-Smtp-Source: APXvYqwfZJx9hTXkSyPVnZ+/roZkwAw7TkmaGc+jaOWI4YuiMzVvTC34N+6+KH8b3WIKxQQQvJVY/A==
X-Received: by 2002:a50:fb01:: with SMTP id d1mr7167712edq.267.1559251265570;
        Thu, 30 May 2019 14:21:05 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h25sm597082ejz.10.2019.05.30.14.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 14:21:04 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/3] mtd: nand: raw: brcmnand: Refactored code and introduced inline functions
Date:   Thu, 30 May 2019 17:20:35 -0400
Message-Id: <1559251257-12383-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactored NAND ECC and CMD address configuration code to use inline
functions.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 100 +++++++++++++++++++------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index ce0b8ff..77b7850 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -588,6 +588,54 @@ static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
 	__raw_writel(val, ctrl->nand_fc + word * 4);
 }
 
+static inline void brcmnand_clear_ecc_addr(struct brcmnand_controller *ctrl)
+{
+
+	/* Clear error addresses */
+	brcmnand_write_reg(ctrl, BRCMNAND_UNCORR_ADDR, 0);
+	brcmnand_write_reg(ctrl, BRCMNAND_CORR_ADDR, 0);
+	brcmnand_write_reg(ctrl, BRCMNAND_UNCORR_EXT_ADDR, 0);
+	brcmnand_write_reg(ctrl, BRCMNAND_CORR_EXT_ADDR, 0);
+}
+
+static inline u64 brcmnand_get_uncorrecc_addr(struct brcmnand_controller *ctrl)
+{
+	u64 err_addr;
+
+	err_addr = brcmnand_read_reg(ctrl, BRCMNAND_UNCORR_ADDR);
+	err_addr |= ((u64)(brcmnand_read_reg(ctrl,
+					     BRCMNAND_UNCORR_EXT_ADDR)
+					     & 0xffff) << 32);
+
+	return err_addr;
+}
+
+static inline u64 brcmnand_get_correcc_addr(struct brcmnand_controller *ctrl)
+{
+	u64 err_addr;
+
+	err_addr = brcmnand_read_reg(ctrl, BRCMNAND_CORR_ADDR);
+	err_addr |= ((u64)(brcmnand_read_reg(ctrl,
+					     BRCMNAND_CORR_EXT_ADDR)
+					     & 0xffff) << 32);
+
+	return err_addr;
+}
+
+static inline void brcmnand_set_cmd_addr(struct mtd_info *mtd, u64 addr)
+{
+	struct nand_chip *chip =  mtd_to_nand(mtd);
+	struct brcmnand_host *host = nand_get_controller_data(chip);
+	struct brcmnand_controller *ctrl = host->ctrl;
+
+	brcmnand_write_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS,
+			   (host->cs << 16) | ((addr >> 32) & 0xffff));
+	(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS);
+	brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS,
+			   lower_32_bits(addr));
+	(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
+}
+
 static inline u16 brcmnand_cs_offset(struct brcmnand_controller *ctrl, int cs,
 				     enum brcmnand_cs_reg reg)
 {
@@ -1213,9 +1261,12 @@ static void brcmnand_send_cmd(struct brcmnand_host *host, int cmd)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
 	int ret;
+	u64 cmd_addr;
+
+	cmd_addr = brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
+
+	dev_dbg(ctrl->dev, "send native cmd %d addr 0x%llx\n", cmd, cmd_addr);
 
-	dev_dbg(ctrl->dev, "send native cmd %d addr_lo 0x%x\n", cmd,
-		brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS));
 	BUG_ON(ctrl->cmd_pending != 0);
 	ctrl->cmd_pending = cmd;
 
@@ -1374,12 +1425,7 @@ static void brcmnand_cmdfunc(struct nand_chip *chip, unsigned command,
 	if (!native_cmd)
 		return;
 
-	brcmnand_write_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS,
-		(host->cs << 16) | ((addr >> 32) & 0xffff));
-	(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS);
-	brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS, lower_32_bits(addr));
-	(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
-
+	brcmnand_set_cmd_addr(mtd, addr);
 	brcmnand_send_cmd(host, native_cmd);
 	brcmnand_waitfunc(chip);
 
@@ -1597,20 +1643,10 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 	struct brcmnand_controller *ctrl = host->ctrl;
 	int i, j, ret = 0;
 
-	/* Clear error addresses */
-	brcmnand_write_reg(ctrl, BRCMNAND_UNCORR_ADDR, 0);
-	brcmnand_write_reg(ctrl, BRCMNAND_CORR_ADDR, 0);
-	brcmnand_write_reg(ctrl, BRCMNAND_UNCORR_EXT_ADDR, 0);
-	brcmnand_write_reg(ctrl, BRCMNAND_CORR_EXT_ADDR, 0);
-
-	brcmnand_write_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS,
-			(host->cs << 16) | ((addr >> 32) & 0xffff));
-	(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS);
+	brcmnand_clear_ecc_addr(ctrl);
 
 	for (i = 0; i < trans; i++, addr += FC_BYTES) {
-		brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS,
-				   lower_32_bits(addr));
-		(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
+		brcmnand_set_cmd_addr(mtd, addr);
 		/* SPARE_AREA_READ does not use ECC, so just use PAGE_READ */
 		brcmnand_send_cmd(host, CMD_PAGE_READ);
 		brcmnand_waitfunc(chip);
@@ -1630,21 +1666,15 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 					host->hwcfg.sector_size_1k);
 
 		if (!ret) {
-			*err_addr = brcmnand_read_reg(ctrl,
-					BRCMNAND_UNCORR_ADDR) |
-				((u64)(brcmnand_read_reg(ctrl,
-						BRCMNAND_UNCORR_EXT_ADDR)
-					& 0xffff) << 32);
+			*err_addr = brcmnand_get_uncorrecc_addr(ctrl);
+
 			if (*err_addr)
 				ret = -EBADMSG;
 		}
 
 		if (!ret) {
-			*err_addr = brcmnand_read_reg(ctrl,
-					BRCMNAND_CORR_ADDR) |
-				((u64)(brcmnand_read_reg(ctrl,
-						BRCMNAND_CORR_EXT_ADDR)
-					& 0xffff) << 32);
+			*err_addr = brcmnand_get_correcc_addr(ctrl);
+
 			if (*err_addr)
 				ret = -EUCLEAN;
 		}
@@ -1711,7 +1741,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 	dev_dbg(ctrl->dev, "read %llx -> %p\n", (unsigned long long)addr, buf);
 
 try_dmaread:
-	brcmnand_write_reg(ctrl, BRCMNAND_UNCORR_COUNT, 0);
+	brcmnand_clear_ecc_addr(ctrl);
 
 	if (has_flash_dma(ctrl) && !oob && flash_dma_buf_ok(buf)) {
 		err = brcmnand_dma_trans(host, addr, buf, trans * FC_BYTES,
@@ -1858,15 +1888,9 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 		goto out;
 	}
 
-	brcmnand_write_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS,
-			(host->cs << 16) | ((addr >> 32) & 0xffff));
-	(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_EXT_ADDRESS);
-
 	for (i = 0; i < trans; i++, addr += FC_BYTES) {
 		/* full address MUST be set before populating FC */
-		brcmnand_write_reg(ctrl, BRCMNAND_CMD_ADDRESS,
-				   lower_32_bits(addr));
-		(void)brcmnand_read_reg(ctrl, BRCMNAND_CMD_ADDRESS);
+		brcmnand_set_cmd_addr(mtd, addr);
 
 		if (buf) {
 			brcmnand_soc_data_bus_prepare(ctrl->soc, false);
-- 
1.9.0.138.g2de3478

