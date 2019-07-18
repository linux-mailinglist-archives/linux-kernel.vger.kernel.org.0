Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BA26D024
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390837AbfGROp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 10:45:59 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40228 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390707AbfGROpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:45:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 257E72001A9;
        Thu, 18 Jul 2019 16:45:42 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1913420011A;
        Thu, 18 Jul 2019 16:45:42 +0200 (CEST)
Received: from lorenz.ea.freescale.net (lorenz.ea.freescale.net [10.171.71.5])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BA56C205C7;
        Thu, 18 Jul 2019 16:45:41 +0200 (CEST)
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: [PATCH 14/14] crypto: caam - change return value in case CAAM has no MDHA
Date:   Thu, 18 Jul 2019 17:45:24 +0300
Message-Id: <1563461124-24641-15-git-send-email-iuliana.prodan@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1563461124-24641-1-git-send-email-iuliana.prodan@nxp.com>
References: <1563461124-24641-1-git-send-email-iuliana.prodan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be consistent with other CAAM modules, caamhash should return 0
instead of -ENODEV in case CAAM has no MDHA.

Based on commit 1b46c90c8e00 ("crypto: caam - convert top level drivers to libraries")
the value returned by entry point is never checked and
the exit point is always executed.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/crypto/caam/caamhash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index e89913b..d4e047f 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -2008,7 +2008,7 @@ int caam_algapi_hash_init(struct device *ctrldev)
 	 * is not present.
 	 */
 	if (!md_inst)
-		return -ENODEV;
+		return 0;
 
 	/* Limit digest size based on LP256 */
 	if (md_vid == CHA_VER_VID_MD_LP256)
-- 
2.1.0

