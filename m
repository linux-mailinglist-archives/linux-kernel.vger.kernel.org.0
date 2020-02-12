Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F31B159EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 02:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgBLBxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 20:53:21 -0500
Received: from mail.serbinski.com ([162.218.126.2]:50606 "EHLO
        mail.serbinski.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgBLBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:53:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id 679ABD00715;
        Wed, 12 Feb 2020 01:53:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
        by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 94Js4DC9Vdse; Tue, 11 Feb 2020 20:52:59 -0500 (EST)
Received: from anet (23-233-80-73.cpe.pppoe.ca [23.233.80.73])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.serbinski.com (Postfix) with ESMTPSA id D3ABAD00716;
        Tue, 11 Feb 2020 20:52:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com D3ABAD00716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
        s=default; t=1581472357;
        bh=sCqIaNBg22m4KSr5ybpHHBuJAkr81NYlbS+800oGfyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXZThFMhlIlcOd69D22R9GeDM6Zdi+0mmEoYsrFak4ZQKrgNZd2uMhSDxdwxYCnaH
         1QnXRW+OsPX/cQdjo/nRuVOJ+PAf7fHGNmMUELhTSopbfD4hmb6nZvuKdQ7/Na/JT5
         EBjnjBS6V8xX7Ld1Qmqqdc+1d3qq7MTK+lzmGTEE=
From:   Adam Serbinski <adam@serbinski.com>
To:     Mark Brown <broonie@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Adam Serbinski <adam@serbinski.com>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] ASoC: qdsp6: q6afe-dai: add support to pcm port dais
Date:   Tue, 11 Feb 2020 20:52:19 -0500
Message-Id: <20200212015222.8229-4-adam@serbinski.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212015222.8229-1-adam@serbinski.com>
References: <20200212015222.8229-1-adam@serbinski.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support of AFE DAI for PCM port.

Signed-off-by: Adam Serbinski <adam@serbinski.com>
CC: Andy Gross <agross@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Patrick Lai <plai@codeaurora.org>
CC: Banajit Goswami <bgoswami@codeaurora.org>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: alsa-devel@alsa-project.org
CC: linux-arm-msm@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 210 ++++++++++++++++++++++++++++++-
 1 file changed, 205 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index c1a7624eaf17..2deb8d6da462 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -63,6 +63,8 @@ struct q6afe_dai_priv_data {
 	uint32_t invert_sync;
 	uint32_t data_delay;
 	uint32_t data_align;
+	uint32_t quantype;
+	uint32_t slot_number_mapping[AFE_MAX_PCM_SLOT_COUNT];
 };
 
 struct q6afe_dai_data {
@@ -151,6 +153,52 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int q6pcm_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6afe_pcm_cfg *pcm = &dai_data->port_config[dai->id].pcm_cfg;
+	int i = 0;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+		pcm->sample_rate = params_rate(params);
+		break;
+	default:
+		dev_err(dai->dev, "invalid sample rate = %u\n",
+			params_rate(params));
+		return -EINVAL;
+	}
+
+	pcm->quantype = dai_data->priv[dai->id].quantype;
+
+	for (i = 0; i < AFE_MAX_PCM_SLOT_COUNT; i++)
+		pcm->slot_number_mapping[i] =
+			dai_data->priv[dai->id].slot_number_mapping[i];
+
+	return 0;
+}
+
+static int q6pcm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
+	struct q6afe_pcm_cfg *pcm = &dai_data->port_config[dai->id].pcm_cfg;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBM_CFM:
+		pcm->fmt = fmt;
+		break;
+	default:
+		dev_err(dai->dev, "unsupported format = %u\n", fmt);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int q6i2s_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -358,6 +406,15 @@ static int q6afe_dai_prepare(struct snd_pcm_substream *substream,
 			return rc;
 		}
 		break;
