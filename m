Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820056D785
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 01:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfGRX7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 19:59:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53130 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfGRX6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:58:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 74C522003BD;
        Fri, 19 Jul 2019 01:58:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 678C3200003;
        Fri, 19 Jul 2019 01:58:13 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B9C3205D1;
        Fri, 19 Jul 2019 01:58:13 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2 03/14] crypto: caam - update IV only when crypto operation succeeds
Date:   Fri, 19 Jul 2019 02:57:45 +0300
Message-Id: <1563494276-3993-4-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1563494276-3993-1-git-send-email-iuliana.prodan@nxp.com>
References: <1563494276-3993-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

skcipher encryption might fail and in some cases, like (invalid) input
length smaller then block size, updating the IV would lead to a useless
IV copy in case hardware issued an error.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamalg.c     | 5 ++---
 drivers/crypto/caam/caamalg_qi.c  | 4 +++-
 drivers/crypto/caam/caamalg_qi2.c | 8 ++++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 06b4f2d..28d55a0 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -990,10 +990,9 @@ static void skcipher_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
 	 * ciphertext block (CBC mode) or last counter (CTR mode).
 	 * This is used e.g. by the CTS mode.
 	 */
-	if (ivsize) {
+	if (ivsize && !ecode) {
 		memcpy(req->iv, (u8 *)edesc->sec4_sg + edesc->sec4_sg_bytes,
 		       ivsize);
-
 		print_hex_dump_debug("dstiv  @"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
 				     edesc->src_nents > 1 ? 100 : ivsize, 1);
@@ -1030,7 +1029,7 @@ static void skcipher_decrypt_done(struct device *jrdev, u32 *desc, u32 err,
 	 * ciphertext block (CBC mode) or last counter (CTR mode).
 	 * This is used e.g. by the CTS mode.
 	 */
-	if (ivsize) {
+	if (ivsize && !ecode) {
 		memcpy(req->iv, (u8 *)edesc->sec4_sg + edesc->sec4_sg_bytes,
 		       ivsize);
 
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index ab263b1..66531d6 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -1201,7 +1201,9 @@ static void skcipher_done(struct caam_drv_req *drv_req, u32 status)
 	 * ciphertext block (CBC mode) or last counter (CTR mode).
 	 * This is used e.g. by the CTS mode.
 	 */
-	memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes, ivsize);
+	if (!ecode)
+		memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes,
+		       ivsize);
 
 	qi_cache_free(edesc);
 	skcipher_request_complete(req, ecode);
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 2681581..bc370af 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -1358,7 +1358,9 @@ static void skcipher_encrypt_done(void *cbk_ctx, u32 status)
 	 * ciphertext block (CBC mode) or last counter (CTR mode).
 	 * This is used e.g. by the CTS mode.
 	 */
-	memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes, ivsize);
+	if (!ecode)
+		memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes,
+		       ivsize);
 
 	qi_cache_free(edesc);
 	skcipher_request_complete(req, ecode);
@@ -1394,7 +1396,9 @@ static void skcipher_decrypt_done(void *cbk_ctx, u32 status)
 	 * ciphertext block (CBC mode) or last counter (CTR mode).
 	 * This is used e.g. by the CTS mode.
 	 */
-	memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes, ivsize);
+	if (!ecode)
+		memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes,
+		       ivsize);
 
 	qi_cache_free(edesc);
 	skcipher_request_complete(req, ecode);
-- 
2.1.0

