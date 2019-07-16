Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 781436A7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbfGPL6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 07:58:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41918 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGPL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:58:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so9334028pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UcuUE/S7i/9RoJgJQkaNx3Dl7upRJzpic0vUkmZftPI=;
        b=P3ujRSbgjfj5pVKwS8xDAw18tv0L3Pj/aTvuPKtss0Jg/RaAXl4wjGq9LqezxEw02i
         dqticwpgdoLN9ZRIdxGeJvP2f1re/998e+pxEsCrwhtYsprs5HkGFeY3g7MymKICVROS
         DvsFxJsM03iJubWNKKhcAznfIR/yGKofDC0jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcuUE/S7i/9RoJgJQkaNx3Dl7upRJzpic0vUkmZftPI=;
        b=qmdLjRIFtIuuhjGcelk9MhoVFOo1Jo6pqwaiZwckiliVB6xmgk6k5bE6EPkALe9Qnh
         VA4+NP5lfNM3BHoYpPgnVmGHPkUqJiwt4HPc5IhjUh7z83s6Hntj6U7/uMH6+bsnndrz
         oJcpJK1MvQHyUdFw8AQM8degaGDFRMKVBZBV0iosvy3oaN3WdMqjyAqmnFfKAcUMC0K5
         RZ4vgH3bfpqRjnQ/oWq6EuY8AOInofkSmI+gAnwqJTREA+YZ+y9RuVu5WpN/ERSLc+9d
         PpFZHQ0ZmIppSr0bf/Uqv0t10mm0KY+t/CHdV1oc5WQ+kK+FIEDuDGn2Y0Vuz6rzIZlc
         rh+A==
X-Gm-Message-State: APjAAAUZmuwd52RDOZ8iiAzMQSVRz3eXfiEc28JSRY+n5+Sdvz0VS8se
        mqeYSqsLrj96wQ+slNBEidC76Ul9WkQ=
X-Google-Smtp-Source: APXvYqx6QYcxll7hDTZ1VC4UvENBWYy2XfmVk+G8u0zG+FU/OAsw/Myhn3ChYRmaWLTMvDh1TIhp6A==
X-Received: by 2002:a65:6294:: with SMTP id f20mr33968359pgv.349.1563278286073;
        Tue, 16 Jul 2019 04:58:06 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id q7sm24758107pff.2.2019.07.16.04.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 04:58:05 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v4 4/5] ASoC: rockchip_max98090: Add dai_link for HDMI
Date:   Tue, 16 Jul 2019 19:57:24 +0800
Message-Id: <20190716115725.66558-5-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190716115725.66558-1-cychiang@chromium.org>
References: <20190716115725.66558-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use two dai_links. One for HDMI and one for max98090.
With this setup, audio can play to speaker and HDMI selectively.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/rockchip/Kconfig             |  3 +-
 sound/soc/rockchip/rockchip_max98090.c | 96 ++++++++++++++++++++------
 2 files changed, 75 insertions(+), 24 deletions(-)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index b43657e6e655..d610b553ea3b 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -40,9 +40,10 @@ config SND_SOC_ROCKCHIP_MAX98090
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
+	select SND_SOC_HDMI_CODEC
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
-	  boards using the MAX98090 codec, such as Veyron.
+	  boards using the MAX98090 codec and HDMI codec, such as Veyron.
 
 config SND_SOC_ROCKCHIP_RT5645
 	tristate "ASoC support for Rockchip boards using a RT5645/RT5650 codec"
diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index c5fc24675a33..c82948e383da 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -11,6 +11,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <sound/core.h>
+#include <sound/hdmi-codec.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -41,6 +42,7 @@ static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_LINE("HDMI", NULL),
 };
 
 static const struct snd_soc_dapm_route rk_audio_map[] = {
@@ -52,6 +54,7 @@ static const struct snd_soc_dapm_route rk_audio_map[] = {
 	{"Headphone", NULL, "HPR"},
 	{"Speaker", NULL, "SPKL"},
 	{"Speaker", NULL, "SPKR"},
+	{"HDMI", NULL, "TX"},
 };
 
 static const struct snd_kcontrol_new rk_mc_controls[] = {
@@ -59,6 +62,7 @@ static const struct snd_kcontrol_new rk_mc_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Int Mic"),
 	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("HDMI"),
 };
 
 static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
@@ -92,38 +96,63 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
 				     SND_SOC_CLOCK_OUT);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+	if (ret) {
+		dev_err(cpu_dai->dev, "Can't set cpu dai clock %d\n", ret);
 		return ret;
 	}
 
