Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50032B790C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390255AbfISMN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 08:13:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45830 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390226AbfISMNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:13:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 33D291A0084;
        Thu, 19 Sep 2019 14:13:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 08B9A1A01CD;
        Thu, 19 Sep 2019 14:13:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5A9DC40309;
        Thu, 19 Sep 2019 20:13:04 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: [PATCH V3 4/4] ASoC: fsl_asrc: Fix error with S24_3LE format bitstream in i.MX8
Date:   Thu, 19 Sep 2019 20:11:42 +0800
Message-Id: <0fe619f4c8f0898cf51c7324c9a0784c5782ed91.1568861098.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1568861098.git.shengjiu.wang@nxp.com>
References: <cover.1568861098.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1568861098.git.shengjiu.wang@nxp.com>
References: <cover.1568861098.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is error "aplay: pcm_write:2023: write error: Input/output error"
on i.MX8QM/i.MX8QXP platform for S24_3LE format.

In i.MX8QM/i.MX8QXP, the DMA is EDMA, which don't support 24bit
sample, but we didn't add any constraint, that cause issues.

So we need to query the caps of dma, then update the hw parameters
according to the caps.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c     |  4 +--
 sound/soc/fsl/fsl_asrc.h     |  3 +++
 sound/soc/fsl/fsl_asrc_dma.c | 52 +++++++++++++++++++++++++++++++-----
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 584badf956d2..0bf91a6f54b9 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -115,7 +115,7 @@ static void fsl_asrc_sel_proc(int inrate, int outrate,
  * within range [ANCA, ANCA+ANCB-1], depends on the channels of pair A
  * while pair A and pair C are comparatively independent.
  */
-static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
+int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
 {
 	enum asrc_pair_index index = ASRC_INVALID_PAIR;
 	struct fsl_asrc *asrc_priv = pair->asrc_priv;
@@ -158,7 +158,7 @@ static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair)
  *
  * It clears the resource from asrc_priv and releases the occupied channels.
  */
-static void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
+void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
 {
 	struct fsl_asrc *asrc_priv = pair->asrc_priv;
 	enum asrc_pair_index index = pair->index;
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 38af485bdd22..2b57e8c53728 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -462,4 +462,7 @@ struct fsl_asrc {
 #define DRV_NAME "fsl-asrc-dai"
 extern struct snd_soc_component_driver fsl_asrc_component;
 struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir);
+int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pair);
+void fsl_asrc_release_pair(struct fsl_asrc_pair *pair);
+
 #endif /* _FSL_ASRC_H */
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 01052a0808b0..c1c8ee4aca54 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -16,13 +16,11 @@
 
 #define FSL_ASRC_DMABUF_SIZE	(256 * 1024)
 
-static const struct snd_pcm_hardware snd_imx_hardware = {
+static struct snd_pcm_hardware snd_imx_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP |
-		SNDRV_PCM_INFO_MMAP_VALID |
-		SNDRV_PCM_INFO_PAUSE |
-		SNDRV_PCM_INFO_RESUME,
+		SNDRV_PCM_INFO_MMAP_VALID,
 	.buffer_bytes_max = FSL_ASRC_DMABUF_SIZE,
 	.period_bytes_min = 128,
 	.period_bytes_max = 65535, /* Limited by SDMA engine */
@@ -276,6 +274,11 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
 	struct device *dev = component->dev;
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
 	struct fsl_asrc_pair *pair;
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	u8 dir = tx ? OUT : IN;
+	struct dma_chan *tmp_chan;
+	struct snd_dmaengine_dai_dma_data *dma_data;
+	int ret;
 
 	pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
 	if (!pair)
@@ -285,9 +288,44 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
 
 	runtime->private_data = pair;
 
-	snd_pcm_hw_constraint_integer(substream->runtime,
-				      SNDRV_PCM_HW_PARAM_PERIODS);
-	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(dev, "failed to set pcm hw params periods\n");
+		return ret;
+	}
+
+	/* Request a temp pair, which is release in the end */
+	ret = fsl_asrc_request_pair(1, pair);
+	if (ret < 0) {
+		dev_err(dev, "failed to request asrc pair\n");
+		return ret;
+	}
+
+	tmp_chan = fsl_asrc_get_dma_channel(pair, dir);
+	if (!tmp_chan) {
+		dev_err(dev, "can't get dma channel\n");
+		return -EINVAL;
+	}
+
+	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
+
+	ret = snd_dmaengine_pcm_refine_runtime_hwparams(substream,
+							dma_data,
+							&snd_imx_hardware,
+							tmp_chan);
+	if (ret < 0) {
+		dev_err(dev, "failed to set runtime hwparams\n");
+		return ret;
+	}
+
+	ret = snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
+	if (ret)
+		return ret;
+
+	dma_release_channel(tmp_chan);
+	fsl_asrc_release_pair(pair);
+
 
 	return 0;
 }
-- 
2.21.0

