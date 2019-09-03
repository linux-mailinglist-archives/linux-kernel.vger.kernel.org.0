Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27D0A6854
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 14:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfICML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 08:11:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbfICML1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:11:27 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A8712D7854C09EEB3E30;
        Tue,  3 Sep 2019 20:11:25 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 20:11:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: typec: tps6598x: Fix build error without CONFIG_REGMAP_I2C
Date:   Tue, 3 Sep 2019 20:10:26 +0800
Message-ID: <20190903121026.22148-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_REGMAP_I2C is not set, building fails:

drivers/usb/typec/tps6598x.o: In function `tps6598x_probe':
tps6598x.c:(.text+0x5f0): undefined reference to `__devm_regmap_init_i2c'

Select REGMAP_I2C to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/typec/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 89d9193..895e241 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -53,6 +53,7 @@ source "drivers/usb/typec/ucsi/Kconfig"
 config TYPEC_TPS6598X
 	tristate "TI TPS6598x USB Power Delivery controller driver"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say Y or M here if your system has TI TPS65982 or TPS65983 USB Power
 	  Delivery controller.
-- 
2.7.4


