Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2F2B7D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfE0Ovg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 10:51:36 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:60779 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfE0Ova (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:51:30 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 4B38A200006;
        Mon, 27 May 2019 14:51:27 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com
Subject: [PATCH 05/14] crypto: inside-secure - improve the result error format when displayed
Date:   Mon, 27 May 2019 16:50:57 +0200
Message-Id: <20190527145106.8693-6-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527145106.8693-1-antoine.tenart@bootlin.com>
References: <20190527145106.8693-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result descriptors contain errors, which are represented as a
bitmap. This patch updates the error message to not treat the error as a
decimal value, but as an hexadecimal one. This helps in knowing the
value does not have a direct meaning (the set bits themselves have).

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 263bd4ce73c5..d5392893973c 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -589,7 +589,7 @@ inline int safexcel_rdesc_check_errors(struct safexcel_crypto_priv *priv,
 	if (rdesc->result_data.error_code & 0x407f) {
 		/* Fatal error (bits 0-7, 14) */
 		dev_err(priv->dev,
-			"cipher: result: result descriptor error (%d)\n",
+			"cipher: result: result descriptor error (0x%x)\n",
 			rdesc->result_data.error_code);
 		return -EIO;
 	} else if (rdesc->result_data.error_code == BIT(9)) {
-- 
2.21.0

