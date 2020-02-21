Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97457167EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 14:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBUNbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 08:31:16 -0500
Received: from foss.arm.com ([217.140.110.172]:39412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgBUNbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:31:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFFD330E;
        Fri, 21 Feb 2020 05:31:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 383B83F703;
        Fri, 21 Feb 2020 05:31:15 -0800 (PST)
Date:   Fri, 21 Feb 2020 13:31:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: g12a: add tohdmitx reset" to the asoc tree
In-Reply-To:  <20200221121146.1498427-1-jbrunet@baylibre.com>
Message-Id:  <applied-20200221121146.1498427-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: g12a: add tohdmitx reset

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

From 22946f37557e27697aabc8e4f62642bfe4a17fd8 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 21 Feb 2020 13:11:46 +0100
Subject: [PATCH] ASoC: meson: g12a: add tohdmitx reset

Reset the g12a hdmi codec glue on probe. This ensure a sane startup state.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20200221121146.1498427-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/g12a-tohdmitx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/meson/g12a-tohdmitx.c b/sound/soc/meson/g12a-tohdmitx.c
index 9cfbd343a00c..8a0db28a6a40 100644
--- a/sound/soc/meson/g12a-tohdmitx.c
+++ b/sound/soc/meson/g12a-tohdmitx.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <sound/pcm_params.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
 
@@ -378,6 +379,11 @@ static int g12a_tohdmitx_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	void __iomem *regs;
 	struct regmap *map;
+	int ret;
+
+	ret = device_reset(dev);
+	if (ret)
+		return ret;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
-- 
2.20.1

