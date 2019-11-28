Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F9010CAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 15:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfK1O6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 09:58:10 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40365 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfK1O6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:58:05 -0500
Received: by mail-lf1-f66.google.com with SMTP id y5so7553367lfy.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PyA4fvyHPic1hHseYG61wC3TVgVcfbpZ17hSo3R3QxM=;
        b=H9GNJFOo2tBgwxNF/Mvxe35zT+dq5pwGZ0owmVOSIU2EzzDigi/R9KMcG5HAWIvrIT
         Qg8Nh9+oMFaBwCtzZOFWvEKKLVFDWNsMN4jJfpL5FlPmX8MwlNNI2NkNfPBm9Af9pQxA
         iRix/HHPfoc8REM8iZpZBBjYY/GcODdO3UCM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PyA4fvyHPic1hHseYG61wC3TVgVcfbpZ17hSo3R3QxM=;
        b=YwiKRvYSfdEep3qFVVqcX1es1BgtUmjiQvuQyE2WI8319NQ6M5vCDaTk2jvfXK9/Aa
         QfcIUCCYg+AnxdMvXJmJdeVTvHkMjPpsTWEasWmuyf3WRL2/NAd+iTlWL1ScT7+4uSzM
         INtngmnoL2R2zAJ77DosKlHisP2crLkW1XoOwtk6kIKmgkYurtdqUjmmFHJRKQYcmvNe
         s3U4X9+IequYdh7oqtB4iEGceAHaCnpmjUw9LwtmjvISvIK8wz8VPs5jXa3om4puE+VV
         0dKzhVdCjritZpCHk9h0o7s5ny5vdh2AQ6cRIJxrXClAHbBWfVbok16qBeQmlH720nzt
         QhDQ==
X-Gm-Message-State: APjAAAXsAXtyv228rJE1UaCcS9WmdK7a5fbGDCne+5QAWs2xAMKWmZCB
        FQjGJUTVL4w8GpPsvd8mZxWrIw==
X-Google-Smtp-Source: APXvYqyvt7YRsEI3f7Rdq/jHii7xfNyBE/f16tqd63AmAMdURuB/Q1c5U4ESjLrpdqfvdabSVNzicQ==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr1872602lfa.70.1574953081096;
        Thu, 28 Nov 2019 06:58:01 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:58:00 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 43/49] soc: fsl: qe: avoid IS_ERR_VALUE in ucc_fast.c
Date:   Thu, 28 Nov 2019 15:55:48 +0100
Message-Id: <20191128145554.1297-44-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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

Reviewed-by: Timur Tabi <timur@kernel.org>
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

