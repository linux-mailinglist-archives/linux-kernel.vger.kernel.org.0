Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B502164C01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 18:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgBSRfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 12:35:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38538 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgBSRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:35:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id e8so1537889wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BqmcatfVJj5xrXzxiAlRViCfx2wqJxp1Q75g+68ZIF0=;
        b=uiEC5W7a2kP2wVEfH7P8sPenh/GSG+KW7dHY9bOnTFzAi0/VZQD6qtkhY5B1WSALxm
         ddORP2Uyj/fTvuJi0QmsUu76fwTBVZUtNuO6equ3L5j90m7SgBJ6vxmel0e5oTj2d86y
         JNZGfhrAm7/JATajZUuv6x6CpbFqYlnTB9a6mFH0RuwVJR8Nhbpv3R5tXp3B2wuZ+y2+
         RknDrXdsbx6xppE0sq38wIocLtEoqRfofCdydDDEmePwRVu0/mUfBCHysdHDiNZ7f6T7
         YX0ESb5CSnZNzS33P0d5n5QWaznE7jfWwHZHxe1qBn3MFZczPcyOsx6/XV5a0lsZaxQk
         qWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BqmcatfVJj5xrXzxiAlRViCfx2wqJxp1Q75g+68ZIF0=;
        b=k42dD3qvjmB7p8X+dV2GjxU1UqF1Z88jByW/Csm5hPaZsRHzBwvaPQY5b3v0cNnNMG
         ck2ukA8p4P3Jd9n/KnV8y4M6hbibxdCfp0WnjulwsN77aflH59US2vsxPQ9q6tTVTVfc
         Bq/8Q1x5sUdv8CKPXSknF+6/TISf1KXF2Je22H9w5mUiesx+gwKwhJ3gKoBciDOzg4h5
         JwP+EpZJJIVRNGt99ZMTvlcHZizvnkpIEnkphiUXUEzAzp3qFORkRMXjMVacZP+WpPh6
         WuPEU8Xup7gJCLGNFbHCxfRDOcrM1rMASx60rhTgjR5kY5KZA4A2WJB2H4nZZDpeTUAm
         9scg==
X-Gm-Message-State: APjAAAWGNWTGmn3xCTu/gajJMVADt4hXYu22rdRfSDvdRCKwFndzIMG2
        uR77GYWHBh3s0Zr9SNOoZFfuaA==
X-Google-Smtp-Source: APXvYqzI0XlsMyg8OHWVOAxoCAZKe4cvac/hTf7z07vTP2/TJHLOXbPiICOvA9D4NDqoGf2oLl70TQ==
X-Received: by 2002:adf:82ce:: with SMTP id 72mr36994009wrc.14.1582133711448;
        Wed, 19 Feb 2020 09:35:11 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id v15sm648120wrf.7.2020.02.19.09.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:35:10 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v3 2/2] ASoC: meson: add t9015 internal DAC driver
Date:   Wed, 19 Feb 2020 18:35:03 +0100
Message-Id: <20200219173503.1112561-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219173503.1112561-1-jbrunet@baylibre.com>
References: <20200219173503.1112561-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the codec driver of the internal DAC found on Amlogic gxl, g12a and
sm1 family.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig  |   8 +
 sound/soc/meson/Makefile |   2 +
 sound/soc/meson/t9015.c  | 333 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 343 insertions(+)
 create mode 100644 sound/soc/meson/t9015.c

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 22d2af75b59e..897a706dcda0 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -6,6 +6,7 @@ config SND_MESON_AIU
 	tristate "Amlogic AIU"
 	select SND_MESON_CODEC_GLUE
 	select SND_PCM_IEC958
+	imply SND_SOC_MESON_T9015
 	imply SND_SOC_HDMI_CODEC if DRM_MESON_DW_HDMI
 	help
 	  Select Y or M to add support for the Audio output subsystem found
@@ -116,4 +117,11 @@ config SND_MESON_G12A_TOHDMITX
 	help
 	  Select Y or M to add support for HDMI audio on the g12a SoC
 	  family
