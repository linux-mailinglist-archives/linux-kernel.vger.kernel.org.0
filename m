Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7704412A8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 19:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfLYSWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 13:22:05 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34640 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLYSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 13:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6GuSETK5XFZcST04I3aBRObtIZjLVXqfD4iVTAAABcY=; b=mYotA1G2qMnz
        HgD61MQ33HXUWZqu/pE1M7HRDtkCVVvD/G1aS1OMMSz5/1V42plrKiXPfhm8kF5pq7putQ2Yjqg7w
        ACmjXpxEZzVvBWu2XMzZB5qo3rv8jGiISI2nQClnOWXc1k/BD6yCf9yGgmkOOaW2LMBhfPNLx0IZV
        nyYvA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikBIH-0001on-Ns; Wed, 25 Dec 2019 18:22:01 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 36F18D01A24; Wed, 25 Dec 2019 18:22:01 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Olliver Schinagl <oliver@schinagl.nl>,
        Priit Laes <plaes@plaes.org>
Subject: Applied "regulator: axp20x: Fix axp20x_set_ramp_delay" to the regulator tree
In-Reply-To: <20191221081049.32490-1-axel.lin@ingics.com>
Message-Id: <applied-20191221081049.32490-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 18:22:01 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: Fix axp20x_set_ramp_delay

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

From 71dd2fe5dec171b34b71603a81bb46c24c498fde Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 21 Dec 2019 16:10:49 +0800
Subject: [PATCH] regulator: axp20x: Fix axp20x_set_ramp_delay

Current code set incorrect bits when set ramp_delay for AXP20X_DCDC2,
fix it.

Fixes: d29f54df8b16 ("regulator: axp20x: add support for set_ramp_delay for AXP209")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20191221081049.32490-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index fe369cba34fb..16f0c8570036 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -413,10 +413,13 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 		int i;
 
 		for (i = 0; i < rate_count; i++) {
-			if (ramp <= slew_rates[i])
-				cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
-			else
+			if (ramp > slew_rates[i])
 				break;
+
+			if (id == AXP20X_DCDC2)
+				cfg = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE(i);
+			else
+				cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
 		}
 
 		if (cfg == 0xff) {
-- 
2.20.1

