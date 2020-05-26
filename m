Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FEF19AA5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 13:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbgDALGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 07:06:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732179AbgDALGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:06:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16DB230E;
        Wed,  1 Apr 2020 04:06:48 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DCA63F68F;
        Wed,  1 Apr 2020 04:06:47 -0700 (PDT)
Date:   Wed, 01 Apr 2020 12:06:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        tiwai@suse.com
Subject: Applied "ASoC: rt5682: Fix build error without CONFIG_I2C" to the asoc tree
In-Reply-To:  <20200401091055.34112-1-yuehaibing@huawei.com>
Message-Id:  <applied-20200401091055.34112-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5682: Fix build error without CONFIG_I2C

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

From 59564e117356d5bb6df6876c03d7d650361781c9 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 1 Apr 2020 17:10:55 +0800
Subject: [PATCH] ASoC: rt5682: Fix build error without CONFIG_I2C

If I2C is n but SoundWire is m, building fails:

sound/soc/codecs/rt5682.c:3716:1: warning: data definition has no type or storage class
 module_i2c_driver(rt5682_i2c_driver);
 ^~~~~~~~~~~~~~~~~
sound/soc/codecs/rt5682.c:3716:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
sound/soc/codecs/rt5682.c:3716:1: warning: parameter names (without types) in function declaration

Guard this use #ifdef CONFIG_I2C.

Fixes: 5549ea647997 ("ASoC: rt5682: fix unmet dependencies")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20200401091055.34112-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index c9268a230daa..d36f560ad7a8 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -3703,7 +3703,7 @@ static const struct acpi_device_id rt5682_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5682_acpi_match);
 #endif
 
-static struct i2c_driver rt5682_i2c_driver = {
+static struct i2c_driver __maybe_unused rt5682_i2c_driver = {
 	.driver = {
 		.name = "rt5682",
 		.of_match_table = of_match_ptr(rt5682_of_match),
@@ -3713,7 +3713,10 @@ static struct i2c_driver rt5682_i2c_driver = {
 	.shutdown = rt5682_i2c_shutdown,
 	.id_table = rt5682_i2c_id,
 };
+
+#ifdef CONFIG_I2C
 module_i2c_driver(rt5682_i2c_driver);
+#endif
 
 MODULE_DESCRIPTION("ASoC RT5682 driver");
 MODULE_AUTHOR("Bard Liao <bardliao@realtek.com>");
-- 
2.20.1