+	case PRIMARY_PCM_RX ... QUATERNARY_PCM_TX:
+		rc = q6afe_pcm_port_prepare(dai_data->port[dai->id],
+				&dai_data->port_config[dai->id].pcm_cfg);
+		if (rc < 0) {
+			dev_err(dai->dev, "fail to prepare AFE port %x\n",
+				dai->id);
+			return rc;
+		}
+		break;
 	case PRIMARY_TDM_RX_0 ... QUINARY_TDM_TX_7:
 		q6afe_tdm_port_prepare(dai_data->port[dai->id],
 					&dai_data->port_config[dai->id].tdm);
@@ -429,16 +486,25 @@ static int q6afe_mi2s_set_sysclk(struct snd_soc_dai *dai,
 					     Q6AFE_LPASS_CLK_ROOT_DEFAULT,
 					     freq, dir);
 	case Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT ... Q6AFE_LPASS_CLK_ID_QUI_MI2S_OSR:
+	case Q6AFE_LPASS_CLK_ID_PRI_PCM_IBIT ... Q6AFE_LPASS_CLK_ID_QUI_PCM_OSR:
+		switch (dai->id) {
+		case PRIMARY_TDM_RX_0 ... QUINARY_TDM_TX_7:
+			return q6afe_port_set_sysclk(port, clk_id,
+				Q6AFE_LPASS_CLK_ATTRIBUTE_INVERT_COUPLE_NO,
+				Q6AFE_LPASS_CLK_ROOT_DEFAULT,
+				freq, dir);
+			break;
+		default:
+			return q6afe_port_set_sysclk(port, clk_id,
+				Q6AFE_LPASS_CLK_ATTRIBUTE_COUPLE_NO,
+				Q6AFE_LPASS_CLK_ROOT_DEFAULT,
+				freq, dir);
+		}
 	case Q6AFE_LPASS_CLK_ID_MCLK_1 ... Q6AFE_LPASS_CLK_ID_INT_MCLK_1:
 		return q6afe_port_set_sysclk(port, clk_id,
 					     Q6AFE_LPASS_CLK_ATTRIBUTE_COUPLE_NO,
 					     Q6AFE_LPASS_CLK_ROOT_DEFAULT,
 					     freq, dir);
-	case Q6AFE_LPASS_CLK_ID_PRI_TDM_IBIT ... Q6AFE_LPASS_CLK_ID_QUIN_TDM_EBIT:
-		return q6afe_port_set_sysclk(port, clk_id,
-					     Q6AFE_LPASS_CLK_ATTRIBUTE_INVERT_COUPLE_NO,
-					     Q6AFE_LPASS_CLK_ROOT_DEFAULT,
-					     freq, dir);
 	}
 
 	return 0;
@@ -468,6 +534,11 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"Tertiary MI2S Playback", NULL, "TERT_MI2S_RX"},
 	{"Quaternary MI2S Playback", NULL, "QUAT_MI2S_RX"},
 
+	{"Primary PCM Playback", NULL, "PRI_PCM_RX"},
+	{"Secondary PCM Playback", NULL, "SEC_PCM_RX"},
+	{"Tertiary PCM Playback", NULL, "TERT_PCM_RX"},
+	{"Quaternary PCM Playback", NULL, "QUAT_PCM_RX"},
+
 	{"Primary TDM0 Playback", NULL, "PRIMARY_TDM_RX_0"},
 	{"Primary TDM1 Playback", NULL, "PRIMARY_TDM_RX_1"},
 	{"Primary TDM2 Playback", NULL, "PRIMARY_TDM_RX_2"},
@@ -562,6 +633,11 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"PRI_MI2S_TX", NULL, "Primary MI2S Capture"},
 	{"SEC_MI2S_TX", NULL, "Secondary MI2S Capture"},
 	{"QUAT_MI2S_TX", NULL, "Quaternary MI2S Capture"},
