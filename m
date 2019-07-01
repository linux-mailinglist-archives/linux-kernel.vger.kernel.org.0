Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68AE2B7D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfE0Ovb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 10:51:31 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47897 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfE0Ov3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:51:29 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4824D240006;
        Mon, 27 May 2019 14:51:23 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, igall@marvell.com
Subject: [PATCH 04/14] crypto: inside-secure - remove useless check
Date:   Mon, 27 May 2019 16:50:56 +0200
Message-Id: <20190527145106.8693-5-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527145106.8693-1-antoine.tenart@bootlin.com>
References: <20190527145106.8693-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sending an ahash request, the code checks for the extra variable
not to be 0. This check is useless as the extra variable can't be 0 at
this point (it is checked on the line just before).

This patch does not modify the driver behaviour in any way.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel_hash.c | 24 +++++++++-----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index a7cee9ed3789..58ce480690eb 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -230,19 +230,17 @@ static int safexcel_ahash_send_req(struct crypto_async_request *async, int ring,
 		if (!extra)
 			extra = crypto_ahash_blocksize(ahash);
 
-		if (extra) {
-			sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
-					   req->cache_next, extra,
-					   areq->nbytes - extra);
-
-			queued -= extra;
-			len -= extra;
-
-			if (!queued) {
-				*commands = 0;
-				*results = 0;
-				return 0;
-			}
+		sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
+				   req->cache_next, extra,
+				   areq->nbytes - extra);
+
+		queued -= extra;
+		len -= extra;
+
+		if (!queued) {
+			*commands = 0;
+			*results = 0;
+			return 0;
 		}
 	}
 
-- 
2.21.0

