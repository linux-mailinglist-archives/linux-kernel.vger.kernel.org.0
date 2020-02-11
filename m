Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F451593CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 16:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgBKPvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 10:51:31 -0500
Received: from foss.arm.com ([217.140.110.172]:48832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbgBKPv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:51:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5134C30E;
        Tue, 11 Feb 2020 07:51:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB7B33F68E;
        Tue, 11 Feb 2020 07:51:28 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:51:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     Adam.Thomson.Opensource@diasemi.com, axel.lin@ingics.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        support.opensource@diasemi.com
Subject: Applied "regulator: da9063: remove redundant return statement" to the regulator tree
In-Reply-To: <1580996996-28798-1-git-send-email-gupt21@gmail.com>
Message-Id: <applied-1580996996-28798-1-git-send-email-gupt21@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9063: remove redundant return statement

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.7

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

From 6d8d840b214e12be6556ed7bee803d9280c54f3b Mon Sep 17 00:00:00 2001
From: Rishi Gupta <gupt21@gmail.com>
Date: Thu, 6 Feb 2020 19:19:56 +0530
Subject: [PATCH] regulator: da9063: remove redundant return statement

The devm_request_threaded_irq() already returns 0 on success
and negative error code on failure. So return from this itself
can be used while preserving error log in case of failure.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
Link: https://lore.kernel.org/r/1580996996-28798-1-git-send-email-gupt21@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9063-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index ae54c76a8580..aaa994293e9b 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -877,12 +877,10 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 				NULL, da9063_ldo_lim_event,
 				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				"LDO_LIM", regulators);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "Failed to request LDO_LIM IRQ.\n");
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static struct platform_driver da9063_regulator_driver = {
-- 
2.20.1

