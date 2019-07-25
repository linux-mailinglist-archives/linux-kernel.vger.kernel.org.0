Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F667506F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404616AbfGYN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:59:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58346 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404172AbfGYN6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:58:41 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 81364200721;
        Thu, 25 Jul 2019 15:58:38 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 66F0A20071D;
        Thu, 25 Jul 2019 15:58:38 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 13778205E8;
        Thu, 25 Jul 2019 15:58:38 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 05/14] crypto: caam - check authsize
Date:   Thu, 25 Jul 2019 16:58:17 +0300
Message-Id: <1564063106-9552-6-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564063106-9552-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564063106-9552-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check authsize to solve the extra tests that expect -EINVAL to be
returned when the authentication tag size is not valid.

Validated authsize for GCM, RFC4106 and RFC4543.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamalg.c     | 13 +++++++++++++
 drivers/crypto/caam/caamalg_qi.c  | 13 +++++++++++++
 drivers/crypto/caam/caamalg_qi2.c | 13 +++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index d379ea6..dcc1b89 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -376,6 +376,11 @@ static int gcm_set_sh_desc(struct crypto_aead *aead)
 static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	int err;
+
+	err = check_gcm_authsize(authsize);
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
+	err = check_rfc4106_authsize(authsize);
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
index 6d8cdba..8bc7564 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -371,6 +371,11 @@ static int gcm_set_sh_desc(struct crypto_aead *aead)
 static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	int err;
+
+	err = check_gcm_authsize(authsize);
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
+	err = check_rfc4106_authsize(authsize);
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
index a13d05e..faea744 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -719,6 +719,11 @@ static int gcm_set_sh_desc(struct crypto_aead *aead)
 static int gcm_setauthsize(struct crypto_aead *authenc, unsigned int authsize)
 {
 	struct caam_ctx *ctx = crypto_aead_ctx(authenc);
+	int err;
+
+	err = check_gcm_authsize(authsize);
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
+	err = check_rfc4106_authsize(authsize);
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

