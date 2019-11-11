Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF9F7530
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 14:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKKNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 08:39:49 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57526 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfKKNjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:39:48 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 251C8BEF5CC8052D5EC7;
        Mon, 11 Nov 2019 21:39:47 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 21:39:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <cyrille.pitchen@atmel.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: atmel - Fix randbuild error
Date:   Mon, 11 Nov 2019 21:39:01 +0800
Message-ID: <20191111133901.19164-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CRYPTO_AUTHENC is m, CRYPTO_DEV_ATMEL_SHA is m, but
CRYPTO_DEV_ATMEL_AES is y, building will fails:

drivers/crypto/atmel-aes.o: In function `atmel_aes_authenc_init_tfm':
atmel-aes.c:(.text+0x670): undefined reference to `atmel_sha_authenc_get_reqsize'
atmel-aes.c:(.text+0x67a): undefined reference to `atmel_sha_authenc_spawn'
drivers/crypto/atmel-aes.o: In function `atmel_aes_authenc_setkey':
atmel-aes.c:(.text+0x7e5): undefined reference to `atmel_sha_authenc_setkey'

Fix this by moving the selection of CRYPTO_DEV_ATMEL_SHA under
CRYPTO_DEV_ATMEL_AES.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 89a82ef87e01 ("crypto: atmel-authenc - add support to...")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index c5cc04d..148605a 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -495,7 +495,6 @@ config CRYPTO_DEV_ATMEL_AUTHENC
 	tristate "Support for Atmel IPSEC/SSL hw accelerator"
 	depends on ARCH_AT91 || COMPILE_TEST
 	select CRYPTO_DEV_ATMEL_AES
-	select CRYPTO_DEV_ATMEL_SHA
 	help
 	  Some Atmel processors can combine the AES and SHA hw accelerators
 	  to enhance support of IPSEC/SSL.
@@ -509,6 +508,7 @@ config CRYPTO_DEV_ATMEL_AES
 	select CRYPTO_AEAD
 	select CRYPTO_AUTHENC
 	select CRYPTO_SKCIPHER
+	select CRYPTO_DEV_ATMEL_SHA
 	help
 	  Some Atmel processors have AES hw accelerator.
 	  Select this if you want to use the Atmel module for
-- 
2.7.4


