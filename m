Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77E25EBF0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 20:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfGCStg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 14:49:36 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:60126 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCStf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:49:35 -0400
Received: from localhost.localdomain (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0074BC642D;
        Wed,  3 Jul 2019 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1562179772; bh=9DizQ8OziyzZDK+fmM5mzABZl479bhqpI8LTwVmMOKE=;
        h=From:To:Cc:Subject:Date;
        b=jAVEnO7uq2QTRWst/+QFsN5w8bdWbv4Yu49XUV4jnqn02gYxiZCP5+eUopcycjO0g
         nC3c2tYhQL4HY3kK28juYm59IkLBCEmq4xwhkkJHrd6EgwmZb2TVIrL3s2769eJ9AC
         pTGoG5yeYxZ/Ifz0xSAWg5lZAr6+O4hLE1Rk7dzM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     alsa-devel@alsa-project.org
Cc:     ~martijnbraam/pmos-upstream@lists.sr.ht,
        Luca Weiss <luca@z3ntu.xyz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: sunxi: sun50i-codec-analog: Add earpiece
Date:   Wed,  3 Jul 2019 20:48:11 +0200
Message-Id: <20190703184814.27191-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the necessary registers and audio routes to play audio using
the Earpiece, that's supported on the A64.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes v1 -> v2:
* Make the earpiece enable register a DAPM widget
* Adjust the audio routes to include the new Earpiece Amp widget
* Left/Right Analog Mixer => Left/Right Mixer

 sound/soc/sunxi/sun50i-codec-analog.c | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index d105c90c3706..6d1de565350e 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -49,6 +49,15 @@
 #define SUN50I_ADDA_OR_MIX_CTRL_DACR		1
 #define SUN50I_ADDA_OR_MIX_CTRL_DACL		0
 
+#define SUN50I_ADDA_EARPIECE_CTRL0	0x03
+#define SUN50I_ADDA_EARPIECE_CTRL0_EAR_RAMP_TIME	4
+#define SUN50I_ADDA_EARPIECE_CTRL0_ESPSR		0
+
+#define SUN50I_ADDA_EARPIECE_CTRL1	0x04
+#define SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN	7
+#define SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE	6
+#define SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL	0
+
 #define SUN50I_ADDA_LINEOUT_CTRL0	0x05
 #define SUN50I_ADDA_LINEOUT_CTRL0_LEN		7
 #define SUN50I_ADDA_LINEOUT_CTRL0_REN		6
@@ -172,6 +181,10 @@ static const DECLARE_TLV_DB_RANGE(sun50i_codec_lineout_vol_scale,
 	2, 31, TLV_DB_SCALE_ITEM(-4350, 150, 0),
 );
 
+static const DECLARE_TLV_DB_RANGE(sun50i_codec_earpiece_vol_scale,
+	0, 1, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
+	2, 31, TLV_DB_SCALE_ITEM(-4350, 150, 0),
+);
 
 /* volume / mute controls */
 static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
@@ -225,6 +238,15 @@ static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
 		   SUN50I_ADDA_LINEOUT_CTRL0_LEN,
 		   SUN50I_ADDA_LINEOUT_CTRL0_REN, 1, 0),
 
+	SOC_SINGLE_TLV("Earpiece Playback Volume",
+		       SUN50I_ADDA_EARPIECE_CTRL1,
+		       SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL, 0x1f, 0,
+		       sun50i_codec_earpiece_vol_scale),
+
+	SOC_SINGLE("Earpiece Playback Switch",
+		   SUN50I_ADDA_EARPIECE_CTRL1,
+		   SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0),
+
 };
 
 static const char * const sun50i_codec_hp_src_enum_text[] = {
@@ -257,6 +279,20 @@ static const struct snd_kcontrol_new sun50i_codec_lineout_src[] = {
 		      sun50i_codec_lineout_src_enum),
 };
 
+static const char * const sun50i_codec_earpiece_src_enum_text[] = {
+	"DACR", "DACL", "Right Mixer", "Left Mixer",
+};
+
+static SOC_ENUM_SINGLE_DECL(sun50i_codec_earpiece_src_enum,
+			    SUN50I_ADDA_EARPIECE_CTRL0,
+			    SUN50I_ADDA_EARPIECE_CTRL0_ESPSR,
+			    sun50i_codec_earpiece_src_enum_text);
+
+static const struct snd_kcontrol_new sun50i_codec_earpiece_src[] = {
+	SOC_DAPM_ENUM("Earpiece Source Playback Route",
+		      sun50i_codec_earpiece_src_enum),
+};
+
 static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	/* DAC */
 	SND_SOC_DAPM_DAC("Left DAC", NULL, SUN50I_ADDA_MIX_DAC_CTRL,
@@ -285,6 +321,12 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_lineout_src),
 	SND_SOC_DAPM_OUTPUT("LINEOUT"),
 
+	SND_SOC_DAPM_MUX("Earpiece Source Playback Route",
+			 SND_SOC_NOPM, 0, 0, sun50i_codec_earpiece_src),
+	SND_SOC_DAPM_OUT_DRV("Earpiece Amp", SUN50I_ADDA_EARPIECE_CTRL1,
+			     SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("EARPIECE"),
+
 	/* Microphone inputs */
 	SND_SOC_DAPM_INPUT("MIC1"),
 
@@ -388,6 +430,14 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Line Out Source Playback Route", "Mono Differential",
 		"Right Mixer" },
 	{ "LINEOUT", NULL, "Line Out Source Playback Route" },
+
+	/* Earpiece Routes */
+	{ "Earpiece Source Playback Route", "DACL", "Left DAC" },
+	{ "Earpiece Source Playback Route", "DACR", "Right DAC" },
+	{ "Earpiece Source Playback Route", "Left Mixer", "Left Mixer" },
+	{ "Earpiece Source Playback Route", "Right Mixer", "Right Mixer" },
+	{ "Earpiece Amp", NULL, "Earpiece Source Playback Route" },
+	{ "EARPIECE", NULL, "Earpiece Amp" },
 };
 
 static const struct snd_soc_component_driver sun50i_codec_analog_cmpnt_drv = {
-- 
2.22.0

