Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D6143A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgAUJ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:57:39 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34553 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729259AbgAUJ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:57:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHep6i_1579600653;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0ToHep6i_1579600653)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 17:57:33 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] crypto: testmgr - Add SM2 test vectors
Date:   Tue, 21 Jan 2020 17:57:17 +0800
Message-Id: <20200121095718.52404-6-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121095718.52404-1-tianjia.zhang@linux.alibaba.com>
References: <20200121095718.52404-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add testmgr tests and vectors for SM2 asymmetric cipher.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/testmgr.c |  7 +++++++
 crypto/testmgr.h | 25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index db9b5ac878e7..ecc6b27c1dd3 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5050,6 +5050,13 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(sha512_tv_template)
 		}
+	}, {
+		.alg = "sm2",
+		.test = alg_test_akcipher,
+		.fips_allowed = 1,
+		.suite = {
+			.akcipher = __VECS(sm2_tv_template)
+		}
 	}, {
 		.alg = "sm3",
 		.test = alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 48da646651cb..9bee14ebfff6 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -809,6 +809,31 @@ static const struct akcipher_testvec pkcs1pad_rsa_tv_template[] = {
 	}
 };
 
+/*
+ * SM2 test vectors.
+ */
+static const struct akcipher_testvec sm2_tv_template[] = {
+	{
+	.key =
+	"\x30\x68"      /* 104 bytes */
+	"\x02\x01\x01"  /* version */
+	"\x04\x20"      /* priv key */
+	"\xbd\xca\x64\x55\xa5\x5b\x9c\x27\x22\xd0\xf5\x80\xf7\xf3\xc5\x63"
+	"\x3c\xbf\xce\xe8\x55\x17\xaa\xa5\x7f\x11\x9b\x4b\x25\x56\x9b\x43"
+	"\x03\x41"      /* pub key */
+	"\x04"
+	"\x8a\x68\x9f\x2e\xa8\x7a\x60\x1c\xdb\xa2\xcd\x46\xe0\x86\x2d\x66"
+	"\xde\xb4\x8f\xf1\xc6\x36\xd0\x68\xed\x1d\xdb\xe4\x72\x01\xbb\xdd"
+	"\x02\xbe\x58\xc5\xac\xc9\x4f\xa3\xfb\x82\xe1\xcb\xd2\x20\x17\x2f"
+	"\x1f\x30\x4b\xdd\x89\xab\x7e\x29\x4a\x4f\x67\x2c\x04\xeb\x3d\xe4",
+	.m = "\x39\xb3\x2c\x59\x82\xc7\xdf\x11\x8a\x64\x2d",
+	.c = NULL,
+	.key_len = 106,
+	.m_size = 11,
+	.c_size = 0,
+	}
+};
+
 static const struct kpp_testvec dh_tv_template[] = {
 	{
 	.secret =
-- 
2.17.1

