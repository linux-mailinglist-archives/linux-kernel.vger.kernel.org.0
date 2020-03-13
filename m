Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5346D1844A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 11:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCMKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 06:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgCMKQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:16:54 -0400
Received: from localhost.localdomain (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42EA12074A;
        Fri, 13 Mar 2020 10:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584094613;
        bh=rfa/ArgLgaz92yJLGY97fFpfRcmpI+tJU0aLfsmPz08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iznt9oKjV/txCuMtzfiN92ytAPVBcYydY+nOW2W+X/bC1TEcaFrDFtg+JrKGWQfHd
         jFj4YpIWAGi/C7NasJWRB02E4YEP4z9mTAhvNGj4pCL1aSVdWASt1mw98JT3bLVQoq
         wf8oNsCvJqLsQ+C64tNxAW22e0XG6WA0UOWkspgw=
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
Subject: [RESEND PATCH v2 3/9] ASoC: qcom: q6asm: pass codec profile to q6asm_open_write
Date:   Fri, 13 Mar 2020 15:46:21 +0530
Message-Id: <20200313101627.1561365-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313101627.1561365-1-vkoul@kernel.org>
References: <20200313101627.1561365-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Codec profile is required to be passed for WMA codecs so that we know
the codec profile present and tell DSP accordingly, so update this API
to pass the codec profile as argument

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 ++--
 sound/soc/qcom/qdsp6/q6asm.c     | 2 +-
 sound/soc/qcom/qdsp6/q6asm.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index c0d422d0ab94..8f245d03b6f5 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -250,7 +250,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		ret = q6asm_open_write(prtd->audio_client, FORMAT_LINEAR_PCM,
-				       prtd->bits_per_sample);
+				       0, prtd->bits_per_sample);
 	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		ret = q6asm_open_read(prtd->audio_client, FORMAT_LINEAR_PCM,
 				       prtd->bits_per_sample);
@@ -652,7 +652,7 @@ static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
 	prtd->bits_per_sample = 16;
 	if (dir == SND_COMPRESS_PLAYBACK) {
 		ret = q6asm_open_write(prtd->audio_client, params->codec.id,
-					prtd->bits_per_sample);
+				params->codec.profile, prtd->bits_per_sample);
 
 		if (ret < 0) {
 			dev_err(dev, "q6asm_open_write failed\n");
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 36e0eab13a98..64eb7b6ba305 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -858,7 +858,7 @@ static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
  * Return: Will be an negative value on error or zero on success
  */
 int q6asm_open_write(struct audio_client *ac, uint32_t format,
-		     uint16_t bits_per_sample)
+		     u32 codec_profile, uint16_t bits_per_sample)
 {
 	struct asm_stream_cmd_open_write_v3 *open;
 	struct apr_pkt *pkt;
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index 6764f55f7078..1cff7f68b95d 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -55,7 +55,7 @@ void q6asm_audio_client_free(struct audio_client *ac);
 int q6asm_write_async(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
 		       uint32_t lsw_ts, uint32_t flags);
 int q6asm_open_write(struct audio_client *ac, uint32_t format,
-		     uint16_t bits_per_sample);
+		     u32 codec_profile, uint16_t bits_per_sample);
 
 int q6asm_open_read(struct audio_client *ac, uint32_t format,
 		     uint16_t bits_per_sample);
-- 
2.24.1

