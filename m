Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A04108552
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2019 23:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKXWdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Nov 2019 17:33:23 -0500
Received: from inva020.nxp.com ([92.121.34.13]:32980 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfKXWdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 17:33:22 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C14731A07FE;
        Sun, 24 Nov 2019 23:33:20 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B45771A07F3;
        Sun, 24 Nov 2019 23:33:20 +0100 (CET)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F4F6203C5;
        Sun, 24 Nov 2019 23:33:20 +0100 (CET)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: [PATCH] crypto: caam - do not reset pointer size if caam_ptr_size is 64 bits
Date:   Mon, 25 Nov 2019 00:33:04 +0200
Message-Id: <1574634784-10571-1-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 'a1cf573ee95 ("crypto: caam - select DMA address
size at runtime")' CAAM pointer size (caam_ptr_size) is changed
from sizeof(dma_addr_t) to runtime value computed from MCFGR register.
At some point, the bit for Pointer Size should be reset to 0,
but only for the case when the CAAM pointer size if 32 bits.
Therefore, use caam_ptr_size instead of sizeof(dma_addr_t).

Fixes: a1cf573ee95 ("crypto: caam - select DMA address size at runtime")
Cc: <stable@vger.kernel.org>
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index d7c3c38..786eef6 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -674,7 +674,7 @@ static int caam_probe(struct platform_device *pdev)
 		clrsetbits_32(&ctrl->mcr, MCFGR_AWCACHE_MASK | MCFGR_LONG_PTR,
 			      MCFGR_AWCACHE_CACH | MCFGR_AWCACHE_BUFF |
 			      MCFGR_WDENABLE | MCFGR_LARGE_BURST |
-			      (sizeof(dma_addr_t) == sizeof(u64) ?
+			      (caam_ptr_sz == sizeof(u64) ?
 			       MCFGR_LONG_PTR : 0));
 
 	handle_imx6_err005766(&ctrl->mcr);
-- 
2.1.0

