Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52920BEA26
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 03:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbfIZBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 21:31:47 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45556 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfIZBbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:31:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F62C1A04E6;
        Thu, 26 Sep 2019 03:31:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B83BD1A08E8;
        Thu, 26 Sep 2019 03:31:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7DB99402D5;
        Thu, 26 Sep 2019 09:31:29 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, lars@metafoo.de
Subject: [PATCH V5 2/4] ASoC: fsl_asrc: update supported sample format
Date:   Thu, 26 Sep 2019 09:29:49 +0800
Message-Id: <45a7c383f43cc1dd9d0934846447aee653278c03.1569387932.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1569387932.git.shengjiu.wang@nxp.com>
References: <cover.1569387932.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1569387932.git.shengjiu.wang@nxp.com>
References: <cover.1569387932.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASRC support 24bit/16bit/8bit input width, which is
data width, not slot width.

For the S20_3LE format, the data with is 20bit, slot width
is 24bit, if we set ASRMCR1n.IWD to be 24bits, the result
is the volume is lower than expected, it likes 24bit data
right shift 4 bits

So replace S20_3LE with S24_3LE in supported list and add S8
format in TX supported list

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 4d3804a1ea55..584badf956d2 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -624,7 +624,7 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
 
 #define FSL_ASRC_FORMATS	(SNDRV_PCM_FMTBIT_S24_LE | \
 				 SNDRV_PCM_FMTBIT_S16_LE | \
-				 SNDRV_PCM_FMTBIT_S20_3LE)
+				 SNDRV_PCM_FMTBIT_S24_3LE)
 
 static struct snd_soc_dai_driver fsl_asrc_dai = {
 	.probe = fsl_asrc_dai_probe,
@@ -635,7 +635,8 @@ static struct snd_soc_dai_driver fsl_asrc_dai = {
 		.rate_min = 5512,
 		.rate_max = 192000,
 		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_ASRC_FORMATS,
+		.formats = FSL_ASRC_FORMATS |
+			   SNDRV_PCM_FMTBIT_S8,
 	},
 	.capture = {
 		.stream_name = "ASRC-Capture",
-- 
2.21.0

