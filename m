Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA71431F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 20:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgATTKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 14:10:24 -0500
Received: from foss.arm.com ([217.140.110.172]:35958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgATTKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:10:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52A8231B;
        Mon, 20 Jan 2020 11:10:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5C973F68E;
        Mon, 20 Jan 2020 11:10:22 -0800 (PST)
Date:   Mon, 20 Jan 2020 19:10:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Collabora Kernel ML <kernel@collabora.com>, dianders@chromium.org,
        Dmitry Osipenko <digetx@gmail.com>, drinkcat@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mka@chromium.org
Subject: Applied "regulator: core: Fix exported symbols to the exported GPL version" to the regulator tree
In-Reply-To: <20200120123921.1204339-1-enric.balletbo@collabora.com>
Message-Id: <applied-20200120123921.1204339-1-enric.balletbo@collabora.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Fix exported symbols to the exported GPL version

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From 3d7610e8da993539346dce6f7c909fd3d56bf4d5 Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Mon, 20 Jan 2020 13:39:21 +0100
Subject: [PATCH] regulator: core: Fix exported symbols to the exported GPL
 version

Change the exported symbols introduced by commit e9153311491da
("regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage")
from EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL(), like is used for all the core
parts.

Fixes: e9153311491da ("regulator: vctrl-regulator: Avoid deadlock getting and setting the voltage")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Link: https://lore.kernel.org/r/20200120123921.1204339-1-enric.balletbo@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6be687d25484..5bab251b9a9d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3466,7 +3466,7 @@ int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 out:
 	return ret;
 }
-EXPORT_SYMBOL(regulator_set_voltage_rdev);
+EXPORT_SYMBOL_GPL(regulator_set_voltage_rdev);
 
 static int regulator_limit_voltage_step(struct regulator_dev *rdev,
 					int *current_uV, int *min_uV)
@@ -4031,7 +4031,7 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
 		return ret;
 	return ret - rdev->constraints->uV_offset;
 }
-EXPORT_SYMBOL(regulator_get_voltage_rdev);
+EXPORT_SYMBOL_GPL(regulator_get_voltage_rdev);
 
 /**
  * regulator_get_voltage - get regulator output voltage
-- 
2.20.1

