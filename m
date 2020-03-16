Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801291864CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 06:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgCPFzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 01:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgCPFzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 01:55:39 -0400
Received: from vkoul-mobl.Dlink (unknown [49.207.58.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0DF420663;
        Mon, 16 Mar 2020 05:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584338138;
        bh=KVsBTWdSRrwp2b8W6rCdYOvr/IzqmQADneGKlr7H/g0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0w7pbpmkls6dsefsAlcheIgAi0AH4ZsfmGii5dDjOFo+/I96/S2kD1cn3I8kEY6L
         jY/TI2e+3H7iCs+/UJP80CrWEsKgec6pwBWJKayidfVOO7+xvhO7jPkIWcpNe1323z
         wDXIgegrlDGUgmf9DtFqlOhhI4ATZrnrEK3GkHnk=
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
Subject: [PATCH v3 5/9] ASoC: qcom: q6asm-dai: add support to wma decoder
Date:   Mon, 16 Mar 2020 11:22:17 +0530
Message-Id: <20200316055221.1944464-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316055221.1944464-1-vkoul@kernel.org>
References: <20200316055221.1944464-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm DSPs also supports the wma decoder, so add support for wma
decoder and convert the snd_codec_params to qdsp format.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 67 +++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 8f245d03b6f5..53c250778eea 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -627,10 +627,13 @@ static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
 	int dir = stream->direction;
 	struct q6asm_dai_data *pdata;
 	struct q6asm_flac_cfg flac_cfg;
+	struct q6asm_wma_cfg wma_cfg;
+	unsigned int wma_v9 = 0;
 	struct device *dev = c->dev;
 	int ret;
 	union snd_codec_options *codec_options;
 	struct snd_dec_flac *flac;
+	struct snd_dec_wma *wma;
 
 	codec_options = &(prtd->codec_param.codec.options);
 
@@ -692,6 +695,67 @@ static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
 			return -EIO;
 		}
 		break;
+
+	case SND_AUDIOCODEC_WMA:
+		wma = &codec_options->wma_d;
+
+		memset(&wma_cfg, 0x0, sizeof(struct q6asm_wma_cfg));
+
+		wma_cfg.sample_rate =  params->codec.sample_rate;
+		wma_cfg.num_channels = params->codec.ch_in;
+		wma_cfg.bytes_per_sec = params->codec.bit_rate / 8;
+		wma_cfg.block_align = params->codec.align;
+		wma_cfg.bits_per_sample = prtd->bits_per_sample;
+		wma_cfg.enc_options = wma->encoder_option;
+		wma_cfg.adv_enc_options = wma->adv_encoder_option;
+		wma_cfg.adv_enc_options2 = wma->adv_encoder_option2;
+
+		if (wma_cfg.num_channels == 1)
+			wma_cfg.channel_mask = 4; /* Mono Center */
+		else if (wma_cfg.num_channels == 2)
+			wma_cfg.channel_mask = 3; /* Stereo FL/FR */
+		else
+			return -EINVAL;
+
+		/* check the codec profile */
+		switch (params->codec.profile) {
+		case SND_AUDIOPROFILE_WMA9:
+			wma_cfg.fmtag = 0x161;
+			wma_v9 = 1;
+			break;
+
+		case SND_AUDIOPROFILE_WMA10:
+			wma_cfg.fmtag = 0x166;
+			break;
+
+		case SND_AUDIOPROFILE_WMA9_PRO:
+			wma_cfg.fmtag = 0x162;
+			break;
+
+		case SND_AUDIOPROFILE_WMA9_LOSSLESS:
+			wma_cfg.fmtag = 0x163;
+			break;
+
+		case SND_AUDIOPROFILE_WMA10_LOSSLESS:
+			wma_cfg.fmtag = 0x167;
+			break;
+
+		default:
+			dev_err(dev, "Unknown WMA profile:%x\n",
+				params->codec.profile);
+			return -EIO;
+		}
+
+		if (wma_v9)
+			ret = q6asm_stream_media_format_block_wma_v9(
+					prtd->audio_client, &wma_cfg);
+		else
+			ret = q6asm_stream_media_format_block_wma_v10(
+					prtd->audio_client, &wma_cfg);
+		if (ret < 0) {
+			dev_err(dev, "WMA9 CMD failed:%d\n", ret);
+			return -EIO;
+		}
 	default:
 		break;
 	}
@@ -791,9 +855,10 @@ static int q6asm_dai_compr_get_caps(struct snd_compr_stream *stream,
 	caps->max_fragment_size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE;
 	caps->min_fragments = COMPR_PLAYBACK_MIN_NUM_FRAGMENTS;
 	caps->max_fragments = COMPR_PLAYBACK_MAX_NUM_FRAGMENTS;
-	caps->num_codecs = 2;
+	caps->num_codecs = 3;
 	caps->codecs[0] = SND_AUDIOCODEC_MP3;
 	caps->codecs[1] = SND_AUDIOCODEC_FLAC;
+	caps->codecs[2] = SND_AUDIOCODEC_WMA;
 
 	return 0;
 }
-- 
2.24.1

