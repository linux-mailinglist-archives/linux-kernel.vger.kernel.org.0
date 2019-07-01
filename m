Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B292325069
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfEUNeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 09:34:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6907 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbfEUNeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:34:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 457cDZ6D68z9v1ns;
        Tue, 21 May 2019 15:34:06 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=S3O9Monj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hN9Xq_QN1r0e; Tue, 21 May 2019 15:34:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 457cDZ5444z9v1nh;
        Tue, 21 May 2019 15:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558445646; bh=TcuJ+OElTRYibwxTdLgf+9A9AnKmYb54DTdEQjLJFJo=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=S3O9MonjIpiQ12xaI+dxvArbcylwLpVqYoRlppDeMSIe0h/yXjnEKOe9htL+5Bj0/
         5vc2p5BcwsAkRyspGAo2kWmLHhVEDGrjIG4J2Zahm3EUMFs9zRx4AU+6ePQ8m9sRSt
         eCvBuTUuxHmI5awSEJPt5KPFk5/xnPo99mD11cdg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2719E8B80D;
        Tue, 21 May 2019 15:34:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id f4BLSVzRffHC; Tue, 21 May 2019 15:34:08 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE6638B80C;
        Tue, 21 May 2019 15:34:07 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BD6E868458; Tue, 21 May 2019 13:34:07 +0000 (UTC)
Message-Id: <6edc4ab00aab67632659d12451e4437399550159.1558445259.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1558445259.git.christophe.leroy@c-s.fr>
References: <cover.1558445259.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 01/15] crypto: talitos - fix skcipher failure due to wrong
 output IV
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 21 May 2019 13:34:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selftests report the following:

[    2.984845] alg: skcipher: cbc-aes-talitos encryption test failed (wrong output IV) on test vector 0, cfg="in-place"
[    2.995377] 00000000: 3d af ba 42 9d 9e b4 30 b4 22 da 80 2c 9f ac 41
[    3.032673] alg: skcipher: cbc-des-talitos encryption test failed (wrong output IV) on test vector 0, cfg="in-place"
[    3.043185] 00000000: fe dc ba 98 76 54 32 10
[    3.063238] alg: skcipher: cbc-3des-talitos encryption test failed (wrong output IV) on test vector 0, cfg="in-place"
[    3.073818] 00000000: 7d 33 88 93 0f 93 b2 42

This above dumps show that the actual output IV is indeed the input IV.
This is due to the IV not being copied back into the request.

This patch fixes that.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 4de9d0b547b9 ("crypto: talitos - Add ablkcipher algorithms")
Cc: stable@vger.kernel.org
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
---
 drivers/crypto/talitos.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 1d429fc073d1..f443cbe7da80 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1637,11 +1637,15 @@ static void ablkcipher_done(struct device *dev,
 			    int err)
 {
 	struct ablkcipher_request *areq = context;
+	struct crypto_ablkcipher *cipher = crypto_ablkcipher_reqtfm(areq);
+	struct talitos_ctx *ctx = crypto_ablkcipher_ctx(cipher);
+	unsigned int ivsize = crypto_ablkcipher_ivsize(cipher);
 	struct talitos_edesc *edesc;
 
 	edesc = container_of(desc, struct talitos_edesc, desc);
 
 	common_nonsnoop_unmap(dev, edesc, areq);
+	memcpy(areq->info, ctx->iv, ivsize);
 
 	kfree(edesc);
 
-- 
2.13.3

