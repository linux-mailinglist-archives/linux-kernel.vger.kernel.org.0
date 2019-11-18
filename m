Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE391003D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 12:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfKRLYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 06:24:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfKRLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so18999739wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uKxtxAnStDtPqjNJxBgJ+/b3/LBB3oZn+H7vofIc/Cg=;
        b=NuF6g6Vb4k/CBHwgQMTRCPWUyppGLXXzJJrSR0zVUvLxiQR1nRY9DKLq70mCasT6Al
         7rfz9gRm6WljzG6dwWznDRmRdGvZEVbisM1Jz02mnmvaK0pbSX+Z8Frz4u37kqObghY1
         AhV0Y/f08FM1NloVf5IHo2bFKTtyn/SU0k6Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKxtxAnStDtPqjNJxBgJ+/b3/LBB3oZn+H7vofIc/Cg=;
        b=dBb9MW14cyKzsBNroyT7QKEKjQB4UxWOK98Pdvc6vUeJrbtie4tara7Kmt22ILa0hE
         fWNEiksoafl0Jwm+pAJd5+Gz7QG4wZ2vNyVIFwtSP4X+XmvgrVeAE+rTF7rgrtl+KnGc
         6qLgx41AY5P3rMS9vn4djhrT+Uz7rYSmkHRWKnb7Jy8KO3i8q5nNQFiGcZuHFADFXMFq
         8N6S/F5v+m58yFPVHvnbINCMFHX54eYFd0DEAwKQHkxGirTzCpTb7eQUsaT/6jafsHnG
         V6bHGkAh73a02fdiee07RaHaLkCPELtKYMJQdAvJ1OjlJPlxCAUFWdX5Tcz2ZQ5PBDhc
         La+Q==
X-Gm-Message-State: APjAAAWffCMqtISrVzlN/FDj+OD9bpNS4IA3VQpZ7yNq3b6azq7DqgAB
        uC8vxuFjemkgnGoV7PthNQ97Rw==
X-Google-Smtp-Source: APXvYqxpW6w95kYRF9FIjVS9xnuXp9jE3D8Zuacookj/+v+EKqwQ8bCni2kQvGlSsvZBkEGhQ7vKTg==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr16431672wrq.301.1574076268431;
        Mon, 18 Nov 2019 03:24:28 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:27 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 43/48] soc: fsl: qe: avoid IS_ERR_VALUE in ucc_fast.c
Date:   Mon, 18 Nov 2019 12:23:19 +0100
Message-Id: <20191118112324.22725-44-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building this on a 64-bit platform gcc rightly warns that the
error checking is broken (-ENOMEM stored in an u32 does not compare
greater than (unsigned long)-MAX_ERRNO). Instead, change the
ucc_fast_[tr]x_virtual_fifo_base_offset members to s32 and use an
ordinary check-for-negative. Also, this avoids treating 0 as "this
cannot have been returned from qe_muram_alloc() so don't free it".

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/ucc_fast.c | 15 ++++++---------
 include/soc/fsl/qe/ucc_fast.h |  4 ++--
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
index ca0452497a20..ad6193ea4597 100644
--- a/drivers/soc/fsl/qe/ucc_fast.c
+++ b/drivers/soc/fsl/qe/ucc_fast.c
@@ -197,6 +197,8 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 			__func__);
 		return -ENOMEM;
 	}
+	uccf->ucc_fast_tx_virtual_fifo_base_offset = -1;
+	uccf->ucc_fast_rx_virtual_fifo_base_offset = -1;
 
 	/* Fill fast UCC structure */
 	uccf->uf_info = uf_info;
@@ -265,10 +267,9 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	/* Allocate memory for Tx Virtual Fifo */
 	uccf->ucc_fast_tx_virtual_fifo_base_offset =
 	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_ERR_VALUE(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
+	if (uccf->ucc_fast_tx_virtual_fifo_base_offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO\n",
 			__func__);
-		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
 		return -ENOMEM;
 	}
@@ -278,10 +279,9 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		qe_muram_alloc(uf_info->urfs +
 			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
 			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_ERR_VALUE(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
+	if (uccf->ucc_fast_rx_virtual_fifo_base_offset < 0) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO\n",
 			__func__);
-		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
 		return -ENOMEM;
 	}
@@ -384,11 +384,8 @@ void ucc_fast_free(struct ucc_fast_private * uccf)
 	if (!uccf)
 		return;
 
-	if (uccf->ucc_fast_tx_virtual_fifo_base_offset)
-		qe_muram_free(uccf->ucc_fast_tx_virtual_fifo_base_offset);
-
-	if (uccf->ucc_fast_rx_virtual_fifo_base_offset)
-		qe_muram_free(uccf->ucc_fast_rx_virtual_fifo_base_offset);
+	qe_muram_free(uccf->ucc_fast_tx_virtual_fifo_base_offset);
+	qe_muram_free(uccf->ucc_fast_rx_virtual_fifo_base_offset);
 
 	if (uccf->uf_regs)
 		iounmap(uccf->uf_regs);
diff --git a/include/soc/fsl/qe/ucc_fast.h b/include/soc/fsl/qe/ucc_fast.h
index e9cc46042a83..ba0e838f962a 100644
--- a/include/soc/fsl/qe/ucc_fast.h
+++ b/include/soc/fsl/qe/ucc_fast.h
@@ -188,9 +188,9 @@ struct ucc_fast_private {
 	int stopped_tx;		/* Whether channel has been stopped for Tx
 				   (STOP_TX, etc.) */
 	int stopped_rx;		/* Whether channel has been stopped for Rx */
-	u32 ucc_fast_tx_virtual_fifo_base_offset;/* pointer to base of Tx
+	s32 ucc_fast_tx_virtual_fifo_base_offset;/* pointer to base of Tx
 						    virtual fifo */
-	u32 ucc_fast_rx_virtual_fifo_base_offset;/* pointer to base of Rx
+	s32 ucc_fast_rx_virtual_fifo_base_offset;/* pointer to base of Rx
 						    virtual fifo */
 #ifdef STATISTICS
 	u32 tx_frames;		/* Transmitted frames counter. */
-- 
2.23.0

