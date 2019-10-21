Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBE8DEE8A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfJUN6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 09:58:23 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:16992 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728812AbfJUN6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:58:22 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LDsQgt030658;
        Mon, 21 Oct 2019 08:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=3e47+2svvldlESGI3TS24HllBKDwYi244Zra1KazakM=;
 b=YspvTl9o/gAS/KBfpjWqcd94oT5WWhjla9Mv3gei2yhmfiaR6Y3rsD2jgIyTAu8KFcqN
 3WOQWM+P5ubi1Hic3gHYWhZF6uKRHRd2dVeKSd6a5PFcpme+nuHHm4LfwWTU8yVfoBMz
 t3xqIAa2UVNmf17AQHGghSK1n+7hUF/KrKJcAQlaTeyY8kIQg+GmhW2chY3HA/QVcnAv
 R5YOy4UPA8jo5QXWM3USq5ezfqmpIGK00qnjMJP7mRD5Y24r0zdd1b/G0auhCxt+Ap5Z
 yEtFdq+ZDkfl69Tk0Nmkps4h3pqlaUX1RLBv08C92AfwTtBPkAWgqRnXoEQoM7oPVdNa xg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2vqxwnjv0v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Oct 2019 08:58:16 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 21 Oct
 2019 14:58:13 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 21 Oct 2019 14:58:13 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B0FC1448;
        Mon, 21 Oct 2019 13:58:13 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH RESEND v4 3/3] mfd: madera: Add support for requesting the supply clocks
Date:   Mon, 21 Oct 2019 14:58:13 +0100
Message-ID: <20191021135813.13571-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191021135813.13571-1-ckeepax@opensource.cirrus.com>
References: <20191021135813.13571-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=1
 phishscore=0 malwarescore=0 mlxlogscore=887 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910210132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to get the clock for each clock input pin of the chip
and enable MCLK2 since that is expected to be a permanently enabled
32kHz clock.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c       | 27 ++++++++++++++++++++++++++-
 include/linux/mfd/madera/core.h | 11 +++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 29540cbf75934..a8cfadc1fc01e 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -450,6 +450,21 @@ int madera_dev_init(struct madera *madera)
 		       sizeof(madera->pdata));
 	}
 
+	madera->mclk[MADERA_MCLK1].id = "mclk1";
+	madera->mclk[MADERA_MCLK2].id = "mclk2";
+	madera->mclk[MADERA_MCLK3].id = "mclk3";
+
+	ret = devm_clk_bulk_get_optional(madera->dev, ARRAY_SIZE(madera->mclk),
+					 madera->mclk);
+	if (ret) {
+		dev_err(madera->dev, "Failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	/* Not using devm_clk_get to prevent breakage of existing DTs */
+	if (!madera->mclk[MADERA_MCLK2].clk)
+		dev_warn(madera->dev, "Missing MCLK2, requires 32kHz clock\n");
+
 	ret = madera_get_reset_gpio(madera);
 	if (ret)
 		return ret;
@@ -660,13 +675,19 @@ int madera_dev_init(struct madera *madera)
 	}
 
 	/* Init 32k clock sourced from MCLK2 */
+	ret = clk_prepare_enable(madera->mclk[MADERA_MCLK2].clk);
+	if (ret) {
+		dev_err(madera->dev, "Failed to enable 32k clock: %d\n", ret);
+		goto err_reset;
+	}
+
 	ret = regmap_update_bits(madera->regmap,
 			MADERA_CLOCK_32K_1,
 			MADERA_CLK_32K_ENA_MASK | MADERA_CLK_32K_SRC_MASK,
 			MADERA_CLK_32K_ENA | MADERA_32KZ_MCLK2);
 	if (ret) {
 		dev_err(madera->dev, "Failed to init 32k clock: %d\n", ret);
-		goto err_reset;
+		goto err_clock;
 	}
 
 	pm_runtime_set_active(madera->dev);
@@ -687,6 +708,8 @@ int madera_dev_init(struct madera *madera)
 
 err_pm_runtime:
 	pm_runtime_disable(madera->dev);
+err_clock:
+	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
 err_reset:
 	madera_enable_hard_reset(madera);
 	regulator_disable(madera->dcvdd);
@@ -713,6 +736,8 @@ int madera_dev_exit(struct madera *madera)
 	 */
 	pm_runtime_disable(madera->dev);
 
+	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
+
 	regulator_disable(madera->dcvdd);
 	regulator_put(madera->dcvdd);
 
diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
index 7ffa696cce7ca..ad2c138105d4b 100644
--- a/include/linux/mfd/madera/core.h
+++ b/include/linux/mfd/madera/core.h
@@ -8,6 +8,7 @@
 #ifndef MADERA_CORE_H
 #define MADERA_CORE_H
 
+#include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/madera/pdata.h>
@@ -29,6 +30,13 @@ enum madera_type {
 	CS42L92 = 9,
 };
 
+enum {
+	MADERA_MCLK1,
+	MADERA_MCLK2,
+	MADERA_MCLK3,
+	MADERA_NUM_MCLK
+};
+
 #define MADERA_MAX_CORE_SUPPLIES	2
 #define MADERA_MAX_GPIOS		40
 
@@ -155,6 +163,7 @@ struct snd_soc_dapm_context;
  * @irq_dev:		the irqchip child driver device
  * @irq_data:		pointer to irqchip data for the child irqchip driver
  * @irq:		host irq number from SPI or I2C configuration
+ * @mclk:		Structure holding clock supplies
  * @out_clamp:		indicates output clamp state for each analogue output
  * @out_shorted:	indicates short circuit state for each analogue output
  * @hp_ena:		bitflags of enable state for the headphone outputs
@@ -184,6 +193,8 @@ struct madera {
 	struct regmap_irq_chip_data *irq_data;
 	int irq;
 
+	struct clk_bulk_data mclk[MADERA_NUM_MCLK];
+
 	unsigned int num_micbias;
 	unsigned int num_childbias[MADERA_MAX_MICBIAS];
 
-- 
2.11.0

