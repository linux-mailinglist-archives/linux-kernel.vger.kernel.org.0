Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7610C952
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfK1NSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:18:50 -0500
Received: from foss.arm.com ([217.140.110.172]:35280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1NSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:18:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2313312FC;
        Thu, 28 Nov 2019 05:18:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B123F52E;
        Thu, 28 Nov 2019 05:18:49 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:18:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: fix use after free issue" to the regulator tree
In-Reply-To: <20191124145835.25999-1-wenyang@linux.alibaba.com>
Message-Id: <applied-20191124145835.25999-1-wenyang@linux.alibaba.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fix use after free issue

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

From 4affd79a125ac91e6a53be843ea3960a8fc00cbb Mon Sep 17 00:00:00 2001
From: Wen Yang <wenyang@linux.alibaba.com>
Date: Sun, 24 Nov 2019 22:58:35 +0800
Subject: [PATCH] regulator: fix use after free issue

This is caused by dereferencing 'rdev' after put_device() in
the _regulator_get()/_regulator_put() functions.
This patch just moves the put_device() down a bit to avoid the
issue.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/20191124145835.25999-1-wenyang@linux.alibaba.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5e6c629806e4..c80f3fd9532d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1937,8 +1937,8 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 	regulator = create_regulator(rdev, dev, id);
 	if (regulator == NULL) {
 		regulator = ERR_PTR(-ENOMEM);
-		put_device(&rdev->dev);
 		module_put(rdev->owner);
+		put_device(&rdev->dev);
 		return regulator;
 	}
 
@@ -2059,13 +2059,13 @@ static void _regulator_put(struct regulator *regulator)
 
 	rdev->open_count--;
 	rdev->exclusive = 0;
-	put_device(&rdev->dev);
 	regulator_unlock(rdev);
 
 	kfree_const(regulator->supply_name);
 	kfree(regulator);
 
 	module_put(rdev->owner);
+	put_device(&rdev->dev);
 }
 
 /**
-- 
2.20.1

