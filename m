Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8EA30E01
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 14:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfEaMVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 08:21:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46946 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfEaMVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:21:45 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 93BADFC6077132208A13;
        Fri, 31 May 2019 20:21:42 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 31 May 2019
 20:21:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <ard.biesheuvel@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] crypto: atmel-i2c - Fix build error while CRC16 set to m
Date:   Fri, 31 May 2019 20:17:49 +0800
Message-ID: <20190531121749.9144-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190531094900.12708-1-yuehaibing@huawei.com>
References: <20190531094900.12708-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CRYPTO_DEV_ATMEL_ECC is set m, which select CRC16 to m,
while CRYPTO_DEV_ATMEL_SHA204A is set to y, building fails.

drivers/crypto/atmel-i2c.o: In function 'atmel_i2c_checksum':
atmel-i2c.c:(.text+0x16): undefined reference to 'crc16'

Add CRC16 dependency to CRYPTO_DEV_ATMEL_SHA204A

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: da001fb651b0 ("crypto: atmel-i2c - add support for SHA204A random number generator")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2：use 'select' instead of 'depends on'
---
 drivers/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index fe01a99..603413f 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -542,6 +542,7 @@ config CRYPTO_DEV_ATMEL_SHA204A
 	depends on I2C
 	select CRYPTO_DEV_ATMEL_I2C
 	select HW_RANDOM
+	select CRC16
 	help
 	  Microhip / Atmel SHA accelerator and RNG.
 	  Select this if you want to use the Microchip / Atmel SHA204A
-- 
2.7.4

