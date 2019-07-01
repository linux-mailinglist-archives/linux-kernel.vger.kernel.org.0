Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1592B7D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfE0OvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 10:51:21 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52915 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfE0OvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:51:21 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 41A96200013;
        Mon, 27 May 2019 14:51:11 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com
Subject: [PATCH 01/14] crypto: inside-secure - remove empty line
Date:   Mon, 27 May 2019 16:50:53 +0200
Message-Id: <20190527145106.8693-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527145106.8693-1-antoine.tenart@bootlin.com>
References: <20190527145106.8693-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cosmetic patch removing an empty line in the skcipher token creation
routine.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel_cipher.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index de4be10b172f..aca1cdf33362 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -73,7 +73,6 @@ static void safexcel_skcipher_token(struct safexcel_cipher_ctx *ctx, u8 *iv,
 			memcpy(cdesc->control_data.token, iv, DES3_EDE_BLOCK_SIZE);
 			cdesc->control_data.options |= EIP197_OPTION_2_TOKEN_IV_CMD;
 			break;
-
 		case SAFEXCEL_AES:
 			offset = AES_BLOCK_SIZE / sizeof(u32);
 			memcpy(cdesc->control_data.token, iv, AES_BLOCK_SIZE);
-- 
2.21.0

