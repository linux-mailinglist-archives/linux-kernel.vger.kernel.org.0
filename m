Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D771041EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 18:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfKTRSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 12:18:40 -0500
Received: from foss.arm.com ([217.140.110.172]:43434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbfKTRSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:18:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DAE21045;
        Wed, 20 Nov 2019 09:18:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFD913F703;
        Wed, 20 Nov 2019 09:18:36 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:18:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     b.galvani@gmail.com, broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        phh@phh.me, stefan@agner.ch
Subject: Applied "regulator: rn5t618: fix rc5t619 ldo10 enable" to the regulator tree
In-Reply-To: <20191113182643.23885-1-andreas@kemnade.info>
Message-Id: <applied-20191113182643.23885-1-andreas@kemnade.info>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rn5t618: fix rc5t619 ldo10 enable

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From 3f1a9e630b6e124c387cc57f6fea517cec68b44f Mon Sep 17 00:00:00 2001
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 13 Nov 2019 19:26:43 +0100
Subject: [PATCH] regulator: rn5t618: fix rc5t619 ldo10 enable

LDO9 and LDO10 were listed with the same enable bits.
That looks insane and there are no provisions in the code for handling such
a special case. Also other out-of-tree drivers use a separate bit to
enable it.
Example:
https://github.com/brunotl/kernel-kobo-mx6sl-ntx/blob/master/drivers/regulator/ricoh619-regulator.c
So it seems to be clearly a bug.
I cannot fully check it on my board without schematics and just discovered
this during code analysis for another problem.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://lore.kernel.org/r/20191113182643.23885-1-andreas@kemnade.info
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rn5t618-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rn5t618-regulator.c b/drivers/regulator/rn5t618-regulator.c
index eb807a059479..4a91be0ad5ae 100644
--- a/drivers/regulator/rn5t618-regulator.c
+++ b/drivers/regulator/rn5t618-regulator.c
@@ -90,7 +90,7 @@ static const struct regulator_desc rc5t619_regulators[] = {
 	REG(LDO7, LDOEN1, BIT(6), LDO7DAC, 0x7f, 900000, 3500000, 25000),
 	REG(LDO8, LDOEN1, BIT(7), LDO8DAC, 0x7f, 900000, 3500000, 25000),
 	REG(LDO9, LDOEN2, BIT(0), LDO9DAC, 0x7f, 900000, 3500000, 25000),
-	REG(LDO10, LDOEN2, BIT(0), LDO10DAC, 0x7f, 900000, 3500000, 25000),
+	REG(LDO10, LDOEN2, BIT(1), LDO10DAC, 0x7f, 900000, 3500000, 25000),
 	/* LDO RTC */
 	REG(LDORTC1, LDOEN2, BIT(4), LDORTCDAC, 0x7f, 1700000, 3500000, 25000),
 	REG(LDORTC2, LDOEN2, BIT(5), LDORTC2DAC, 0x7f, 900000, 3500000, 25000),
-- 
2.20.1

