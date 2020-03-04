Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0639C179188
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 14:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbgCDNjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 08:39:16 -0500
Received: from foss.arm.com ([217.140.110.172]:34310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgCDNjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:39:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFF2031B;
        Wed,  4 Mar 2020 05:39:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33B373F6C4;
        Wed,  4 Mar 2020 05:39:15 -0800 (PST)
Date:   Wed, 04 Mar 2020 13:39:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     akshu.agrawal@amd.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        tiwai@suse.com, yuehaibing@huawei.com
Subject: Applied "ASoc: amd: acp3x: Add missing include <linux/io.h>" to the asoc tree
In-Reply-To:  <20200304084057.44764-1-yuehaibing@huawei.com>
Message-Id:  <applied-20200304084057.44764-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoc: amd: acp3x: Add missing include <linux/io.h>

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

From 14beaccc36dc9c1afbe6da627b873bf1d6849234 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 4 Mar 2020 16:40:57 +0800
Subject: [PATCH] ASoc: amd: acp3x: Add missing include <linux/io.h>

gcc 7.4.0 build fails:

In file included from sound/soc/amd/acp3x-rt5682-max9836.c:20:0:
sound/soc/amd/raven/acp3x.h: In function rv_readl:
sound/soc/amd/raven/acp3x.h:113:9: error: implicit declaration of function readl; did you mean rv_readl? [-Werror=implicit-function-declaration]
  return readl(base_addr - ACP3x_PHY_BASE_ADDRESS);
         ^~~~~
         rv_readl
sound/soc/amd/raven/acp3x.h: In function rv_writel:
sound/soc/amd/raven/acp3x.h:118:2: error: implicit declaration of function writel; did you mean rv_writel? [-Werror=implicit-function-declaration]
  writel(val, base_addr - ACP3x_PHY_BASE_ADDRESS);
  ^~~~~~
  rv_writel

Add <linux/io.h> to fix this.

Fixes: 6b8e4e7db3cd ("ASoC: amd: Add machine driver for Raven based platform")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Message-Id: <20200304084057.44764-1-yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index 521c9ab4c29c..8f71c3f7ef79 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
+#include <linux/io.h>
 #include <linux/acpi.h>
 
 #include "raven/acp3x.h"
-- 
2.20.1

