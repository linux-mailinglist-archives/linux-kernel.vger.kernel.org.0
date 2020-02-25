Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D214116C22E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 14:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgBYNYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 08:24:04 -0500
Received: from foss.arm.com ([217.140.110.172]:50766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729602AbgBYNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:24:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A8C6FEC;
        Tue, 25 Feb 2020 05:24:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A746D3F703;
        Tue, 25 Feb 2020 05:24:02 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:24:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>
Subject: Applied "ASoC: Intel: mrfld: fix incorrect check on p->sink" to the asoc tree
In-Reply-To:  <20191119113640.166940-1-colin.king@canonical.com>
Message-Id:  <applied-20191119113640.166940-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: mrfld: fix incorrect check on p->sink

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

From f5e056e1e46fcbb5f74ce560792aeb7d57ce79e6 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 19 Nov 2019 11:36:40 +0000
Subject: [PATCH] ASoC: Intel: mrfld: fix incorrect check on p->sink

The check on p->sink looks bogus, I believe it should be p->source
since the following code blocks are related to p->source. Fix
this by replacing p->sink with p->source.

Fixes: 24c8d14192cc ("ASoC: Intel: mrfld: add DSP core controls")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Addresses-Coverity: ("Copy-paste error")
Link: https://lore.kernel.org/r/20191119113640.166940-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index baef461a99f1..f883c9340eee 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -1333,7 +1333,7 @@ int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
 				dai->capture_widget->name);
 		w = dai->capture_widget;
 		snd_soc_dapm_widget_for_each_source_path(w, p) {
-			if (p->connected && !p->connected(w, p->sink))
+			if (p->connected && !p->connected(w, p->source))
 				continue;
 
 			if (p->connect &&  p->source->power &&
-- 
2.20.1

