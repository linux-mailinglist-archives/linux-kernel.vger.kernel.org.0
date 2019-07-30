Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21837A689
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbfG3LHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 07:07:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55642 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbfG3LGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:06:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C832200672;
        Tue, 30 Jul 2019 13:06:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EF0C20066A;
        Tue, 30 Jul 2019 13:06:52 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 152E9204D6;
        Tue, 30 Jul 2019 13:06:52 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH v4 08/14] crypto: caam - update rfc4106 sh desc to support zero length input
Date:   Tue, 30 Jul 2019 14:06:39 +0300
Message-Id: <1564484805-28735-9-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1564484805-28735-1-git-send-email-iuliana.prodan@nxp.com>
References: <1564484805-28735-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update share descriptor for rfc4106 to skip instructions in case
cryptlen is zero. If no instructions are jumped the DECO hangs and a
timeout error is thrown.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
Changes since v3:
- move the erratum workaround to reduce the chances of DECO stalling.
---
 drivers/crypto/caam/caamalg_desc.c | 47 ++++++++++++++++++++++++++------------
 drivers/crypto/caam/caamalg_desc.h |  2 +-
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_desc.c b/drivers/crypto/caam/caamalg_desc.c
index 7253183..5ddaf61 100644
--- a/drivers/crypto/caam/caamalg_desc.c
+++ b/drivers/crypto/caam/caamalg_desc.c
@@ -843,13 +843,16 @@ EXPORT_SYMBOL(cnstr_shdsc_gcm_decap);
  * @ivsize: initialization vector size
  * @icvsize: integrity check value (ICV) size (truncated or full)
  * @is_qi: true when called from caam/qi
