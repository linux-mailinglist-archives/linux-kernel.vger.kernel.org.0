Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13F4177CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 18:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgCCRIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 12:08:13 -0500
Received: from foss.arm.com ([217.140.110.172]:49984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbgCCRIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:08:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E899C2F;
        Tue,  3 Mar 2020 09:08:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C57A3F534;
        Tue,  3 Mar 2020 09:08:12 -0800 (PST)
Date:   Tue, 03 Mar 2020 17:08:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: anatop: Lower error message level for -EPROBE_DEFER" to the regulator tree
In-Reply-To:  <1583243052-1930-1-git-send-email-Anson.Huang@nxp.com>
Message-Id:  <applied-1583243052-1930-1-git-send-email-Anson.Huang@nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: anatop: Lower error message level for -EPROBE_DEFER

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

From 788bfc6eb6912df40a31245566b3e5c99ea7a66a Mon Sep 17 00:00:00 2001
From: Anson Huang <Anson.Huang@nxp.com>
Date: Tue, 3 Mar 2020 21:44:12 +0800
Subject: [PATCH] regulator: anatop: Lower error message level for
 -EPROBE_DEFER

devm_regulator_register() could return -EPROBE_DEFER when trying to
get init data and NOT all resources are available at that time, for
this case, error message is better to be present for debug level ONLY.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Link: https://lore.kernel.org/r/1583243052-1930-1-git-send-email-Anson.Huang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/anatop-regulator.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 754739d004e5..ca92b3de0e9c 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -305,9 +305,13 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	/* register regulator */
 	rdev = devm_regulator_register(dev, rdesc, &config);
 	if (IS_ERR(rdev)) {
-		dev_err(dev, "failed to register %s\n",
-			rdesc->name);
-		return PTR_ERR(rdev);
+		ret = PTR_ERR(rdev);
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(dev, "failed to register %s, deferring...\n",
+				rdesc->name);
+		else
+			dev_err(dev, "failed to register %s\n", rdesc->name);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, rdev);
-- 
2.20.1

