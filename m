Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F251C17D495
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 16:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCHP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 11:57:34 -0400
Received: from foss.arm.com ([217.140.110.172]:45768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgCHP5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 11:57:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70B1F7FA;
        Sun,  8 Mar 2020 08:57:32 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38F4D3F6CF;
        Sun,  8 Mar 2020 08:57:31 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] crypto: ccree - only check condition if needed
Date:   Sun,  8 Mar 2020 17:57:07 +0200
Message-Id: <20200308155710.14546-5-gilad@benyossef.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200308155710.14546-1-gilad@benyossef.com>
References: <20200308155710.14546-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move testing of condition to after the point we decide if
we need it or not.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_aead.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/ccree/cc_aead.c b/drivers/crypto/ccree/cc_aead.c
index 1c5d927d632c..cce103e3b822 100644
--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -1800,12 +1800,6 @@ static int cc_gcm(struct aead_request *req, struct cc_hw_desc desc[],
 	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
 	unsigned int cipher_flow_mode;
 
-	if (req_ctx->gen_ctx.op_type == DRV_CRYPTO_DIRECTION_DECRYPT) {
-		cipher_flow_mode = AES_and_HASH;
-	} else { /* Encrypt */
-		cipher_flow_mode = AES_to_HASH_and_DOUT;
-	}
-
 	//in RFC4543 no data to encrypt. just copy data from src to dest.
 	if (req_ctx->plaintext_authenticate_only) {
 		cc_proc_cipher_desc(req, BYPASS, desc, seq_size);
@@ -1817,6 +1811,12 @@ static int cc_gcm(struct aead_request *req, struct cc_hw_desc desc[],
 		return 0;
 	}
 
+	if (req_ctx->gen_ctx.op_type == DRV_CRYPTO_DIRECTION_DECRYPT) {
+		cipher_flow_mode = AES_and_HASH;
+	} else { /* Encrypt */
+		cipher_flow_mode = AES_to_HASH_and_DOUT;
+	}
+
 	// for gcm and rfc4106.
 	cc_set_ghash_desc(req, desc, seq_size);
 	/* process(ghash) assoc data */
-- 
2.25.1

