Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7E8167F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 14:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgBUN42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 08:56:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728477AbgBUN42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:56:28 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 672E2DF8E568B6A01DC6;
        Fri, 21 Feb 2020 21:56:24 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 21 Feb 2020
 21:56:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] crypto: md5: remove unused macros
Date:   Fri, 21 Feb 2020 21:55:15 +0800
Message-ID: <20200221135515.14948-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto/md5.c:26:0: warning: macro "MD5_DIGEST_WORDS" is not used [-Wunused-macros]
crypto/md5.c:27:0: warning: macro "MD5_MESSAGE_BYTES" is not used [-Wunused-macros]

They are never used since commit 3c7eb3cc8360 ("md5: remove from
lib and only live in crypto").

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 crypto/md5.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/crypto/md5.c b/crypto/md5.c
index 22dc60b..72c0c46 100644
--- a/crypto/md5.c
+++ b/crypto/md5.c
@@ -23,9 +23,6 @@
 #include <linux/types.h>
 #include <asm/byteorder.h>
 
-#define MD5_DIGEST_WORDS 4
-#define MD5_MESSAGE_BYTES 64
-
 const u8 md5_zero_message_hash[MD5_DIGEST_SIZE] = {
 	0xd4, 0x1d, 0x8c, 0xd9, 0x8f, 0x00, 0xb2, 0x04,
 	0xe9, 0x80, 0x09, 0x98, 0xec, 0xf8, 0x42, 0x7e,
-- 
2.7.4