+ *
+ * Input sequence: AAD | PTXT
+ * Output sequence: AAD | CTXT | ICV
+ * AAD length (assoclen), which includes the IV length, is available in Math3.
  */
 void cnstr_shdsc_rfc4106_encap(u32 * const desc, struct alginfo *cdata,
 			       unsigned int ivsize, unsigned int icvsize,
 			       const bool is_qi)
 {
-	u32 *key_jump_cmd;
-
+	u32 *key_jump_cmd, *zero_cryptlen_jump_cmd, *skip_instructions;
 	init_sh_desc(desc, HDR_SHARE_SERIAL);
 
 	/* Skip key loading if it is loaded due to sharing */
@@ -892,24 +895,26 @@ void cnstr_shdsc_rfc4106_encap(u32 * const desc, struct alginfo *cdata,
 	append_math_sub_imm_u32(desc, VARSEQINLEN, REG3, IMM, ivsize);
 	append_math_add(desc, VARSEQOUTLEN, ZERO, REG3, CAAM_CMD_SZ);
 
-	/* Read assoc data */
-	append_seq_fifo_load(desc, 0, FIFOLD_CLASS_CLASS1 | FIFOLDST_VLF |
-			     FIFOLD_TYPE_AAD | FIFOLD_TYPE_FLUSH1);
+	/* Skip AAD */
+	append_seq_fifo_store(desc, 0, FIFOST_TYPE_SKIP | FIFOLDST_VLF);
 
-	/* Skip IV */
-	append_seq_fifo_load(desc, ivsize, FIFOLD_CLASS_SKIP);
+	/* Read cryptlen and set this value into VARSEQOUTLEN */
+	append_math_sub(desc, VARSEQOUTLEN, SEQINLEN, REG3, CAAM_CMD_SZ);
 
-	/* Will read cryptlen bytes */
-	append_math_sub(desc, VARSEQINLEN, SEQINLEN, REG0, CAAM_CMD_SZ);
+	/* If cryptlen is ZERO jump to AAD command */
+	zero_cryptlen_jump_cmd = append_jump(desc, JUMP_TEST_ALL |
+					    JUMP_COND_MATH_Z);
 
-	/* Workaround for erratum A-005473 (simultaneous SEQ FIFO skips) */
-	append_seq_fifo_load(desc, 0, FIFOLD_CLASS_CLASS1 | FIFOLD_TYPE_MSG);
+	/* Read AAD data */
+	append_seq_fifo_load(desc, 0, FIFOLD_CLASS_CLASS1 | FIFOLDST_VLF |
+			     FIFOLD_TYPE_AAD | FIFOLD_TYPE_FLUSH1);
 
-	/* Skip assoc data */
-	append_seq_fifo_store(desc, 0, FIFOST_TYPE_SKIP | FIFOLDST_VLF);
+	/* Workaround for erratum A-005473 (simultaneous SEQ FIFO skips) */
+	append_seq_fifo_store(desc, 0, FIFOST_TYPE_MESSAGE_DATA);
 
-	/* cryptlen = seqoutlen - assoclen */
-	append_math_sub(desc, VARSEQOUTLEN, VARSEQINLEN, REG0, CAAM_CMD_SZ);
+	/* Skip IV */
+	append_seq_fifo_load(desc, ivsize, FIFOLD_CLASS_SKIP);
+	append_math_add(desc, VARSEQINLEN, VARSEQOUTLEN, REG0, CAAM_CMD_SZ);
 
 	/* Write encrypted data */
 	append_seq_fifo_store(desc, 0, FIFOST_TYPE_MESSAGE_DATA | FIFOLDST_VLF);
@@ -918,6 +923,18 @@ void cnstr_shdsc_rfc4106_encap(u32 * const desc, struct alginfo *cdata,
 	append_seq_fifo_load(desc, 0, FIFOLD_CLASS_CLASS1 | FIFOLDST_VLF |
 			     FIFOLD_TYPE_MSG | FIFOLD_TYPE_LAST1);
 
+	/* Jump instructions to avoid double reading of AAD */
+	skip_instructions = append_jump(desc, JUMP_TEST_ALL);
+
+	/* There is no input data, cryptlen = 0 */
+	set_jump_tgt_here(desc, zero_cryptlen_jump_cmd);
+
+	/* Read AAD */
+	append_seq_fifo_load(desc, 0, FIFOLD_CLASS_CLASS1 | FIFOLDST_VLF |
+			     FIFOLD_TYPE_AAD | FIFOLD_TYPE_LAST1);
+
+	set_jump_tgt_here(desc, skip_instructions);
+
 	/* Write ICV */
 	append_seq_store(desc, icvsize, LDST_CLASS_1_CCB |
 			 LDST_SRCDST_BYTE_CONTEXT);
diff --git a/drivers/crypto/caam/caamalg_desc.h b/drivers/crypto/caam/caamalg_desc.h
index da4a4ee..a6146ea 100644
--- a/drivers/crypto/caam/caamalg_desc.h
+++ b/drivers/crypto/caam/caamalg_desc.h
@@ -31,7 +31,7 @@
 #define DESC_QI_GCM_DEC_LEN		(DESC_GCM_DEC_LEN + 3 * CAAM_CMD_SZ)
 
 #define DESC_RFC4106_BASE		(3 * CAAM_CMD_SZ)
-#define DESC_RFC4106_ENC_LEN		(DESC_RFC4106_BASE + 13 * CAAM_CMD_SZ)
+#define DESC_RFC4106_ENC_LEN		(DESC_RFC4106_BASE + 16 * CAAM_CMD_SZ)
 #define DESC_RFC4106_DEC_LEN		(DESC_RFC4106_BASE + 13 * CAAM_CMD_SZ)
 #define DESC_QI_RFC4106_ENC_LEN		(DESC_RFC4106_ENC_LEN + 5 * CAAM_CMD_SZ)
 #define DESC_QI_RFC4106_DEC_LEN		(DESC_RFC4106_DEC_LEN + 5 * CAAM_CMD_SZ)
-- 
2.1.0

