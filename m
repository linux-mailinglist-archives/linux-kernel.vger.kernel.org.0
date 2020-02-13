Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0D15B581
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 00:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgBLX5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 18:57:14 -0500
Received: from foss.arm.com ([217.140.110.172]:39712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLX5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:57:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68287101E;
        Wed, 12 Feb 2020 15:57:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF31B3F68E;
        Wed, 12 Feb 2020 15:57:11 -0800 (PST)
Date:   Wed, 12 Feb 2020 23:57:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: Fix SND_SOC_ALL_CODECS imply SPI fallout" to the asoc tree
In-Reply-To: <20200212145650.4602-2-geert@linux-m68k.org>
Message-Id: <applied-20200212145650.4602-2-geert@linux-m68k.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Fix SND_SOC_ALL_CODECS imply SPI fallout

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

From ce0c97f8a2936d05951da7093b881c8eaaee72e0 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Feb 2020 15:56:48 +0100
Subject: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply SPI fallout

Fixes for CONFIG_SPI=n:

    WARNING: unmet direct dependencies detected for REGMAP_SPI
      Depends on [n]: SPI [=n]
      Selected by [m]:
      - SND_SOC_ADAU1781_SPI [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
      - SND_SOC_ADAU1977_SPI [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]

    ERROR: "spi_async" [...] undefined!
    ERROR: "spi_get_device_id" [...] undefined!
    ERROR: "__spi_register_driver" [...] undefined!
    ERROR: "spi_setup" [...] undefined!
    ERROR: "spi_sync" [...] undefined!
    ERROR: "spi_write_then_read" [...] undefined!

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: ea00d95200d02ece ("ASoC: Use imply for SND_SOC_ALL_CODECS")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Link: https://lore.kernel.org/r/20200212145650.4602-2-geert@linux-m68k.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 68 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7a14b1c416b5..c2fb985de8c4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -327,12 +327,14 @@ config SND_SOC_AC97_CODEC
 
 config SND_SOC_AD1836
 	tristate
+	depends on SPI_MASTER
 
 config SND_SOC_AD193X
 	tristate
 
 config SND_SOC_AD193X_SPI
 	tristate
+	depends on SPI_MASTER
 	select SND_SOC_AD193X
 
 config SND_SOC_AD193X_I2C
@@ -390,6 +392,7 @@ config SND_SOC_ADAU1781_I2C
 
 config SND_SOC_ADAU1781_SPI
 	tristate
+	depends on SPI_MASTER
 	select SND_SOC_ADAU1781
 	select REGMAP_SPI
 
@@ -398,6 +401,7 @@ config SND_SOC_ADAU1977
 
 config SND_SOC_ADAU1977_SPI
 	tristate
+	depends on SPI_MASTER
 	select SND_SOC_ADAU1977
 	select REGMAP_SPI
 
@@ -441,6 +445,7 @@ config SND_SOC_ADAV80X
 
 config SND_SOC_ADAV801
 	tristate
+	depends on SPI_MASTER
 	select SND_SOC_ADAV80X
 
 config SND_SOC_ADAV803
@@ -498,6 +503,7 @@ config SND_SOC_ALC5623
 
 config SND_SOC_ALC5632
 	tristate
+	depends on I2C
 
 config SND_SOC_BD28623
 	tristate "ROHM BD28623 CODEC"
@@ -698,6 +704,7 @@ config SND_SOC_L3
 
 config SND_SOC_DA7210
 	tristate
+	depends on I2C
 
 config SND_SOC_DA7213
 	tristate "Dialog DA7213 CODEC"
@@ -705,15 +712,19 @@ config SND_SOC_DA7213
 
 config SND_SOC_DA7218
 	tristate
+	depends on I2C
 
 config SND_SOC_DA7219
 	tristate
+	depends on I2C
 
 config SND_SOC_DA732X
 	tristate
+	depends on I2C
 
 config SND_SOC_DA9055
 	tristate
+	depends on I2C
 
 config SND_SOC_DMIC
 	tristate "Generic Digital Microphone CODEC"
@@ -773,9 +784,11 @@ config SND_SOC_INNO_RK3036
 
 config SND_SOC_ISABELLE
 	tristate
+	depends on I2C
 
 config SND_SOC_LM49453
 	tristate
+	depends on I2C
 
 config SND_SOC_LOCHNAGAR_SC
 	tristate "Lochnagar Sound Card"
@@ -802,17 +815,20 @@ config SND_SOC_MAX98088
 	depends on I2C
 
 config SND_SOC_MAX98090
-       tristate
+	tristate
+	depends on I2C
 
 config SND_SOC_MAX98095
-       tristate
+	tristate
+	depends on I2C
 
 config SND_SOC_MAX98357A
 	tristate "Maxim MAX98357A CODEC"
 	depends on GPIOLIB
 
 config SND_SOC_MAX98371
-       tristate
+	tristate
+	depends on I2C
 
 config SND_SOC_MAX98504
 	tristate "Maxim MAX98504 speaker amplifier"
@@ -823,10 +839,12 @@ config SND_SOC_MAX9867
 	depends on I2C
 
 config SND_SOC_MAX98925
-       tristate
+	tristate
+	depends on I2C
 
 config SND_SOC_MAX98926
 	tristate
+	depends on I2C
 
 config SND_SOC_MAX98927
 	tristate "Maxim Integrated MAX98927 Speaker Amplifier"
@@ -838,6 +856,7 @@ config SND_SOC_MAX98373
 
 config SND_SOC_MAX9850
 	tristate
+	depends on I2C
 
 config SND_SOC_MAX9860
 	tristate "Maxim MAX9860 Mono Audio Voice Codec"
@@ -1016,26 +1035,32 @@ config SND_SOC_RT298
 
 config SND_SOC_RT1011
 	tristate
+	depends on I2C
 
 config SND_SOC_RT1015
 	tristate
+	depends on I2C
 
 config SND_SOC_RT1305
 	tristate
+	depends on I2C
 
 config SND_SOC_RT1308
 	tristate
+	depends on I2C
 
 config SND_SOC_RT1308_SDW
 	tristate "Realtek RT1308 Codec - SDW"
-	depends on SOUNDWIRE
+	depends on I2C && SOUNDWIRE
 	select REGMAP_SOUNDWIRE
 
 config SND_SOC_RT5514
 	tristate
+	depends on I2C
 
 config SND_SOC_RT5514_SPI
 	tristate
+	depends on SPI_MASTER
 
 config SND_SOC_RT5514_SPI_BUILTIN
 	bool # force RT5514_SPI to be built-in to avoid link errors
@@ -1051,30 +1076,39 @@ config SND_SOC_RT5631
 
 config SND_SOC_RT5640
 	tristate
+	depends on I2C
 
 config SND_SOC_RT5645
 	tristate
+	depends on I2C
 
 config SND_SOC_RT5651
 	tristate
+	depends on I2C
 
 config SND_SOC_RT5659
 	tristate
+	depends on I2C
 
 config SND_SOC_RT5660
 	tristate
+	depends on I2C
 
 config SND_SOC_RT5663
 	tristate
+	depends on I2C
 
 config SND_SOC_RT5665
 	tristate
+	depends on I2C
 
 config SND_SOC_RT5668
 	tristate
+	depends on I2C
 
 config SND_SOC_RT5670
 	tristate
+	depends on I2C
 
 config SND_SOC_RT5677
 	tristate
@@ -1087,6 +1121,7 @@ config SND_SOC_RT5677_SPI
 
 config SND_SOC_RT5682
 	tristate
+	depends on I2C
 
 config SND_SOC_RT700
 	tristate
@@ -1154,6 +1189,7 @@ config SND_SOC_SSM2305
 
 config SND_SOC_SSM2518
 	tristate
+	depends on I2C
 
 config SND_SOC_SSM2602
 	tristate
@@ -1185,6 +1221,7 @@ config SND_SOC_STA350
 
 config SND_SOC_STA529
 	tristate
+	depends on I2C
 
 config SND_SOC_STAC9766
 	tristate
@@ -1282,6 +1319,7 @@ config SND_SOC_TLV320AIC3X
 
 config SND_SOC_TLV320DAC33
 	tristate
+	depends on I2C
 
 config SND_SOC_TS3A227E
 	tristate "TI Headset/Mic detect and keypress chip"
@@ -1348,18 +1386,23 @@ config SND_SOC_WL1273
 
 config SND_SOC_WM0010
 	tristate
+	depends on SPI_MASTER
 
 config SND_SOC_WM1250_EV1
 	tristate
+	depends on I2C
 
 config SND_SOC_WM2000
 	tristate
+	depends on I2C
 
 config SND_SOC_WM2200
 	tristate
+	depends on I2C
 
 config SND_SOC_WM5100
 	tristate
+	depends on I2C
 
 config SND_SOC_WM5102
 	tristate
@@ -1462,9 +1505,11 @@ config SND_SOC_WM8904
 
 config SND_SOC_WM8940
 	tristate
+	depends on I2C
 
 config SND_SOC_WM8955
 	tristate
+	depends on I2C
 
 config SND_SOC_WM8960
 	tristate "Wolfson Microelectronics WM8960 CODEC"
@@ -1472,6 +1517,7 @@ config SND_SOC_WM8960
 
 config SND_SOC_WM8961
 	tristate
+	depends on I2C
 
 config SND_SOC_WM8962
 	tristate "Wolfson Microelectronics WM8962 CODEC"
@@ -1479,6 +1525,7 @@ config SND_SOC_WM8962
 
 config SND_SOC_WM8971
 	tristate
+	depends on I2C
 
 config SND_SOC_WM8974
 	tristate "Wolfson Microelectronics WM8974 codec"
@@ -1490,6 +1537,7 @@ config SND_SOC_WM8978
 
 config SND_SOC_WM8983
 	tristate
+	depends on I2C
 
 config SND_SOC_WM8985
 	tristate "Wolfson Microelectronics WM8985 and WM8758 codec driver"
@@ -1500,12 +1548,15 @@ config SND_SOC_WM8988
 
 config SND_SOC_WM8990
 	tristate
+	depends on I2C
 
 config SND_SOC_WM8991
 	tristate
+	depends on I2C
 
 config SND_SOC_WM8993
 	tristate
+	depends on I2C
 
 config SND_SOC_WM8994
 	tristate
@@ -1515,6 +1566,7 @@ config SND_SOC_WM8995
 
 config SND_SOC_WM8996
 	tristate
+	depends on I2C
 
 config SND_SOC_WM8997
 	tristate
@@ -1528,6 +1580,7 @@ config SND_SOC_WM9081
 
 config SND_SOC_WM9090
 	tristate
+	depends on I2C
 
 config SND_SOC_WM9705
 	tristate
@@ -1561,6 +1614,7 @@ config SND_SOC_ZX_AUD96P22
 # Amp
 config SND_SOC_LM4857
 	tristate
+	depends on I2C
 
 config SND_SOC_MAX9759
 	tristate "Maxim MAX9759 speaker Amplifier"
@@ -1568,15 +1622,18 @@ config SND_SOC_MAX9759
 
 config SND_SOC_MAX9768
 	tristate
+	depends on I2C
 
 config SND_SOC_MAX9877
 	tristate
+	depends on I2C
 
 config SND_SOC_MC13783
 	tristate
 
 config SND_SOC_ML26124
 	tristate
+	depends on I2C
 
 config SND_SOC_MT6351
 	tristate "MediaTek MT6351 Codec"
@@ -1614,6 +1671,7 @@ config SND_SOC_NAU8824
 
 config SND_SOC_NAU8825
 	tristate
+	depends on I2C
 
 config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
-- 
2.20.1

