Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9622714432D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 18:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgAUR3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 12:29:00 -0500
Received: from foss.arm.com ([217.140.110.172]:46508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAUR27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:28:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2A5130E;
        Tue, 21 Jan 2020 09:28:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52D533F6C4;
        Tue, 21 Jan 2020 09:28:58 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:28:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        John Stultz <john.stultz@linaro.org>, john.stultz@linaro.org,
        lars@metafoo.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: soc-generic-dmaengine-pcm: Fix error handling" to the asoc tree
In-Reply-To: <1579505286-32085-1-git-send-email-shengjiu.wang@nxp.com>
Message-Id: <applied-1579505286-32085-1-git-send-email-shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-generic-dmaengine-pcm: Fix error handling

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 130128098a4e5ce9a0dfbdf9a7e27a43579901fd Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Mon, 20 Jan 2020 15:28:06 +0800
Subject: [PATCH] ASoC: soc-generic-dmaengine-pcm: Fix error handling

Remove the return value checking, that is to align with the code
before adding snd_dmaengine_pcm_refine_runtime_hwparams function.

Otherwise it causes a regression on the HiKey board:

[   17.721424] hi6210_i2s f7118000.i2s: ASoC: can't open component f7118000.i2s: -6

Fixes: e957204e732b ("ASoC: pcm_dmaengine: Extract snd_dmaengine_pcm_refine_runtime_hwparams")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reported-by: John Stultz <john.stultz@linaro.org>
Link: https://lore.kernel.org/r/1579505286-32085-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index a428ff393ea2..2b5f3b1b062b 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -117,7 +117,6 @@ dmaengine_pcm_set_runtime_hwparams(struct snd_soc_component *component,
 	struct dma_chan *chan = pcm->chan[substream->stream];
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct snd_pcm_hardware hw;
-	int ret;
 
 	if (pcm->config && pcm->config->pcm_hardware)
 		return snd_soc_set_runtime_hwparams(substream,
@@ -138,12 +137,15 @@ dmaengine_pcm_set_runtime_hwparams(struct snd_soc_component *component,
 	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
 		hw.info |= SNDRV_PCM_INFO_BATCH;
 
-	ret = snd_dmaengine_pcm_refine_runtime_hwparams(substream,
-							dma_data,
-							&hw,
-							chan);
-	if (ret)
-		return ret;
+	/**
+	 * FIXME: Remove the return value check to align with the code
+	 * before adding snd_dmaengine_pcm_refine_runtime_hwparams
+	 * function.
+	 */
+	snd_dmaengine_pcm_refine_runtime_hwparams(substream,
+						  dma_data,
+						  &hw,
+						  chan);
 
 	return snd_soc_set_runtime_hwparams(substream, &hw);
 }
-- 
2.20.1

