Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155571593B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 16:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgBKPtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 10:49:31 -0500
Received: from foss.arm.com ([217.140.110.172]:48510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730401AbgBKPt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:49:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BFCD1063;
        Tue, 11 Feb 2020 07:49:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85EC33F68E;
        Tue, 11 Feb 2020 07:49:26 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:49:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt5659: remove redundant assignment to variable idx" to the asoc tree
In-Reply-To: <20200208221529.37105-1-colin.king@canonical.com>
Message-Id: <applied-20200208221529.37105-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5659: remove redundant assignment to variable idx

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From 1646484ed2430e37f00945db4755449d54354b57 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sat, 8 Feb 2020 22:15:29 +0000
Subject: [PATCH] ASoC: rt5659: remove redundant assignment to variable idx

Variable idx is being assigned with a value that is never idx, it is
assigned a new value a couple of statements later. The assignment is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20200208221529.37105-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index e66d08398f74..89e0f58512fa 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -1604,7 +1604,7 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
-	int pd, idx = -EINVAL;
+	int pd, idx;
 
 	pd = rl6231_get_pre_div(rt5659->regmap,
 		RT5659_ADDA_CLK_1, RT5659_I2S_PD1_SFT);
-- 
2.20.1

