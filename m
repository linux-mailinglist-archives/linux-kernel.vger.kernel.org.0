Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B647156051
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 21:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBGU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 15:58:46 -0500
Received: from mail.serbinski.com ([162.218.126.2]:46942 "EHLO
        mail.serbinski.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgBGU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:58:44 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Feb 2020 15:58:43 EST
Received: from localhost (unknown [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id 2669DD0072D;
        Fri,  7 Feb 2020 20:50:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
        by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Eufmzu5hBPkt; Fri,  7 Feb 2020 15:50:42 -0500 (EST)
Received: from anet (ipagstaticip-7ac5353e-e7de-3a0d-ff65-4540e9bc137f.sdsl.bell.ca [142.112.15.192])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.serbinski.com (Postfix) with ESMTPSA id D3A91D00718;
        Fri,  7 Feb 2020 15:50:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com D3A91D00718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
        s=default; t=1581108628;
        bh=jsi/0KR95Be8JlP/oKlvl9hSpIDJt2oiAI/0W60I3Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0OrpfU8/w9VilEM9I/tqhxyIjKwyf5iq6Aq7raIC2MGZuCKMrEthjXpIZiqyTdAqv
         ntPVkIL3MzCmmuRCE4fbYEVwlsMSMmnpvfxApovxM7nKfBZNjauTIW0ljEgkssqm/x
         BlMX9XGbzcEG5WJrROwbdhKn59+N3vAVDBFs9zKI=
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
Subject: [PATCH 2/8] ASoC: qdsp6: q6afe: add support to pcm ports
Date:   Fri,  7 Feb 2020 15:50:07 -0500
Message-Id: <20200207205013.12274-3-adam@serbinski.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200207205013.12274-1-adam@serbinski.com>
References: <20200207205013.12274-1-adam@serbinski.com>
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
 sound/soc/qcom/qdsp6/q6afe.c | 246 +++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h |   9 +-
 2 files changed, 254 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index e0945f7a58c8..b53ad14a78fd 100644
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
 
@@ -421,6 +431,166 @@ struct afe_digital_clk_cfg {
 	u16                  reserved;
 } __packed;
 
+#define AFE_API_VERSION_PCM_CONFIG	0x1
+/* Enumeration for the auxiliary PCM synchronization signal
+ * provided by an external source.
+ */
+
+#define AFE_PORT_PCM_SYNC_SRC_EXTERNAL 0x0
+/*	Enumeration for the auxiliary PCM synchronization signal
+ * provided by an internal source.
+ */
+#define AFE_PORT_PCM_SYNC_SRC_INTERNAL  0x1
+/*	Enumeration for the PCM configuration aux_mode parameter,
+ * which configures the auxiliary PCM interface to use
+ * short synchronization.
+ */
+#define AFE_PORT_PCM_AUX_MODE_PCM  0x0
+/*
+ * Enumeration for the PCM configuration aux_mode parameter,
+ * which configures the auxiliary PCM interface to use long
+ * synchronization.
+ */
+#define AFE_PORT_PCM_AUX_MODE_AUX    0x1
+/*
+ * Enumeration for setting the PCM configuration frame to 8.
+ */
+#define AFE_PORT_PCM_BITS_PER_FRAME_8  0x0
+/*
+ * Enumeration for setting the PCM configuration frame to 16.
+ */
+#define AFE_PORT_PCM_BITS_PER_FRAME_16   0x1
+
+/*	Enumeration for setting the PCM configuration frame to 32.*/
+#define AFE_PORT_PCM_BITS_PER_FRAME_32 0x2
+
+/*	Enumeration for setting the PCM configuration frame to 64.*/
+#define AFE_PORT_PCM_BITS_PER_FRAME_64   0x3
+
+/*	Enumeration for setting the PCM configuration frame to 128.*/
+#define AFE_PORT_PCM_BITS_PER_FRAME_128 0x4
+
+/*	Enumeration for setting the PCM configuration frame to 256.*/
+#define AFE_PORT_PCM_BITS_PER_FRAME_256 0x5
+
+/*	Enumeration for setting the PCM configuration
+ * quantype parameter to A-law with no padding.
+ */
+#define AFE_PORT_PCM_ALAW_NOPADDING 0x0
+
+/* Enumeration for setting the PCM configuration quantype
+ * parameter to mu-law with no padding.
+ */
+#define AFE_PORT_PCM_MULAW_NOPADDING 0x1
+/*	Enumeration for setting the PCM configuration quantype
+ * parameter to linear with no padding.
+ */
+#define AFE_PORT_PCM_LINEAR_NOPADDING 0x2
+/*	Enumeration for setting the PCM configuration quantype
+ * parameter to A-law with padding.
+ */
+#define AFE_PORT_PCM_ALAW_PADDING  0x3
+/*	Enumeration for setting the PCM configuration quantype
+ * parameter to mu-law with padding.
+ */
+#define AFE_PORT_PCM_MULAW_PADDING 0x4
+/*	Enumeration for setting the PCM configuration quantype
+ * parameter to linear with padding.
+ */
+#define AFE_PORT_PCM_LINEAR_PADDING 0x5
+/*	Enumeration for disabling the PCM configuration
+ * ctrl_data_out_enable parameter.
+ * The PCM block is the only master.
+ */
+#define AFE_PORT_PCM_CTRL_DATA_OE_DISABLE 0x0
+/*
+ * Enumeration for enabling the PCM configuration
+ * ctrl_data_out_enable parameter. The PCM block shares
+ * the signal with other masters.
+ */
+#define AFE_PORT_PCM_CTRL_DATA_OE_ENABLE  0x1
+
+/*  Payload of the #AFE_PARAM_ID_PCM_CONFIG command's
+ * (PCM configuration parameter).
+ */
+
+struct afe_param_id_pcm_cfg {
+	u32                  pcm_cfg_minor_version;
+/* Minor version used for tracking the version of the AUX PCM
+ * configuration interface.
+ * Supported values: #AFE_API_VERSION_PCM_CONFIG
+ */
+
+	u16                  aux_mode;
+/* PCM synchronization setting.
+ * Supported values:
+ * - #AFE_PORT_PCM_AUX_MODE_PCM
+ * - #AFE_PORT_PCM_AUX_MODE_AUX
+ */
+
+	u16                  sync_src;
+/* Synchronization source.
+ * Supported values:
+ * - #AFE_PORT_PCM_SYNC_SRC_EXTERNAL
+ * - #AFE_PORT_PCM_SYNC_SRC_INTERNAL
+ */
+
+	u16                  frame_setting;
+/* Number of bits per frame.
+ * Supported values:
+ * - #AFE_PORT_PCM_BITS_PER_FRAME_8
+ * - #AFE_PORT_PCM_BITS_PER_FRAME_16
+ * - #AFE_PORT_PCM_BITS_PER_FRAME_32
+ * - #AFE_PORT_PCM_BITS_PER_FRAME_64
+ * - #AFE_PORT_PCM_BITS_PER_FRAME_128
+ * - #AFE_PORT_PCM_BITS_PER_FRAME_256
+ */
+
+	u16                  quantype;
+/* PCM quantization type.
+ * Supported values:
+ * - #AFE_PORT_PCM_ALAW_NOPADDING
+ * - #AFE_PORT_PCM_MULAW_NOPADDING
+ * - #AFE_PORT_PCM_LINEAR_NOPADDING
+ * - #AFE_PORT_PCM_ALAW_PADDING
+ * - #AFE_PORT_PCM_MULAW_PADDING
+ * - #AFE_PORT_PCM_LINEAR_PADDING
+ */
+
+	u16                  ctrl_data_out_enable;
+/* Specifies whether the PCM block shares the data-out
+ * signal to the drive with other masters.
+ * Supported values:
+ * - #AFE_PORT_PCM_CTRL_DATA_OE_DISABLE
+ * - #AFE_PORT_PCM_CTRL_DATA_OE_ENABLE
+ */
+		u16                  reserved;
+	/* This field must be set to zero. */
+
+	u32                  sample_rate;
+/* Sampling rate of the port.
+ * Supported values:
+ * - #AFE_PORT_SAMPLE_RATE_8K
+ * - #AFE_PORT_SAMPLE_RATE_16K
+ */
+
+	u16                  bit_width;
+/* Bit width of the sample.
+ * Supported values: 16
+ */
+
+	u16                  num_channels;
+/* Number of channels.
+ * Supported values: 1 to 4
+ */
+
+	u16                  slot_number_mapping[4];
+/* Specifies the slot number for the each channel in
+ * multi channel scenario.
+ * Supported values: 1 to 32
+ */
+} __packed;
+
 struct afe_param_id_i2s_cfg {
 	u32	i2s_cfg_minor_version;
 	u16	bit_width;
@@ -452,6 +622,7 @@ union afe_port_config {
 	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
 	struct afe_param_id_slimbus_cfg           slim_cfg;
 	struct afe_param_id_i2s_cfg	i2s_cfg;
+	struct afe_param_id_pcm_cfg	pcm_cfg;
 	struct afe_param_id_tdm_cfg	tdm_cfg;
 } __packed;
 
@@ -707,6 +878,22 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
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
@@ -993,6 +1180,7 @@ int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
 		break;
 	case Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT ... Q6AFE_LPASS_CLK_ID_QUI_MI2S_OSR:
 	case Q6AFE_LPASS_CLK_ID_MCLK_1 ... Q6AFE_LPASS_CLK_ID_INT_MCLK_1:
+	/* TDM cases overlap with PCM */
 	case Q6AFE_LPASS_CLK_ID_PRI_TDM_IBIT ... Q6AFE_LPASS_CLK_ID_QUIN_TDM_EBIT:
 		cset.clk_set_minor_version = AFE_API_VERSION_CLOCK_SET;
 		cset.clk_id = clk_id;
@@ -1145,6 +1333,54 @@ void q6afe_hdmi_port_prepare(struct q6afe_port *port,
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
+
+	pcfg->pcm_cfg.pcm_cfg_minor_version = AFE_API_VERSION_PCM_CONFIG;
+	pcfg->pcm_cfg.aux_mode = AFE_PORT_PCM_AUX_MODE_PCM;
+
+	switch (cfg->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		pcfg->pcm_cfg.sync_src = AFE_PORT_PCM_SYNC_SRC_INTERNAL;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/* CPU is slave */
+		pcfg->pcm_cfg.sync_src = AFE_PORT_PCM_SYNC_SRC_EXTERNAL;
+		break;
+	default:
+		break;
+	}
+
+	switch (cfg->sample_rate) {
+	case 8000:
+		pcfg->pcm_cfg.frame_setting = AFE_PORT_PCM_BITS_PER_FRAME_128;
+		break;
+	case 16000:
+		pcfg->pcm_cfg.frame_setting = AFE_PORT_PCM_BITS_PER_FRAME_64;
+		break;
+	}
+	pcfg->pcm_cfg.quantype = AFE_PORT_PCM_LINEAR_NOPADDING;
+	pcfg->pcm_cfg.ctrl_data_out_enable = AFE_PORT_PCM_CTRL_DATA_OE_DISABLE;
+	pcfg->pcm_cfg.reserved = 0;
+	pcfg->pcm_cfg.sample_rate = cfg->sample_rate;
+
+	/* 16 bit mono */
+	pcfg->pcm_cfg.bit_width = 16;
+	pcfg->pcm_cfg.num_channels = 1;
+	pcfg->pcm_cfg.slot_number_mapping[0] = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6afe_pcm_port_prepare);
+
 /**
  * q6afe_i2s_port_prepare() - Prepare i2s afe port.
  *
@@ -1417,6 +1653,16 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
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
index c7ed5422baff..c832be6d0ff5 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -5,7 +5,7 @@
 
 #include <dt-bindings/sound/qcom,q6afe.h>
 
-#define AFE_PORT_MAX		105
+#define AFE_PORT_MAX		113
 
 #define MSM_AFE_PORT_TYPE_RX 0
 #define MSM_AFE_PORT_TYPE_TX 1
@@ -170,6 +170,11 @@ struct q6afe_i2s_cfg {
 	int fmt;
 };
 
+struct q6afe_pcm_cfg {
+	u32	sample_rate;
+	int fmt;
+};
+
 struct q6afe_tdm_cfg {
 	u16	num_channels;
 	u32	sample_rate;
@@ -188,6 +193,7 @@ struct q6afe_port_config {
 	struct q6afe_hdmi_cfg hdmi;
 	struct q6afe_slim_cfg slim;
 	struct q6afe_i2s_cfg i2s_cfg;
+	struct q6afe_pcm_cfg pcm_cfg;
 	struct q6afe_tdm_cfg tdm;
 };
 
@@ -203,6 +209,7 @@ void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 void q6afe_slim_port_prepare(struct q6afe_port *port,
 			  struct q6afe_slim_cfg *cfg);
 int q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg);
+int q6afe_pcm_port_prepare(struct q6afe_port *port, struct q6afe_pcm_cfg *cfg);
 void q6afe_tdm_port_prepare(struct q6afe_port *port, struct q6afe_tdm_cfg *cfg);
 
 int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
-- 
2.21.1

