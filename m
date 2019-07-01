Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC792E87D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 00:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfE2WtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 18:49:13 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:56036 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2WtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:49:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id A75C71809AD8C;
        Thu, 30 May 2019 00:49:08 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, festevam@gmail.com, kernel@pengutronix.de,
        s.hauer@pengutronix.de, shawnguo@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, david@sigma-star.at,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH 1/2] crypto: Allow working with key references
Date:   Thu, 30 May 2019 00:48:43 +0200
Message-Id: <20190529224844.25203-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some crypto accelerators allow working with secure or hidden keys.
This keys are not exposed to Linux nor main memory. To use them
for a crypto operation they are referenced with a device specific id.

This patch adds a new flag, CRYPTO_TFM_REQ_REF_KEY.
If this flag is set, crypto drivers should tread the key as
specified via setkey as reference and not as regular key.
Since we reuse the key data structure such a reference is limited
by the key size of the chiper and is chip specific.

TODO: If the cipher implementation or the driver does not
support reference keys, we need a way to detect this an fail
upon setkey.
How should the driver indicate that it supports this feature?

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/linux/crypto.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index f2565a103158..737ea00e026b 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -121,6 +121,7 @@
 #define CRYPTO_TFM_REQ_FORBID_WEAK_KEYS	0x00000100
 #define CRYPTO_TFM_REQ_MAY_SLEEP	0x00000200
 #define CRYPTO_TFM_REQ_MAY_BACKLOG	0x00000400
+#define CRYPTO_TFM_REQ_REF_KEY		0x00000800
 #define CRYPTO_TFM_RES_WEAK_KEY		0x00100000
 #define CRYPTO_TFM_RES_BAD_KEY_LEN   	0x00200000
 #define CRYPTO_TFM_RES_BAD_KEY_SCHED 	0x00400000
-- 
2.16.4

