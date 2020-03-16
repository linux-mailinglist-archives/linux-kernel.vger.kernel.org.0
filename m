Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A20187248
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 19:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbgCPS1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 14:27:52 -0400
Received: from foss.arm.com ([217.140.110.172]:55260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732314AbgCPS1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:27:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69C6630E;
        Mon, 16 Mar 2020 11:27:51 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E20B23F67D;
        Mon, 16 Mar 2020 11:27:50 -0700 (PDT)
Date:   Mon, 16 Mar 2020 18:27:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "regulator: mp886x: add MP8867 support" to the regulator tree
In-Reply-To:  <20200316223127.4b1ecc92@xhacker>
Message-Id:  <applied-20200316223127.4b1ecc92@xhacker>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mp886x: add MP8867 support

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

From 751ca3aa15be815373536eb8b3dc44910b800e9f Mon Sep 17 00:00:00 2001
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Mon, 16 Mar 2020 22:31:27 +0800
Subject: [PATCH] regulator: mp886x: add MP8867 support

MP8867 is an I2C-controlled adjustable voltage regulator made by
Monolithic Power Systems. The difference between MP8867 and MP8869
are:
1.If V_BOOT, the vref of MP8869 is fixed at 600mv while vref of
MP8867 is determined by the I2C control.
2.For MP8867, when setting voltage, if the step is within 5, we
need to manually set the GO BIT to 0.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Link: https://lore.kernel.org/r/20200316223127.4b1ecc92@xhacker
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp886x.c | 62 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index f77321a449ca..1786f7162019 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// MP8869 regulator driver
+// MP8867/MP8869 regulator driver
 //
 // Copyright (C) 2020 Synaptics Incorporated
 //
@@ -119,6 +119,62 @@ static const struct regulator_ops mp8869_regulator_ops = {
 	.get_mode = mp886x_get_mode,
 };
 
+static int mp8867_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	struct mp886x_device_info *di = rdev_get_drvdata(rdev);
+	int ret, delta;
+
+	ret = mp8869_set_voltage_sel(rdev, sel);
+	if (ret < 0)
+		return ret;
+
+	delta = di->sel - sel;
+	if (abs(delta) <= 5)
+		ret = regmap_update_bits(rdev->regmap, MP886X_SYSCNTLREG1,
+					 MP886X_GO, 0);
+	di->sel = sel;
+
+	return ret;
+}
+
+static int mp8867_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct mp886x_device_info *di = rdev_get_drvdata(rdev);
+	int ret, uv;
+	unsigned int val;
+	bool fbloop;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &val);
+	if (ret)
+		return ret;
+
+	fbloop = val & MP886X_V_BOOT;
+
+	val &= rdev->desc->vsel_mask;
+	val >>= ffs(rdev->desc->vsel_mask) - 1;
+
+	if (fbloop) {
+		uv = regulator_list_voltage_linear(rdev, val);
+		uv = mp8869_scale(uv, di->r[0], di->r[1]);
+		return regulator_map_voltage_linear(rdev, uv, uv);
+	}
+
+	return val;
+}
+
+static const struct regulator_ops mp8867_regulator_ops = {
+	.set_voltage_sel = mp8867_set_voltage_sel,
+	.get_voltage_sel = mp8867_get_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.map_voltage = regulator_map_voltage_linear,
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mp886x_set_mode,
+	.get_mode = mp886x_get_mode,
+};
+
 static int mp886x_regulator_register(struct mp886x_device_info *di,
 				     struct regulator_config *config)
 {
@@ -201,6 +257,10 @@ static int mp886x_i2c_probe(struct i2c_client *client,
 }
 
 static const struct of_device_id mp886x_dt_ids[] = {
+	{
+		.compatible = "mps,mp8867",
+		.data = &mp8867_regulator_ops
+	},
 	{
 		.compatible = "mps,mp8869",
 		.data = &mp8869_regulator_ops
-- 
2.20.1

