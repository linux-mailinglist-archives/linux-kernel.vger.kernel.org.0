Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B09E076B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 17:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfJVPa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 11:30:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38215 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfJVPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:30:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so10159467pgt.5;
        Tue, 22 Oct 2019 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATIwrf/1fIEUlKhFd36q+N/Ssl36ZJUl1JImv5rIDe0=;
        b=jVYHcG2y1vchfspKigbDnXW8DzWH8gDgp1bGHchM/LqtbiplfZtL3aY7nebEPA+1o+
         sccYNTu9iARcdVNlohY/BaybEx/FNbxJCr5OmCPap95OOaiX3lCNEMg5Xll/LaOO5HKi
         xQkS4YxR/TkS/55d/Vyis6F+YcZ1EbNW+aBeISLOq5aFGRepU4Hp0umYBzQbNsv3W13a
         DjOxU2jPYMx4+pNqYj/BImnvt5iEpUHCPoJR3sX4fbXKZ6mIsFK8Ed0Xf7o2kya4czeD
         YAkqG84sh5rMbDfaF6XpZr39I9efgtNhI9BYlNXiaU5xfQVLus38x+X1EgxOXM/RwiuC
         TipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATIwrf/1fIEUlKhFd36q+N/Ssl36ZJUl1JImv5rIDe0=;
        b=Q4gi9qdqE2j4mcsoe8HpPeq4JMDI4QXfR/i5TQ+IJf1RpD+hcvcjjbgAoIk37GtFx3
         Pr2JXv1BIOcQaNaw2WO0D+oUHMlsfsYTqCy8UMTPOXhQDpPYqGqUw+lAFPj7fvl6yEOZ
         WvHHZxsZekraxP8/DmpUcR4teCNG+MAnQVvuwE+d44FHiJOEmt1yDdP12oIVj11Vg6aq
         UoETOMicMQ+x2+ShcNp+hLyQdMy1vxDtFYbJCxGwXdZssBClnuqwwoZAwoOCWmIttzJT
         CMf8AklnRQILehBubGWxTs+d8ldsuTaaTVk/wILzQFPp8TWp46Ph6B9qtbujI7aeso5h
         wUmg==
X-Gm-Message-State: APjAAAXC8uXu6zJSPQswkRhwRwbD2bG0Yt9SHAixXBlE15edVt+wkyMN
        Ma62utAb3LCqJaC5fp4KxJ2od772
X-Google-Smtp-Source: APXvYqyYaii82DUJJmMLQRC4tlBlWil3ezwfSgN0fqfJ5rXse7PaVQpC5+2uGpYACUDYs6b7VZQWfw==
X-Received: by 2002:a63:5d06:: with SMTP id r6mr4482677pgb.216.1571758225540;
        Tue, 22 Oct 2019 08:30:25 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id z63sm6066128pgb.75.2019.10.22.08.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 08:30:24 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] crypto: caam - use devres to unmap memory
Date:   Tue, 22 Oct 2019 08:30:08 -0700
Message-Id: <20191022153013.3692-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022153013.3692-1-andrew.smirnov@gmail.com>
References: <20191022153013.3692-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devres to unmap memory and drop corresponding iounmap() call.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/ctrl.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index db22777d59b4..35bf82d1bedc 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -308,11 +308,9 @@ static int caam_remove(struct platform_device *pdev)
 {
 	struct device *ctrldev;
 	struct caam_drv_private *ctrlpriv;
-	struct caam_ctrl __iomem *ctrl;
 
 	ctrldev = &pdev->dev;
 	ctrlpriv = dev_get_drvdata(ctrldev);
-	ctrl = (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
 
 	/* Remove platform devices under the crypto node */
 	of_platform_depopulate(ctrldev);
@@ -334,9 +332,6 @@ static int caam_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(ctrlpriv->dfs_root);
 #endif
 
-	/* Unmap controller region */
-	iounmap(ctrl);
-
 	return 0;
 }
 
@@ -611,10 +606,11 @@ static int caam_probe(struct platform_device *pdev)
 
 	/* Get configuration properties from device tree */
 	/* First, get register page */
-	ctrl = of_iomap(nprop, 0);
-	if (!ctrl) {
+	ctrl = devm_of_iomap(dev, nprop, 0, NULL);
+	ret = PTR_ERR_OR_ZERO(ctrl);
+	if (ret) {
 		dev_err(dev, "caam: of_iomap() failed\n");
-		return -ENOMEM;
+		return ret;
 	}
 
 	caam_little_end = !(bool)(rd_reg32(&ctrl->perfmon.status) &
@@ -632,22 +628,18 @@ static int caam_probe(struct platform_device *pdev)
 	if (ctrlpriv->qi_present && !caam_dpaa2) {
 		ret = qman_is_probed();
 		if (!ret) {
-			ret = -EPROBE_DEFER;
-			goto iounmap_ctrl;
+			return -EPROBE_DEFER;
 		} else if (ret < 0) {
 			dev_err(dev, "failing probe due to qman probe error\n");
-			ret = -ENODEV;
-			goto iounmap_ctrl;
+			return -ENODEV;
 		}
 
 		ret = qman_portals_probed();
 		if (!ret) {
-			ret = -EPROBE_DEFER;
-			goto iounmap_ctrl;
+			return -EPROBE_DEFER;
 		} else if (ret < 0) {
 			dev_err(dev, "failing probe due to qman portals probe error\n");
-			ret = -ENODEV;
-			goto iounmap_ctrl;
+			return -ENODEV;
 		}
 	}
 #endif
@@ -722,7 +714,7 @@ static int caam_probe(struct platform_device *pdev)
 	ret = dma_set_mask_and_coherent(dev, caam_get_dma_mask(dev));
 	if (ret) {
 		dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n", ret);
-		goto iounmap_ctrl;
+		return ret;
 	}
 
 	ctrlpriv->era = caam_get_era(ctrl);
@@ -927,8 +919,6 @@ static int caam_probe(struct platform_device *pdev)
 	if (ctrlpriv->qi_init)
 		caam_qi_shutdown(dev);
 #endif
-iounmap_ctrl:
-	iounmap(ctrl);
 	return ret;
 }
 
-- 
2.21.0

