Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5A37471
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfFFMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 08:42:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33497 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfFFMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:42:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so1775857wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIimX4zalPxWqsR++fPDzwLzCyUhOlm3en9qY2O7MrQ=;
        b=nNgsiirawQVNHqW9po2qUE5hrxI7ECQ6XGnUQU/7nowM4G4VgeJw+RqHpyXSTb8j70
         OHH6VCT4bese2fm+2doJKmc6623CPNfNi9/mi7sWKOCrxJUFx8WFmAb/YzGaDMb0+S4E
         lSC+AB2NMhMUr5dW+RHnEOZzzJnfDKV1AaKTIC8OUSFAniqlW3LhgG+Zn0JwozM6wTvm
         T2nthqyHnXoHsxjNMLruC1XErYMI68cjSoIbt1UOJdI7X8wajp2nOgRceqsIU0zgMu+f
         LGqfOpYXtPHtu0Ujx3TJCGSTYRFcbnnPaVy16GYEFEfk9czV18qyHyUcpmQYSMzDWTic
         x4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIimX4zalPxWqsR++fPDzwLzCyUhOlm3en9qY2O7MrQ=;
        b=PLkVH6y424IekwZ/hIbgJir+Pv7+GHUTTMw6ayC/MbCF4MgqWdttZLAf821Ghwjqnw
         xc2o5MSGlkt5B7r2MDLtLhYEIujIGd3IR2s8Yl7Vv4Rs3ItxZTAAMZGASOUZlbCgBjs3
         +FZA7hbPVly42ktZL66Qnlw0Vsl1tSmj3F2FBEikvEvWQoKIrlKzMUXGyvrJe14OjCSy
         fSTqrSfbTVji2ZkUCqOj6hY8/TPt/pd4B8pfZ6Q6e+iDiNQWJyEUFlykslurxjuDG3RQ
         x/vhIWWjONoJOIZcS2L6cFSee6Q875frOHp/ixZ1lb/U07YD1Z5qbEdslXaqwUOpvxSk
         VrbA==
X-Gm-Message-State: APjAAAVhX8fpCt8ifqVgeJCJzXJBZefywyDoMCkobbz6AEjCl0OsZJoP
        jMsLqX1mjgjJPuszn3hxovBKAmCGq19Cfw==
X-Google-Smtp-Source: APXvYqzgm2+u5yREPcIefbJr88nGwEr7p+iPs1qUge3gdrSdrgbwpjRKrh8ybU/XSudur4DcTPj84A==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr26805693wmb.19.1559824971885;
        Thu, 06 Jun 2019 05:42:51 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id r131sm1604696wmf.4.2019.06.06.05.42.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 05:42:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] ASoC: msm8916-wcd-digital: Add sidetone support
Date:   Thu,  6 Jun 2019 13:42:42 +0100
Message-Id: <20190606124242.12941-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds sidetone support via one of the 3 RX Mix paths
using IIR1 and IIR2.
IIR1 can be feed by any Decimators or RX paths, and IIRx can also be
looped back to RX mixers to provide sidetone functionality.
Two IIR filters are used for Side tone equalization and each filter
is 5 stage.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- added missing break in switch
	- Moved IIR bands enable to switch controls

 sound/soc/codecs/msm8916-wcd-digital.c | 282 +++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index a63961861e55..1db7e43ec203 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -187,6 +187,43 @@
 #define MSM8916_WCD_DIGITAL_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 				     SNDRV_PCM_FMTBIT_S32_LE)
 
