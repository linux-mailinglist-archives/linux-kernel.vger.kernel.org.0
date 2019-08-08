Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F29786B95
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 22:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404818AbfHHUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 16:33:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59082 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390337AbfHHUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/rq/2ce6mWXa/vegfzxi5Nnd0b+NfKRKsaObwqhcVSw=; b=eO4hS+87LtFB
        xs//n93trhQpa6EEHoNxaR3YQUphwF8qeHgW+fvgTEttlJH0RHUE8xi906ona+f+oRl72I3GuHASa
        HbaK+7OmollxD3mzw/PBMjiNZXnEPiFxg1UJxpsvTBO1ugufKy6GHbr1mCKp+Zr6Hr1ZhwGKawvFq
        kO47k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvp6b-00042g-BG; Thu, 08 Aug 2019 20:33:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DDAD72742B42; Thu,  8 Aug 2019 21:33:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        maarten@treewalker.org, Mark Brown <broonie@kernel.org>,
        paul@crapouillou.net
Subject: Applied "regulator: act8865: Fix build error without CONFIG_POWER_SUPPLY" to the regulator tree
In-Reply-To: <20190807133822.67124-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190808203348.DDAD72742B42@ypsilon.sirena.org.uk>
Date:   Thu,  8 Aug 2019 21:33:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8865: Fix build error without CONFIG_POWER_SUPPLY

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

From 5375f1efd70b5adbbbaded22889d50c07f6f89a4 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 7 Aug 2019 21:38:22 +0800
Subject: [PATCH] regulator: act8865: Fix build error without
 CONFIG_POWER_SUPPLY

Building without CONFIG_POWER_SUPPLY will fail:

drivers/regulator/act8865-regulator.o: In function `act8865_pmic_probe':
act8865-regulator.c:(.text+0x357): undefined reference to `devm_power_supply_register'
drivers/regulator/act8865-regulator.o: In function `act8600_charger_get_property':
act8865-regulator.c:(.text+0x3f1): undefined reference to `power_supply_get_drvdata'

Add POWER_SUPPLY dependency to Kconfig.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2d09a79bf637 ("regulator: act8865: Add support for act8600 charger")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190807133822.67124-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b57093d7c01f..37e64884b9ee 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -83,6 +83,7 @@ config REGULATOR_88PM8607
 config REGULATOR_ACT8865
 	tristate "Active-semi act8865 voltage regulator"
 	depends on I2C
+	depends on POWER_SUPPLY
 	select REGMAP_I2C
 	help
 	  This driver controls a active-semi act8865 voltage output
-- 
2.20.1

