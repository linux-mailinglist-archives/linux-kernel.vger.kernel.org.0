Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA627A6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 13:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfG3LHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 07:07:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55574 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbfG3LGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:06:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3318A20067F;
        Tue, 30 Jul 2019 13:06:51 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 265D120066A;
        Tue, 30 Jul 2019 13:06:51 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B6331204D6;
        Tue, 30 Jul 2019 13:06:50 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v4 05/14] crypto: caam - check authsize
Date:   Tue, 30 Jul 2019 14:06:36 +0300
Message-Id: <1564484805-28735-6-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564484805-28735-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564484805-28735-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check authsize to solve the extra tests that expect -EINVAL to be
returned when the authentication tag size is not valid.

Validated authsize for GCM, RFC4106 and RFC4543.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caamalg.c     | 13 +++++++++++++
 drivers/crypto/caam/caamalg_qi.c  | 13 +++++++++++++
 drivers/crypto/caam/caamalg_qi2.c | 13 +++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index bb38f31..0461bf3 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -376,6 +376,11 @@ static int gcm_set_sh_desc(struct crypto_aead *aead)
 static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	int err;
+
+	err = crypto_gcm_check_authsize(authsize);
+	if (err)
+		return err;
 
 	ctx->authsize = authsize;
 	gcm_set_sh_desc(authenc);
@@ -439,6 +444,11 @@ static int rfc4106_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	int err;
+
+	err = crypto_rfc4106_check_authsize(authsize);
+	if (err)
+		return err;
 
 	ctx->authsize = authsize;
 	rfc4106_set_sh_desc(authenc);
@@ -503,6 +513,9 @@ static int rfc4543_setauthsize(struct crypto_aead *authenc,
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
 
+	if (authsize != 16)
+		return -EINVAL;
+
 	ctx->authsize = authsize;
 	rfc4543_set_sh_desc(authenc);
 
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index b9c8581..8011a2a 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -371,6 +371,11 @@ static int gcm_set_sh_desc(struct crypto_aead *aead)
 static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	int err;
+
+	err = crypto_gcm_check_authsize(authsize);
+	if (err)
+		return err;
 
 	ctx->authsize = authsize;
 	gcm_set_sh_desc(authenc);
@@ -472,6 +477,11 @@ static int rfc4106_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	int err;
+
+	err = crypto_rfc4106_check_authsize(authsize);
+	if (err)
+		return err;
 
 	ctx->authsize = authsize;
 	rfc4106_set_sh_desc(authenc);
@@ -578,6 +588,9 @@ static int rfc4543_setauthsize(struct crypto_aead *authenc,
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
 
+	if (authsize != 16)
+		return -EINVAL;
+
 	ctx->authsize = authsize;
 	rfc4543_set_sh_desc(authenc);
 
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 0b672f93..e351ff2 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -719,6 +719,11 @@ static int gcm_set_sh_desc(struct crypto_aead *aead)
 static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	int err;
+
+	err = crypto_gcm_check_authsize(authsize);
+	if (err)
+		return err;
 
 	ctx->authsize = authsize;
 	gcm_set_sh_desc(authenc);
@@ -811,6 +816,11 @@ static int rfc4106_setauthsize(struct crypto_aead *authenc,
 			       unsigned int authsize)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	int err;
+
+	err = crypto_rfc4106_check_authsize(authsize);
+	if (err)
+		return err;
 
 	ctx->authsize = authsize;
 	rfc4106_set_sh_desc(authenc);
@@ -910,6 +920,9 @@ static int rfc4543_setauthsize(struct crypto_aead *authenc,
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
 
+	if (authsize != 16)
+		return -EINVAL;
+
 	ctx->authsize = authsize;
 	rfc4543_set_sh_desc(authenc);
 
-- 
2.1.0

