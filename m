Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665301115D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 04:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfEBCTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 22:19:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56422 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfEBCTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=s/aeLHmcSaCGZGW2T/ryaeA0ktI3wfHggwlvpiCdiGs=; b=pBr7tviub0M4
        Y7B+GAiIE0/H/6glIphSg1+JN79huRE/j+YTI3NQ8U8Ngjerot3AmpFSTaWjMQnGMlH6D7sZc9AUF
        3KdkDIC/cUuL6ULBrrDQkXR65KG+hNHiJxGyDwLWrIXCheEHEoXTtb4tYDKdoVda2u6WvOL4XHiHy
        b4dDw=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1J8-0005tL-2M; Thu, 02 May 2019 02:18:46 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 03B03441D3B; Thu,  2 May 2019 03:18:43 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        festevam@gmail.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com,
        perex@perex.cz, timur@kernel.org, tiwai@suse.com,
        Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_micfil: Remove set but not used variable 'osr'" to the asoc tree
In-Reply-To:  <20190417150915.37968-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021843.03B03441D3B@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:42 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_micfil: Remove set but not used variable 'osr'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From a0c34c7629bee46ffd8121987d27df25a6433cc7 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 17 Apr 2019 23:09:15 +0800
Subject: [PATCH] ASoC: fsl_micfil: Remove set but not used variable 'osr'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/fsl/fsl_micfil.c: In function 'get_clk_div':
sound/soc/fsl/fsl_micfil.c:154:6: warning: variable 'osr' set but not used [-Wunused-but-set-variable]

It is never used since introduction in
commit 47a70e6fc9a8 ("ASoC: Add MICFIL SoC Digital Audio Interface driver.")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_micfil.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 40c07e756481..f7f2d29f1bfe 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -151,12 +151,9 @@ static inline int get_clk_div(struct fsl_micfil *micfil,
 {
 	u32 ctrl2_reg;
 	long mclk_rate;
-	int osr;
 	int clk_div;
 
 	regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
-	osr = 16 - ((ctrl2_reg & MICFIL_CTRL2_CICOSR_MASK)
-		    >> MICFIL_CTRL2_CICOSR_SHIFT);
 
 	mclk_rate = clk_get_rate(micfil->mclk);
 
-- 
2.20.1

