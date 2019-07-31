Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2EE17C2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 15:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbfGaNIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 09:08:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35178 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbfGaNI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:08:26 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 49FD81A09D5;
        Wed, 31 Jul 2019 15:08:23 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D74A1A09D1;
        Wed, 31 Jul 2019 15:08:23 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DE4CF205F3;
        Wed, 31 Jul 2019 15:08:22 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v5 06/14] crypto: caam - check assoclen
Date:   Wed, 31 Jul 2019 16:08:07 +0300
Message-Id: <1564578495-9883-7-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564578495-9883-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564578495-9883-1-git-send-email-iuliana.prodan@nxp.com>
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
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caamalg.c     | 10 ++--------
 drivers/crypto/caam/caamalg_qi.c  | 12 ++++--------
 drivers/crypto/caam/caamalg_qi2.c | 10 ++--------
 3 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 5919069..f832491 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -1598,10 +1598,7 @@ static int chachapoly_decrypt(struct aead_request *req)
 
 static int ipsec_gcm_encrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return gcm_encrypt(req);
+	return crypto_ipsec_check_assoclen(req->assoclen) ? : gcm_encrypt(req);
 }
 
 static int aead_encrypt(struct aead_request *req)
@@ -1675,10 +1672,7 @@ static int gcm_decrypt(struct aead_request *req)
 
 static int ipsec_gcm_decrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return gcm_decrypt(req);
+	return crypto_ipsec_check_assoclen(req->assoclen) ? : gcm_decrypt(req);
 }
 
 static int aead_decrypt(struct aead_request *req)
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 6c69f54..2158020 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -1237,18 +1237,14 @@ static int aead_decrypt(struct aead_request *req)
 
 static int ipsec_gcm_encrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return aead_crypt(req, true);
+	return crypto_ipsec_check_assoclen(req->assoclen) ? : aead_crypt(req,
+					   true);
 }
 
 static int ipsec_gcm_decrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return aead_crypt(req, false);
+	return crypto_ipsec_check_assoclen(req->assoclen) ? : aead_crypt(req,
+					   false);
 }
 
 static void skcipher_done(struct caam_drv_req *drv_req, u32 status)
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index b5baa17..0aed1e6 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -1406,18 +1406,12 @@ static int aead_decrypt(struct aead_request *req)
 
 static int ipsec_gcm_encrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return aead_encrypt(req);
+	return crypto_ipsec_check_assoclen(req->assoclen) ? : aead_encrypt(req);
 }
 
 static int ipsec_gcm_decrypt(struct aead_request *req)
 {
-	if (req->assoclen < 8)
-		return -EINVAL;
-
-	return aead_decrypt(req);
+	return crypto_ipsec_check_assoclen(req->assoclen) ? : aead_decrypt(req);
 }
 
 static void skcipher_encrypt_done(void *cbk_ctx, u32 status)
-- 
2.1.0

