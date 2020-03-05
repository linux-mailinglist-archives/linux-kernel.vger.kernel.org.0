Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACA417B029
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 21:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEU7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 15:59:30 -0500
Received: from viti.kaiser.cx ([85.214.81.225]:43332 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgCEU73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:59:29 -0500
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1j9xaW-0000e9-Av; Thu, 05 Mar 2020 21:59:24 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 3/5] hwrng: imx-rngc - (trivial) simplify error prints
Date:   Thu,  5 Mar 2020 21:58:22 +0100
Message-Id: <20200305205824.4371-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305205824.4371-1-martin@kaiser.cx>
References: <20200128110102.11522-1-martin@kaiser.cx>
 <20200305205824.4371-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the device name, it is added by the dev_...() routines.

Drop the error code as well. It will be shown by the driver core when
the probe operation failed.

Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 903894518c8d..92e93abcc9cc 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -258,14 +258,14 @@ static int imx_rngc_probe(struct platform_device *pdev)
 	if (self_test) {
 		ret = imx_rngc_self_test(rngc);
 		if (ret) {
-			dev_err(rngc->dev, "FSL RNGC self test failed.\n");
+			dev_err(rngc->dev, "self test failed\n");
 			goto err;
 		}
 	}
 
 	ret = hwrng_register(&rngc->rng);
 	if (ret) {
-		dev_err(&pdev->dev, "FSL RNGC registering failed (%d)\n", ret);
+		dev_err(&pdev->dev, "hwrng registration failed\n");
 		goto err;
 	}
 
-- 
2.20.1

