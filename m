Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8FC159EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 02:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgBLBww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 20:52:52 -0500
Received: from mail.serbinski.com ([162.218.126.2]:50324 "EHLO
        mail.serbinski.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgBLBwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:52:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id 6FFC3D00693;
        Wed, 12 Feb 2020 01:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
        by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6g8I74C66uh9; Tue, 11 Feb 2020 20:52:33 -0500 (EST)
Received: from anet (23-233-80-73.cpe.pppoe.ca [23.233.80.73])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.serbinski.com (Postfix) with ESMTPSA id D861FD006F9;
        Tue, 11 Feb 2020 20:52:32 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com D861FD006F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
        s=default; t=1581472352;
        bh=5G+j9z85VmKhr+y6mqiRgd08if/sZtEwNi0yvFuTXBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDpT2Fi10Rzq62jJrNZd3Fec4fWBWHsRlojcCIDAEkoiw3WlrQFOGr3xzwkB/mNY2
         6hT1AIt72Njgg1Pv5hEIuAe3GicGj4NKIjcy7PB84XUKREsonkSwvGJ2CqyXom3VDI
         oXiJ//yXQw77R3nkz0/eYsHAXU1SQfXOydZEePjc=
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
Subject: [PATCH v3 2/6] ASoC: qdsp6: q6afe: add support to pcm ports
Date:   Tue, 11 Feb 2020 20:52:18 -0500
Message-Id: <20200212015222.8229-3-adam@serbinski.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212015222.8229-1-adam@serbinski.com>
References: <20200212015222.8229-1-adam@serbinski.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to pcm ports in AFE.

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
 sound/soc/qcom/qdsp6/q6afe.c | 118 +++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h |  13 +++-
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index e0945f7a58c8..11de01679cad 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -40,6 +40,7 @@
 
 #define AFE_PARAM_ID_SLIMBUS_CONFIG    0x00010212
 #define AFE_PARAM_ID_I2S_CONFIG	0x0001020D
+#define AFE_PARAM_ID_PCM_CONFIG        0x0001020E
 #define AFE_PARAM_ID_TDM_CONFIG	0x0001029D
 #define AFE_PARAM_ID_PORT_SLOT_MAPPING_CONFIG	0x00010297
 
@@ -117,6 +118,15 @@
 #define AFE_PORT_ID_QUATERNARY_MI2S_RX      0x1006
 #define AFE_PORT_ID_QUATERNARY_MI2S_TX      0x1007
 
+#define AFE_PORT_ID_PRIMARY_PCM_RX          0x100A
+#define AFE_PORT_ID_PRIMARY_PCM_TX          0x100B
+#define AFE_PORT_ID_SECONDARY_PCM_RX        0x100C
+#define AFE_PORT_ID_SECONDARY_PCM_TX        0x100D
+#define AFE_PORT_ID_TERTIARY_PCM_RX         0x1012
+#define AFE_PORT_ID_TERTIARY_PCM_TX         0x1013
+#define AFE_PORT_ID_QUATERNARY_PCM_RX       0x1014
+#define AFE_PORT_ID_QUATERNARY_PCM_TX       0x1015
+
 /* Start of the range of port IDs for TDM devices. */
 #define AFE_PORT_ID_TDM_PORT_RANGE_START	0x9000
 
@@ -421,6 +431,29 @@ struct afe_digital_clk_cfg {
 	u16                  reserved;
 } __packed;
 
+#define AFE_API_VERSION_PCM_CONFIG		0x1
+#define AFE_PORT_PCM_QUANT_MAX			0x5
+#define AFE_PORT_PCM_SYNC_SRC_EXTERNAL		0x0
+#define AFE_PORT_PCM_SYNC_SRC_INTERNAL		0x1
+#define AFE_PORT_PCM_AUX_MODE_PCM		0x0
+#define AFE_PORT_PCM_BITS_PER_FRAME_64		0x3
+#define AFE_PORT_PCM_BITS_PER_FRAME_128		0x4
+#define AFE_PORT_PCM_CTRL_DATA_OE_DISABLE	0x0
+
+struct afe_param_id_pcm_cfg {
+	u32	pcm_cfg_minor_version;
+	u16	aux_mode;
+	u16	sync_src;
+	u16	frame_setting;
+	u16	quantype;
+	u16	ctrl_data_out_enable;
+	u16	reserved;
+	u32	sample_rate;
+	u16	bit_width;
+	u16	num_channels;
+	u16	slot_number_mapping[AFE_MAX_PCM_SLOT_COUNT];
+} __packed;
+
 struct afe_param_id_i2s_cfg {
 	u32	i2s_cfg_minor_version;
 	u16	bit_width;
@@ -452,6 +485,7 @@ union afe_port_config {
 	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
 	struct afe_param_id_slimbus_cfg           slim_cfg;
 	struct afe_param_id_i2s_cfg	i2s_cfg;
+	struct afe_param_id_pcm_cfg	pcm_cfg;
 	struct afe_param_id_tdm_cfg	tdm_cfg;
 } __packed;
 
@@ -707,6 +741,22 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				QUINARY_TDM_TX_7, 0, 1},
 	[DISPLAY_PORT_RX] = { AFE_PORT_ID_HDMI_OVER_DP_RX,
 				DISPLAY_PORT_RX, 1, 1},
+	[PRIMARY_PCM_RX] = { AFE_PORT_ID_PRIMARY_PCM_RX,
+				PRIMARY_PCM_RX, 1, 1},
+	[PRIMARY_PCM_TX] = { AFE_PORT_ID_PRIMARY_PCM_TX,
+				PRIMARY_PCM_RX, 0, 1},
+	[SECONDARY_PCM_RX] = { AFE_PORT_ID_SECONDARY_PCM_RX,
+				SECONDARY_PCM_RX, 1, 1},
+	[SECONDARY_PCM_TX] = { AFE_PORT_ID_SECONDARY_PCM_TX,
+				SECONDARY_PCM_TX, 0, 1},
+	[TERTIARY_PCM_RX] = { AFE_PORT_ID_TERTIARY_PCM_RX,
+				TERTIARY_PCM_RX, 1, 1},
+	[TERTIARY_PCM_TX] = { AFE_PORT_ID_TERTIARY_PCM_TX,
+				TERTIARY_PCM_TX, 0, 1},
+	[QUATERNARY_PCM_RX] = { AFE_PORT_ID_QUATERNARY_PCM_RX,
+				QUATERNARY_PCM_RX, 1, 1},
+	[QUATERNARY_PCM_TX] = { AFE_PORT_ID_QUATERNARY_PCM_TX,
+				QUATERNARY_PCM_TX, 0, 1},
 };
 
 static void q6afe_port_free(struct kref *ref)
