Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC863ABB26
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394540AbfIFOjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 10:39:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389288AbfIFOjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:39:52 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CAAB2AE8DB8E0933910;
        Fri,  6 Sep 2019 22:39:50 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 22:39:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] perf/arm-ccn: use devm_platform_ioremap_resource() to simplify code
Date:   Fri, 6 Sep 2019 22:39:28 +0800
Message-ID: <20190906143928.28412-1-yuehaibing@huawei.com>
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
 drivers/perf/arm-ccn.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 6fc0273..fee5cb2 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1477,8 +1477,7 @@ static int arm_ccn_probe(struct platform_device *pdev)
 	ccn->dev = &pdev->dev;
 	platform_set_drvdata(pdev, ccn);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ccn->base = devm_ioremap_resource(ccn->dev, res);
+	ccn->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ccn->base))
 		return PTR_ERR(ccn->base);
 
-- 
2.7.4