+	/* HDMI codec dai does not need to set sysclk. */
+	if (!strcmp(rtd->dai_link->name, "HDMI"))
+		return 0;
+
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 				     SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+	if (ret) {
+		dev_err(codec_dai->dev, "Can't set codec dai clock %d\n", ret);
 		return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct snd_soc_ops rk_aif1_ops = {
 	.hw_params = rk_aif1_hw_params,
 };
 
-SND_SOC_DAILINK_DEFS(hifi,
+SND_SOC_DAILINK_DEFS(analog,
 	DAILINK_COMP_ARRAY(COMP_EMPTY()),
 	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
-static struct snd_soc_dai_link rk_dailink = {
-	.name = "max98090",
-	.stream_name = "Audio",
-	.ops = &rk_aif1_ops,
-	/* set max98090 as slave */
-	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		SND_SOC_DAIFMT_CBS_CFS,
-	SND_SOC_DAILINK_REG(hifi),
+SND_SOC_DAILINK_DEFS(hdmi,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(HDMI_CODEC_DRV_NAME, "i2s-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+enum {
+	DAILINK_MAX98090,
+	DAILINK_HDMI,
+};
+
+/* max98090 and HDMI codec dai_link */
+static struct snd_soc_dai_link rk_dailinks[] = {
+	[DAILINK_MAX98090] = {
+		.name = "max98090",
+		.stream_name = "Analog",
+		.ops = &rk_aif1_ops,
+		/* set max98090 as slave */
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(analog),
+	},
+	[DAILINK_HDMI] = {
+		.name = "HDMI",
+		.stream_name = "HDMI",
+		.ops = &rk_aif1_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(hdmi),
+	}
 };
 
 static int rk_98090_headset_init(struct snd_soc_component *component);
@@ -136,8 +165,8 @@ static struct snd_soc_aux_dev rk_98090_headset_dev = {
 static struct snd_soc_card snd_soc_card_rk = {
 	.name = "ROCKCHIP-I2S",
 	.owner = THIS_MODULE,
-	.dai_link = &rk_dailink,
-	.num_links = 1,
+	.dai_link = rk_dailinks,
+	.num_links = ARRAY_SIZE(rk_dailinks),
 	.aux_dev = &rk_98090_headset_dev,
 	.num_aux_devs = 1,
 	.dapm_widgets = rk_dapm_widgets,
@@ -173,27 +202,48 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	int ret = 0;
 	struct snd_soc_card *card = &snd_soc_card_rk;
 	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np_analog;
+	struct device_node *np_cpu;
+	struct of_phandle_args args;
 
 	/* register the soc card */
 	card->dev = &pdev->dev;
 
-	rk_dailink.codecs->of_node = of_parse_phandle(np,
-			"rockchip,audio-codec", 0);
-	if (!rk_dailink.codecs->of_node) {
+	np_analog = of_parse_phandle(np, "rockchip,audio-codec", 0);
+	if (!np_analog) {
 		dev_err(&pdev->dev,
 			"Property 'rockchip,audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
+	rk_dailinks[DAILINK_MAX98090].codecs->of_node = np_analog;
+
+	ret = of_parse_phandle_with_fixed_args(np, "rockchip,audio-codec",
+					       0, 0, &args);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Unable to parse property 'rockchip,audio-codec'\n");
+		return ret;
+	}
+
+	ret = snd_soc_get_dai_name(
+			&args, &rk_dailinks[DAILINK_MAX98090].codecs->dai_name);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to get codec dai_name\n");
+		return ret;
+	}
+
+	np_cpu = of_parse_phandle(np, "rockchip,i2s-controller", 0);
 
-	rk_dailink.cpus->of_node = of_parse_phandle(np,
-			"rockchip,i2s-controller", 0);
-	if (!rk_dailink.cpus->of_node) {
+	if (!np_cpu) {
 		dev_err(&pdev->dev,
 			"Property 'rockchip,i2s-controller' missing or invalid\n");
 		return -EINVAL;
 	}
 
-	rk_dailink.platforms->of_node = rk_dailink.cpus->of_node;
+	rk_dailinks[DAILINK_MAX98090].cpus->of_node = np_cpu;
+	rk_dailinks[DAILINK_MAX98090].platforms->of_node = np_cpu;
+	rk_dailinks[DAILINK_HDMI].cpus->of_node = np_cpu;
+	rk_dailinks[DAILINK_HDMI].platforms->of_node = np_cpu;
 
 	rk_98090_headset_dev.codec_of_node = of_parse_phandle(np,
 			"rockchip,headset-codec", 0);
-- 
2.22.0.510.g264f2c817a-goog

