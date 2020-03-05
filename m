Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4217B02B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 21:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCEU7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 15:59:31 -0500
Received: from viti.kaiser.cx ([85.214.81.225]:43330 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgCEU73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:59:29 -0500
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1j9xaX-0000e9-W5; Thu, 05 Mar 2020 21:59:26 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 4/5] hwrng: imx-rngc - check the rng type
Date:   Thu,  5 Mar 2020 21:58:23 +0100
Message-Id: <20200305205824.4371-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305205824.4371-1-martin@kaiser.cx>
References: <20200128110102.11522-1-martin@kaiser.cx>
 <20200305205824.4371-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the rng type and hardware revision during probe. Fail the probe
operation if the type is not one of rngc or rngb.
(There's also an rnga type, which needs a different driver.)

Display the type and revision in a debug print if probe was successful.

Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 92e93abcc9cc..50a8923d829a 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -18,12 +18,22 @@
 #include <linux/completion.h>
 #include <linux/io.h>
 
+#define RNGC_VER_ID			0x0000
 #define RNGC_COMMAND			0x0004
 #define RNGC_CONTROL			0x0008
 #define RNGC_STATUS			0x000C
 #define RNGC_ERROR			0x0010
 #define RNGC_FIFO			0x0014
 
+/* the fields in the ver id register */
+#define RNGC_TYPE_SHIFT		28
+#define RNGC_VER_MAJ_SHIFT		8
+
+/* the rng_type field */
+#define RNGC_TYPE_RNGB			0x1
+#define RNGC_TYPE_RNGC			0x2
+
+
 #define RNGC_CMD_CLR_ERR		0x00000020
 #define RNGC_CMD_CLR_INT		0x00000010
 #define RNGC_CMD_SEED			0x00000002
@@ -212,6 +222,8 @@ static int imx_rngc_probe(struct platform_device *pdev)
 	struct imx_rngc *rngc;
 	int ret;
 	int irq;
+	u32 ver_id;
+	u8  rng_type;
 
 	rngc = devm_kzalloc(&pdev->dev, sizeof(*rngc), GFP_KERNEL);
 	if (!rngc)
@@ -237,6 +249,17 @@ static int imx_rngc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ver_id = readl(rngc->base + RNGC_VER_ID);
+	rng_type = ver_id >> RNGC_TYPE_SHIFT;
+	/*
+	 * This driver supports only RNGC and RNGB. (There's a different
+	 * driver for RNGA.)
+	 */
+	if (rng_type != RNGC_TYPE_RNGC && rng_type != RNGC_TYPE_RNGB) {
+		ret = -ENODEV;
+		goto err;
+	}
+
 	ret = devm_request_irq(&pdev->dev,
 			irq, imx_rngc_irq, 0, pdev->name, (void *)rngc);
 	if (ret) {
@@ -269,7 +292,10 @@ static int imx_rngc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	dev_info(&pdev->dev, "Freescale RNGC registered.\n");
+	dev_info(&pdev->dev,
+		"Freescale RNG%c registered (HW revision %d.%02d)\n",
+		rng_type == RNGC_TYPE_RNGB ? 'B' : 'C',
+		(ver_id >> RNGC_VER_MAJ_SHIFT) & 0xff, ver_id & 0xff);
 	return 0;
 
 err:
-- 
2.20.1

