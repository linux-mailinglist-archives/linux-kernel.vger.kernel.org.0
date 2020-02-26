Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF61707EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 19:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgBZSrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 13:47:20 -0500
Received: from foss.arm.com ([217.140.110.172]:41252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgBZSrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:47:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271AB30E;
        Wed, 26 Feb 2020 10:47:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91FD33F881;
        Wed, 26 Feb 2020 10:47:18 -0800 (PST)
Date:   Wed, 26 Feb 2020 18:47:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, alsa-devel@alsa-project.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: amd: Allow I2S wake event after ACP is powerd On" to the asoc tree
In-Reply-To:  <20200226104746.208656-1-akshu.agrawal@amd.com>
Message-Id:  <applied-20200226104746.208656-1-akshu.agrawal@amd.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: Allow I2S wake event after ACP is powerd On

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

From 911abf8b050e76591479d35c928f7e72605067ac Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Wed, 26 Feb 2020 16:17:44 +0530
Subject: [PATCH] ASoC: amd: Allow I2S wake event after ACP is powerd On

ACP_PME_EN allows wake interrupt to be generated when I2S wake
feature is enabled. On turning ACP On, ACP_PME_EN gets cleared.
Setting the bit back ensures that wake event can be received
when ACP is On.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Link: https://lore.kernel.org/r/20200226104746.208656-1-akshu.agrawal@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/pci-acp3x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index da60e2ec5535..f25ce50f1a90 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -38,8 +38,13 @@ static int acp3x_power_on(void __iomem *acp3x_base)
 	timeout = 0;
 	while (++timeout < 500) {
 		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
-		if (!val)
+		if (!val) {
+			/* Set PME_EN as after ACP power On,
+			 * PME_EN gets cleared
+			 */
+			rv_writel(0x1, acp3x_base + mmACP_PME_EN);
 			return 0;
+		}
 		udelay(1);
 	}
 	return -ETIMEDOUT;
-- 
2.20.1