@@ -993,6 +1043,7 @@ int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
 		break;
 	case Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT ... Q6AFE_LPASS_CLK_ID_QUI_MI2S_OSR:
 	case Q6AFE_LPASS_CLK_ID_MCLK_1 ... Q6AFE_LPASS_CLK_ID_INT_MCLK_1:
+	/* TDM cases overlap with PCM */
 	case Q6AFE_LPASS_CLK_ID_PRI_TDM_IBIT ... Q6AFE_LPASS_CLK_ID_QUIN_TDM_EBIT:
 		cset.clk_set_minor_version = AFE_API_VERSION_CLOCK_SET;
 		cset.clk_id = clk_id;
@@ -1145,6 +1196,63 @@ void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 }
 EXPORT_SYMBOL_GPL(q6afe_hdmi_port_prepare);
 
+/**
+ * q6afe_pcm_port_prepare() - Prepare pcm afe port.
+ *
+ * @port: Instance of afe port
+ * @cfg: PCM configuration for the afe port
+ *
+ */
+int q6afe_pcm_port_prepare(struct q6afe_port *port, struct q6afe_pcm_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+	struct device *dev = port->afe->dev;
+
+	pcfg->pcm_cfg.pcm_cfg_minor_version = AFE_API_VERSION_PCM_CONFIG;
+
+	if (cfg->quantype > AFE_PORT_PCM_QUANT_MAX) {
+		dev_err(dev, "Invalid pcm quantization\n");
+		return -EINVAL;
+	}
+	pcfg->pcm_cfg.quantype = cfg->quantype;
+
+	memcpy(pcfg->pcm_cfg.slot_number_mapping, cfg->slot_number_mapping,
+	       sizeof(u16) * AFE_PORT_MAX_PCM_AUDIO_CHAN_CNT);
+
+	pcfg->pcm_cfg.aux_mode = AFE_PORT_PCM_AUX_MODE_PCM;
+	switch (cfg->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		pcfg->pcm_cfg.sync_src = AFE_PORT_PCM_SYNC_SRC_INTERNAL;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		pcfg->pcm_cfg.sync_src = AFE_PORT_PCM_SYNC_SRC_EXTERNAL;
+		break;
+	default:
+		dev_err(dev, "Unsupported format\n");
+		return -EINVAL;
+	}
+
+	switch (cfg->sample_rate) {
+	case 8000:
+		pcfg->pcm_cfg.frame_setting = AFE_PORT_PCM_BITS_PER_FRAME_128;
+		break;
+	case 16000:
+		pcfg->pcm_cfg.frame_setting = AFE_PORT_PCM_BITS_PER_FRAME_64;
+		break;
+	default:
+		dev_err(dev, "Unsupported sample rate\n");
+		return -EINVAL;
+	}
+	pcfg->pcm_cfg.ctrl_data_out_enable = AFE_PORT_PCM_CTRL_DATA_OE_DISABLE;
+	pcfg->pcm_cfg.reserved = 0;
+	pcfg->pcm_cfg.sample_rate = cfg->sample_rate;
+	pcfg->pcm_cfg.bit_width = 16;
+	pcfg->pcm_cfg.num_channels = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6afe_pcm_port_prepare);
+
 /**
  * q6afe_i2s_port_prepare() - Prepare i2s afe port.
  *
@@ -1417,6 +1525,16 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	case AFE_PORT_ID_QUATERNARY_MI2S_TX:
 		cfg_type = AFE_PARAM_ID_I2S_CONFIG;
 		break;
+	case AFE_PORT_ID_PRIMARY_PCM_RX:
+	case AFE_PORT_ID_PRIMARY_PCM_TX:
+	case AFE_PORT_ID_SECONDARY_PCM_RX:
+	case AFE_PORT_ID_SECONDARY_PCM_TX:
+	case AFE_PORT_ID_TERTIARY_PCM_RX:
+	case AFE_PORT_ID_TERTIARY_PCM_TX:
+	case AFE_PORT_ID_QUATERNARY_PCM_RX:
+	case AFE_PORT_ID_QUATERNARY_PCM_TX:
+		cfg_type = AFE_PARAM_ID_PCM_CONFIG;
+		break;
 	case AFE_PORT_ID_PRIMARY_TDM_RX ... AFE_PORT_ID_QUINARY_TDM_TX_7:
 		cfg_type = AFE_PARAM_ID_TDM_CONFIG;
 		break;
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index c7ed5422baff..d3b79e391e44 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -5,7 +5,7 @@
 
 #include <dt-bindings/sound/qcom,q6afe.h>
 
-#define AFE_PORT_MAX		105
+#define AFE_PORT_MAX		113
 
 #define MSM_AFE_PORT_TYPE_RX 0
 #define MSM_AFE_PORT_TYPE_TX 1
@@ -14,7 +14,9 @@
 #define Q6AFE_MAX_MI2S_LINES	4
 
 #define AFE_MAX_CHAN_COUNT	8
+#define AFE_MAX_PCM_SLOT_COUNT	4
 #define AFE_PORT_MAX_AUDIO_CHAN_CNT	0x8
+#define AFE_PORT_MAX_PCM_AUDIO_CHAN_CNT	0x4
 
 #define Q6AFE_LPASS_CLK_SRC_INTERNAL 1
 #define Q6AFE_LPASS_CLK_ROOT_DEFAULT 0
@@ -170,6 +172,13 @@ struct q6afe_i2s_cfg {
 	int fmt;
 };
 
+struct q6afe_pcm_cfg {
+	u16	quantype;
+	u32	sample_rate;
+	u16	slot_number_mapping[AFE_MAX_PCM_SLOT_COUNT];
+	int fmt;
+};
+
 struct q6afe_tdm_cfg {
 	u16	num_channels;
 	u32	sample_rate;
@@ -188,6 +197,7 @@ struct q6afe_port_config {
 	struct q6afe_hdmi_cfg hdmi;
 	struct q6afe_slim_cfg slim;
 	struct q6afe_i2s_cfg i2s_cfg;
+	struct q6afe_pcm_cfg pcm_cfg;
 	struct q6afe_tdm_cfg tdm;
 };
 
@@ -203,6 +213,7 @@ void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 void q6afe_slim_port_prepare(struct q6afe_port *port,
 			  struct q6afe_slim_cfg *cfg);
 int q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg);
+int q6afe_pcm_port_prepare(struct q6afe_port *port, struct q6afe_pcm_cfg *cfg);
 void q6afe_tdm_port_prepare(struct q6afe_port *port, struct q6afe_tdm_cfg *cfg);
 
 int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
-- 
2.21.1

