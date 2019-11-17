Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB56FFBF8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 23:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfKQWbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 17:31:04 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56860 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfKQWbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:31:04 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CE2771A0D0D;
        Sun, 17 Nov 2019 23:31:02 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C1D601A0D0A;
        Sun, 17 Nov 2019 23:31:02 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C67B202AF;
        Sun, 17 Nov 2019 23:31:02 +0100 (CET)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH 01/12] crypto: add helper function for akcipher_request
Date:   Mon, 18 Nov 2019 00:30:34 +0200
Message-Id: <1574029845-22796-2-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1574029845-22796-1-git-send-email-iuliana.prodan@nxp.com>
References: <1574029845-22796-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add akcipher_request_cast function to get an akcipher_request struct from
a crypto_async_request struct.

Remove this function from ccp driver.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/ccp/ccp-crypto-rsa.c | 6 ------
 include/crypto/akcipher.h           | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-rsa.c b/drivers/crypto/ccp/ccp-crypto-rsa.c
index 649c91d..3ab659d 100644
--- a/drivers/crypto/ccp/ccp-crypto-rsa.c
+++ b/drivers/crypto/ccp/ccp-crypto-rsa.c
@@ -19,12 +19,6 @@
 
 #include "ccp-crypto.h"
 
-static inline struct akcipher_request *akcipher_request_cast(
-	struct crypto_async_request *req)
-{
-	return container_of(req, struct akcipher_request, base);
-}
-
 static inline int ccp_copy_and_save_keypart(u8 **kpbuf, unsigned int *kplen,
 					    const u8 *buf, size_t sz)
 {
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 6924b09..4365edd 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -170,6 +170,12 @@ static inline struct crypto_akcipher *crypto_akcipher_reqtfm(
 	return __crypto_akcipher_tfm(req->base.tfm);
 }
 
+static inline struct akcipher_request *akcipher_request_cast(
+	struct crypto_async_request *req)
+{
+	return container_of(req, struct akcipher_request, base);
+}
+
 /**
  * crypto_free_akcipher() - free AKCIPHER tfm handle
  *
-- 
2.1.0

