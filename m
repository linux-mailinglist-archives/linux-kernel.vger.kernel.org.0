Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C81864D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 06:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgCPF4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 01:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgCPF4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 01:56:21 -0400
Received: from vkoul-mobl.Dlink (unknown [49.207.58.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0F220663;
        Mon, 16 Mar 2020 05:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584338180;
        bh=gJilxXwLTj8c2GYjN3RvcEFAZQ5/KAmE5G/jXrKmasc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXFTME3QUT8VlKFZhqG36kFjLRxraQ93M6viT4WKym8pFKTWIkoALE39zoxVf8ECy
         FqPsqxdUD2RTi0PEItQ6VKnxbyOMjyRZYkVr2oKNdSo1wHvXQZi1tNxQPvnnzoQncQ
         pScwcFgRCjbVKY91ZfhkBhSniKk9Cw452KKkcLFg=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] ASoC: qcom: q6asm: add support for alac and ape configs
Date:   Mon, 16 Mar 2020 11:22:19 +0530
Message-Id: <20200316055221.1944464-8-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316055221.1944464-1-vkoul@kernel.org>
References: <20200316055221.1944464-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm DSPs expect ALAC and APE configs to be send for decoders,
so add the API to program the respective config to the DSP.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 118 +++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h |  32 ++++++++++
 2 files changed, 150 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 4cec95c657ba..0e0e8f7a460a 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -48,6 +48,8 @@
 #define ASM_STREAM_CMD_OPEN_READ_V3                 0x00010DB4
 #define ASM_DATA_EVENT_READ_DONE_V2 0x00010D9A
 #define ASM_STREAM_CMD_OPEN_READWRITE_V2        0x00010D8D
+#define ASM_MEDIA_FMT_ALAC			0x00012f31
+#define ASM_MEDIA_FMT_APE			0x00012f32
 
 
 #define ASM_LEGACY_STREAM_SESSION	0
@@ -133,6 +135,36 @@ struct asm_wmaprov10_fmt_blk_v2 {
 	u32          advanced_enc_options2;
 } __packed;
 
+struct asm_alac_fmt_blk_v2 {
+	struct asm_data_cmd_media_fmt_update_v2 fmt_blk;
+	u32 frame_length;
+	u8 compatible_version;
+	u8 bit_depth;
+	u8 pb;
+	u8 mb;
+	u8 kb;
+	u8 num_channels;
+	u16 max_run;
+	u32 max_frame_bytes;
+	u32 avg_bit_rate;
+	u32 sample_rate;
+	u32 channel_layout_tag;
+} __packed;
+
+struct asm_ape_fmt_blk_v2 {
+	struct asm_data_cmd_media_fmt_update_v2 fmt_blk;
+	u16 compatible_version;
+	u16 compression_level;
+	u32 format_flags;
+	u32 blocks_per_frame;
+	u32 final_frame_blocks;
+	u32 total_frames;
+	u16 bits_per_sample;
+	u16 num_channels;
+	u32 sample_rate;
+	u32 seek_table_present;
+} __packed;
+
 struct asm_stream_cmd_set_encdec_param {
 	u32                  param_id;
 	u32                  param_size;
@@ -941,6 +973,12 @@ int q6asm_open_write(struct audio_client *ac, uint32_t format,
 			goto err;
 		}
 		break;
+	case SND_AUDIOCODEC_ALAC:
+		open->dec_fmt_id = ASM_MEDIA_FMT_ALAC;
+		break;
+	case SND_AUDIOCODEC_APE:
+		open->dec_fmt_id = ASM_MEDIA_FMT_APE;
+		break;
 	default:
 		dev_err(ac->dev, "Invalid format 0x%x\n", format);
 		rc = -EINVAL;
@@ -1198,6 +1236,86 @@ int q6asm_stream_media_format_block_wma_v10(struct audio_client *ac,
 }
 EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_wma_v10);
 
+int q6asm_stream_media_format_block_alac(struct audio_client *ac,
+					 struct q6asm_alac_cfg *cfg)
+{
+	struct asm_alac_fmt_blk_v2 *fmt;
+	struct apr_pkt *pkt;
+	void *p;
+	int rc, pkt_size;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	fmt = p + APR_HDR_SIZE;
+
+	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, true, ac->stream_id);
+
+	pkt->hdr.opcode = ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2;
+	fmt->fmt_blk.fmt_blk_size = sizeof(*fmt) - sizeof(fmt->fmt_blk);
+
+	fmt->frame_length = cfg->frame_length;
+	fmt->compatible_version = cfg->compatible_version;
+	fmt->bit_depth =  cfg->bit_depth;
+	fmt->num_channels = cfg->num_channels;
+	fmt->max_run = cfg->max_run;
+	fmt->max_frame_bytes = cfg->max_frame_bytes;
+	fmt->avg_bit_rate = cfg->avg_bit_rate;
+	fmt->sample_rate = cfg->sample_rate;
+	fmt->channel_layout_tag = cfg->channel_layout_tag;
+	fmt->pb = cfg->pb;
+	fmt->mb = cfg->mb;
+	fmt->kb = cfg->kb;
+
+	rc = q6asm_ac_send_cmd_sync(ac, pkt);
+	kfree(pkt);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_alac);
+
+int q6asm_stream_media_format_block_ape(struct audio_client *ac,
+					struct q6asm_ape_cfg *cfg)
+{
+	struct asm_ape_fmt_blk_v2 *fmt;
+	struct apr_pkt *pkt;
+	void *p;
+	int rc, pkt_size;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*fmt);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	fmt = p + APR_HDR_SIZE;
+
+	q6asm_add_hdr(ac, &pkt->hdr, pkt_size, true, ac->stream_id);
+
+	pkt->hdr.opcode = ASM_DATA_CMD_MEDIA_FMT_UPDATE_V2;
+	fmt->fmt_blk.fmt_blk_size = sizeof(*fmt) - sizeof(fmt->fmt_blk);
+
+	fmt->compatible_version = cfg->compatible_version;
+	fmt->compression_level = cfg->compression_level;
+	fmt->format_flags = cfg->format_flags;
+	fmt->blocks_per_frame = cfg->blocks_per_frame;
+	fmt->final_frame_blocks = cfg->final_frame_blocks;
+	fmt->total_frames = cfg->total_frames;
+	fmt->bits_per_sample = cfg->bits_per_sample;
+	fmt->num_channels = cfg->num_channels;
+	fmt->sample_rate = cfg->sample_rate;
+	fmt->seek_table_present = cfg->seek_table_present;
+
+	rc = q6asm_ac_send_cmd_sync(ac, pkt);
+	kfree(pkt);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_stream_media_format_block_ape);
+
 /**
  * q6asm_enc_cfg_blk_pcm_format_support() - setup pcm configuration for capture
  *
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 5d9fbc75688c..38a207d6cd95 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -58,6 +58,34 @@ struct q6asm_wma_cfg {
 	u32 adv_enc_options2;
 };
 
+struct q6asm_alac_cfg {
+	u32 frame_length;
+	u8 compatible_version;
+	u8 bit_depth;
+	u8 pb;
+	u8 mb;
+	u8 kb;
+	u8 num_channels;
+	u16 max_run;
+	u32 max_frame_bytes;
+	u32 avg_bit_rate;
+	u32 sample_rate;
+	u32 channel_layout_tag;
+};
+
+struct q6asm_ape_cfg {
+	u16 compatible_version;
+	u16 compression_level;
+	u32 format_flags;
+	u32 blocks_per_frame;
+	u32 final_frame_blocks;
+	u32 total_frames;
+	u16 bits_per_sample;
+	u16 num_channels;
+	u32 sample_rate;
+	u32 seek_table_present;
+};
+
 typedef void (*q6asm_cb) (uint32_t opcode, uint32_t token,
 			  void *payload, void *priv);
 struct audio_client;
@@ -86,6 +114,10 @@ int q6asm_stream_media_format_block_wma_v9(struct audio_client *ac,
 					   struct q6asm_wma_cfg *cfg);
 int q6asm_stream_media_format_block_wma_v10(struct audio_client *ac,
 					    struct q6asm_wma_cfg *cfg);
+int q6asm_stream_media_format_block_alac(struct audio_client *ac,
+					 struct q6asm_alac_cfg *cfg);
+int q6asm_stream_media_format_block_ape(struct audio_client *ac,
+					struct q6asm_ape_cfg *cfg);
 int q6asm_run(struct audio_client *ac, uint32_t flags, uint32_t msw_ts,
 	      uint32_t lsw_ts);
 int q6asm_run_nowait(struct audio_client *ac, uint32_t flags, uint32_t msw_ts,
-- 
2.24.1

