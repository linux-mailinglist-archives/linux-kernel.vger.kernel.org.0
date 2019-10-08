Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA7CF4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 10:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfJHIYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 04:24:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48300 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfJHIYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:24:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iHknF-0005xs-1K; Tue, 08 Oct 2019 08:24:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] crypto: inside-secure: fix spelling mistake "algorithmn" -> "algorithm"
Date:   Tue,  8 Oct 2019 09:24:28 +0100
Message-Id: <20191008082428.19839-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it. Add in missing
newline.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Add in newline \n

---
 drivers/crypto/inside-secure/safexcel_cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index cecc56073337..8ccc9c59f376 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -437,7 +437,7 @@ static int safexcel_aead_setkey(struct crypto_aead *ctfm, const u8 *key,
 			goto badkey;
 		break;
 	default:
-		dev_err(priv->dev, "aead: unsupported hash algorithmn");
+		dev_err(priv->dev, "aead: unsupported hash algorithm\n");
 		goto badkey;
 	}
 
-- 
2.20.1

