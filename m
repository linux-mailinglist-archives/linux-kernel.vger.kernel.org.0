Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC311195CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgC0R2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 13:28:47 -0400
Received: from foss.arm.com ([217.140.110.172]:49730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgC0R2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:28:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0497E1FB;
        Fri, 27 Mar 2020 10:28:47 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C1983F71E;
        Fri, 27 Mar 2020 10:28:46 -0700 (PDT)
Date:   Fri, 27 Mar 2020 17:28:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: amd: acp3x-pcm-dma: clean up two indentation issues" to the asoc tree
In-Reply-To:  <20200327141429.269191-1-colin.king@canonical.com>
Message-Id:  <applied-20200327141429.269191-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: acp3x-pcm-dma: clean up two indentation issues

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

From acd4946f5bf031fa38e64bfe2467be94a1b8c25d Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 27 Mar 2020 14:14:29 +0000
Subject: [PATCH] ASoC: amd: acp3x-pcm-dma: clean up two indentation issues

There are a couple of statements that are not indented correctly,
add in the missing tab and break the lines to address a checkpatch
warning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20200327141429.269191-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index d62c0d90c41e..e362f0bc9e46 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -458,7 +458,8 @@ static int acp3x_resume(struct device *dev)
 			reg_val = mmACP_I2STDM_ITER;
 			frmt_val = mmACP_I2STDM_TXFRMT;
 		}
-	rv_writel((rtd->xfer_resolution  << 3), rtd->acp3x_base + reg_val);
+		rv_writel((rtd->xfer_resolution  << 3),
+			  rtd->acp3x_base + reg_val);
 	}
 	if (adata->capture_stream && adata->capture_stream->runtime) {
 		struct i2s_stream_instance *rtd =
@@ -474,7 +475,8 @@ static int acp3x_resume(struct device *dev)
 			reg_val = mmACP_I2STDM_IRER;
 			frmt_val = mmACP_I2STDM_RXFRMT;
 		}
-	rv_writel((rtd->xfer_resolution  << 3), rtd->acp3x_base + reg_val);
+		rv_writel((rtd->xfer_resolution  << 3),
+			  rtd->acp3x_base + reg_val);
 	}
 	if (adata->tdm_mode == TDM_ENABLE) {
 		rv_writel(adata->tdm_fmt, adata->acp3x_base + frmt_val);
-- 
2.20.1

