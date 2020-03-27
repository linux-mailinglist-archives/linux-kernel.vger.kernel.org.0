Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A2F195018
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 05:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgC0EgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 00:36:07 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:9585 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgC0EgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 00:36:06 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5e7d8287a87-d195e; Fri, 27 Mar 2020 12:35:20 +0800 (CST)
X-RM-TRANSID: 2eec5e7d8287a87-d195e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e7d828648f-0b381;
        Fri, 27 Mar 2020 12:35:20 +0800 (CST)
X-RM-TRANSID: 2ee35e7d828648f-0b381
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     rrichter@marvell.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] mmc:cavium-octeon: remove nonsense variable coercion
Date:   Fri, 27 Mar 2020 12:36:39 +0800
Message-Id: <20200327043639.6564-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function, the variable 'base' is already 'void __iomem *base',
and the return function 'devm_platform_ioremap_resource()' also returns
this type, so the mandatory definition here is redundant.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/mmc/host/cavium-octeon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 916746c6c..e299cdd1e 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -207,13 +207,13 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-	host->base = (void __iomem *)base;
+	host->base = base;
 	host->reg_off = 0;
 
 	base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-	host->dma_base = (void __iomem *)base;
+	host->dma_base = base;
 	/*
 	 * To keep the register addresses shared we intentionaly use
 	 * a negative offset here, first register used on Octeon therefore
-- 
2.20.1.windows.1



