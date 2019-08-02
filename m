Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687E98008E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 21:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfHBTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 15:00:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40658 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfHBTAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2MTBTXM1Lg5vogB4evU1IwkNP6cSEKbLGHBZeFAtHlA=; b=q/JOmaCHOITS
        elP6G1oTsXB2kg22rxY6jvkIu7JkJ9A2lddpuLb3P11ZfRPHF5YXWxypj1MruMKHNJOTV9zRvuZE1
        9cVyoLgASHKNrSpiyhmQ2SAmX/UzejFdOLj5B2eSXUeidSi+EW04tqka7hkcRkmJCQvYTqhT1SSpy
        s12VI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htcmq-0000AB-7c; Fri, 02 Aug 2019 19:00:20 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6070B2742E86; Fri,  2 Aug 2019 20:00:19 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Alexander.Deucher@amd.com, alsa-devel@alsa-project.org,
        "Cc:"@sirena.org.uk, "Cc:"@sirena.org.uk,
        Colin Ian King <colin.king@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        moderated@sirena.org.uk, "list:SOUND"@sirena.org.uk,
        -@sirena.org.uk, SOC@sirena.org.uk, LAYER@sirena.org.uk,
        /@sirena.org.uk, DYNAMIC@sirena.org.uk,
        open list <linux-kernel@vger.kernel.org>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Applied "ASoC: amd: acp3x: use dma_ops of parent device for acp3x dma driver" to the asoc tree
In-Reply-To: <1564753899-17124-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Patchwork-Hint: ignore
Message-Id: <20190802190019.6070B2742E86@ypsilon.sirena.org.uk>
Date:   Fri,  2 Aug 2019 20:00:19 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: acp3x: use dma_ops of parent device for acp3x dma driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 88639051017fb61a414b636dd0fc490da2b62b64 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Fri, 2 Aug 2019 19:21:23 +0530
Subject: [PATCH] ASoC: amd: acp3x: use dma_ops of parent device for acp3x dma
 driver

AMD platform device acp3x_rv_i2s created by parent PCI device
driver. Pass struct device of the parent to
snd_pcm_lib_preallocate_pages() so dma_alloc_coherent() can use
correct dma_ops. Otherwise, it will use default dma_ops which
is nommu_dma_ops on x86_64 even when IOMMU is enabled and
set to non passthrough mode.

Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Link: https://lore.kernel.org/r/1564753899-17124-1-git-send-email-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index a4ade6bb5beb..905ed2f1861b 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -385,9 +385,11 @@ static snd_pcm_uframes_t acp3x_dma_pointer(struct snd_pcm_substream *substream)
 
 static int acp3x_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
+								    DRV_NAME);
+	struct device *parent = component->dev->parent;
 	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
-					      rtd->pcm->card->dev,
-					      MIN_BUFFER, MAX_BUFFER);
+					      parent, MIN_BUFFER, MAX_BUFFER);
 	return 0;
 }
 
-- 
2.20.1