+
+config SND_SOC_MESON_T9015
+	tristate "Amlogic T9015 DAC"
+	select REGMAP_MMIO
+	help
+	  Say Y or M if you want to add support for the internal DAC found
+	  on GXL, G12 and SM1 SoC family.
 endmenu
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index f9c90c391498..3c9d48846816 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -23,6 +23,7 @@ snd-soc-meson-card-utils-objs := meson-card-utils.o
 snd-soc-meson-codec-glue-objs := meson-codec-glue.o
 snd-soc-meson-gx-sound-card-objs := gx-card.o
 snd-soc-meson-g12a-tohdmitx-objs := g12a-tohdmitx.o
+snd-soc-meson-t9015-objs := t9015.o
 
 obj-$(CONFIG_SND_MESON_AIU) += snd-soc-meson-aiu.o
 obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
@@ -40,3 +41,4 @@ obj-$(CONFIG_SND_MESON_CARD_UTILS) += snd-soc-meson-card-utils.o
 obj-$(CONFIG_SND_MESON_CODEC_GLUE) += snd-soc-meson-codec-glue.o
 obj-$(CONFIG_SND_MESON_GX_SOUND_CARD) += snd-soc-meson-gx-sound-card.o
 obj-$(CONFIG_SND_MESON_G12A_TOHDMITX) += snd-soc-meson-g12a-tohdmitx.o
