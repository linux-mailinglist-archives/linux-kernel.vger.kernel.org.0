Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F046170038
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 14:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgBZNkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 08:40:40 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33008 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZNkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:40:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QDdrYq034511;
        Wed, 26 Feb 2020 07:39:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582724393;
        bh=HTRVPjh5DuXVRlDJkrZ6Z9RblyZsq7c/8F7wOehG3zw=;
        h=From:To:CC:Subject:Date;
        b=wEwlWUXMOpmqXzaj1p3Iafzy5ChoyhKl77B4qsHA8/3HwDSGESsVVjOYMu42ytA/v
         tdgAZQT/Y6uOQcRRAAJXJ5DDzbAb+IBUS0q7brKAP9ACQ6Kt6dwby3xnH4Hn5EP3/M
         VmG+9wAxq7dQbMzl4n/Os4OHDFCV8VMtNHZGMG04=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QDdrHb026706;
        Wed, 26 Feb 2020 07:39:53 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 07:39:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 07:39:52 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QDdqRY023003;
        Wed, 26 Feb 2020 07:39:52 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Ricard Wanderlof <ricardw@axis.com>
Subject: [PATCH for-next] ASoC: tlv320adcx140: Fix MIC_BIAS defines for ADC full scale
Date:   Wed, 26 Feb 2020 07:34:39 -0600
Message-ID: <20200226133439.15837-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the #defines for the ADC full scale bits from MIC_BIAS to
ADC_FSCALE.  This also changes the error message to incidate ADC full
scale value error as opposed to the Mic bias.

Reported-by: Ricard Wanderlof <ricardw@axis.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 12 ++++++------
 sound/soc/codecs/tlv320adcx140.h |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 93a0cb8e662c..825ace9b5fa7 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -758,12 +758,12 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	ret = device_property_read_u8(adcx140->dev, "ti,vref-source",
 				      &vref_source);
 	if (ret)
-		vref_source = ADCX140_MIC_BIAS_VREF_275V;
+		vref_source = ADCX140_ADC_FSCALE_VREF_275V;
 
-	if (vref_source != ADCX140_MIC_BIAS_VREF_275V &&
-	    vref_source != ADCX140_MIC_BIAS_VREF_25V &&
-	    vref_source != ADCX140_MIC_BIAS_VREF_1375V) {
-		dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
+	if (vref_source != ADCX140_ADC_FSCALE_VREF_275V &&
+	    vref_source != ADCX140_ADC_FSCALE_VREF_25V &&
+	    vref_source != ADCX140_ADC_FSCALE_VREF_1375V) {
+		dev_err(adcx140->dev, "ADC full scale setting is invalid\n");
 		return -EINVAL;
 	}
 
@@ -787,7 +787,7 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 
 	ret = regmap_update_bits(adcx140->regmap, ADCX140_BIAS_CFG,
 				ADCX140_MIC_BIAS_VAL_MSK |
-				ADCX140_MIC_BIAS_VREF_MSK, bias_source);
+				ADCX140_ADC_FSCALE_VREF_MSK, bias_source);
 	if (ret)
 		dev_err(adcx140->dev, "setting MIC bias failed %d\n", ret);
 out:
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index 6d055e55909e..adb9513900b1 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -117,10 +117,10 @@
 #define ADCX140_MIC_BIAS_VAL_AVDD	6
 #define ADCX140_MIC_BIAS_VAL_MSK GENMASK(6, 4)
 
-#define ADCX140_MIC_BIAS_VREF_275V	0
-#define ADCX140_MIC_BIAS_VREF_25V	1
-#define ADCX140_MIC_BIAS_VREF_1375V	2
-#define ADCX140_MIC_BIAS_VREF_MSK GENMASK(1, 0)
+#define ADCX140_ADC_FSCALE_VREF_275V	0
+#define ADCX140_ADC_FSCALE_VREF_25V	1
+#define ADCX140_ADC_FSCALE_VREF_1375V	2
+#define ADCX140_ADC_FSCALE_VREF_MSK GENMASK(1, 0)
 
 #define ADCX140_PWR_CFG_BIAS_PDZ	BIT(7)
 #define ADCX140_PWR_CFG_ADC_PDZ		BIT(6)
-- 
2.25.0

