Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D488857E7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 04:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389634AbfHHCAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 22:00:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730505AbfHHCAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:00:42 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 45FC3EBC03D76B2A2438;
        Thu,  8 Aug 2019 10:00:39 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 10:00:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <maarten@treewalker.org>, <paul@crapouillou.net>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] regulator: act8865: Fix build error without CONFIG_POWER_SUPPLY
Date:   Wed, 7 Aug 2019 21:38:22 +0800
Message-ID: <20190807133822.67124-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building without CONFIG_POWER_SUPPLY will fail:

drivers/regulator/act8865-regulator.o: In function `act8865_pmic_probe':
act8865-regulator.c:(.text+0x357): undefined reference to `devm_power_supply_register'
drivers/regulator/act8865-regulator.o: In function `act8600_charger_get_property':
act8865-regulator.c:(.text+0x3f1): undefined reference to `power_supply_get_drvdata'

Add POWER_SUPPLY dependency to Kconfig.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2d09a79bf637 ("regulator: act8865: Add support for act8600 charger")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b57093d..37e6488 100644
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
2.7.4


