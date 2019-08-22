Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F5199742
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 16:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbfHVOq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 10:46:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731964AbfHVOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:46:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2ACEC49C283CA29A4ED7;
        Thu, 22 Aug 2019 22:45:42 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:45:34 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: atmel - Fix -Wunused-const-variable warning
Date:   Thu, 22 Aug 2019 22:44:44 +0800
Message-ID: <20190822144444.74872-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/crypto/atmel-i2c.h:68:3: warning:
 error_list defined but not used [-Wunused-const-variable=]

error_list is only used in atmel-i2c.c,
so just move the definition over there.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/atmel-i2c.c | 12 ++++++++++++
 drivers/crypto/atmel-i2c.h | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index dc876fab..1d33559 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -21,6 +21,18 @@
 #include <linux/workqueue.h>
 #include "atmel-i2c.h"
 
+static const struct {
+	u8 value;
+	const char *error_text;
+} error_list[] = {
+	{ 0x01, "CheckMac or Verify miscompare" },
+	{ 0x03, "Parse Error" },
+	{ 0x05, "ECC Fault" },
+	{ 0x0F, "Execution Error" },
+	{ 0xEE, "Watchdog about to expire" },
+	{ 0xFF, "CRC or other communication error" },
+};
+
 /**
  * atmel_i2c_checksum() - Generate 16-bit CRC as required by ATMEL ECC.
  * CRC16 verification of the count, opcode, param1, param2 and data bytes.
diff --git a/drivers/crypto/atmel-i2c.h b/drivers/crypto/atmel-i2c.h
index 21860b9..63b97b1 100644
--- a/drivers/crypto/atmel-i2c.h
+++ b/drivers/crypto/atmel-i2c.h
@@ -62,18 +62,6 @@ struct atmel_i2c_cmd {
 #define STATUS_NOERR			0x00
 #define STATUS_WAKE_SUCCESSFUL		0x11
 
-static const struct {
-	u8 value;
-	const char *error_text;
-} error_list[] = {
-	{ 0x01, "CheckMac or Verify miscompare" },
-	{ 0x03, "Parse Error" },
-	{ 0x05, "ECC Fault" },
-	{ 0x0F, "Execution Error" },
-	{ 0xEE, "Watchdog about to expire" },
-	{ 0xFF, "CRC or other communication error" },
-};
-
 /* Definitions for eeprom organization */
 #define CONFIG_ZONE			0
 
-- 
2.7.4


