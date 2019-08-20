Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC91E96A78
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 22:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfHTU0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 16:26:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39947 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbfHTUYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:24:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so3856057pgj.7;
        Tue, 20 Aug 2019 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nRUDnV2Z6bg7tRuaAScZCTeD/PyJE3qbsgu7V0nYnKI=;
        b=dceTo1hRBh2XmxroLLCXg4TuWMEFVpCggiv8ShF2s11ihuW/f7auHiMVkKLaRn9Lbc
         NNlKoCgKSZ2qdee+y3XtfjS1MIYLGd320yhr8Xf7kXXzisJhXmuB85y7VjY27TgDeeS2
         v1m75a5QO70OoUSsSp43ExBU3ssQqGcK6mGq5DmQ1m5FaqhUjVZLxOs7cgddVdh5bcIW
         y1s+om4Ha+b5W1983bGuLR48v8rQPjkCVZDta+WEHTjMC7JIpCTGM+20go2uHpgLsgri
         WW9jhBE3n2WBTQuwP68//FmWchE2Uf16AZRUuaE+F7EGyNICAbZoHNPzJrThjdUYghy7
         snPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nRUDnV2Z6bg7tRuaAScZCTeD/PyJE3qbsgu7V0nYnKI=;
        b=XSILhGg9RX43CFuj9YCEFfOLClkWD6qAtRo8lcsTFvepCbS+AHTn/35rnY9b0losLu
         oBOYpK71Ae6G/tTZzvTPvW5H45GAzXxdWza2bY87HnHoJvHcDl9ePtmVgq88hROjjPSS
         NEjPUA/oZI3112j1LcMc7sO/NphXNWiI9aBnnI41zl8HgFrBVsCG4E2Fnp3ILe3AmitY
         ppDtJr1rpsYvjj3oU5F4+bAvb5q8WkQ0XYkfJm7aG4G+DHtUvHc0L01q/Lak6VHTeP3x
         AyOwa6KPiENtf1P9oIy438x8IK7GBKYHESVK1iw/fgOUXGJckZNuI+AF4FVoBqd/zBkP
         PRqQ==
X-Gm-Message-State: APjAAAWBLfc9TxSb9sEHzUe28uF//fgXct9bG/9GLCAObQecH1tJhqHz
        Z1jY5ztgWIHcYva8F2nDPhDw3zIEJ3o=
X-Google-Smtp-Source: APXvYqwjI6vAc0j/dOseJzyU44AYf7zqoe2BP8obsxPlJOK4tTgF1lYOkoWKqsB3NkZydoJOJtyuXA==
X-Received: by 2002:a63:e70f:: with SMTP id b15mr26315945pgi.152.1566332660049;
        Tue, 20 Aug 2019 13:24:20 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id k3sm36149846pfg.23.2019.08.20.13.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 13:24:19 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/16] crypto: caam - simplfy clock initialization
Date:   Tue, 20 Aug 2019 13:23:48 -0700
Message-Id: <20190820202402.24951-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820202402.24951-1-andrew.smirnov@gmail.com>
References: <20190820202402.24951-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify clock initialization code by converting it to use clk-bulk,
devres and soc_device_match() match table. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: Chris Spencer <christopher.spencer@sea.co.uk>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/ctrl.c   | 198 ++++++++++++++++-------------------
 drivers/crypto/caam/intern.h |   7 +-
 2 files changed, 95 insertions(+), 110 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 50336494f285..0b4007068c31 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -25,16 +25,6 @@ EXPORT_SYMBOL(caam_dpaa2);
 #include "qi.h"
 #endif
 
-/*
- * i.MX targets tend to have clock control subsystems that can
- * enable/disable clocking to our device.
- */
-static inline struct clk *caam_drv_identify_clk(struct device *dev,
-						char *clk_name)
-{
-	return caam_imx ? devm_clk_get(dev, clk_name) : NULL;
-}
-
 /*
  * Descriptor to instantiate RNG State Handle 0 in normal mode and
  * load the JDKEK, TDKEK and TDSK registers
@@ -342,13 +332,6 @@ static int caam_remove(struct platform_device *pdev)
 	/* Unmap controller region */
 	iounmap(ctrl);
 
-	/* shut clocks off before finalizing shutdown */
-	clk_disable_unprepare(ctrlpriv->caam_ipg);
-	if (ctrlpriv->caam_mem)
-		clk_disable_unprepare(ctrlpriv->caam_mem);
-	clk_disable_unprepare(ctrlpriv->caam_aclk);
-	if (ctrlpriv->caam_emi_slow)
-		clk_disable_unprepare(ctrlpriv->caam_emi_slow);
 	return 0;
 }
 
