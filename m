Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B341C5DF61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfGCIOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 04:14:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38193 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGCIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:14:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so856374pfn.5;
        Wed, 03 Jul 2019 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6x6jWn1arFYtCfxNQ45HZjLDVkH250RmOZOdF+kQcoI=;
        b=N50zpxJwnQFYf34e2vjC/buPUEmo71NS8jbvOqdqR8/g1FHy8o3AYLowccVfeiRgcM
         n8f22BJK86jY+QLfkLJgtQSW3JIeDacJXodSJm9GO61ZVfs0Rby2wGaBnPwySgERTmxf
         oF3oqF62ynoddlZW+W2hZJMzAzctR4XtHk1rD33msYh5FqcHgqyAGu5WuXV0CV4qXPiU
         oeZe6x5WEv+lW2J7RSTmZXO/mf4xw4xPUJH2y84ZANb4tIu627NgG5cglLVYHR2fYLyH
         MCPFeXFGXx4olNZpqCPMTTlz5uqfWN8XwTXGbtHI84RnFM/tQ8i5N5nh4VgnUrnUqDgz
         q4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6x6jWn1arFYtCfxNQ45HZjLDVkH250RmOZOdF+kQcoI=;
        b=dLZEiehr5TmzJ9rUJ3jSZyyqPktX7fkdDtskIu5WTgJWFBtkkcxZi3QvwbCdniS1rl
         R5cc5HbFQa0dWPfT2K+QHagu080PNQoadSSciOocnkmV19J9JwOz1IyskCxO0ppo+H5Q
         t3ElmPhTn9mAbCFaAABk+c42nhQWabAQJ1dkEw5ymPO4PuSqU7v9gmZ0PpdEZ3FbDCoz
         neVYpJIpO66dnWqghH7fyMgCFtsnhUEJRYDJJ0unrK7zUIBmeIsaMU7eRuSUSeuHl70w
         v5w663gQEiWxC5VSTQ4CkbHBJqvA+DLDweWR6KpJIe/KG5kMG3TphTIcvVaWX9lwNgL0
         GN4A==
X-Gm-Message-State: APjAAAWoBesQB4lAVsvMcla5IaN8hCslG7qqM+FOZ4vNuro7uvPi3wbE
        1iBPqrLt4tECNE1pLgS5DBY0dTtjlDA=
X-Google-Smtp-Source: APXvYqwZYbvTT+7X+Zd3zsAH8twpYtWuKStEbv+6mrfkYCWkO469a/5y+/PYTbl8r3Gk2e05e4aNFw==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr11382311pjz.85.1562141638765;
        Wed, 03 Jul 2019 01:13:58 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id d2sm1445306pgo.0.2019.07.03.01.13.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 01:13:57 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/16] crypto: caam - move DMA mask selection into a function
Date:   Wed,  3 Jul 2019 01:13:12 -0700
Message-Id: <20190703081327.17505-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703081327.17505-1-andrew.smirnov@gmail.com>
References: <20190703081327.17505-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exactly the same code to figure out DMA mask is repeated twice in the
driver code. To avoid repetition, move that logic into a standalone
subroutine in intern.h. While at it re-shuffle the code to make it
more readable with early returns.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Cc: Chris Spencer <christopher.spencer@sea.co.uk>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/ctrl.c   | 11 +----------
 drivers/crypto/caam/intern.h | 20 ++++++++++++++++++++
 drivers/crypto/caam/jr.c     | 15 +--------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 4e43ca4d3656..e674d8770cdb 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -688,16 +688,7 @@ static int caam_probe(struct platform_device *pdev)
 			      JRSTART_JR1_START | JRSTART_JR2_START |
 			      JRSTART_JR3_START);
 
-	if (sizeof(dma_addr_t) == sizeof(u64)) {
-		if (caam_dpaa2)
-			ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(49));
-		else if (of_device_is_compatible(nprop, "fsl,sec-v5.0"))
-			ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
-		else
-			ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
-	} else {
-		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-	}
+	ret = dma_set_mask_and_coherent(dev, caam_get_dma_mask(dev));
 	if (ret) {
 		dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n", ret);
 		goto iounmap_ctrl;
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 6af84bbc612c..ec25d260fa40 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -10,6 +10,8 @@
 #ifndef INTERN_H
 #define INTERN_H
 
+#include "ctrl.h"
+
 /* Currently comes from Kconfig param as a ^2 (driver-required) */
 #define JOBR_DEPTH (1 << CONFIG_CRYPTO_DEV_FSL_CAAM_RINGSIZE)
 
@@ -215,4 +217,22 @@ DEFINE_SIMPLE_ATTRIBUTE(caam_fops_u32_ro, caam_debugfs_u32_get, NULL, "%llu\n");
 DEFINE_SIMPLE_ATTRIBUTE(caam_fops_u64_ro, caam_debugfs_u64_get, NULL, "%llu\n");
 #endif
 
+static inline u64 caam_get_dma_mask(struct device *dev)
+{
+	struct device_node *nprop = dev->of_node;
+
+	if (sizeof(dma_addr_t) != sizeof(u64))
+		return DMA_BIT_MASK(32);
+
+	if (caam_dpaa2)
+		return DMA_BIT_MASK(49);
+
+	if (of_device_is_compatible(nprop, "fsl,sec-v5.0-job-ring") ||
+	    of_device_is_compatible(nprop, "fsl,sec-v5.0"))
+		return DMA_BIT_MASK(40);
+
+	return DMA_BIT_MASK(36);
+}
+
+
 #endif /* INTERN_H */
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index cea811fed320..4b25b2fa3d02 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -543,20 +543,7 @@ static int caam_jr_probe(struct platform_device *pdev)
 
 	jrpriv->rregs = (struct caam_job_ring __iomem __force *)ctrl;
 
-	if (sizeof(dma_addr_t) == sizeof(u64)) {
-		if (caam_dpaa2)
-			error = dma_set_mask_and_coherent(jrdev,
-							  DMA_BIT_MASK(49));
-		else if (of_device_is_compatible(nprop,
-						 "fsl,sec-v5.0-job-ring"))
-			error = dma_set_mask_and_coherent(jrdev,
-							  DMA_BIT_MASK(40));
-		else
-			error = dma_set_mask_and_coherent(jrdev,
-							  DMA_BIT_MASK(36));
-	} else {
-		error = dma_set_mask_and_coherent(jrdev, DMA_BIT_MASK(32));
-	}
+	error = dma_set_mask_and_coherent(jrdev, caam_get_dma_mask(jrdev));
 	if (error) {
 		dev_err(jrdev, "dma_set_mask_and_coherent failed (%d)\n",
 			error);
-- 
2.21.0

