Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D54E184CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 17:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgCMQuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 12:50:05 -0400
Received: from foss.arm.com ([217.140.110.172]:32904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgCMQuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:50:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6B0331B;
        Fri, 13 Mar 2020 09:50:04 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4205E3F534;
        Fri, 13 Mar 2020 09:50:04 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:50:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: Avoid device name duplication in NORMAL_GET" to the regulator tree
In-Reply-To:  <20200312183245.1612-1-andriy.shevchenko@linux.intel.com>
Message-Id:  <applied-20200312183245.1612-1-andriy.shevchenko@linux.intel.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Avoid device name duplication in NORMAL_GET

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 6e5505cf3ee411761fae8b7419e4f673be41690a Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 12 Mar 2020 20:32:45 +0200
Subject: [PATCH] regulator: core: Avoid device name duplication in NORMAL_GET

With current code:
	st-gyro-i2c i2c-PRP0001:00: i2c-PRP0001:00 supply vdd not found, using dummy regulator

which looks a bit oververbose.

Replace this with simplified format string for the above case, and drop
"deviceless" case since for all dev_*() macros used in _regulator_get()
the "(null)" will be printed anyway.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20200312183245.1612-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d015d99cb59d..7486f6e4e613 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1849,7 +1849,6 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 {
 	struct regulator_dev *rdev;
 	struct regulator *regulator;
-	const char *devname = dev ? dev_name(dev) : "deviceless";
 	struct device_link *link;
 	int ret;
 
@@ -1887,9 +1886,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 			 * enabled, even if it isn't hooked up, and just
 			 * provide a dummy.
 			 */
-			dev_warn(dev,
-				 "%s supply %s not found, using dummy regulator\n",
-				 devname, id);
+			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			rdev = dummy_regulator_rdev;
 			get_device(&rdev->dev);
 			break;
-- 
2.20.1

