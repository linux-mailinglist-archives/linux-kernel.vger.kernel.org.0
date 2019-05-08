Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654B11749A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 11:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfEHJJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 05:09:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57276 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfEHJJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ePNgMDZVWp1ygjo73nwXpHVJtNSFKzeuPsYmnu8cYKg=; b=E9aTIDz93dLo
        8wqjdpR78LQF+W+TENsKaKtwYfi1+iCmtovvwq24eBXYVLDva1rLCiq5PZLesxqZBvKe+ErdSJpMD
        RBkXobemS4fJe/DSjH71LWKNtRPLw85hHg92uBbx32uf+skvGqIHmdIxg+oKa2ArR8pCiGba56DmC
        2vmyM=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOIZM-0007gE-O3; Wed, 08 May 2019 09:08:57 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 7FDD0440017; Wed,  8 May 2019 10:08:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: Slightly improve readability of _regulator_get_enable_time" to the regulator tree
In-Reply-To: <20190504033336.11582-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190508090846.7FDD0440017@finisterre.sirena.org.uk>
Date:   Wed,  8 May 2019 10:08:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Slightly improve readability of _regulator_get_enable_time

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From 68ce3a4461726ebd3acf9d94841a46386402a058 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 4 May 2019 11:33:36 +0800
Subject: [PATCH] regulator: core: Slightly improve readability of
 _regulator_get_enable_time

The logic is equivalent, but it looks more straightforward this way:
If rdev->desc->ops->enable_time is set, call it.
Otherwise fallback to return rdev->desc->enable_time.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 955a0a15b9cb..bf4cdbcf0653 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1650,9 +1650,9 @@ static int _regulator_get_enable_time(struct regulator_dev *rdev)
 {
 	if (rdev->constraints && rdev->constraints->enable_time)
 		return rdev->constraints->enable_time;
-	if (!rdev->desc->ops->enable_time)
-		return rdev->desc->enable_time;
-	return rdev->desc->ops->enable_time(rdev);
+	if (rdev->desc->ops->enable_time)
+		return rdev->desc->ops->enable_time(rdev);
+	return rdev->desc->enable_time;
 }
 
 static struct regulator_supply_alias *regulator_find_supply_alias(
-- 
2.20.1

