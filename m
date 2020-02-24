Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B321516A76A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 14:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBXNlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 08:41:52 -0500
Received: from foss.arm.com ([217.140.110.172]:37184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgBXNlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:41:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E909D30E;
        Mon, 24 Feb 2020 05:41:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EC433F534;
        Mon, 24 Feb 2020 05:41:50 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:41:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout" to the asoc tree
In-Reply-To:  <20200224112537.14483-1-geert@linux-m68k.org>
Message-Id:  <applied-20200224112537.14483-1-geert@linux-m68k.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout

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

From 5a309875787db47d69610e45f00a727ef9e62aa0 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2020 12:25:37 +0100
Subject: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout

On i386 randconfig:

    sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
    wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
    sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
    wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
    sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
    wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'

Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20200224112537.14483-1-geert@linux-m68k.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e9d54e4576c..a7e89567edbe 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1610,16 +1610,19 @@ config SND_SOC_WM9090
 
 config SND_SOC_WM9705
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9712
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9713
 	tristate
+	depends on SND_SOC_AC97_BUS
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
-- 
2.20.1

