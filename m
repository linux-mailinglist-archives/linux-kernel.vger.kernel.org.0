Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915B8CEA33
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 19:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfJGRJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 13:09:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54528 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfJGRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:09:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x97H9HQP034661;
        Mon, 7 Oct 2019 12:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570468157;
        bh=Uj2L0n4bSMjAeSXo6uEKjVpSlKE2402ydacUosjJgTo=;
        h=From:To:CC:Subject:Date;
        b=ZzpVKSJOY1F/PRsf5iTKydJBrQS0AFU3f5fHYCkl+/vIYGcJy5XnpSVqQ1H69+IMO
         i1Bd8faoTrZBaZ3xN6tL/KpYiv6Gg17MoWNVS3Z+mSxQMuZEZMdg7C846Mvisx0+WD
         MPMdjhHXthbJaiyx/6YywOUxbVbhNd+VM3EXBxUs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x97H9GOC067748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Oct 2019 12:09:17 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 12:09:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 12:09:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97H9GFE005648;
        Mon, 7 Oct 2019 12:09:16 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <shifu0704@thundersoft.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <navada@ti.com>, <perex@perex.cz>,
        <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 1/3] ASoC: tas2770: Fix snd_soc_update_bits error handling
Date:   Mon, 7 Oct 2019 12:11:55 -0500
Message-ID: <20191007171157.17813-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According the documentation for snd_soc_update_bits the API
will return a 1 if the update was successful with a value change,
a 0 if the update was successful with no value change or a negative
if the command just failed.

So the value of return in the driver needs to be checked for being less
then 0 or the caller may indicate failure when the value actually
changed.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Missed one update_bit return issue.

 sound/soc/codecs/tas2770.c | 46 +++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index dbbb21fe0548..361d0bba72b3 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -82,7 +82,8 @@ static int tas2770_codec_suspend(struct snd_soc_component *component)
 		TAS2770_PWR_CTRL,
 		TAS2770_PWR_CTRL_MASK,
 		TAS2770_PWR_CTRL_SHUTDOWN);
-	if (ret)
+
+	if (ret < 0)
 		return ret;
 
 	return 0;
@@ -96,8 +97,9 @@ static int tas2770_codec_resume(struct snd_soc_component *component)
 		TAS2770_PWR_CTRL,
 		TAS2770_PWR_CTRL_MASK,
 		TAS2770_PWR_CTRL_ACTIVE);
-	if (ret)
-		return -EINVAL;
+
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -149,7 +151,10 @@ static int tas2770_dac_event(struct snd_soc_dapm_widget *w,
 	}
 
 end:
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static const struct snd_kcontrol_new isense_switch =
@@ -199,7 +204,10 @@ static int tas2770_mute(struct snd_soc_dai *dai, int mute)
 			TAS2770_PWR_CTRL_MASK,
 			TAS2770_PWR_CTRL_ACTIVE);
 
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
@@ -252,7 +260,10 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 		tas2770->i_sense_slot);
 
 end:
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
@@ -344,9 +355,11 @@ static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
 	}
 
 end:
-	if (!ret)
-		tas2770->sampling_rate = samplerate;
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	tas2770->sampling_rate = samplerate;
+	return 0;
 }
 
 static int tas2770_hw_params(struct snd_pcm_substream *substream,
@@ -401,7 +414,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG1,
 		TAS2770_TDM_CFG_REG1_RX_MASK,
 		asi_cfg_1);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -426,7 +439,7 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG1,
 		TAS2770_TDM_CFG_REG1_MASK,
 	(tdm_rx_start_slot << TAS2770_TDM_CFG_REG1_51_SHIFT));
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	value = snd_soc_component_read32(component, TAS2770_TDM_CFG_REG3);
@@ -472,12 +485,12 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG3,
 		TAS2770_TDM_CFG_REG3_30_MASK,
 		(left_slot << TAS2770_TDM_CFG_REG3_30_SHIFT));
-	if (ret)
+	if (ret < 0)
 		return ret;
 	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG3,
 		TAS2770_TDM_CFG_REG3_RXS_MASK,
 	(right_slot << TAS2770_TDM_CFG_REG3_RXS_SHIFT));
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	switch (slot_width) {
@@ -511,10 +524,11 @@ static int tas2770_set_dai_tdm_slot(struct snd_soc_dai *dai,
 		ret = -EINVAL;
 	}
 
-	if (!ret)
-		tas2770->slot_width = slot_width;
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	tas2770->slot_width = slot_width;
+	return 0;
 }
 
 static struct snd_soc_dai_ops tas2770_dai_ops = {
-- 
2.22.0.214.g8dca754b1e

