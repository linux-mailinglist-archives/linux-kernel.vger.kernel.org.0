Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F03F103C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbfKFH3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 02:29:24 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40496 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbfKFH3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:29:23 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 16AB42001C8;
        Wed,  6 Nov 2019 08:29:21 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8CC4E20013E;
        Wed,  6 Nov 2019 08:29:16 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AD12340285;
        Wed,  6 Nov 2019 15:29:10 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_audmix: Add spin lock to protect tdms
Date:   Wed,  6 Nov 2019 15:27:45 +0800
Message-Id: <1573025265-31852-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audmix support two substream, When two substream start
to run, the trigger function may be called by two substream
in same time, that the priv->tdms may be updated wrongly.

The expected priv->tdms is 0x3, but sometimes the
result is 0x2, or 0x1.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_audmix.c | 6 ++++++
 sound/soc/fsl/fsl_audmix.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index c7e4e9757dce..a1db1bce330f 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -286,6 +286,7 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 				  struct snd_soc_dai *dai)
 {
 	struct fsl_audmix *priv = snd_soc_dai_get_drvdata(dai);
+	unsigned long lock_flags;
 
 	/* Capture stream shall not be handled */
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
@@ -295,12 +296,16 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		spin_lock_irqsave(&priv->lock, lock_flags);
 		priv->tdms |= BIT(dai->driver->id);
+		spin_unlock_irqrestore(&priv->lock, lock_flags);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		spin_lock_irqsave(&priv->lock, lock_flags);
 		priv->tdms &= ~BIT(dai->driver->id);
+		spin_unlock_irqrestore(&priv->lock, lock_flags);
 		break;
 	default:
 		return -EINVAL;
@@ -491,6 +496,7 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->ipg_clk);
 	}
 
+	spin_lock_init(&priv->lock);
 	platform_set_drvdata(pdev, priv);
 	pm_runtime_enable(dev);
 
diff --git a/sound/soc/fsl/fsl_audmix.h b/sound/soc/fsl/fsl_audmix.h
index 7812ffec45c5..479f05695d53 100644
--- a/sound/soc/fsl/fsl_audmix.h
+++ b/sound/soc/fsl/fsl_audmix.h
@@ -96,6 +96,7 @@ struct fsl_audmix {
 	struct platform_device *pdev;
 	struct regmap *regmap;
 	struct clk *ipg_clk;
+	spinlock_t lock; /* Protect tdms */
 	u8 tdms;
 };
 
-- 
2.21.0

