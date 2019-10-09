Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369CBD1165
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfJIOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 10:38:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfJIOir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:38:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 43DB6252E7B68721479A;
        Wed,  9 Oct 2019 22:38:45 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 22:38:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] misc: atmel_tclib: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 9 Oct 2019 22:37:52 +0800
Message-ID: <20191009143752.11236-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/misc/atmel_tclib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index 08b5b63..7de7840 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -109,7 +109,6 @@ static int __init tc_probe(struct platform_device *pdev)
 	struct atmel_tc *tc;
 	struct clk	*clk;
 	int		irq;
-	struct resource	*r;
 	unsigned int	i;
 
 	if (of_get_child_count(pdev->dev.of_node))
@@ -133,8 +132,7 @@ static int __init tc_probe(struct platform_device *pdev)
 	if (IS_ERR(tc->slow_clk))
 		return PTR_ERR(tc->slow_clk);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tc->regs = devm_ioremap_resource(&pdev->dev, r);
+	tc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tc->regs))
 		return PTR_ERR(tc->regs);
 
-- 
2.7.4


