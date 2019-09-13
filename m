Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEA7B2608
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 21:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfIMT2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 15:28:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41876 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbfIMT2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:28:14 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6482E1A073C;
        Fri, 13 Sep 2019 21:28:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5730D1A0352;
        Fri, 13 Sep 2019 21:28:12 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C9E43205DB;
        Fri, 13 Sep 2019 21:28:11 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 3/3] ASoC: fsl_sai: Fix TCSR.TE/RCSR.RE in synchronous mode
Date:   Fri, 13 Sep 2019 22:28:07 +0300
Message-Id: <20190913192807.8423-4-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913192807.8423-1-daniel.baluta@nxp.com>
References: <20190913192807.8423-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAI transmitter and receiver can be configured to operate with
synchronous bit clock and frame sync.

When Tx is synchronous with receiver RCSR.RE should be set in playback
to enable the receiver which provides bit clock and frame sync.

When Rx is synchronous with transmitter TCSR.TE should be set in record
to enable the transmitter which provides bit clock and frame sync.

Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1: 
* new patch

 sound/soc/fsl/fsl_sai.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 6598a1ae0a2d..a59300e37549 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -539,8 +539,8 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 			   sai->synchronous[RX] ? FSL_SAI_CR2_SYNC : 0);
 
 	/*
-	 * It is recommended that the transmitter is the last enabled
-	 * and the first disabled.
+	 * it is recommended that the asynchronous block to be the last enabled
+	 * and the first disabled
 	 */
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -549,9 +549,11 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
 				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
 
-		regmap_update_bits(sai->regmap, FSL_SAI_RCSR(ofs),
-				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
-		regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs),
+		if (sai->synchronous[tx])
+			regmap_update_bits(sai->regmap, FSL_SAI_xCSR(!tx, ofs),
+					   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
+
+		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
 				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
 
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
-- 
2.17.1

