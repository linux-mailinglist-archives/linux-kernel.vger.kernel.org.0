Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A84314B3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 12:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgA1Lnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 06:43:31 -0500
Received: from viti.kaiser.cx ([85.214.81.225]:39812 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgA1Ln3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:43:29 -0500
Received: from dslb-088-068-095-017.088.068.pools.vodafone-ip.de ([88.68.95.17] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1iwOcj-0008Dy-85; Tue, 28 Jan 2020 12:01:37 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/6] hwrng: imx-rngc - (trivial) simplify error prints
Date:   Tue, 28 Jan 2020 12:01:00 +0100
Message-Id: <20200128110102.11522-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200128110102.11522-1-martin@kaiser.cx>
References: <20200128110102.11522-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the device name, it is added by the dev_...() routines.

Drop the error code as well. It will be shown by the driver core when
the probe operation failed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 1381ddd5b891..8222055b9e9b 100644
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
 
 	ret = devm_hwrng_register(&pdev->dev, &rngc->rng);
 	if (ret) {
-		dev_err(&pdev->dev, "FSL RNGC registering failed (%d)\n", ret);
+		dev_err(&pdev->dev, "hwrng registration failed\n");
 		goto err;
 	}
 
-- 
2.20.1

