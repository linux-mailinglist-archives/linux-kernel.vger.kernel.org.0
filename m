Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9DFFB0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 13:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKMMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 07:46:37 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36728 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMMqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:46:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xADCkQLH013616;
        Wed, 13 Nov 2019 06:46:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573649186;
        bh=KcStxR+XaqqutrtFiRj7KO9BKQOGxi+kB1kiTLkhTJs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MT7FUd3+UFVzd4m9y37DYwp2DyEjjT/C3LjwIsTbh0KEWs9MHo6hzGBrOFtUBwIhg
         R6OnecrLkcAtMoT5bvb35d5Iztd9sg7B5YtFKnRE6kvmTiBurqK8v65CaZX/18CY8w
         bAOeNwoCEWldGyzca/00wQstFSfEbgfdfnSvrFHc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xADCkQvw081427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 06:46:26 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 06:46:08 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 06:46:25 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xADCkIGG127078;
        Wed, 13 Nov 2019 06:46:23 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <kuninori.morimoto.gx@renesas.com>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: pcm3168a: Add support for optional RST gpio handling
Date:   Wed, 13 Nov 2019 14:47:34 +0200
Message-ID: <20191113124734.27984-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113124734.27984-1-peter.ujfalusi@ti.com>
References: <20191113124734.27984-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the RST line is connected to a GPIO line it needs to be pulled high
when the driver probes to be able to use the codec.

Add support also for cases when more than one codec is is controlled by the
same GPIO line by requesting the gpio with GPIOD_FLAGS_BIT_NONEXCLUSIVE.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

--- asoc: pcm3168a rst
---
 sound/soc/codecs/pcm3168a.c | 38 +++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 313500ab36df..f3475134b519 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -9,7 +9,9 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
@@ -59,6 +61,7 @@ struct pcm3168a_priv {
 	struct regulator_bulk_data supplies[PCM3168A_NUM_SUPPLIES];
 	struct regmap *regmap;
 	struct clk *scki;
+	struct gpio_desc *gpio_rst;
 	unsigned long sysclk;
 
 	struct pcm3168a_io_params io_params[2];
@@ -643,6 +646,7 @@ static bool pcm3168a_readable_register(struct device *dev, unsigned int reg)
 static bool pcm3168a_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case PCM3168A_RST_SMODE:
 	case PCM3168A_DAC_ZERO:
 	case PCM3168A_ADC_OV:
 		return true;
@@ -702,6 +706,21 @@ int pcm3168a_probe(struct device *dev, struct regmap *regmap)
 
 	dev_set_drvdata(dev, pcm3168a);
 
+	/*
+	 * Request the RST gpio line as non exclusive as the same reset line
+	 * might be connected to multiple pcm3168a codec
+	 */
+	pcm3168a->gpio_rst = devm_gpiod_get_optional(dev, "rst",
+						GPIOD_OUT_HIGH |
+						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	if (IS_ERR(pcm3168a->gpio_rst)) {
+		ret = PTR_ERR(pcm3168a->gpio_rst);
+		if (ret != -EPROBE_DEFER )
+			dev_err(dev, "failed to acquire RST gpio: %d\n", ret);
+
+		return ret;
+	}
+
 	pcm3168a->scki = devm_clk_get(dev, "scki");
 	if (IS_ERR(pcm3168a->scki)) {
 		ret = PTR_ERR(pcm3168a->scki);
@@ -743,10 +762,18 @@ int pcm3168a_probe(struct device *dev, struct regmap *regmap)
 		goto err_regulator;
 	}
 
-	ret = pcm3168a_reset(pcm3168a);
-	if (ret) {
-		dev_err(dev, "Failed to reset device: %d\n", ret);
-		goto err_regulator;
+	if (pcm3168a->gpio_rst) {
+		/*
+		 * The device is taken out from reset via GPIO line, wait for
+		 * 3846 SCKI clock cycles for the internal reset de-assertion
+		 */
+		msleep(DIV_ROUND_UP(3846 * 1000, pcm3168a->sysclk));
+	} else {
+		ret = pcm3168a_reset(pcm3168a);
+		if (ret) {
+			dev_err(dev, "Failed to reset device: %d\n", ret);
+			goto err_regulator;
+		}
 	}
 
 	pm_runtime_set_active(dev);
@@ -785,6 +812,9 @@ static void pcm3168a_disable(struct device *dev)
 
 void pcm3168a_remove(struct device *dev)
 {
+	struct pcm3168a_priv *pcm3168a = dev_get_drvdata(dev);
+
+	gpiod_set_value_cansleep(pcm3168a->gpio_rst, 0);
 	pm_runtime_disable(dev);
 #ifndef CONFIG_PM
 	pcm3168a_disable(dev);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

