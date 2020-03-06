Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273E417C857
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 23:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCFWaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 17:30:06 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48596 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCFWaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1583533782; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBQZFNwVCKmMQLPO0TvYnTz9bJx9Q4eUUD3tPE6MeUw=;
        b=Zw9tcUpECwokaP/m9pjkdDhRrd2MEgCv0+42Vlyk7V5TD2Ok9JW3PVjHdfzOcCges3SZ2N
        qLkNKOT/UTDa//LjqSEyxNLC2I8UfyeMDi6LU+WOpk4JAWSB6sG5KfjgCnqWJYF6d201u6
        FzSUA+nsXyLilwZ69RNmluypOD35VsI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/6] ASoC: jz4740-i2s: Add support for the JZ4760
Date:   Fri,  6 Mar 2020 23:29:30 +0100
Message-Id: <20200306222931.39664-5-paul@crapouillou.net>
In-Reply-To: <20200306222931.39664-1-paul@crapouillou.net>
References: <20200306222931.39664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change of offset for the {rx,tx}_threshold fields in the conf
register predates the JZ4780, and was first introduced in the JZ4760.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/jz4740/jz4740-i2s.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 3f9b2e1b4747..253f8d8ba273 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -49,12 +49,8 @@
 
 #define JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 12
 #define JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 8
-#define JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
-#define JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
-#define JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_MASK \
-			(0xf << JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET)
-#define JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_MASK \
-			(0x1f <<  JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET)
+#define JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
+#define JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
 
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
@@ -90,6 +86,7 @@
 
 enum jz47xx_i2s_version {
 	JZ_I2S_JZ4740,
+	JZ_I2S_JZ4760,
 	JZ_I2S_JZ4780,
 };
 
@@ -403,9 +400,9 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
 		&i2s->capture_dma_data);
 
-	if (i2s->soc_info->version >= JZ_I2S_JZ4780) {
-		conf = (7 << JZ4780_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
-			(8 << JZ4780_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
+	if (i2s->soc_info->version >= JZ_I2S_JZ4760) {
+		conf = (7 << JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
+			(8 << JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
 			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
 			JZ_AIC_CONF_I2S |
 			JZ_AIC_CONF_INTERNAL_CODEC;
@@ -467,6 +464,11 @@ static const struct i2s_soc_info jz4740_i2s_soc_info = {
 	.dai = &jz4740_i2s_dai,
 };
 
+static const struct i2s_soc_info jz4760_i2s_soc_info = {
+	.version = JZ_I2S_JZ4760,
+	.dai = &jz4740_i2s_dai,
+};
+
 static struct snd_soc_dai_driver jz4780_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
 	.remove = jz4740_i2s_dai_remove,
@@ -499,6 +501,7 @@ static const struct snd_soc_component_driver jz4740_i2s_component = {
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_of_matches[] = {
 	{ .compatible = "ingenic,jz4740-i2s", .data = &jz4740_i2s_soc_info },
+	{ .compatible = "ingenic,jz4760-i2s", .data = &jz4760_i2s_soc_info },
 	{ .compatible = "ingenic,jz4780-i2s", .data = &jz4780_i2s_soc_info },
 	{ /* sentinel */ }
 };
-- 
2.25.1

