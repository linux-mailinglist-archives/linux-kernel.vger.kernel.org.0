Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B187078122
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfG1TZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 15:25:14 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38896 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfG1TYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:24:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A93C1A123B;
        Sun, 28 Jul 2019 21:24:48 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D9831A1232;
        Sun, 28 Jul 2019 21:24:48 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BB23E2060A;
        Sun, 28 Jul 2019 21:24:47 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, viorel.suman@nxp.com,
        timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca,
        tiwai@suse.com, nicoleotsuka@gmail.com, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 3/7] ASoC: fsl_sai: Add support to enable multiple data lines
Date:   Sun, 28 Jul 2019 22:24:25 +0300
Message-Id: <20190728192429.1514-4-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728192429.1514-1-daniel.baluta@nxp.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAI supports up to 8 Rx/Tx data lines which can be enabled
using TCE/RCE bits of TCR3/RCR3 registers.

Data lines to be enabled are read from DT fsl,dl-mask property.
By default (if no DT entry is provided) only data line 0 is enabled.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 11 ++++++++++-
 sound/soc/fsl/fsl_sai.h |  4 +++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 637b1d12a575..5e7cb7fd29f5 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -601,7 +601,7 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
 			   FSL_SAI_CR3_TRCE_MASK,
-			   FSL_SAI_CR3_TRCE);
+			   FSL_SAI_CR3_TRCE(sai->soc_data->dl_mask[tx]);
 
 	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
@@ -888,6 +888,15 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * active data lines mask for TX/RX, defaults to 1 (only the first
+	 * data line is enabled
+	 */
+	sai->dl_mask[RX] = 1;
+	sai->dl_mask[TX] = 1;
+	of_property_read_u32_index(np, "fsl,dl-mask", RX, &sai->dl_mask[RX]);
+	of_property_read_u32_index(np, "fsl,dl-mask", TX, &sai->dl_mask[TX]);
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 20c5b9b1e8bc..6d32f0950ec5 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -109,7 +109,7 @@
 #define FSL_SAI_CR2_DIV_MASK	0xff
 
 /* SAI Transmit and Receive Configuration 3 Register */
-#define FSL_SAI_CR3_TRCE	BIT(16)
+#define FSL_SAI_CR3_TRCE(x)	((x) << 16)
 #define FSL_SAI_CR3_TRCE_MASK	GENMASK(23, 16)
 #define FSL_SAI_CR3_WDFL(x)	(x)
 #define FSL_SAI_CR3_WDFL_MASK	0x1f
@@ -176,6 +176,8 @@ struct fsl_sai {
 	unsigned int slots;
 	unsigned int slot_width;
 
+	unsigned int dl_mask[2];
+
 	const struct fsl_sai_soc_data *soc_data;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
-- 
2.17.1