@@ -497,20 +480,98 @@ static const struct of_device_id caam_match[] = {
 };
 MODULE_DEVICE_TABLE(of, caam_match);
 
+struct caam_imx_data {
+	const struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+static const struct clk_bulk_data caam_imx6_clks[] = {
+	{ .id = "ipg" },
+	{ .id = "mem" },
+	{ .id = "aclk" },
+	{ .id = "emi_slow" },
+};
+
+static const struct caam_imx_data caam_imx6_data = {
+	.clks = caam_imx6_clks,
+	.num_clks = ARRAY_SIZE(caam_imx6_clks),
+};
+
+static const struct clk_bulk_data caam_imx7_clks[] = {
+	{ .id = "ipg" },
+	{ .id = "aclk" },
+};
+
+static const struct caam_imx_data caam_imx7_data = {
+	.clks = caam_imx7_clks,
+	.num_clks = ARRAY_SIZE(caam_imx7_clks),
+};
+
+static const struct clk_bulk_data caam_imx6ul_clks[] = {
+	{ .id = "ipg" },
+	{ .id = "mem" },
+	{ .id = "aclk" },
+};
+
+static const struct caam_imx_data caam_imx6ul_data = {
+	.clks = caam_imx6ul_clks,
+	.num_clks = ARRAY_SIZE(caam_imx6ul_clks),
+};
+
+static const struct soc_device_attribute caam_imx_soc_table[] = {
+	{ .soc_id = "i.MX6UL", .data = &caam_imx6ul_data },
+	{ .soc_id = "i.MX6*",  .data = &caam_imx6_data },
+	{ .soc_id = "i.MX7*",  .data = &caam_imx7_data },
+	{ .family = "Freescale i.MX" },
+	{ /* sentinel */ }
+};
+
+static void disable_clocks(void *data)
+{
+	struct caam_drv_private *ctrlpriv = data;
+
+	clk_bulk_disable_unprepare(ctrlpriv->num_clks, ctrlpriv->clks);
+}
+
+static int init_clocks(struct device *dev, const struct caam_imx_data *data)
+{
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
+	int ret;
+
+	ctrlpriv->num_clks = data->num_clks;
+	ctrlpriv->clks = devm_kmemdup(dev, data->clks,
+				      data->num_clks * sizeof(data->clks[0]),
+				      GFP_KERNEL);
+	if (!ctrlpriv->clks)
+		return -ENOMEM;
+
+	ret = devm_clk_bulk_get(dev, ctrlpriv->num_clks, ctrlpriv->clks);
+	if (ret) {
+		dev_err(dev,
+			"Failed to request all necessary clocks\n");
+		return ret;
+	}
+
+	ret = clk_bulk_prepare_enable(ctrlpriv->num_clks, ctrlpriv->clks);
+	if (ret) {
+		dev_err(dev,
+			"Failed to prepare/enable all necessary clocks\n");
+		return ret;
+	}
+
+	return devm_add_action_or_reset(dev, disable_clocks, ctrlpriv);
+}
+
 /* Probe routine for CAAM top (controller) level */
 static int caam_probe(struct platform_device *pdev)
 {
 	int ret, ring, gen_sk, ent_delay = RTSDCTL_ENT_DLY_MIN;
 	u64 caam_id;
-	static const struct soc_device_attribute imx_soc[] = {
-		{.family = "Freescale i.MX"},
-		{},
-	};
+	const struct soc_device_attribute *imx_soc_match;
 	struct device *dev;
 	struct device_node *nprop, *np;
 	struct caam_ctrl __iomem *ctrl;
 	struct caam_drv_private *ctrlpriv;
-	struct clk *clk;
 #ifdef CONFIG_DEBUG_FS
 	struct caam_perfmon *perfmon;
 #endif
@@ -537,7 +598,8 @@ static int caam_probe(struct platform_device *pdev)
 
 	caam_little_end = !(bool)(rd_reg32(&ctrl->perfmon.status) &
 				  (CSTA_PLEND | CSTA_ALT_PLEND));
-	caam_imx = (bool)soc_device_match(imx_soc);
+	imx_soc_match = soc_device_match(caam_imx_soc_table);
+	caam_imx = (bool)imx_soc_match;
 
 	comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ms);
 	caam_dpaa2 = !!(comp_params & CTPR_MS_DPAA2);
@@ -568,81 +630,17 @@ static int caam_probe(struct platform_device *pdev)
 	}
 #endif
 
