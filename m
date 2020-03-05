Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B6E17A62F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 14:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCENPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 08:15:38 -0500
Received: from foss.arm.com ([217.140.110.172]:48418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCENPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:15:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 393E91FB;
        Thu,  5 Mar 2020 05:15:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B22053F6CF;
        Thu,  5 Mar 2020 05:15:37 -0800 (PST)
Date:   Thu, 05 Mar 2020 13:15:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     alsa-devel@alsa-project.org, baolin.wang7@gmail.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        orsonzhai@gmail.com, perex@perex.cz, tiwai@suse.com,
        zhang.lyra@gmail.com
Subject: Applied "ASoC: sprd: Allow the MCDT driver to build into modules" to the asoc tree
In-Reply-To:  <9306f2b99641136653ae4fe6cf9e859b7f698f77.1583387748.git.baolin.wang7@gmail.com>
Message-Id:  <applied-9306f2b99641136653ae4fe6cf9e859b7f698f77.1583387748.git.baolin.wang7@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sprd: Allow the MCDT driver to build into modules

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

From fd357ec595d36676c239d8d16706a270a961ac32 Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang7@gmail.com>
Date: Thu, 5 Mar 2020 14:00:53 +0800
Subject: [PATCH] ASoC: sprd: Allow the MCDT driver to build into modules

Change the config to 'tristate' for MCDT driver to allow it to build into
modules, as well as changing to use IS_ENABLED() to validate if need supply
dummy functions when building the MCDT driver as a module.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
Link: https://lore.kernel.org/r/9306f2b99641136653ae4fe6cf9e859b7f698f77.1583387748.git.baolin.wang7@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/Kconfig     | 2 +-
 sound/soc/sprd/sprd-mcdt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sprd/Kconfig b/sound/soc/sprd/Kconfig
index 5474fd3de8c0..5e0ac8278572 100644
--- a/sound/soc/sprd/Kconfig
+++ b/sound/soc/sprd/Kconfig
@@ -8,7 +8,7 @@ config SND_SOC_SPRD
 	  the Spreadtrum SoCs' Audio interfaces.
 
 config SND_SOC_SPRD_MCDT
-	bool "Spreadtrum multi-channel data transfer support"
+	tristate "Spreadtrum multi-channel data transfer support"
 	depends on SND_SOC_SPRD
 	help
 	  Say y here to enable multi-channel data transfer support. It
diff --git a/sound/soc/sprd/sprd-mcdt.h b/sound/soc/sprd/sprd-mcdt.h
index 9cc7e207ac76..679e3af3baad 100644
--- a/sound/soc/sprd/sprd-mcdt.h
+++ b/sound/soc/sprd/sprd-mcdt.h
@@ -48,7 +48,7 @@ struct sprd_mcdt_chan {
 	struct list_head list;
 };
 
-#ifdef CONFIG_SND_SOC_SPRD_MCDT
+#if IS_ENABLED(CONFIG_SND_SOC_SPRD_MCDT)
 struct sprd_mcdt_chan *sprd_mcdt_request_chan(u8 channel,
 					      enum sprd_mcdt_channel_type type);
 void sprd_mcdt_free_chan(struct sprd_mcdt_chan *chan);
-- 
2.20.1

