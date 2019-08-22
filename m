Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69A99716
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 16:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbfHVOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 10:41:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbfHVOl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:41:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8FD855261A6D262269E9;
        Thu, 22 Aug 2019 22:41:49 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:41:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: aegis128 - Fix -Wunused-const-variable warning
Date:   Thu, 22 Aug 2019 22:41:38 +0800
Message-ID: <20190822144138.75904-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto/aegis.h:27:32: warning:
 crypto_aegis_const defined but not used [-Wunused-const-variable=]

crypto_aegis_const is only used in aegis128-core.c,
just move the definition over there.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 crypto/aegis.h         | 11 -----------
 crypto/aegis128-core.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/crypto/aegis.h b/crypto/aegis.h
index 4d56a85..6920ebe 100644
--- a/crypto/aegis.h
+++ b/crypto/aegis.h
@@ -24,17 +24,6 @@ union aegis_block {
 #define AEGIS_BLOCK_ALIGN (__alignof__(union aegis_block))
 #define AEGIS_ALIGNED(p) IS_ALIGNED((uintptr_t)p, AEGIS_BLOCK_ALIGN)
 
-static const union aegis_block crypto_aegis_const[2] = {
-	{ .words64 = {
-		cpu_to_le64(U64_C(0x0d08050302010100)),
-		cpu_to_le64(U64_C(0x6279e99059372215)),
-	} },
-	{ .words64 = {
-		cpu_to_le64(U64_C(0xf12fc26d55183ddb)),
-		cpu_to_le64(U64_C(0xdd28b57342311120)),
-	} },
-};
-
 static __always_inline void crypto_aegis_block_xor(union aegis_block *dst,
 						   const union aegis_block *src)
 {
diff --git a/crypto/aegis128-core.c b/crypto/aegis128-core.c
index fa69e99..80e7361 100644
--- a/crypto/aegis128-core.c
+++ b/crypto/aegis128-core.c
@@ -45,6 +45,17 @@ struct aegis128_ops {
 
 static bool have_simd;
 
+static const union aegis_block crypto_aegis_const[2] = {
+	{ .words64 = {
+		cpu_to_le64(U64_C(0x0d08050302010100)),
+		cpu_to_le64(U64_C(0x6279e99059372215)),
+	} },
+	{ .words64 = {
+		cpu_to_le64(U64_C(0xf12fc26d55183ddb)),
+		cpu_to_le64(U64_C(0xdd28b57342311120)),
+	} },
+};
+
 static bool aegis128_do_simd(void)
 {
 #ifdef CONFIG_CRYPTO_AEGIS128_SIMD
-- 
2.7.4


