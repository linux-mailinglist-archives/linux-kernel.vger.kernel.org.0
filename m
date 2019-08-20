Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4BB95D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 13:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfHTL0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 07:26:55 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41680 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729723AbfHTL0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:26:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9865D2001C6;
        Tue, 20 Aug 2019 13:26:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B5B12000B8;
        Tue, 20 Aug 2019 13:26:53 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 21B3E20604;
        Tue, 20 Aug 2019 13:26:53 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH] crypto: caam/qi - use print_hex_dump_debug function to print debug messages
Date:   Tue, 20 Aug 2019 14:26:39 +0300
Message-Id: <1566300399-19965-1-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use print_hex_dump_debug function to print debug messages, instead of
print_hex_dump inside #ifdef DEBUG.

Fixes: 6e005503199b ("crypto: caam - print debug messages at debug level")
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamalg_qi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index fb54b2c..3b30862 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -234,11 +234,10 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 	dma_sync_single_for_device(jrdev->parent, ctx->key_dma,
 				   ctx->adata.keylen_pad + keys.enckeylen,
 				   ctx->dir);
-#ifdef DEBUG
-	print_hex_dump(KERN_ERR, "ctx.key@" __stringify(__LINE__)": ",
-		       DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
-		       ctx->adata.keylen_pad + keys.enckeylen, 1);
-#endif
+
+	print_hex_dump_debug("ctx.key@" __stringify(__LINE__)": ",
+			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
+			     ctx->adata.keylen_pad + keys.enckeylen, 1);
 
 skip_split_key:
 	ctx->cdata.keylen = keys.enckeylen;
-- 
2.1.0

