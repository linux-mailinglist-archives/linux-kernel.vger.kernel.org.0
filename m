Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E702BA78E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 04:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfIDCfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 22:35:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35393 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbfIDCfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:35:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so9763258pfw.2;
        Tue, 03 Sep 2019 19:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vkEqfSccoN1oLEz/SRYe0sDy4jQ4PKYZEDS6j9FIsrA=;
        b=mo44f9gaZjLO5yp1PvOxiMQzQk8O9iAxlVSx4K/SQpnmG+VFBf7LRm5Ce/BXhQXPmk
         dmx/y5QZg7tGISUHQZKqmd2uKB90L2iGQbqHvM+gEAE1zpODorp5NgIqj0KzleR77Ahm
         aob6QzNhCT8vXXhbZNswr2ODMoEYxGrgzmqyalHWh59rbH/TMzAWI0dFo26PWYHGmysW
         vp7t1MRT1Ki2+dLzYt9XBSevFxp/3uoadKneQ3bRbQa4M2iU6U+fTQHa94ElwRwF9FQp
         ebas5qf5/f0Is6Tfbyk1KeICKfh5btoj+eI182SFaJwqn64CwSyRJ9uDfU0ArQsjHV7o
         kP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkEqfSccoN1oLEz/SRYe0sDy4jQ4PKYZEDS6j9FIsrA=;
        b=G2Mge0EBtyH2Ipu+nrX3Zd8m77p75aZRn7dWfSBLyD9sXzegjmihpEKMiuwkyoi8cg
         hZRWi6izfgdAg6c4QEcp1axMd+RayavpESkRlSkro4DMjhgE0kmekUiKXXWohdJBVyVf
         GAOHJLLxQdvGowfvkvOjvs4DxsPfsn4bG++SbNQeniMMArKtgqw1GSuafGw7LsK7mjI8
         Iv9B9znWplqDrfApNlEj0QiCYUsZKP9QhZmCwmdPU+DiLvwsCTl9JyGg4NU1k+veQHfQ
         k/Uchcu7LcLljxFgaEpAe83KrZNk7QoiB9nMzPWv+XdBPSew2L2XMeUW6JGlL9n8RjxF
         cz5g==
X-Gm-Message-State: APjAAAVEwYY5QvEjhyTY2+yJk6fUaOJn7a0Nc9RM14Ha2RjI6sjsbeJh
        JjE8w5Cq50gugFAxVR3jyQtWbsLIlqY=
X-Google-Smtp-Source: APXvYqzl/+Q+m0AdgnJABJi+C3BzrMBNqoW9byPFmsX+kO+EmmMx0mxCSgYdOAIG57gc1v66j7gl4A==
X-Received: by 2002:a63:1749:: with SMTP id 9mr33806066pgx.0.1567564533848;
        Tue, 03 Sep 2019 19:35:33 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id i74sm7480250pfe.28.2019.09.03.19.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 19:35:33 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] crypto: caam - use devres to unmap JR's registers
Date:   Tue,  3 Sep 2019 19:35:05 -0700
Message-Id: <20190904023515.7107-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904023515.7107-1-andrew.smirnov@gmail.com>
References: <20190904023515.7107-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devres to unmap memory and drop explicit de-initialization
code.

NOTE: There's no corresponding unmapping code in caam_jr_remove which
seems like a resource leak.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/jr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 417ad52615c6..7947d61a25cf 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -498,6 +498,7 @@ static int caam_jr_probe(struct platform_device *pdev)
 	struct caam_job_ring __iomem *ctrl;
 	struct caam_drv_private_jr *jrpriv;
 	static int total_jobrs;
+	struct resource *r;
 	int error;
 
 	jrdev = &pdev->dev;
@@ -513,9 +514,15 @@ static int caam_jr_probe(struct platform_device *pdev)
 	nprop = pdev->dev.of_node;
 	/* Get configuration properties from device tree */
 	/* First, get register page */
-	ctrl = of_iomap(nprop, 0);
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(jrdev, "platform_get_resource() failed\n");
+		return -ENOMEM;
+	}
+
+	ctrl = devm_ioremap(jrdev, r->start, resource_size(r));
 	if (!ctrl) {
-		dev_err(jrdev, "of_iomap() failed\n");
+		dev_err(jrdev, "devm_ioremap() failed\n");
 		return -ENOMEM;
 	}
 
@@ -525,7 +532,6 @@ static int caam_jr_probe(struct platform_device *pdev)
 	if (error) {
 		dev_err(jrdev, "dma_set_mask_and_coherent failed (%d)\n",
 			error);
-		iounmap(ctrl);
 		return error;
 	}
 
@@ -536,7 +542,6 @@ static int caam_jr_probe(struct platform_device *pdev)
 	error = caam_jr_init(jrdev); /* now turn on hardware */
 	if (error) {
 		irq_dispose_mapping(jrpriv->irq);
-		iounmap(ctrl);
 		return error;
 	}
 
-- 
2.21.0

