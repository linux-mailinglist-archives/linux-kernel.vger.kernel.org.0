Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE60EC3327
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 13:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbfJALmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 07:42:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40542 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbfJALk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZGl+hCx9u/66B7tvLuoBxNOYAm3sNLNizym3DyA34fs=; b=hGjRKc5zycsW
        CPYR6e2IPZO68ULxAdUEptle9zMo6ktB6gTeZN86uQWLQ4iVEKZEigYGKtttEjR7sSsQKLZ/KP22R
        7ZyAUeZCqjf7oMOM/yuNvXGODmDMdVJqWWQ36VEJcL+V/JqscXWamMcrPTdbZOi3CfdTUZQ9iUSVy
        W19ro=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWO-0004T4-8k; Tue, 01 Oct 2019 11:40:48 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AA2AA2742A10; Tue,  1 Oct 2019 12:40:47 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt5663: clean up indentation issues" to the asoc tree
In-Reply-To: <20190925100330.20695-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114047.AA2AA2742A10@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:47 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5663: clean up indentation issues

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

From bd1468f252e85280b71a069a2255842d78133cc4 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 25 Sep 2019 11:03:30 +0100
Subject: [PATCH] ASoC: rt5663: clean up indentation issues

There are two break statements that are indented one level too deeply,
remove the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190925100330.20695-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 2943692f66ed..e6c1ec6c426e 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3644,7 +3644,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5663->regmap, RT5663_PWR_ANLG_1,
 			RT5663_LDO1_DVO_MASK | RT5663_AMP_HP_MASK,
 			RT5663_LDO1_DVO_0_9V | RT5663_AMP_HP_3X);
-			break;
+		break;
 	case CODEC_VER_0:
 		regmap_update_bits(rt5663->regmap, RT5663_DIG_MISC,
 			RT5663_DIG_GATE_CTRL_MASK, RT5663_DIG_GATE_CTRL_EN);
@@ -3663,7 +3663,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5663->regmap, RT5663_TDM_2,
 			RT5663_DATA_SWAP_ADCDAT1_MASK,
 			RT5663_DATA_SWAP_ADCDAT1_LL);
-			break;
+		break;
 	default:
 		dev_err(&i2c->dev, "%s:Unknown codec type\n", __func__);
 	}
-- 
2.20.1

