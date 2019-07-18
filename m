Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C066D018
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390673AbfGROpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 10:45:41 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40120 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfGROpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:45:39 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F3CAE200088;
        Thu, 18 Jul 2019 16:45:36 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E4821200009;
        Thu, 18 Jul 2019 16:45:36 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 98768205C7;
        Thu, 18 Jul 2019 16:45:36 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH 01/14] crypto: caam/qi - fix error handling in ERN handler
Date:   Thu, 18 Jul 2019 17:45:11 +0300
Message-Id: <1563461124-24641-2-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1563461124-24641-1-git-send-email-iuliana.prodan@nxp.com>
References: <1563461124-24641-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

ERN handler calls the caam/qi frontend "done" callback with a status
of -EIO. This is incorrect, since the callback expects a status value
meaningful for the crypto engine - hence the cryptic messages
like the one below:
platform caam_qi: 15: unknown error source

Fix this by providing the callback with:
-the status returned by the crypto engine (fd[status]) in case
it contains an error, OR
-a QI "No error" code otherwise; this will trigger the message:
platform caam_qi: 50000000: Queue Manager Interface: No error
which is fine, since QMan driver provides details about the cause of
failure

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 67c2315d ("crypto: caam - add Queue Interface (QI) backend support")
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/error.c | 1 +
 drivers/crypto/caam/qi.c    | 5 ++++-
 drivers/crypto/caam/regs.h  | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/error.c b/drivers/crypto/caam/error.c
index 4f0d458..95da6ae 100644
--- a/drivers/crypto/caam/error.c
+++ b/drivers/crypto/caam/error.c
@@ -118,6 +118,7 @@ static const struct {
 	u8 value;
 	const char *error_text;
 } qi_error_list[] = {
+	{ 0x00, "No error" },
 	{ 0x1F, "Job terminated by FQ or ICID flush" },
 	{ 0x20, "FD format error"},
 	{ 0x21, "FD command format error"},
diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index 0fe618e..19a378b 100644
--- a/drivers/crypto/caam/qi.c
+++ b/drivers/crypto/caam/qi.c
@@ -163,7 +163,10 @@ static void caam_fq_ern_cb(struct qman_portal *qm, struct qman_fq *fq,
 	dma_unmap_single(drv_req->drv_ctx->qidev, qm_fd_addr(fd),
 			 sizeof(drv_req->fd_sgt), DMA_BIDIRECTIONAL);
 
-	drv_req->cbk(drv_req, -EIO);
+	if (fd->status)
+		drv_req->cbk(drv_req, be32_to_cpu(fd->status));
+	else
+		drv_req->cbk(drv_req, JRSTA_SSRC_QI);
 }
 
 static struct qman_fq *create_caam_req_fq(struct device *qidev,
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 8591914..7c7ea8a 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -641,6 +641,7 @@ struct caam_job_ring {
 #define JRSTA_SSRC_CCB_ERROR        0x20000000
 #define JRSTA_SSRC_JUMP_HALT_USER   0x30000000
 #define JRSTA_SSRC_DECO             0x40000000
+#define JRSTA_SSRC_QI               0x50000000
 #define JRSTA_SSRC_JRERROR          0x60000000
 #define JRSTA_SSRC_JUMP_HALT_CC     0x70000000
 
-- 
2.1.0

