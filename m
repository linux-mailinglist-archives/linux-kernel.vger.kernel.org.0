Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C93811163
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 04:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfEBCTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 22:19:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56216 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfEBCS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=L9kr2PyDG3ONEeQqCQol/NtkqBAJzA6CBfbpNXHI7e8=; b=NRigOCsL9VTh
        hIVKdYkuZzJPn5rhWY3aLBT5Q7sVYIvQYAl0imp0EmDf9xmXfmvh1vb7Uhohndl5WIWVFn1GVY83x
        viLsYljAkYFXpwzaCc18jFOfNVXDC2MNomP95SFTEjgyOKlAC4GhiiOfNSsVtORa5N8o/ycSAgCSs
        wnqqM=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1J5-0005t8-SH; Thu, 02 May 2019 02:18:44 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C9330441D3C; Thu,  2 May 2019 03:18:40 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, nh6z@nh6z.net, perex@perex.cz,
        tiwai@suse.com
Subject: Applied "ASoC: tlv320aic32x4: Remove set but not used variable 'mclk_rate'" to the asoc tree
In-Reply-To:  <20190417150157.24044-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021840.C9330441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:40 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320aic32x4: Remove set but not used variable 'mclk_rate'

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

From 83b4f50ca2b2e93346195b51f58e8089f9f35c0b Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 17 Apr 2019 23:01:57 +0800
Subject: [PATCH] ASoC: tlv320aic32x4: Remove set but not used variable
 'mclk_rate'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/codecs/tlv320aic32x4.c: In function 'aic32x4_setup_clocks':
sound/soc/codecs/tlv320aic32x4.c:669:16: warning: variable 'mclk_rate' set but not used [-Wunused-but-set-variable]

It is not used since introduction in
commit 96c3bb00239d ("ASoC: tlv320aic32x4: Dynamically Determine Clocking")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 6edee05ff9f0..83608f386aef 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -684,9 +684,8 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	u8 madc, nadc, mdac, ndac, max_nadc, min_mdac, max_ndac;
 	u8 dosr_increment;
 	u16 max_dosr, min_dosr;
-	unsigned long mclk_rate, adc_clock_rate, dac_clock_rate;
+	unsigned long adc_clock_rate, dac_clock_rate;
 	int ret;
-	struct clk *mclk;
 
 	struct clk_bulk_data clocks[] = {
 		{ .id = "pll" },
@@ -700,9 +699,6 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	mclk = clk_get_parent(clocks[1].clk);
-	mclk_rate = clk_get_rate(mclk);
-
 	if (sample_rate <= 48000) {
 		aosr = 128;
 		adc_resource_class = 6;
-- 
2.20.1

