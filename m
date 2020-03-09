Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF8517D865
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 05:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgCIEFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 00:05:32 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35004 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgCIEFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 00:05:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0282E1A16FB;
        Mon,  9 Mar 2020 05:05:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E64F21A1738;
        Mon,  9 Mar 2020 05:05:22 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 52801402A5;
        Mon,  9 Mar 2020 12:05:14 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/7] ASoC: fsl-asoc-card: Support new property fsl,asrc-format
Date:   Mon,  9 Mar 2020 11:58:29 +0800
Message-Id: <266dccc836c11165ad91a301f24fe4f7ad2557be.1583725533.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1583725533.git.shengjiu.wang@nxp.com>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1583725533.git.shengjiu.wang@nxp.com>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to align with new ESARC, we add new property fsl,asrc-format.
The fsl,asrc-format can replace the fsl,asrc-width, driver
can accept format from devicetree, don't need to convert it to
format through width.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 9ce55feaac22..32101b9a37b9 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -680,17 +680,19 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 			goto asrc_fail;
 		}
 
-		ret = of_property_read_u32(asrc_np, "fsl,asrc-width", &width);
+		ret = of_property_read_u32(asrc_np, "fsl,asrc-format", &priv->asrc_format);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to get output rate\n");
-			ret = -EINVAL;
-			goto asrc_fail;
-		}
+			ret = of_property_read_u32(asrc_np, "fsl,asrc-width", &width);
+			if (ret) {
+				dev_err(&pdev->dev, "failed to get output width\n");
+				return ret;
+			}
 
-		if (width == 24)
-			priv->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
-		else
-			priv->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
+			if (width == 24)
+				priv->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
+			else
+				priv->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
+		}
 	}
 
 	/* Finish card registering */
-- 
2.21.0

