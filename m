Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2567A6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbfG3LHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 07:07:53 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55612 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfG3LGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:06:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0DA2920067D;
        Tue, 30 Jul 2019 13:06:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 01C1C20067A;
        Tue, 30 Jul 2019 13:06:52 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 99D4C204D6;
        Tue, 30 Jul 2019 13:06:51 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v4 07/14] crypto: caam - check zero-length input
Date:   Tue, 30 Jul 2019 14:06:38 +0300
Message-Id: <1564484805-28735-8-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564484805-28735-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564484805-28735-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check zero-length input, for skcipher algorithm, to solve the extra
tests. This is a valid operation, therefore the API will return no error.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/caam/caamalg.c     | 6 ++++++
 drivers/crypto/caam/caamalg_qi.c  | 3 +++
 drivers/crypto/caam/caamalg_qi2.c | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 47e61c0..9f83b55 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -1884,6 +1884,9 @@ static int skcipher_encrypt(struct skcipher_request *req)
 	u32 *desc;
 	int ret = 0;
 
+	if (!req->cryptlen)
+		return 0;
+
 	/* allocate extended descriptor */
 	edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
 	if (IS_ERR(edesc))
@@ -1918,6 +1921,9 @@ static int skcipher_decrypt(struct skcipher_request *req)
 	u32 *desc;
 	int ret = 0;
 
+	if (!req->cryptlen)
+		return 0;
+
 	/* allocate extended descriptor */
 	edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
 	if (IS_ERR(edesc))
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 794d155d..5ba620d 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -1445,6 +1445,9 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 	struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
 	int ret;
 
+	if (!req->cryptlen)
+		return 0;
+
 	if (unlikely(caam_congested))
 		return -EAGAIN;
 
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 5fd6529..d5f6517 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -1498,6 +1498,9 @@ static int skcipher_encrypt(struct skcipher_request *req)
 	struct caam_request *caam_req = skcipher_request_ctx(req);
 	int ret;
 
+	if (!req->cryptlen)
+		return 0;
+
 	/* allocate extended descriptor */
 	edesc = skcipher_edesc_alloc(req);
 	if (IS_ERR(edesc))
@@ -1526,6 +1529,8 @@ static int skcipher_decrypt(struct skcipher_request *req)
 	struct caam_request *caam_req = skcipher_request_ctx(req);
 	int ret;
 
+	if (!req->cryptlen)
+		return 0;
 	/* allocate extended descriptor */
 	edesc = skcipher_edesc_alloc(req);
 	if (IS_ERR(edesc))
-- 
2.1.0

