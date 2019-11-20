Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E981041E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 18:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfKTRSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 12:18:05 -0500
Received: from foss.arm.com ([217.140.110.172]:43280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbfKTRSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:18:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 584DBDA7;
        Wed, 20 Nov 2019 09:18:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0F73F703;
        Wed, 20 Nov 2019 09:18:02 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:18:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: soc-pcm: check symmetry before hw_params" to the asoc tree
In-Reply-To: <1573555602-5403-1-git-send-email-shengjiu.wang@nxp.com>
Message-Id: <applied-1573555602-5403-1-git-send-email-shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-pcm: check symmetry before hw_params

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

From 5cca59516de5df9de6bdecb328dd55fb5bcccb41 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Tue, 12 Nov 2019 18:46:42 +0800
Subject: [PATCH] ASoC: soc-pcm: check symmetry before hw_params

This reverts commit 957ce0c6b8a1f (ASoC: soc-pcm: check symmetry after
hw_params).

That commit cause soc_pcm_params_symmetry can't take effect.
cpu_dai->rate, cpu_dai->channels and cpu_dai->sample_bits
are updated in the middle of soc_pcm_hw_params, so move
soc_pcm_params_symmetry to the end of soc_pcm_hw_params is
not a good solution, for judgement of symmetry in the function
is always true.

FIXME:
According to the comments of that commit, I think the case
described in the commit should disable symmetric_rates
in Back-End, rather than changing the position of
soc_pcm_params_symmetry.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1573555602-5403-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2c4f50c44591..01eb8700c3de 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -861,6 +861,11 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+
+	ret = soc_pcm_params_symmetry(substream, params);
+	if (ret)
+		goto out;
+
 	if (rtd->dai_link->ops->hw_params) {
 		ret = rtd->dai_link->ops->hw_params(substream, params);
 		if (ret < 0) {
@@ -940,9 +945,6 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 	component = NULL;
 
-	ret = soc_pcm_params_symmetry(substream, params);
-        if (ret)
-		goto component_err;
 out:
 	mutex_unlock(&rtd->card->pcm_mutex);
 	return ret;
-- 
2.20.1

