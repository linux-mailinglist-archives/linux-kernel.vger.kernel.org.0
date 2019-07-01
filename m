Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB77B127C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfECGYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:24:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33602 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfECGXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cdKCKYPz4QxPklp/Dp5dG8XAK9Cs+SYYmACxxeonNLE=; b=Gc15AAEFxkux
        Xzlsx/7itlk0ZHtoQauiLxZnKDyQ/s4O5Yt4K6XGqlRGJl82l+T+bLT42IRs3eElSHBgWOyWZjQpw
        Ys707ng270mCcSna+u/KXmiXtQNnZpDYrzFmGnlodbOaAhYZsSN1BJXEPOyTMzHk2eFJY5S153O8h
        Kk9lU=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRbh-0000lJ-0C; Fri, 03 May 2019 06:23:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4BA3D441D3F; Fri,  3 May 2019 07:23:37 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Pascal Paillet <p.paillet@st.com>
Subject: Applied "regulator: stm32-pwr: Remove unneeded .min_uV and .list_volage" to the regulator tree
In-Reply-To: <20190430111346.23427-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503062337.4BA3D441D3F@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:23:37 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stm32-pwr: Remove unneeded .min_uV and .list_volage

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

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

From 311a68a51a58bfdead971080d41a34ca565b47a0 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 30 Apr 2019 19:13:46 +0800
Subject: [PATCH] regulator: stm32-pwr: Remove unneeded .min_uV and
 .list_volage

For fixed regulator, setting .n_voltages = 1 and .fixed_uV is enough,
no need to set .min_uV and .list_volage.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stm32-pwr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 8bd15e4d2cea..e0e627b0106e 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -102,7 +102,6 @@ static int stm32_pwr_reg_disable(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops stm32_pwr_reg_ops = {
-	.list_voltage	= regulator_list_voltage_linear,
 	.enable		= stm32_pwr_reg_enable,
 	.disable	= stm32_pwr_reg_disable,
 	.is_enabled	= stm32_pwr_reg_is_enabled,
@@ -115,7 +114,6 @@ static const struct regulator_ops stm32_pwr_reg_ops = {
 		.of_match = of_match_ptr(_name), \
 		.n_voltages = 1, \
 		.type = REGULATOR_VOLTAGE, \
-		.min_uV = _volt, \
 		.fixed_uV = _volt, \
 		.ops = &stm32_pwr_reg_ops, \
 		.enable_mask = _en, \
-- 
2.20.1

