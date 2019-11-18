Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B438D1003F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfKRLZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 06:25:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55858 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfKRLY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so16953414wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTNGYmdFYnmbZW7BpDJGzJwkDqsYkg29EXzmXFmW/h8=;
        b=E+3xGA4/30y1DwCS+6MW7YYGmlSc0pADeOESQccEsjZe1T8x8gDceQhnCntaTw00z4
         5NUzVm8OryK5MkVuKuWGUNxfBeRIcPwKP04YhnN54u6udRog62ushjTqmuvP5rb90HvZ
         lrHDbepBipSt5Oiseoz/3j4UQfNzuYKwzLsL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTNGYmdFYnmbZW7BpDJGzJwkDqsYkg29EXzmXFmW/h8=;
        b=IclbL1atXa7CsekuYPBGRmj62vezSHLCW33fzYey23mK2qE9kNCMDf8ATJbN8QhBGS
         LfnSlIly9pg0M2pqnAWknfeqmRQNaxA2snmjOJq1wK7Vrz125xNHB1qCJAzyFFuSzh/R
         snKm0g3jz3cAeVYeRMf6YLAPIbg8cxtqY0/nJ6QPqveh0ky87ympbAOPE5F1Cv6ScN13
         rXYjRnAL6hYe534mVN/t1Ri1f2c0Z7xc2lV68hXHsJSUEkv8Ip4J3fMNc0c76PLv2ub+
         QWdBMDJx7Zl5rt5nM3hu+mXdHYG2s80H/FsVlShIMZHZX6p+Nc4G9k9I0FSG5pqpQd3m
         Ackw==
X-Gm-Message-State: APjAAAV8PHcuqdinFf8j5E3yb0O/2VFEC2zyLmElPZ1WYXUoGSZPN7HM
        tfMEkIbrf0MOQTApssSgPp9iIg==
X-Google-Smtp-Source: APXvYqyy/TvoE1YD23D4uWmSVI69+ROqT76bGVU1qLM+qZd9KsN2ZpzBpDsbthCjCr5dBm9FMEU9sQ==
X-Received: by 2002:a1c:38c3:: with SMTP id f186mr29228756wma.58.1574076264835;
        Mon, 18 Nov 2019 03:24:24 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:24 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 40/48] soc: fsl: qe: avoid IS_ERR_VALUE in ucc_slow.c
Date:   Mon, 18 Nov 2019 12:23:16 +0100
Message-Id: <20191118112324.22725-41-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to build this for a 64-bit platform, one gets warnings
from using IS_ERR_VALUE on something which is not sizeof(long).

Instead, change the various *_offset fields to store a signed integer,
and simply check for a negative return from qe_muram_alloc(). Since
qe_muram_free() now accepts and ignores a negative argument, we only
need to make sure these fields are initialized with -1, and we can
just unconditionally call qe_muram_free() in ucc_slow_free().

Note that the error case for us_pram_offset failed to set that field
to 0 (which, as noted earlier, is anyway a bogus sentinel value).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/ucc_slow.c | 22 +++++++++-------------
 include/soc/fsl/qe/ucc_slow.h |  6 +++---
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/fsl/qe/ucc_slow.c b/drivers/soc/fsl/qe/ucc_slow.c
index 9b55fd0f50c6..274d34449846 100644
--- a/drivers/soc/fsl/qe/ucc_slow.c
+++ b/drivers/soc/fsl/qe/ucc_slow.c
@@ -154,6 +154,9 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 			__func__);
 		return -ENOMEM;
 	}
+	uccs->rx_base_offset = -1;
+	uccs->tx_base_offset = -1;
+	uccs->us_pram_offset = -1;
 
 	/* Fill slow UCC structure */
 	uccs->us_info = us_info;
@@ -179,7 +182,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	/* Get PRAM base */
 	uccs->us_pram_offset =
 		qe_muram_alloc(UCC_SLOW_PRAM_SIZE, ALIGNMENT_OF_UCC_SLOW_PRAM);
-	if (IS_ERR_VALUE(uccs->us_pram_offset)) {
+	if (uccs->us_pram_offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for PRAM", __func__);
 		ucc_slow_free(uccs);
 		return -ENOMEM;
@@ -206,10 +209,9 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	uccs->rx_base_offset =
 		qe_muram_alloc(us_info->rx_bd_ring_len * sizeof(struct qe_bd),
 				QE_ALIGNMENT_OF_BD);
-	if (IS_ERR_VALUE(uccs->rx_base_offset)) {
+	if (uccs->rx_base_offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate %u RX BDs\n", __func__,
 			us_info->rx_bd_ring_len);
-		uccs->rx_base_offset = 0;
 		ucc_slow_free(uccs);
 		return -ENOMEM;
 	}
@@ -217,9 +219,8 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	uccs->tx_base_offset =
 		qe_muram_alloc(us_info->tx_bd_ring_len * sizeof(struct qe_bd),
 			QE_ALIGNMENT_OF_BD);
-	if (IS_ERR_VALUE(uccs->tx_base_offset)) {
+	if (uccs->tx_base_offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate TX BDs", __func__);
-		uccs->tx_base_offset = 0;
 		ucc_slow_free(uccs);
 		return -ENOMEM;
 	}
@@ -352,14 +353,9 @@ void ucc_slow_free(struct ucc_slow_private * uccs)
 	if (!uccs)
 		return;
 
-	if (uccs->rx_base_offset)
-		qe_muram_free(uccs->rx_base_offset);
-
-	if (uccs->tx_base_offset)
-		qe_muram_free(uccs->tx_base_offset);
-
-	if (uccs->us_pram)
-		qe_muram_free(uccs->us_pram_offset);
+	qe_muram_free(uccs->rx_base_offset);
+	qe_muram_free(uccs->tx_base_offset);
+	qe_muram_free(uccs->us_pram_offset);
 
 	if (uccs->us_regs)
 		iounmap(uccs->us_regs);
diff --git a/include/soc/fsl/qe/ucc_slow.h b/include/soc/fsl/qe/ucc_slow.h
index 8696fdea2ae9..d187a6be83bc 100644
--- a/include/soc/fsl/qe/ucc_slow.h
+++ b/include/soc/fsl/qe/ucc_slow.h
@@ -185,7 +185,7 @@ struct ucc_slow_private {
 	struct ucc_slow_info *us_info;
 	struct ucc_slow __iomem *us_regs; /* Ptr to memory map of UCC regs */
 	struct ucc_slow_pram *us_pram;	/* a pointer to the parameter RAM */
-	u32 us_pram_offset;
+	s32 us_pram_offset;
 	int enabled_tx;		/* Whether channel is enabled for Tx (ENT) */
 	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
 	int stopped_tx;		/* Whether channel has been stopped for Tx
@@ -194,8 +194,8 @@ struct ucc_slow_private {
 	struct list_head confQ;	/* frames passed to chip waiting for tx */
 	u32 first_tx_bd_mask;	/* mask is used in Tx routine to save status
 				   and length for first BD in a frame */
-	u32 tx_base_offset;	/* first BD in Tx BD table offset (In MURAM) */
-	u32 rx_base_offset;	/* first BD in Rx BD table offset (In MURAM) */
+	s32 tx_base_offset;	/* first BD in Tx BD table offset (In MURAM) */
+	s32 rx_base_offset;	/* first BD in Rx BD table offset (In MURAM) */
 	struct qe_bd *confBd;	/* next BD for confirm after Tx */
 	struct qe_bd *tx_bd;	/* next BD for new Tx request */
 	struct qe_bd *rx_bd;	/* next BD to collect after Rx */
-- 
2.23.0

