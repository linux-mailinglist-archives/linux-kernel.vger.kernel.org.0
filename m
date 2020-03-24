Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3A191757
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgCXRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:16:19 -0400
Received: from foss.arm.com ([217.140.110.172]:38478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbgCXRQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:16:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CDB5FEC;
        Tue, 24 Mar 2020 10:16:17 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 001543F71F;
        Tue, 24 Mar 2020 10:16:16 -0700 (PDT)
Date:   Tue, 24 Mar 2020 17:16:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>
Subject: Applied "ASoC: jz4740-i2s: Add support for the JZ4770" to the asoc tree
In-Reply-To:  <20200306222931.39664-6-paul@crapouillou.net>
Message-Id:  <applied-20200306222931.39664-6-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: jz4740-i2s: Add support for the JZ4770

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

From a3434a497a2f33324e0f47bc1500a400959b4b25 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 6 Mar 2020 23:29:31 +0100
Subject: [PATCH] ASoC: jz4740-i2s: Add support for the JZ4770

Before the JZ4770, the playback and capture sampling rates had to match.
The JZ4770 supports independent sampling rates for both.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/20200306222931.39664-6-paul@crapouillou.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/jz4740/jz4740-i2s.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 253f8d8ba273..6f6f8dad0356 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -87,6 +87,7 @@
 enum jz47xx_i2s_version {
 	JZ_I2S_JZ4740,
 	JZ_I2S_JZ4760,
+	JZ_I2S_JZ4770,
 	JZ_I2S_JZ4780,
 };
 
@@ -286,7 +287,7 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
 		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
 
-		if (i2s->soc_info->version >= JZ_I2S_JZ4780) {
+		if (i2s->soc_info->version >= JZ_I2S_JZ4770) {
 			div_reg &= ~I2SDIV_IDV_MASK;
 			div_reg |= (div - 1) << I2SDIV_IDV_SHIFT;
 		} else {
@@ -469,7 +470,7 @@ static const struct i2s_soc_info jz4760_i2s_soc_info = {
 	.dai = &jz4740_i2s_dai,
 };
 
-static struct snd_soc_dai_driver jz4780_i2s_dai = {
+static struct snd_soc_dai_driver jz4770_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
 	.remove = jz4740_i2s_dai_remove,
 	.playback = {
@@ -487,9 +488,14 @@ static struct snd_soc_dai_driver jz4780_i2s_dai = {
 	.ops = &jz4740_i2s_dai_ops,
 };
 
+static const struct i2s_soc_info jz4770_i2s_soc_info = {
+	.version = JZ_I2S_JZ4770,
+	.dai = &jz4770_i2s_dai,
+};
+
 static const struct i2s_soc_info jz4780_i2s_soc_info = {
 	.version = JZ_I2S_JZ4780,
-	.dai = &jz4780_i2s_dai,
+	.dai = &jz4770_i2s_dai,
 };
 
 static const struct snd_soc_component_driver jz4740_i2s_component = {
@@ -502,6 +508,7 @@ static const struct snd_soc_component_driver jz4740_i2s_component = {
 static const struct of_device_id jz4740_of_matches[] = {
 	{ .compatible = "ingenic,jz4740-i2s", .data = &jz4740_i2s_soc_info },
 	{ .compatible = "ingenic,jz4760-i2s", .data = &jz4760_i2s_soc_info },
+	{ .compatible = "ingenic,jz4770-i2s", .data = &jz4770_i2s_soc_info },
 	{ .compatible = "ingenic,jz4780-i2s", .data = &jz4780_i2s_soc_info },
 	{ /* sentinel */ }
 };
-- 
2.20.1

