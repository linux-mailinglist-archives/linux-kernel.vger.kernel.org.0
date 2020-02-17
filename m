Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06ED6161D15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 23:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBQWEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 17:04:10 -0500
Received: from foss.arm.com ([217.140.110.172]:42188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgBQWEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:04:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D19211B3;
        Mon, 17 Feb 2020 14:04:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D82C23F703;
        Mon, 17 Feb 2020 14:04:08 -0800 (PST)
Date:   Mon, 17 Feb 2020 22:04:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: amd: ACP needs to be powered off in BIOS." to the asoc tree
In-Reply-To:  <1581935964-15059-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Message-Id:  <applied-1581935964-15059-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: ACP needs to be powered off in BIOS.

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

From 3bc7b6c15fffdf3f818df31198c8c040ad8f7ea9 Mon Sep 17 00:00:00 2001
From: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Date: Mon, 17 Feb 2020 16:09:19 +0530
Subject: [PATCH] ASoC: amd: ACP needs to be powered off in BIOS.

Removed this logic because It is BIOS which needs to
power off the ACP power domian through ACP_PGFSM_CTRL
register when you De-initialize ACP Engine.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Link: https://lore.kernel.org/r/1581935964-15059-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/pci-acp3x.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 65330bb50e74..da60e2ec5535 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -45,23 +45,6 @@ static int acp3x_power_on(void __iomem *acp3x_base)
 	return -ETIMEDOUT;
 }
 
-static int acp3x_power_off(void __iomem *acp3x_base)
-{
-	u32 val;
-	int timeout;
-
-	rv_writel(ACP_PGFSM_CNTL_POWER_OFF_MASK,
-			acp3x_base + mmACP_PGFSM_CONTROL);
-	timeout = 0;
-	while (++timeout < 500) {
-		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
-		if ((val & ACP_PGFSM_STATUS_MASK) == ACP_POWERED_OFF)
-			return 0;
-		udelay(1);
-	}
-	return -ETIMEDOUT;
-}
-
 static int acp3x_reset(void __iomem *acp3x_base)
 {
 	u32 val;
@@ -115,12 +98,6 @@ static int acp3x_deinit(void __iomem *acp3x_base)
 		pr_err("ACP3x reset failed\n");
 		return ret;
 	}
-	/* power off */
-	ret = acp3x_power_off(acp3x_base);
-	if (ret) {
-		pr_err("ACP3x power off failed\n");
-		return ret;
-	}
 	return 0;
 }
 
-- 
2.20.1

