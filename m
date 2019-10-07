Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63773CE280
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 15:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfJGNDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 09:03:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49140 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfJGNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Dp1YOPGrxNOCFaSYQ3ZFbTLziPXi1S1+97nmW8XjcNI=; b=P64obnjHlyTz
        B5N8xNoJ5K7/vMBsoRAqIPzYgzQVY8BlrqM3Aa7cN/CHGB6VKUV0mN59NAXlkpYrjCwWYy4ABgE4B
        RYbWYkg1/Dav7QHuvHfGxnbmeGbzJcJe7MAZFphTjkwiyDfJvtP4mp62HKJpQ3ECxuLsApEkIgOOU
        Xcp3s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfU-0003RV-G9; Mon, 07 Oct 2019 13:03:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 041DD2741D8E; Mon,  7 Oct 2019 14:03:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps65132: switch to using devm_fwnode_gpiod_get()" to the regulator tree
In-Reply-To: <20191004231017.130290-7-dmitry.torokhov@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007130316.041DD2741D8E@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65132: switch to using devm_fwnode_gpiod_get()

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

From 22803ca3c56b02e5bb8a4eb14104114009fd1c65 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 4 Oct 2019 16:10:16 -0700
Subject: [PATCH] regulator: tps65132: switch to using devm_fwnode_gpiod_get()

devm_fwnode_get_index_gpiod_from_child() is going away as the name is
too unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Note that we no longer need to check for NULL as devm_fwnode_gpiod_get()
will return -ENOENT if GPIO is missing.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20191004231017.130290-7-dmitry.torokhov@gmail.com
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65132-regulator.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index e302bd01a084..7b0e38f8d627 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -136,9 +136,10 @@ static int tps65132_of_parse_cb(struct device_node *np,
 	struct tps65132_reg_pdata *rpdata = &tps->reg_pdata[desc->id];
 	int ret;
 
-	rpdata->en_gpiod = devm_fwnode_get_index_gpiod_from_child(tps->dev,
-					"enable", 0, &np->fwnode, 0, "enable");
-	if (IS_ERR_OR_NULL(rpdata->en_gpiod)) {
+	rpdata->en_gpiod = devm_fwnode_gpiod_get(tps->dev, of_fwnode_handle(np),
+						 "enable", GPIOD_ASIS,
+						 "enable");
+	if (IS_ERR(rpdata->en_gpiod)) {
 		ret = PTR_ERR(rpdata->en_gpiod);
 
 		/* Ignore the error other than probe defer */
@@ -147,10 +148,12 @@ static int tps65132_of_parse_cb(struct device_node *np,
 		return 0;
 	}
 
-	rpdata->act_dis_gpiod = devm_fwnode_get_index_gpiod_from_child(
-					tps->dev, "active-discharge", 0,
-					&np->fwnode, 0, "active-discharge");
-	if (IS_ERR_OR_NULL(rpdata->act_dis_gpiod)) {
+	rpdata->act_dis_gpiod = devm_fwnode_gpiod_get(tps->dev,
+						      of_fwnode_handle(np),
+						      "active-discharge",
+						      GPIOD_ASIS,
+						      "active-discharge");
+	if (IS_ERR(rpdata->act_dis_gpiod)) {
 		ret = PTR_ERR(rpdata->act_dis_gpiod);
 
 		/* Ignore the error other than probe defer */
-- 
2.20.1