+obj-$(CONFIG_SND_SOC_MESON_T9015) += snd-soc-meson-t9015.o
diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
new file mode 100644
index 000000000000..56d2592c16d5
--- /dev/null
+++ b/sound/soc/meson/t9015.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2020 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#define BLOCK_EN	0x00
+#define  LORN_EN	0
+#define  LORP_EN	1
+#define  LOLN_EN	2
+#define  LOLP_EN	3
+#define  DACR_EN	4
+#define  DACL_EN	5
+#define  DACR_INV	20
+#define  DACL_INV	21
+#define  DACR_SRC	22
+#define  DACL_SRC	23
+#define  REFP_BUF_EN	BIT(12)
+#define  BIAS_CURRENT_EN BIT(13)
+#define  VMID_GEN_FAST	BIT(14)
+#define  VMID_GEN_EN	BIT(15)
+#define  I2S_MODE	BIT(30)
+#define VOL_CTRL0	0x04
+#define  GAIN_H		31
+#define  GAIN_L		23
+#define VOL_CTRL1	0x08
+#define  DAC_MONO	8
+#define  RAMP_RATE	10
+#define  VC_RAMP_MODE	12
+#define  MUTE_MODE	13
+#define  UNMUTE_MODE	14
+#define  DAC_SOFT_MUTE	15
+#define  DACR_VC	16
+#define  DACL_VC	24
+#define LINEOUT_CFG	0x0c
+#define  LORN_POL	0
+#define  LORP_POL	4
+#define  LOLN_POL	8
+#define  LOLP_POL	12
+#define POWER_CFG	0x10
+
+struct t9015 {
+	struct clk *pclk;
+	struct regulator *avdd;
+};
+
+static int t9015_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	unsigned int val;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		val = I2S_MODE;
+		break;
+
+	case SND_SOC_DAIFMT_CBS_CFS:
+		val = 0;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_component_update_bits(component, BLOCK_EN, I2S_MODE, val);
+
+	if (((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_I2S) &&
+	    ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_LEFT_J))
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops t9015_dai_ops = {
+	.set_fmt = t9015_dai_set_fmt,
+};
+
+static struct snd_soc_dai_driver t9015_dai = {
+	.name = "t9015-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = (SNDRV_PCM_FMTBIT_S8 |
+			    SNDRV_PCM_FMTBIT_S16_LE |
+			    SNDRV_PCM_FMTBIT_S20_LE |
+			    SNDRV_PCM_FMTBIT_S24_LE),
+	},
+	.ops = &t9015_dai_ops,
+};
+
+static const DECLARE_TLV_DB_MINMAX_MUTE(dac_vol_tlv, -9525, 0);
+
+static const char * const ramp_rate_txt[] = { "Fast", "Slow" };
+static SOC_ENUM_SINGLE_DECL(ramp_rate_enum, VOL_CTRL1, RAMP_RATE,
+			    ramp_rate_txt);
+
+static const char * const dacr_in_txt[] = { "Right", "Left" };
+static SOC_ENUM_SINGLE_DECL(dacr_in_enum, BLOCK_EN, DACR_SRC, dacr_in_txt);
+
+static const char * const dacl_in_txt[] = { "Left", "Right" };
+static SOC_ENUM_SINGLE_DECL(dacl_in_enum, BLOCK_EN, DACL_SRC, dacl_in_txt);
+
+static const char * const mono_txt[] = { "Stereo", "Mono"};
+static SOC_ENUM_SINGLE_DECL(mono_enum, VOL_CTRL1, DAC_MONO, mono_txt);
+
+static const struct snd_kcontrol_new t9015_snd_controls[] = {
+	/* Volume Controls */
+	SOC_ENUM("Playback Channel Mode", mono_enum),
+	SOC_SINGLE("Playback Switch", VOL_CTRL1, DAC_SOFT_MUTE, 1, 1),
+	SOC_DOUBLE_TLV("Playback Volume", VOL_CTRL1, DACL_VC, DACR_VC,
+		       0xff, 0, dac_vol_tlv),
+
+	/* Ramp Controls */
+	SOC_ENUM("Ramp Rate", ramp_rate_enum),
+	SOC_SINGLE("Volume Ramp Switch", VOL_CTRL1, VC_RAMP_MODE, 1, 0),
+	SOC_SINGLE("Mute Ramp Switch", VOL_CTRL1, MUTE_MODE, 1, 0),
+	SOC_SINGLE("Unmute Ramp Switch", VOL_CTRL1, UNMUTE_MODE, 1, 0),
+};
+
+static const struct snd_kcontrol_new t9015_right_dac_mux =
+	SOC_DAPM_ENUM("Right DAC Source", dacr_in_enum);
+static const struct snd_kcontrol_new t9015_left_dac_mux =
+	SOC_DAPM_ENUM("Left DAC Source", dacl_in_enum);
+
+static const struct snd_soc_dapm_widget t9015_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("Right IN", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("Left IN", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_MUX("Right DAC Sel", SND_SOC_NOPM, 0, 0,
+			 &t9015_right_dac_mux),
+	SND_SOC_DAPM_MUX("Left DAC Sel", SND_SOC_NOPM, 0, 0,
+			 &t9015_left_dac_mux),
+	SND_SOC_DAPM_DAC("Right DAC", NULL, BLOCK_EN, DACR_EN, 0),
+	SND_SOC_DAPM_DAC("Left DAC",  NULL, BLOCK_EN, DACL_EN, 0),
+	SND_SOC_DAPM_OUT_DRV("Right- Driver", BLOCK_EN, LORN_EN, 0,
+			 NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("Right+ Driver", BLOCK_EN, LORP_EN, 0,
+			 NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("Left- Driver",  BLOCK_EN, LOLN_EN, 0,
+			 NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("Left+ Driver",  BLOCK_EN, LOLP_EN, 0,
+			 NULL, 0),
+	SND_SOC_DAPM_OUTPUT("LORN"),
+	SND_SOC_DAPM_OUTPUT("LORP"),
+	SND_SOC_DAPM_OUTPUT("LOLN"),
+	SND_SOC_DAPM_OUTPUT("LOLP"),
+};
+
+static const struct snd_soc_dapm_route t9015_dapm_routes[] = {
+	{ "Right IN", NULL, "Playback" },
+	{ "Left IN",  NULL, "Playback" },
+	{ "Right DAC Sel", "Right", "Right IN" },
+	{ "Right DAC Sel", "Left",  "Left IN" },
+	{ "Left DAC Sel",  "Right", "Right IN" },
+	{ "Left DAC Sel",  "Left",  "Left IN" },
+	{ "Right DAC", NULL, "Right DAC Sel" },
+	{ "Left DAC",  NULL, "Left DAC Sel" },
+	{ "Right- Driver", NULL, "Right DAC" },
+	{ "Right+ Driver", NULL, "Right DAC" },
+	{ "Left- Driver",  NULL, "Left DAC"  },
+	{ "Left+ Driver",  NULL, "Left DAC"  },
+	{ "LORN", NULL, "Right- Driver", },
+	{ "LORP", NULL, "Right+ Driver", },
+	{ "LOLN", NULL, "Left- Driver",  },
+	{ "LOLP", NULL, "Left+ Driver",  },
+};
+
+static int t9015_set_bias_level(struct snd_soc_component *component,
+				enum snd_soc_bias_level level)
+{
+	struct t9015 *priv = snd_soc_component_get_drvdata(component);
+	enum snd_soc_bias_level now =
+		snd_soc_component_get_bias_level(component);
+	int ret;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		snd_soc_component_update_bits(component, BLOCK_EN,
+					      BIAS_CURRENT_EN,
+					      BIAS_CURRENT_EN);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		snd_soc_component_update_bits(component, BLOCK_EN,
+					      BIAS_CURRENT_EN,
+					      0);
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		ret = regulator_enable(priv->avdd);
+		if (ret) {
+			dev_err(component->dev, "AVDD enable failed\n");
+			return ret;
+		}
+
+		if (now == SND_SOC_BIAS_OFF) {
+			snd_soc_component_update_bits(component, BLOCK_EN,
+				VMID_GEN_EN | VMID_GEN_FAST | REFP_BUF_EN,
+				VMID_GEN_EN | VMID_GEN_FAST | REFP_BUF_EN);
+
+			mdelay(200);
+			snd_soc_component_update_bits(component, BLOCK_EN,
+						      VMID_GEN_FAST,
+						      0);
+		}
+
+		break;
+	case SND_SOC_BIAS_OFF:
+		snd_soc_component_update_bits(component, BLOCK_EN,
+			VMID_GEN_EN | VMID_GEN_FAST | REFP_BUF_EN,
+			0);
+
+		regulator_disable(priv->avdd);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver t9015_codec_driver = {
+	.set_bias_level		= t9015_set_bias_level,
+	.controls		= t9015_snd_controls,
+	.num_controls		= ARRAY_SIZE(t9015_snd_controls),
+	.dapm_widgets		= t9015_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(t9015_dapm_widgets),
+	.dapm_routes		= t9015_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(t9015_dapm_routes),
+	.suspend_bias_off	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+static const struct regmap_config t9015_regmap_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.max_register		= POWER_CFG,
+};
+
+static int t9015_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct t9015 *priv;
+	void __iomem *regs;
+	struct regmap *regmap;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, priv);
+
+	priv->pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(priv->pclk)) {
+		if (PTR_ERR(priv->pclk) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get core clock\n");
+		return PTR_ERR(priv->pclk);
+	}
+
+	priv->avdd = devm_regulator_get(dev, "AVDD");
+	if (IS_ERR(priv->avdd)) {
+		if (PTR_ERR(priv->avdd) != -EPROBE_DEFER)
+			dev_err(dev, "failed to AVDD\n");
+		return PTR_ERR(priv->avdd);
+	}
+
+	ret = clk_prepare_enable(priv->pclk);
+	if (ret) {
+		dev_err(dev, "core clock enable failed\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev,
+			(void(*)(void *))clk_disable_unprepare,
+			priv->pclk);
+	if (ret)
+		return ret;
+
+	ret = device_reset(dev);
+	if (ret) {
+		dev_err(dev, "reset failed\n");
+		return ret;
+	}
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs)) {
+		dev_err(dev, "register map failed\n");
+		return PTR_ERR(regs);
+	}
+
+	regmap = devm_regmap_init_mmio(dev, regs, &t9015_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "regmap init failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	/*
+	 * Initialize output polarity:
+	 * ATM the output polarity is fixed but in the future it might useful
+	 * to add DT property to set this depending on the platform needs
+	 */
+	regmap_write(regmap, LINEOUT_CFG, 0x1111);
+
+	return devm_snd_soc_register_component(dev, &t9015_codec_driver,
+					       &t9015_dai, 1);
+}
+
+static const struct of_device_id t9015_ids[] = {
+	{ .compatible = "amlogic,t9015", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, t9015_ids);
+
+static struct platform_driver t9015_driver = {
+	.driver = {
+		.name = "t9015-codec",
+		.of_match_table = of_match_ptr(t9015_ids),
+	},
+	.probe = t9015_probe,
+};
+
+module_platform_driver(t9015_driver);
+
+MODULE_DESCRIPTION("ASoC Amlogic T9015 codec driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL");
-- 
2.24.1

