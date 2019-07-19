Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A377F6D780
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 01:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfGRX7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 19:59:00 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53168 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfGRX6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:58:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 964E02003C2;
        Fri, 19 Jul 2019 01:58:14 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 88EF6200003;
        Fri, 19 Jul 2019 01:58:14 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 36729205D1;
        Fri, 19 Jul 2019 01:58:14 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2 06/14] crypto: caam - check assoclen
Date:   Fri, 19 Jul 2019 02:57:48 +0300
Message-Id: <1563494276-3993-7-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1563494276-3993-1-git-send-email-iuliana.prodan@nxp.com>
References: <1563494276-3993-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check assoclen to solve the extra tests that expect -EINVAL to be
returned when the associated data size is not valid.

Validated assoclen for RFC4106 and RFC4543 which expects an assoclen
of 16 or 20.
Based on seqiv, IPsec ESP and RFC4543/RFC4106 the assoclen is sizeof IP
Header (spi, seq_no, extended seq_no) and IV len. This can be 16 or 20
bytes.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamalg.c     | 10 ++--------
 drivers/crypto/caam/caamalg_qi.c  | 10 ++--------
 drivers/crypto/caam/caamalg_qi2.c | 10 ++--------
 drivers/crypto/caam/common_if.c   | 17 +++++++++++++++++
 drivers/crypto/caam/common_if.h   |  2 ++
 5 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 6682e67..6b9937c 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -1605,10 +1605,7 @@ static int chachapoly_decrypt(struct aead_request *req)
 
 static int ipsec_gcm_encrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return gcm_encrypt(req);
+	return check_ipsec_assoclen(req->assoclen) ? : gcm_encrypt(req);
 }
 
 static int aead_encrypt(struct aead_request *req)
@@ -1682,10 +1679,7 @@ static int gcm_decrypt(struct aead_request *req)
 
 static int ipsec_gcm_decrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return gcm_decrypt(req);
+	return check_ipsec_assoclen(req->assoclen) ? : gcm_decrypt(req);
 }
 
 static int aead_decrypt(struct aead_request *req)
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 5f9b14a..69cc657 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -1244,18 +1244,12 @@ static int aead_decrypt(struct aead_request *req)
 
 static int ipsec_gcm_encrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return aead_crypt(req, true);
+	return check_ipsec_assoclen(req->assoclen) ? : aead_crypt(req, true);
 }
 
 static int ipsec_gcm_decrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return aead_crypt(req, false);
+	return check_ipsec_assoclen(req->assoclen) ? : aead_crypt(req, false);
 }
 
 static void skcipher_done(struct caam_drv_req *drv_req, u32 status)
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 0b4de21..da3452b 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -1407,18 +1407,12 @@ static int aead_decrypt(struct aead_request *req)
 
 static int ipsec_gcm_encrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return aead_encrypt(req);
+	return check_ipsec_assoclen(req->assoclen) ? : aead_encrypt(req);
 }
 
 static int ipsec_gcm_decrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return aead_decrypt(req);
+	return check_ipsec_assoclen(req->assoclen) ? : aead_decrypt(req);
 }
 
 static void skcipher_encrypt_done(void *cbk_ctx, u32 status)
diff --git a/drivers/crypto/caam/common_if.c b/drivers/crypto/caam/common_if.c
index fcf47e6..1291d3d 100644
--- a/drivers/crypto/caam/common_if.c
+++ b/drivers/crypto/caam/common_if.c
@@ -66,6 +66,23 @@ int check_rfc4106_authsize(unsigned int authsize)
 }
 EXPORT_SYMBOL(check_rfc4106_authsize);
 
+/*
+ * validate assoclen for RFC4106/RFC4543
+ */
+int check_ipsec_assoclen(unsigned int assoclen)
+{
+	switch (assoclen) {
+	case 16:
+	case 20:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(check_ipsec_assoclen);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FSL CAAM drivers common location");
 MODULE_AUTHOR("NXP Semiconductors");
diff --git a/drivers/crypto/caam/common_if.h b/drivers/crypto/caam/common_if.h
index b17386a..61d5516 100644
--- a/drivers/crypto/caam/common_if.h
+++ b/drivers/crypto/caam/common_if.h
@@ -14,4 +14,6 @@ int check_gcm_authsize(unsigned int authsize);
 
 int check_rfc4106_authsize(unsigned int authsize);
 
+int check_ipsec_assoclen(unsigned int assoclen);
+
 #endif /* CAAM_COMMON_LOCATION_H */
-- 
2.1.0

