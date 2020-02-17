Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F48161D19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 23:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBQWEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 17:04:25 -0500
Received: from foss.arm.com ([217.140.110.172]:42244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgBQWEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:04:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94C7B106F;
        Mon, 17 Feb 2020 14:04:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1810F3F703;
        Mon, 17 Feb 2020 14:04:23 -0800 (PST)
Date:   Mon, 17 Feb 2020 22:04:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Applied "regulator: mp5416: Fix output discharge enable bit for LDOs" to the regulator tree
In-Reply-To:  <20200212150223.20042-1-axel.lin@ingics.com>
Message-Id:  <applied-20200212150223.20042-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mp5416: Fix output discharge enable bit for LDOs

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

From 502cdd605edd95209661c8bf90927af6d05c011c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 12 Feb 2020 23:02:23 +0800
Subject: [PATCH] regulator: mp5416: Fix output discharge enable bit for LDOs

The .active_discharge_on/.active_discharge_mask settings does not match
the datasheet, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20200212150223.20042-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp5416.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index 7954ad17249b..67ce1b52a1a1 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -73,7 +73,7 @@
 		.owner			= THIS_MODULE,			\
 	}
 
-#define MP5416LDO(_name, _id)						\
+#define MP5416LDO(_name, _id, _dval)					\
 	[MP5416_LDO ## _id] = {						\
 		.id = MP5416_LDO ## _id,				\
 		.name = _name,						\
@@ -87,9 +87,9 @@
 		.vsel_mask = MP5416_MASK_VSET,				\
 		.enable_reg = MP5416_REG_LDO ##_id,			\
 		.enable_mask = MP5416_REGULATOR_EN,			\
-		.active_discharge_on	= BIT(_id),			\
+		.active_discharge_on	= _dval,			\
 		.active_discharge_reg	= MP5416_REG_CTL2,		\
-		.active_discharge_mask	= BIT(_id),			\
+		.active_discharge_mask	= _dval,			\
 		.owner			= THIS_MODULE,			\
 	}
 
@@ -155,10 +155,10 @@ static struct regulator_desc mp5416_regulators_desc[MP5416_MAX_REGULATORS] = {
 	MP5416BUCK("buck2", 2, mp5416_I_limits2, MP5416_REG_CTL1, BIT(1), 2),
 	MP5416BUCK("buck3", 3, mp5416_I_limits1, MP5416_REG_CTL1, BIT(2), 1),
 	MP5416BUCK("buck4", 4, mp5416_I_limits2, MP5416_REG_CTL2, BIT(5), 2),
-	MP5416LDO("ldo1", 1),
-	MP5416LDO("ldo2", 2),
-	MP5416LDO("ldo3", 3),
-	MP5416LDO("ldo4", 4),
+	MP5416LDO("ldo1", 1, BIT(4)),
+	MP5416LDO("ldo2", 2, BIT(3)),
+	MP5416LDO("ldo3", 3, BIT(2)),
+	MP5416LDO("ldo4", 4, BIT(1)),
 };
 
 /*
-- 
2.20.1

