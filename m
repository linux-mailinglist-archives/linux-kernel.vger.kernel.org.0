Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3AF15B580
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 00:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgBLX5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 18:57:11 -0500
Received: from foss.arm.com ([217.140.110.172]:39694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLX5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:57:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1289DFEC;
        Wed, 12 Feb 2020 15:57:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B56E3F68E;
        Wed, 12 Feb 2020 15:57:09 -0800 (PST)
Date:   Wed, 12 Feb 2020 23:57:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: Fix SND_SOC_ALL_CODECS imply I2C fallout" to the asoc tree
In-Reply-To: <20200212145650.4602-3-geert@linux-m68k.org>
Message-Id: <applied-20200212145650.4602-3-geert@linux-m68k.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Fix SND_SOC_ALL_CODECS imply I2C fallout

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From 1d0158f547e0dbefa9e18930e93f270ab0309707 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Feb 2020 15:56:49 +0100
Subject: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply I2C fallout
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes for CONFIG_I2C=n:

    WARNING: unmet direct dependencies detected for REGMAP_I2C
      Depends on [n]: I2C [=n]
      Selected by [m]:
      - SND_SOC_ADAU1781_I2C [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
      - SND_SOC_ADAU1977_I2C [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
      - SND_SOC_RT5677 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]

    sound/soc/codecs/...: error: type defaults to ‘int’ in declaration of ‘module_i2c_driver’ [-Werror=implicit-int]

    drivers/base/regmap/regmap-i2c.c: In function ‘regmap_smbus_byte_reg_read’:
    drivers/base/regmap/regmap-i2c.c:25:8: error: implicit declaration of function ‘i2c_smbus_read_byte_data’; did you mean ‘i2c_set_adapdata’? [-Werror=implicit-function-declaration]

Fixes: ea00d95200d02ece ("ASoC: Use imply for SND_SOC_ALL_CODECS")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20200212145650.4602-3-geert@linux-m68k.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c2fb985de8c4..3ef804d07dee 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -339,6 +339,7 @@ config SND_SOC_AD193X_SPI
 
 config SND_SOC_AD193X_I2C
 	tristate
+	depends on I2C
 	select SND_SOC_AD193X
 
 config SND_SOC_AD1980
@@ -353,6 +354,7 @@ config SND_SOC_ADAU_UTILS
 
 config SND_SOC_ADAU1373
 	tristate
+	depends on I2C
 	select SND_SOC_ADAU_UTILS
 
 config SND_SOC_ADAU1701
@@ -387,6 +389,7 @@ config SND_SOC_ADAU1781
 
 config SND_SOC_ADAU1781_I2C
 	tristate
+	depends on I2C
 	select SND_SOC_ADAU1781
 	select REGMAP_I2C
 
@@ -407,6 +410,7 @@ config SND_SOC_ADAU1977_SPI
 
 config SND_SOC_ADAU1977_I2C
 	tristate
+	depends on I2C
 	select SND_SOC_ADAU1977
 	select REGMAP_I2C
 
@@ -450,6 +454,7 @@ config SND_SOC_ADAV801
 
 config SND_SOC_ADAV803
 	tristate
+	depends on I2C
 	select SND_SOC_ADAV80X
 
 config SND_SOC_ADS117X
@@ -471,6 +476,7 @@ config SND_SOC_AK4458
 
 config SND_SOC_AK4535
 	tristate
+	depends on I2C
 
 config SND_SOC_AK4554
 	tristate "AKM AK4554 CODEC"
@@ -481,6 +487,7 @@ config SND_SOC_AK4613
 
 config SND_SOC_AK4641
 	tristate
+	depends on I2C
 
 config SND_SOC_AK4642
 	tristate "AKM AK4642 CODEC"
@@ -488,6 +495,7 @@ config SND_SOC_AK4642
 
 config SND_SOC_AK4671
 	tristate
+	depends on I2C
 
 config SND_SOC_AK5386
 	tristate "AKM AK5638 CODEC"
@@ -1112,6 +1120,7 @@ config SND_SOC_RT5670
 
 config SND_SOC_RT5677
 	tristate
+	depends on I2C
 	select REGMAP_I2C
 	select REGMAP_IRQ
 
-- 
2.20.1

