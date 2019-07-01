Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896322506E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfEUNeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 09:34:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22253 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbfEUNeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:34:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 457cDj0nJ3z9v2Xd;
        Tue, 21 May 2019 15:34:13 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=t6CTZgwB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hG5eaUQBgAeL; Tue, 21 May 2019 15:34:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 457cDh6s29z9v2XY;
        Tue, 21 May 2019 15:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558445652; bh=X7zVZkzYTN4Bnxl5JCO93V9kRHfnwn7UqNQN+g5VEK0=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=t6CTZgwBdzp8Jd5M1fZ8jjkSwqNcRj/h2e/0VQHkfaomJDDOQ4JComRYCtXR/FxV3
         CL0xFSQUUxlZR2Qa5TW4AcZm53V/GtgFEI3L7BNsJ410+7TIjt71cDeopnwA1oGmv/
         7ufeT40ldmjJVyJW9uXh+A9lQ1Nh8BTm6NMY2vcc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 570F88B80C;
        Tue, 21 May 2019 15:34:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id m-bOd9P1Jgef; Tue, 21 May 2019 15:34:14 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D8008B803;
        Tue, 21 May 2019 15:34:14 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E604268479; Tue, 21 May 2019 13:34:13 +0000 (UTC)
Message-Id: <7f868537c70e525d3f57a4223ef50d7a4d243e0a.1558445259.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1558445259.git.christophe.leroy@c-s.fr>
References: <cover.1558445259.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 07/15] crypto: talitos - fix ECB algs ivsize
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 21 May 2019 13:34:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECB's ivsize must be 0.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 5e75ae1b3cef ("crypto: talitos - add new crypto modes")
---
 drivers/crypto/talitos.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 1e5410f92166..6f6f34754ad8 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2809,7 +2809,6 @@ static struct talitos_alg_template driver_algs[] = {
 			.cra_ablkcipher = {
 				.min_keysize = AES_MIN_KEY_SIZE,
 				.max_keysize = AES_MAX_KEY_SIZE,
-				.ivsize = AES_BLOCK_SIZE,
 				.setkey = ablkcipher_aes_setkey,
 			}
 		},
@@ -2862,7 +2861,6 @@ static struct talitos_alg_template driver_algs[] = {
 			.cra_ablkcipher = {
 				.min_keysize = DES_KEY_SIZE,
 				.max_keysize = DES_KEY_SIZE,
-				.ivsize = DES_BLOCK_SIZE,
 				.setkey = ablkcipher_des_setkey,
 			}
 		},
@@ -2897,7 +2895,6 @@ static struct talitos_alg_template driver_algs[] = {
 			.cra_ablkcipher = {
 				.min_keysize = DES3_EDE_KEY_SIZE,
 				.max_keysize = DES3_EDE_KEY_SIZE,
-				.ivsize = DES3_EDE_BLOCK_SIZE,
 				.setkey = ablkcipher_des3_setkey,
 			}
 		},
-- 
2.13.3

