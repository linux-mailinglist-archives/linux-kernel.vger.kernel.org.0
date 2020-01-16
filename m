Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7DA13D7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 11:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbgAPKP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 05:15:29 -0500
Received: from foss.arm.com ([217.140.110.172]:47518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731792AbgAPKP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:15:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 821E913A1;
        Thu, 16 Jan 2020 02:15:26 -0800 (PST)
Received: from e110176-lin.arm.com (unknown [10.50.4.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27B7A3F534;
        Thu, 16 Jan 2020 02:15:24 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] crypto: ccree - split overloaded usage of irq field
Date:   Thu, 16 Jan 2020 12:14:44 +0200
Message-Id: <20200116101447.20374-10-gilad@benyossef.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200116101447.20374-1-gilad@benyossef.com>
References: <20200116101447.20374-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were using the irq field of the drvdata struct in
an overloaded fahsion - saving the IRQ number during init
and then storing the pending itnerrupt sources during
interrupt in the same field.

This worked because these usage are mutually exclusive but
are confusing. So simplify the code and change the init use
case to use a simple local variable.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_driver.c | 16 ++++++++--------
 drivers/crypto/ccree/cc_driver.h |  4 +---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 1bbe82fce4a5..532bc95a8373 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -271,6 +271,7 @@ static int init_cc_resources(struct platform_device *plat_dev)
 	const struct cc_hw_data *hw_rev;
 	const struct of_device_id *dev_id;
 	struct clk *clk;
+	int irq;
 	int rc = 0;
 
 	new_drvdata = devm_kzalloc(dev, sizeof(*new_drvdata), GFP_KERNEL);
@@ -337,9 +338,9 @@ static int init_cc_resources(struct platform_device *plat_dev)
 		&req_mem_cc_regs->start, new_drvdata->cc_base);
 
 	/* Then IRQ */
-	new_drvdata->irq = platform_get_irq(plat_dev, 0);
-	if (new_drvdata->irq < 0)
-		return new_drvdata->irq;
+	irq = platform_get_irq(plat_dev, 0);
+	if (irq < 0)
+		return irq;
 
 	init_completion(&new_drvdata->hw_queue_avail);
 
@@ -442,14 +443,13 @@ static int init_cc_resources(struct platform_device *plat_dev)
 	dev_info(dev, "ARM CryptoCell %s Driver: HW version 0x%08X/0x%8X, Driver version %s\n",
 		 hw_rev->name, hw_rev_pidr, sig_cidr, DRV_MODULE_VERSION);
 	/* register the driver isr function */
-	rc = devm_request_irq(dev, new_drvdata->irq, cc_isr,
-			      IRQF_SHARED, "ccree", new_drvdata);
+	rc = devm_request_irq(dev, irq, cc_isr, IRQF_SHARED, "ccree",
+			      new_drvdata);
 	if (rc) {
-		dev_err(dev, "Could not register to interrupt %d\n",
-			new_drvdata->irq);
+		dev_err(dev, "Could not register to interrupt %d\n", irq);
 		goto post_clk_err;
 	}
-	dev_dbg(dev, "Registered to IRQ: %d\n", new_drvdata->irq);
+	dev_dbg(dev, "Registered to IRQ: %d\n", irq);
 
 	rc = init_cc_regs(new_drvdata, true);
 	if (rc) {
diff --git a/drivers/crypto/ccree/cc_driver.h b/drivers/crypto/ccree/cc_driver.h
index 9d77cfdb10d9..c227718ba992 100644
--- a/drivers/crypto/ccree/cc_driver.h
+++ b/drivers/crypto/ccree/cc_driver.h
@@ -132,13 +132,11 @@ struct cc_crypto_req {
 /**
  * struct cc_drvdata - driver private data context
  * @cc_base:	virt address of the CC registers
- * @irq:	device IRQ number
- * @irq_mask:	Interrupt mask shadow (1 for masked interrupts)
+ * @irq:	bitmap indicating source of last interrupt
  */
 struct cc_drvdata {
 	void __iomem *cc_base;
 	int irq;
-	u32 irq_mask;
 	struct completion hw_queue_avail; /* wait for HW queue availability */
 	struct platform_device *plat_dev;
 	cc_sram_addr_t mlli_sram_addr;
-- 
2.23.0

