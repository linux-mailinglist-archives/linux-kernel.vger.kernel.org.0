Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9970319175C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgCXRQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:16:36 -0400
Received: from foss.arm.com ([217.140.110.172]:38544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgCXRQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:16:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FFF21045;
        Tue, 24 Mar 2020 10:16:35 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04EF33F71F;
        Tue, 24 Mar 2020 10:16:34 -0700 (PDT)
Date:   Tue, 24 Mar 2020 17:16:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: wm8974: remove unused variables" to the asoc tree
In-Reply-To:  <20200324070615.16248-1-yuehaibing@huawei.com>
Message-Id:  <applied-20200324070615.16248-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm8974: remove unused variables

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

From 6b877cf8bc98e6c574a6d763943c4a92592e431c Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 24 Mar 2020 15:06:15 +0800
Subject: [PATCH] ASoC: wm8974: remove unused variables

sound/soc/codecs/wm8974.c:200:38: warning:
 wm8974_aux_boost_controls defined but not used [-Wunused-const-variable=]
sound/soc/codecs/wm8974.c:204:38: warning:
 wm8974_mic_boost_controls defined but not used [-Wunused-const-variable=]

commit 8a123ee2a46d ("ASoC: WM8974 DAPM cleanups")
left behind this, remove them.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20200324070615.16248-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8974.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index dc4fe4f5239d..06ba36595ddd 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -196,14 +196,6 @@ SOC_DAPM_SINGLE("MicN Switch", WM8974_INPUT, 1, 1, 0),
 SOC_DAPM_SINGLE("MicP Switch", WM8974_INPUT, 0, 1, 0),
 };
 
-/* AUX Input boost vol */
-static const struct snd_kcontrol_new wm8974_aux_boost_controls =
-SOC_DAPM_SINGLE("Aux Volume", WM8974_ADCBOOST, 0, 7, 0);
-
-/* Mic Input boost vol */
-static const struct snd_kcontrol_new wm8974_mic_boost_controls =
-SOC_DAPM_SINGLE("Mic Volume", WM8974_ADCBOOST, 4, 7, 0);
-
 static const struct snd_soc_dapm_widget wm8974_dapm_widgets[] = {
 SND_SOC_DAPM_MIXER("Speaker Mixer", WM8974_POWER3, 2, 0,
 	&wm8974_speaker_mixer_controls[0],
-- 
2.20.1

