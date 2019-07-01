Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF673CF01
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391492AbfFKOjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 10:39:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60179 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbfFKOjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:39:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45NXhg5NYVz9v1Dv;
        Tue, 11 Jun 2019 16:39:47 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IxgbMdSW; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id W7tRNAiiyJmM; Tue, 11 Jun 2019 16:39:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45NXhg4GtBz9v1Ds;
        Tue, 11 Jun 2019 16:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560263987; bh=k8RNGVxvMOlr7lWZI+WAhX0fE8MCAVsw7YVSprOxqSY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=IxgbMdSWcp56iw9o3H+4EUqM+4gC33kTDUGMQfasNafD71NVasFP/N7Fyl2N5hCds
         O/BGEvAdGeICCFH1PKFLJY8m8X2OZUKdBeBNdtjedOdWEBUaKmAd0LTNErHkYsVOR3
         6EtuQn6CpwPhB4inbo9c4SaghYzElgOYwAwIaAv8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A1DA8B7F4;
        Tue, 11 Jun 2019 16:39:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tOxJfNgF_w_m; Tue, 11 Jun 2019 16:39:49 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C5D6A8B75B;
        Tue, 11 Jun 2019 16:39:48 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8F79A68CE5; Tue, 11 Jun 2019 14:39:48 +0000 (UTC)
Message-Id: <d9b5fade242f0806a587392d31c272709949479f.1560263641.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1560263641.git.christophe.leroy@c-s.fr>
References: <cover.1560263641.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/4] crypto: talitos - move struct talitos_edesc into
 talitos.h
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 11 Jun 2019 14:39:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next patch will require struct talitos_edesc to be defined
earlier in talitos.c

This patch moves it into talitos.h so that it can be used
from any place in talitos.c

Fixes: 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash on SEC1")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 30 ------------------------------
 drivers/crypto/talitos.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 3b3e99f1cddb..5b401aec6c84 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -951,36 +951,6 @@ static int aead_des3_setkey(struct crypto_aead *authenc,
 	goto out;
 }
 
-/*
- * talitos_edesc - s/w-extended descriptor
- * @src_nents: number of segments in input scatterlist
- * @dst_nents: number of segments in output scatterlist
- * @icv_ool: whether ICV is out-of-line
- * @iv_dma: dma address of iv for checking continuity and link table
- * @dma_len: length of dma mapped link_tbl space
- * @dma_link_tbl: bus physical address of link_tbl/buf
- * @desc: h/w descriptor
- * @link_tbl: input and output h/w link tables (if {src,dst}_nents > 1) (SEC2)
- * @buf: input and output buffeur (if {src,dst}_nents > 1) (SEC1)
- *
- * if decrypting (with authcheck), or either one of src_nents or dst_nents
- * is greater than 1, an integrity check value is concatenated to the end
- * of link_tbl data
- */
-struct talitos_edesc {
-	int src_nents;
-	int dst_nents;
-	bool icv_ool;
-	dma_addr_t iv_dma;
-	int dma_len;
-	dma_addr_t dma_link_tbl;
-	struct talitos_desc desc;
-	union {
-		struct talitos_ptr link_tbl[0];
-		u8 buf[0];
-	};
-};
-
 static void talitos_sg_unmap(struct device *dev,
 			     struct talitos_edesc *edesc,
 			     struct scatterlist *src,
diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
index 32ad4fc679ed..95f78c6d9206 100644
--- a/drivers/crypto/talitos.h
+++ b/drivers/crypto/talitos.h
@@ -42,6 +42,36 @@ struct talitos_desc {
 
 #define TALITOS_DESC_SIZE	(sizeof(struct talitos_desc) - sizeof(__be32))
 
+/*
+ * talitos_edesc - s/w-extended descriptor
+ * @src_nents: number of segments in input scatterlist
+ * @dst_nents: number of segments in output scatterlist
+ * @icv_ool: whether ICV is out-of-line
+ * @iv_dma: dma address of iv for checking continuity and link table
+ * @dma_len: length of dma mapped link_tbl space
+ * @dma_link_tbl: bus physical address of link_tbl/buf
+ * @desc: h/w descriptor
+ * @link_tbl: input and output h/w link tables (if {src,dst}_nents > 1) (SEC2)
+ * @buf: input and output buffeur (if {src,dst}_nents > 1) (SEC1)
+ *
+ * if decrypting (with authcheck), or either one of src_nents or dst_nents
+ * is greater than 1, an integrity check value is concatenated to the end
+ * of link_tbl data
+ */
+struct talitos_edesc {
+	int src_nents;
+	int dst_nents;
+	bool icv_ool;
+	dma_addr_t iv_dma;
+	int dma_len;
+	dma_addr_t dma_link_tbl;
+	struct talitos_desc desc;
+	union {
+		struct talitos_ptr link_tbl[0];
+		u8 buf[0];
+	};
+};
+
 /**
  * talitos_request - descriptor submission request
  * @desc: descriptor pointer (kernel virtual)
-- 
2.13.3

