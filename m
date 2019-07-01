Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CFD2507D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfEUNeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 09:34:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59399 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfEUNeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:34:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 457cDf0xPzz9v2Xb;
        Tue, 21 May 2019 15:34:10 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=gy0LY0ZC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id byM8bp_Gm7Ak; Tue, 21 May 2019 15:34:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 457cDd6zmwz9v2XY;
        Tue, 21 May 2019 15:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558445650; bh=1o48F/RCvOFMIOazQ2qnKlLn8191AY4vZ9Mdu/TThzU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=gy0LY0ZCEqUDQ2MjU5FJhFfvBuAlBGYM9izPHvWn0klDirKlX6Vn+KLAvg7L1tkkT
         Q1jIW1ACWGaF8UwAsDylnoRkukd9nvJHjNpg2ZQnA1DNX51ZfKLwipIa3D7Xrxze5N
         H7Pbje56A1M9CnM/ExZvIfZVVAf5EYR37ZMHZQqM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 695558B803;
        Tue, 21 May 2019 15:34:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KK2d7DxAwGjO; Tue, 21 May 2019 15:34:11 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E11F8B80C;
        Tue, 21 May 2019 15:34:11 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D360F68458; Tue, 21 May 2019 13:34:10 +0000 (UTC)
Message-Id: <e38f8f06ef921113a1960d18abc86db18bcb12eb.1558445259.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1558445259.git.christophe.leroy@c-s.fr>
References: <cover.1558445259.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 04/15] crypto: talitos - check AES key size
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 21 May 2019 13:34:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the HW accepts any size and silently truncates
it to the correct length, the extra tests expects EINVAL
to be returned when the key size is not valid.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 4de9d0b547b9 ("crypto: talitos - Add ablkcipher algorithms")
---
 drivers/crypto/talitos.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 6312f8d501b1..95f71e18bf55 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1622,6 +1622,18 @@ static int ablkcipher_des3_setkey(struct crypto_ablkcipher *cipher,
 	return ablkcipher_setkey(cipher, key, keylen);
 }
 
+static int ablkcipher_aes_setkey(struct crypto_ablkcipher *cipher,
+				  const u8 *key, unsigned int keylen)
+{
+	if (keylen == AES_KEYSIZE_128 || keylen == AES_KEYSIZE_192 ||
+	    keylen == AES_KEYSIZE_256)
+		return ablkcipher_setkey(cipher, key, keylen);
+
+	crypto_ablkcipher_set_flags(cipher, CRYPTO_TFM_RES_BAD_KEY_LEN);
+
+	return -EINVAL;
+}
+
 static void common_nonsnoop_unmap(struct device *dev,
 				  struct talitos_edesc *edesc,
 				  struct ablkcipher_request *areq)
@@ -2782,6 +2794,7 @@ static struct talitos_alg_template driver_algs[] = {
 				.min_keysize = AES_MIN_KEY_SIZE,
 				.max_keysize = AES_MAX_KEY_SIZE,
 				.ivsize = AES_BLOCK_SIZE,
+				.setkey = ablkcipher_aes_setkey,
 			}
 		},
 		.desc_hdr_template = DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
@@ -2798,6 +2811,7 @@ static struct talitos_alg_template driver_algs[] = {
 				.min_keysize = AES_MIN_KEY_SIZE,
 				.max_keysize = AES_MAX_KEY_SIZE,
 				.ivsize = AES_BLOCK_SIZE,
+				.setkey = ablkcipher_aes_setkey,
 			}
 		},
 		.desc_hdr_template = DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
@@ -2815,6 +2829,7 @@ static struct talitos_alg_template driver_algs[] = {
 				.min_keysize = AES_MIN_KEY_SIZE,
 				.max_keysize = AES_MAX_KEY_SIZE,
 				.ivsize = AES_BLOCK_SIZE,
+				.setkey = ablkcipher_aes_setkey,
 			}
 		},
 		.desc_hdr_template = DESC_HDR_TYPE_AESU_CTR_NONSNOOP |
-- 
2.13.3

