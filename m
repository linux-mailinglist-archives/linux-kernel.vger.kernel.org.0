Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735B3567A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfFZLdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 07:33:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53680 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfFZLdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KVT3HptzEAw2nCx6oohu1t8YhQ782ZH7OuAIVwdBjjQ=; b=FxcQWdPMJLmR
        HG8OKmxGe3Z2aEIdkfuilC/uUKHKDfEV/tDnYkpc5RwcEViSb8Vfhk3dRmPAjky8oycPZMM/0smN+
        XIWQByZxJlwjD5C5auPcdqxRA0tXW3CPVKUhaC4eNRH5v5JJLNyxb3HGXPBEq3HZR1uIrS/vuXloK
        0cL7Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hg6AO-0007my-Ss; Wed, 26 Jun 2019 11:32:44 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 65B7144004C; Wed, 26 Jun 2019 12:32:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>, lars@metafoo.de,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: codecs: ad193x: Fix memory corruption on BE 64b systems" to the asoc tree
In-Reply-To: <20190626104947.26547-1-codrin.ciubotariu@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190626113244.65B7144004C@finisterre.sirena.org.uk>
Date:   Wed, 26 Jun 2019 12:32:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: ad193x: Fix memory corruption on BE 64b systems

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From da7260cc8d1dc3564eb4f33550b0525541d71a47 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Wed, 26 Jun 2019 13:49:46 +0300
Subject: [PATCH] ASoC: codecs: ad193x: Fix memory corruption on BE 64b systems

Since change_bit() requires unsigned long*, making this cast on an
unsigned int variable will change a wrong bit on BE platforms, causing
memory corruption. Replace this function with a simple XOR.

Fixes: 90f6e6803139 ("ASoC: codecs: ad193x: Fix frame polarity for DSP_A format")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 96d7cb2e4a56..16e2d334bbe0 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -241,10 +241,8 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	/* For DSP_*, LRCLK's polarity must be inverted */
-	if (fmt & SND_SOC_DAIFMT_DSP_A) {
-		change_bit(ffs(AD193X_DAC_LEFT_HIGH) - 1,
-			   (unsigned long *)&dac_fmt);
-	}
+	if (fmt & SND_SOC_DAIFMT_DSP_A)
+		dac_fmt ^= AD193X_DAC_LEFT_HIGH;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & frm master */
-- 
2.20.1

