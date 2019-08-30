Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77367A400B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 23:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfH3V7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 17:59:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52664 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbfH3V7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:59:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0D4420079F;
        Fri, 30 Aug 2019 23:59:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E48EC20043B;
        Fri, 30 Aug 2019 23:59:12 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FC0F2061E;
        Fri, 30 Aug 2019 23:59:12 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     festevam@gmail.com, shengjiu.wang@nxp.com, Xiubo.Lee@gmail.com,
        nicoleotsuka@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Viorel Suman <viorel.suman@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: fsl_sai: Implement set_bclk_ratio
Date:   Sat, 31 Aug 2019 00:59:10 +0300
Message-Id: <20190830215910.31590-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

This is to allow machine drivers to set a certain bitclk rate
which might not be exactly rate * frame size.

Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 21 +++++++++++++++++++--
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index fe126029f4e3..e896b577b1f7 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -137,6 +137,16 @@ static int fsl_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	return 0;
 }
 
+static int fsl_sai_set_dai_bclk_ratio(struct snd_soc_dai *dai,
+				      unsigned int ratio)
+{
+	struct fsl_sai *sai = snd_soc_dai_get_drvdata(dai);
+
+	sai->bclk_ratio = ratio;
+
+	return 0;
+}
+
 static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int fsl_dir)
 {
@@ -423,8 +433,14 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		slot_width = sai->slot_width;
 
 	if (!sai->is_slave_mode) {
-		ret = fsl_sai_set_bclk(cpu_dai, tx,
-				slots * slot_width * params_rate(params));
+		if (sai->bclk_ratio)
+			ret = fsl_sai_set_bclk(cpu_dai, tx,
+					       sai->bclk_ratio *
+					       params_rate(params));
+		else
+			ret = fsl_sai_set_bclk(cpu_dai, tx,
+					       slots * slot_width *
+					       params_rate(params));
 		if (ret)
 			return ret;
 
@@ -640,6 +656,7 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
+	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt,
 	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 3a3f6f8e5595..f96f8d97489d 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -177,6 +177,7 @@ struct fsl_sai {
 	unsigned int mclk_streams;
 	unsigned int slots;
 	unsigned int slot_width;
+	unsigned int bclk_ratio;
 
 	const struct fsl_sai_soc_data *soc_data;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
-- 
2.17.1