-	/* Enable clocking */
-	clk = caam_drv_identify_clk(&pdev->dev, "ipg");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		dev_err(&pdev->dev,
-			"can't identify CAAM ipg clk: %d\n", ret);
-		goto iounmap_ctrl;
-	}
-	ctrlpriv->caam_ipg = clk;
-
-	if (!of_machine_is_compatible("fsl,imx7d") &&
-	    !of_machine_is_compatible("fsl,imx7s") &&
-	    !of_machine_is_compatible("fsl,imx7ulp")) {
-		clk = caam_drv_identify_clk(&pdev->dev, "mem");
-		if (IS_ERR(clk)) {
-			ret = PTR_ERR(clk);
-			dev_err(&pdev->dev,
-				"can't identify CAAM mem clk: %d\n", ret);
-			goto iounmap_ctrl;
+	if (imx_soc_match) {
+		if (!imx_soc_match->data) {
+			dev_err(dev, "No clock data provided for i.MX SoC");
+			return -EINVAL;
 		}
-		ctrlpriv->caam_mem = clk;
-	}
 
-	clk = caam_drv_identify_clk(&pdev->dev, "aclk");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		dev_err(&pdev->dev,
-			"can't identify CAAM aclk clk: %d\n", ret);
-		goto iounmap_ctrl;
-	}
-	ctrlpriv->caam_aclk = clk;
-
-	if (!of_machine_is_compatible("fsl,imx6ul") &&
-	    !of_machine_is_compatible("fsl,imx7d") &&
-	    !of_machine_is_compatible("fsl,imx7s") &&
-	    !of_machine_is_compatible("fsl,imx7ulp")) {
-		clk = caam_drv_identify_clk(&pdev->dev, "emi_slow");
-		if (IS_ERR(clk)) {
-			ret = PTR_ERR(clk);
-			dev_err(&pdev->dev,
-				"can't identify CAAM emi_slow clk: %d\n", ret);
-			goto iounmap_ctrl;
-		}
-		ctrlpriv->caam_emi_slow = clk;
-	}
-
-	ret = clk_prepare_enable(ctrlpriv->caam_ipg);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "can't enable CAAM ipg clock: %d\n", ret);
-		goto iounmap_ctrl;
-	}
-
-	if (ctrlpriv->caam_mem) {
-		ret = clk_prepare_enable(ctrlpriv->caam_mem);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "can't enable CAAM secure mem clock: %d\n",
-				ret);
-			goto disable_caam_ipg;
-		}
+		ret = init_clocks(dev, imx_soc_match->data);
+		if (ret)
+			return ret;
 	}
 
-	ret = clk_prepare_enable(ctrlpriv->caam_aclk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "can't enable CAAM aclk clock: %d\n", ret);
-		goto disable_caam_mem;
-	}
-
-	if (ctrlpriv->caam_emi_slow) {
-		ret = clk_prepare_enable(ctrlpriv->caam_emi_slow);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "can't enable CAAM emi slow clock: %d\n",
-				ret);
-			goto disable_caam_aclk;
-		}
-	}
 
 	/* Allocating the BLOCK_OFFSET based on the supported page size on
 	 * the platform
@@ -714,7 +712,7 @@ static int caam_probe(struct platform_device *pdev)
 	ret = dma_set_mask_and_coherent(dev, caam_get_dma_mask(dev));
 	if (ret) {
 		dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n", ret);
-		goto disable_caam_emi_slow;
+		goto iounmap_ctrl;
 	}
 
 	ctrlpriv->era = caam_get_era(ctrl);
@@ -919,16 +917,6 @@ static int caam_probe(struct platform_device *pdev)
 	if (ctrlpriv->qi_init)
 		caam_qi_shutdown(dev);
 #endif
-disable_caam_emi_slow:
-	if (ctrlpriv->caam_emi_slow)
-		clk_disable_unprepare(ctrlpriv->caam_emi_slow);
-disable_caam_aclk:
-	clk_disable_unprepare(ctrlpriv->caam_aclk);
-disable_caam_mem:
-	if (ctrlpriv->caam_mem)
-		clk_disable_unprepare(ctrlpriv->caam_mem);
-disable_caam_ipg:
-	clk_disable_unprepare(ctrlpriv->caam_ipg);
 iounmap_ctrl:
 	iounmap(ctrl);
 	return ret;
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index ec25d260fa40..1f01703f510a 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -94,11 +94,8 @@ struct caam_drv_private {
 				   Handles of the RNG4 block are initialized
 				   by this driver */
 
-	struct clk *caam_ipg;
-	struct clk *caam_mem;
-	struct clk *caam_aclk;
-	struct clk *caam_emi_slow;
-
+	struct clk_bulk_data *clks;
+	int num_clks;
 	/*
 	 * debugfs entries for developer view into driver/device
 	 * variables at runtime.
-- 
2.21.0

