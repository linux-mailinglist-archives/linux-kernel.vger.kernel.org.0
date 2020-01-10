Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AF9136E30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 14:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgAJNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 08:38:03 -0500
Received: from foss.arm.com ([217.140.110.172]:44550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbgAJNiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:38:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB29C1063;
        Fri, 10 Jan 2020 05:38:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BCB93F534;
        Fri, 10 Jan 2020 05:38:02 -0800 (PST)
Date:   Fri, 10 Jan 2020 13:38:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     alexandre.torgue@st.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        olivier.moysan@st.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: stm32: dfsdm: fix 16 bits record" to the asoc tree
In-Reply-To: <20200110131131.3191-1-olivier.moysan@st.com>
Message-Id: <applied-20200110131131.3191-1-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: dfsdm: fix 16 bits record

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

From 8e55ea19125b65cffe42747359af99d545e85f2f Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Fri, 10 Jan 2020 14:11:31 +0100
Subject: [PATCH] ASoC: stm32: dfsdm: fix 16 bits record

In stm32_afsdm_pcm_cb function, the transfer size is provided in bytes.
However, samples are copied as 16 bits words from iio buffer.
Divide by two the transfer size, to copy the right number of samples.

Fixes: 1e7f6e1c69f0 ("ASoC: stm32: dfsdm: add 16 bits audio record support")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Link: https://lore.kernel.org/r/20200110131131.3191-1-olivier.moysan@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 81c407da15c5..08696a4adb69 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -153,13 +153,13 @@ static const struct snd_soc_component_driver stm32_adfsdm_dai_component = {
 	.name = "stm32_dfsdm_audio",
 };
 
-static void memcpy_32to16(void *dest, const void *src, size_t n)
+static void stm32_memcpy_32to16(void *dest, const void *src, size_t n)
 {
 	unsigned int i = 0;
 	u16 *d = (u16 *)dest, *s = (u16 *)src;
 
 	s++;
-	for (i = n; i > 0; i--) {
+	for (i = n >> 1; i > 0; i--) {
 		*d++ = *s++;
 		s++;
 	}
@@ -186,8 +186,8 @@ static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 
 	if ((priv->pos + src_size) > buff_size) {
 		if (format == SNDRV_PCM_FORMAT_S16_LE)
-			memcpy_32to16(&pcm_buff[priv->pos], src_buff,
-				      buff_size - priv->pos);
+			stm32_memcpy_32to16(&pcm_buff[priv->pos], src_buff,
+					    buff_size - priv->pos);
 		else
 			memcpy(&pcm_buff[priv->pos], src_buff,
 			       buff_size - priv->pos);
@@ -196,8 +196,8 @@ static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 	}
 
 	if (format == SNDRV_PCM_FORMAT_S16_LE)
-		memcpy_32to16(&pcm_buff[priv->pos],
-			      &src_buff[src_size - cur_size], cur_size);
+		stm32_memcpy_32to16(&pcm_buff[priv->pos],
+				    &src_buff[src_size - cur_size], cur_size);
 	else
 		memcpy(&pcm_buff[priv->pos], &src_buff[src_size - cur_size],
 		       cur_size);
-- 
2.20.1

