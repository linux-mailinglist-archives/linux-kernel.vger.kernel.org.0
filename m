Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01F140C99
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 15:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAQOfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 09:35:25 -0500
Received: from inva021.nxp.com ([92.121.34.21]:36300 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgAQOfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:35:25 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C905200DE5;
        Fri, 17 Jan 2020 15:35:23 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 57034200DDB;
        Fri, 17 Jan 2020 15:35:23 +0100 (CET)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 07E6B2048C;
        Fri, 17 Jan 2020 15:35:22 +0100 (CET)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: caam - add support for i.MX8M Plus
Date:   Fri, 17 Jan 2020 16:35:13 +0200
Message-Id: <20200117143513.7652-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the crypto engine used in i.mx8mp (i.MX 8M "Plus"),
which is very similar to the one used in i.mx8mq, i.mx8mm, i.mx8mn.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 88a58a8fc533..7139366da016 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -99,12 +99,13 @@ static inline int run_descriptor_deco0(struct device *ctrldev, u32 *desc,
 
 	if (ctrlpriv->virt_en == 1 ||
 	    /*
-	     * Apparently on i.MX8MQ, 8MM, 8MN it doesn't matter if virt_en == 1
+	     * Apparently on i.MX8M{Q,M,N,P} it doesn't matter if virt_en == 1
 	     * and the following steps should be performed regardless
 	     */
 	    of_machine_is_compatible("fsl,imx8mq") ||
 	    of_machine_is_compatible("fsl,imx8mm") ||
-	    of_machine_is_compatible("fsl,imx8mn")) {
+	    of_machine_is_compatible("fsl,imx8mn") ||
+	    of_machine_is_compatible("fsl,imx8mp")) {
 		clrsetbits_32(&ctrl->deco_rsr, 0, DECORSR_JR0);
 
 		while (!(rd_reg32(&ctrl->deco_rsr) & DECORSR_VALID) &&
-- 
2.17.1