+
+	{"PRI_PCM_TX", NULL, "Primary PCM Capture"},
+	{"SEC_PCM_TX", NULL, "Secondary PCM Capture"},
+	{"TERT_PCM_TX", NULL, "Tertiary PCM Capture"},
+	{"QUAT_PCM_TX", NULL, "Quaternary PCM Capture"},
 };
 
 static const struct snd_soc_dai_ops q6hdmi_ops = {
@@ -578,6 +654,14 @@ static const struct snd_soc_dai_ops q6i2s_ops = {
 	.set_sysclk	= q6afe_mi2s_set_sysclk,
 };
 
+static const struct snd_soc_dai_ops q6pcm_ops = {
+	.prepare	= q6afe_dai_prepare,
+	.hw_params	= q6pcm_hw_params,
+	.set_fmt	= q6pcm_set_fmt,
+	.shutdown	= q6afe_dai_shutdown,
+	.set_sysclk	= q6afe_mi2s_set_sysclk,
+};
+
 static const struct snd_soc_dai_ops q6slim_ops = {
 	.prepare	= q6afe_dai_prepare,
 	.hw_params	= q6slim_hw_params,
@@ -1012,6 +1096,94 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.ops = &q6i2s_ops,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Primary PCM Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.id = PRIMARY_PCM_RX,
+		.name = "PRI_PCM_RX",
+		.ops = &q6pcm_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.capture = {
+			.stream_name = "Primary PCM Capture",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.id = PRIMARY_PCM_TX,
+		.name = "PRI_PCM_TX",
+		.ops = &q6pcm_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Secondary PCM Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.name = "SEC_PCM_RX",
+		.id = SECONDARY_PCM_RX,
+		.ops = &q6pcm_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.capture = {
+			.stream_name = "Secondary PCM Capture",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.id = SECONDARY_PCM_TX,
+		.name = "SEC_PCM_TX",
+		.ops = &q6pcm_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Tertiary PCM Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.name = "TERT_PCM_RX",
+		.id = TERTIARY_PCM_RX,
+		.ops = &q6pcm_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.capture = {
+			.stream_name = "Tertiary PCM Capture",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.id = TERTIARY_PCM_TX,
+		.name = "TERT_PCM_TX",
+		.ops = &q6pcm_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.playback = {
+			.stream_name = "Quaternary PCM Playback",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.name = "QUAT_PCM_RX",
+		.id = QUATERNARY_PCM_RX,
+		.ops = &q6pcm_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.capture = {
+			.stream_name = "Quaternary PCM Capture",
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+		.id = QUATERNARY_PCM_TX,
+		.name = "QUAT_PCM_TX",
+		.ops = &q6pcm_ops,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
 	},
 	Q6AFE_TDM_PB_DAI("Primary", 0, PRIMARY_TDM_RX_0),
 	Q6AFE_TDM_PB_DAI("Primary", 1, PRIMARY_TDM_RX_1),
@@ -1169,6 +1341,15 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("PRI_MI2S_TX", NULL,
 						0, 0, 0, 0),
 
+	SND_SOC_DAPM_AIF_IN("QUAT_PCM_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("QUAT_PCM_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("TERT_PCM_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("TERT_PCM_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SEC_PCM_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SEC_PCM_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("PRI_PCM_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("PRI_PCM_TX", NULL, 0, 0, 0, 0),
+
 	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_1", NULL,
@@ -1381,6 +1562,25 @@ static void of_q6afe_parse_dai_data(struct device *dev,
 			for (i = 0; i < num_lines; i++)
 				priv->sd_line_mask |= BIT(lines[i]);
 
+			break;
+		case PRIMARY_PCM_RX ... QUATERNARY_PCM_TX:
+			priv = &data->priv[id];
+			ret = of_property_read_u32(node, "qcom,pcm-quantype",
+						   &priv->quantype);
+			if (ret) {
+				dev_err(dev, "No quantype from DT\n");
+				break;
+			}
+
+			ret = of_property_read_variable_u32_array(node,
+						"qcom,pcm-slot-mapping",
+						priv->slot_number_mapping,
+						1, AFE_MAX_PCM_SLOT_COUNT);
+			if (ret < 0) {
+				dev_err(dev, "No slot mapping from DT\n");
+				break;
+			}
+
 			break;
 		case PRIMARY_TDM_RX_0 ... QUINARY_TDM_TX_7:
 			priv = &data->priv[id];
-- 
2.21.1