+/* Codec supports 2 IIR filters */
+enum {
+	IIR1 = 0,
+	IIR2,
+	IIR_MAX,
+};
+
+/* Codec supports 5 bands */
+enum {
+	BAND1 = 0,
+	BAND2,
+	BAND3,
+	BAND4,
+	BAND5,
+	BAND_MAX,
+};
+
+#define WCD_IIR_FILTER_SIZE	(sizeof(u32)*BAND_MAX)
+
+#define WCD_IIR_FILTER_CTL(xname, iidx, bidx) \
+{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = wcd_iir_filter_info, \
+	.get = msm8x16_wcd_get_iir_band_audio_mixer, \
+	.put = msm8x16_wcd_put_iir_band_audio_mixer, \
+	.private_value = (unsigned long)&(struct wcd_iir_filter_ctl) { \
+		.iir_idx = iidx, \
+		.band_idx = bidx, \
+		.bytes_ext = {.max = WCD_IIR_FILTER_SIZE, }, \
+	} \
+}
+
+struct wcd_iir_filter_ctl {
+	unsigned int iir_idx;
+	unsigned int band_idx;
+	struct soc_bytes_ext bytes_ext;
+};
+
 struct msm8916_wcd_digital_priv {
 	struct clk *ahbclk, *mclk;
 };
