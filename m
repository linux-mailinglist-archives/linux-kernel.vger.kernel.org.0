Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6E841AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 05:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392180AbfFLDUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 23:20:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388693AbfFLDU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:20:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B8EA16075F7EE67F5A9C;
        Wed, 12 Jun 2019 11:20:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 11:20:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <minyard@acm.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <Asmaa@mellanox.com>, <vadimp@mellanox.com>
CC:     <linux-kernel@vger.kernel.org>,
        <openipmi-developer@lists.sourceforge.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ipmi: ipmb: Fix build error while CONFIG_I2C is set to m
Date:   Wed, 12 Jun 2019 11:18:25 +0800
Message-ID: <20190612031825.24732-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_I2C is m and CONFIG_I2C_SLAVE is y,
building with CONFIG_IPMB_DEVICE_INTERFACE setting to
y will fail:

drivers/char/ipmi/ipmb_dev_int.o: In function `ipmb_remove':
ipmb_dev_int.c: undefined reference to `i2c_slave_unregister'
drivers/char/ipmi/ipmb_dev_int.o: In function `ipmb_write':
ipmb_dev_int.c: undefined reference to `i2c_smbus_write_block_data'
drivers/char/ipmi/ipmb_dev_int.o: In function `ipmb_probe':
ipmb_dev_int.c: undefined reference to `i2c_slave_register'
drivers/char/ipmi/ipmb_dev_int.o: In function `ipmb_driver_init':
ipmb_dev_int.c: undefined reference to `i2c_register_driver'
drivers/char/ipmi/ipmb_dev_int.o: In function `ipmb_driver_exit':
ipmb_dev_int.c: undefined reference to `i2c_del_driver'

Add I2C Kconfig dependency to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 51bd6f291583 ("Add support for IPMB driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/char/ipmi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index 987191b..4bad061 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -135,6 +135,7 @@ config ASPEED_BT_IPMI_BMC
 
 config IPMB_DEVICE_INTERFACE
 	tristate 'IPMB Interface handler'
+	depends on I2C
 	depends on I2C_SLAVE
 	help
 	  Provides a driver for a device (Satellite MC) to
-- 
2.7.4