@@ -298,6 +335,161 @@ static SOC_ENUM_SINGLE_DECL(rx2_dcb_cutoff_enum, LPASS_CDC_RX2_B4_CTL, 0,
 static SOC_ENUM_SINGLE_DECL(rx3_dcb_cutoff_enum, LPASS_CDC_RX3_B4_CTL, 0,
 			    dc_blocker_cutoff_text);
 
+static int msm8x16_wcd_codec_set_iir_gain(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+			snd_soc_dapm_to_component(w->dapm);
+	int value = 0, reg = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (w->shift == 0)
+			reg = LPASS_CDC_IIR1_GAIN_B1_CTL;
+		else if (w->shift == 1)
+			reg = LPASS_CDC_IIR2_GAIN_B1_CTL;
+		value = snd_soc_component_read32(component, reg);
+		snd_soc_component_write(component, reg, value);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static uint32_t get_iir_band_coeff(struct snd_soc_component *component,
+				   int iir_idx, int band_idx,
+				   int coeff_idx)
+{
+	uint32_t value = 0;
+
+	/* Address does not automatically update if reading */
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B1_CTL + 64 * iir_idx),
+		((band_idx * BAND_MAX + coeff_idx)
+		* sizeof(uint32_t)) & 0x7F);
+
+	value |= snd_soc_component_read32(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx));
+
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B1_CTL + 64 * iir_idx),
+		((band_idx * BAND_MAX + coeff_idx)
+		* sizeof(uint32_t) + 1) & 0x7F);
+
+	value |= (snd_soc_component_read32(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx)) << 8);
+
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B1_CTL + 64 * iir_idx),
+		((band_idx * BAND_MAX + coeff_idx)
+		* sizeof(uint32_t) + 2) & 0x7F);
+
+	value |= (snd_soc_component_read32(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx)) << 16);
+
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B1_CTL + 64 * iir_idx),
+		((band_idx * BAND_MAX + coeff_idx)
+		* sizeof(uint32_t) + 3) & 0x7F);
+
+	/* Mask bits top 2 bits since they are reserved */
+	value |= ((snd_soc_component_read32(component,
+		 (LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx)) & 0x3f) << 24);
+	return value;
+
+}
+
+static int msm8x16_wcd_get_iir_band_audio_mixer(
+					struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+
+	struct snd_soc_component *component =
+			snd_soc_kcontrol_component(kcontrol);
+	struct wcd_iir_filter_ctl *ctl =
+			(struct wcd_iir_filter_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+	int iir_idx = ctl->iir_idx;
+	int band_idx = ctl->band_idx;
+	u32 coeff[BAND_MAX];
+
+	coeff[0] = get_iir_band_coeff(component, iir_idx, band_idx, 0);
+	coeff[1] = get_iir_band_coeff(component, iir_idx, band_idx, 1);
+	coeff[2] = get_iir_band_coeff(component, iir_idx, band_idx, 2);
+	coeff[3] = get_iir_band_coeff(component, iir_idx, band_idx, 3);
+	coeff[4] = get_iir_band_coeff(component, iir_idx, band_idx, 4);
+
+	memcpy(ucontrol->value.bytes.data, &coeff[0], params->max);
+
+	return 0;
+}
+
+static void set_iir_band_coeff(struct snd_soc_component *component,
+				int iir_idx, int band_idx,
+				uint32_t value)
+{
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx),
+		(value & 0xFF));
+
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx),
+		(value >> 8) & 0xFF);
+
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx),
+		(value >> 16) & 0xFF);
+
+	/* Mask top 2 bits, 7-8 are reserved */
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B2_CTL + 64 * iir_idx),
+		(value >> 24) & 0x3F);
+}
+
+static int msm8x16_wcd_put_iir_band_audio_mixer(
+					struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+			snd_soc_kcontrol_component(kcontrol);
+	struct wcd_iir_filter_ctl *ctl =
+			(struct wcd_iir_filter_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+	int iir_idx = ctl->iir_idx;
+	int band_idx = ctl->band_idx;
+	u32 coeff[BAND_MAX];
+
+	memcpy(&coeff[0], ucontrol->value.bytes.data, params->max);
+
+	/* Mask top bit it is reserved */
+	/* Updates addr automatically for each B2 write */
+	snd_soc_component_write(component,
+		(LPASS_CDC_IIR1_COEF_B1_CTL + 64 * iir_idx),
+		(band_idx * BAND_MAX * sizeof(uint32_t)) & 0x7F);
+
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[0]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[1]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[2]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[3]);
+	set_iir_band_coeff(component, iir_idx, band_idx, coeff[4]);
+
+	return 0;
+}
+
+static int wcd_iir_filter_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *ucontrol)
+{
+	struct wcd_iir_filter_ctl *ctl =
+		(struct wcd_iir_filter_ctl *)kcontrol->private_value;
+	struct soc_bytes_ext *params = &ctl->bytes_ext;
+
+	ucontrol->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	ucontrol->count = params->max;
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new msm8916_wcd_digital_snd_controls[] = {
 	SOC_SINGLE_S8_TLV("RX1 Digital Volume", LPASS_CDC_RX1_VOL_CTL_B2_CTL,
 			  -128, 127, digital_gain),
@@ -322,6 +514,44 @@ static const struct snd_kcontrol_new msm8916_wcd_digital_snd_controls[] = {
 	SOC_SINGLE("RX1 Mute Switch", LPASS_CDC_RX1_B6_CTL, 0, 1, 0),
 	SOC_SINGLE("RX2 Mute Switch", LPASS_CDC_RX2_B6_CTL, 0, 1, 0),
 	SOC_SINGLE("RX3 Mute Switch", LPASS_CDC_RX3_B6_CTL, 0, 1, 0),
+
+	SOC_SINGLE("IIR1 Band1 Switch", LPASS_CDC_IIR1_CTL, 0, 1, 0),
+	SOC_SINGLE("IIR1 Band2 Switch", LPASS_CDC_IIR1_CTL, 1, 1, 0),
+	SOC_SINGLE("IIR1 Band3 Switch", LPASS_CDC_IIR1_CTL, 2, 1, 0),
+	SOC_SINGLE("IIR1 Band4 Switch", LPASS_CDC_IIR1_CTL, 3, 1, 0),
+	SOC_SINGLE("IIR1 Band5 Switch", LPASS_CDC_IIR1_CTL, 4, 1, 0),
+	SOC_SINGLE("IIR2 Band1 Switch", LPASS_CDC_IIR2_CTL, 0, 1, 0),
+	SOC_SINGLE("IIR2 Band2 Switch", LPASS_CDC_IIR2_CTL, 1, 1, 0),
+	SOC_SINGLE("IIR2 Band3 Switch", LPASS_CDC_IIR2_CTL, 2, 1, 0),
+	SOC_SINGLE("IIR2 Band4 Switch", LPASS_CDC_IIR2_CTL, 3, 1, 0),
+	SOC_SINGLE("IIR2 Band5 Switch", LPASS_CDC_IIR2_CTL, 4, 1, 0),
+	WCD_IIR_FILTER_CTL("IIR1 Band1", IIR1, BAND1),
+	WCD_IIR_FILTER_CTL("IIR1 Band2", IIR1, BAND2),
+	WCD_IIR_FILTER_CTL("IIR1 Band3", IIR1, BAND3),
+	WCD_IIR_FILTER_CTL("IIR1 Band4", IIR1, BAND4),
+	WCD_IIR_FILTER_CTL("IIR1 Band5", IIR1, BAND5),
+	WCD_IIR_FILTER_CTL("IIR2 Band1", IIR2, BAND1),
+	WCD_IIR_FILTER_CTL("IIR2 Band2", IIR2, BAND2),
+	WCD_IIR_FILTER_CTL("IIR2 Band3", IIR2, BAND3),
+	WCD_IIR_FILTER_CTL("IIR2 Band4", IIR2, BAND4),
+	WCD_IIR_FILTER_CTL("IIR2 Band5", IIR2, BAND5),
+	SOC_SINGLE_SX_TLV("IIR1 INP1 Volume", LPASS_CDC_IIR1_GAIN_B1_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR1 INP2 Volume", LPASS_CDC_IIR1_GAIN_B2_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR1 INP3 Volume", LPASS_CDC_IIR1_GAIN_B3_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR1 INP4 Volume", LPASS_CDC_IIR1_GAIN_B4_CTL,
+			0,  -84,	40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR2 INP1 Volume", LPASS_CDC_IIR2_GAIN_B1_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR2 INP2 Volume", LPASS_CDC_IIR2_GAIN_B2_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR2 INP3 Volume", LPASS_CDC_IIR2_GAIN_B3_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("IIR2 INP4 Volume", LPASS_CDC_IIR2_GAIN_B4_CTL,
+			0,  -84, 40, digital_gain),
+
 };
 
 static int msm8916_wcd_digital_enable_interpolator(
@@ -448,6 +678,24 @@ static int msm8916_wcd_digital_enable_dmic(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const char * const iir_inp1_text[] = {
+	"ZERO", "DEC1", "DEC2", "RX1", "RX2", "RX3"
+};
+
+static const struct soc_enum iir1_inp1_mux_enum =
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_EQ1_B1_CTL,
+		0, 6, iir_inp1_text);
+
+static const struct soc_enum iir2_inp1_mux_enum =
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_EQ2_B1_CTL,
+		0, 6, iir_inp1_text);
+
+static const struct snd_kcontrol_new iir1_inp1_mux =
+	SOC_DAPM_ENUM("IIR1 INP1 Mux", iir1_inp1_mux_enum);
+
+static const struct snd_kcontrol_new iir2_inp1_mux =
+	SOC_DAPM_ENUM("IIR2 INP1 Mux", iir2_inp1_mux_enum);
+
 static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 	/*RX stuff */
 	SND_SOC_DAPM_AIF_IN("I2S RX1", NULL, 0, SND_SOC_NOPM, 0, 0),
@@ -534,6 +782,15 @@ static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Digital Mic1", NULL),
 	SND_SOC_DAPM_MIC("Digital Mic2", NULL),
 
+	/* Sidetone */
+	SND_SOC_DAPM_MUX("IIR1 INP1 MUX", SND_SOC_NOPM, 0, 0, &iir1_inp1_mux),
+	SND_SOC_DAPM_PGA_E("IIR1", LPASS_CDC_CLK_SD_CTL, 0, 0, NULL, 0,
+		msm8x16_wcd_codec_set_iir_gain, SND_SOC_DAPM_POST_PMU),
+
+	SND_SOC_DAPM_MUX("IIR2 INP1 MUX", SND_SOC_NOPM, 0, 0, &iir2_inp1_mux),
+	SND_SOC_DAPM_PGA_E("IIR2", LPASS_CDC_CLK_SD_CTL, 1, 0, NULL, 0,
+		msm8x16_wcd_codec_set_iir_gain, SND_SOC_DAPM_POST_PMU),
+
 };
 
 static int msm8916_wcd_digital_get_clks(struct platform_device *pdev,
@@ -708,10 +965,14 @@ static const struct snd_soc_dapm_route msm8916_wcd_digital_audio_map[] = {
 	{"RX1 MIX1 INP1", "RX1", "I2S RX1"},
 	{"RX1 MIX1 INP1", "RX2", "I2S RX2"},
 	{"RX1 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX1 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX1 MIX1 INP1", "IIR2", "IIR2"},
 
 	{"RX1 MIX1 INP2", "RX1", "I2S RX1"},
 	{"RX1 MIX1 INP2", "RX2", "I2S RX2"},
 	{"RX1 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX1 MIX1 INP2", "IIR1", "IIR1"},
+	{"RX1 MIX1 INP2", "IIR2", "IIR2"},
 
 	{"RX1 MIX1 INP3", "RX1", "I2S RX1"},
 	{"RX1 MIX1 INP3", "RX2", "I2S RX2"},
@@ -728,10 +989,14 @@ static const struct snd_soc_dapm_route msm8916_wcd_digital_audio_map[] = {
 	{"RX2 MIX1 INP1", "RX1", "I2S RX1"},
 	{"RX2 MIX1 INP1", "RX2", "I2S RX2"},
 	{"RX2 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX2 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX2 MIX1 INP1", "IIR2", "IIR2"},
 
 	{"RX2 MIX1 INP2", "RX1", "I2S RX1"},
 	{"RX2 MIX1 INP2", "RX2", "I2S RX2"},
 	{"RX2 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX2 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX2 MIX1 INP1", "IIR2", "IIR2"},
 
 	{"RX2 MIX1 INP3", "RX1", "I2S RX1"},
 	{"RX2 MIX1 INP3", "RX2", "I2S RX2"},
@@ -748,10 +1013,27 @@ static const struct snd_soc_dapm_route msm8916_wcd_digital_audio_map[] = {
 	{"RX3 MIX1 INP1", "RX1", "I2S RX1"},
 	{"RX3 MIX1 INP1", "RX2", "I2S RX2"},
 	{"RX3 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX3 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX3 MIX1 INP1", "IIR2", "IIR2"},
 
 	{"RX3 MIX1 INP2", "RX1", "I2S RX1"},
 	{"RX3 MIX1 INP2", "RX2", "I2S RX2"},
 	{"RX3 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX3 MIX1 INP2", "IIR1", "IIR1"},
+	{"RX3 MIX1 INP2", "IIR2", "IIR2"},
+
+	{"RX1 MIX2 INP1", "IIR1", "IIR1"},
+	{"RX2 MIX2 INP1", "IIR1", "IIR1"},
+	{"RX1 MIX2 INP1", "IIR2", "IIR2"},
+	{"RX2 MIX2 INP1", "IIR2", "IIR2"},
+
+	{"IIR1", NULL, "IIR1 INP1 MUX"},
+	{"IIR1 INP1 MUX", "DEC1", "DEC1 MUX"},
+	{"IIR1 INP1 MUX", "DEC2", "DEC2 MUX"},
+
+	{"IIR2", NULL, "IIR2 INP1 MUX"},
+	{"IIR2 INP1 MUX", "DEC1", "DEC1 MUX"},
+	{"IIR2 INP1 MUX", "DEC2", "DEC2 MUX"},
 
 	{"RX3 MIX1 INP3", "RX1", "I2S RX1"},
 	{"RX3 MIX1 INP3", "RX2", "I2S RX2"},
-- 
2.21.0

