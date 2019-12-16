Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9764C12031D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 12:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLPLAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 06:00:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7249 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727466AbfLPLAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:00:16 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ECA08B83B02D2E9C3EF4;
        Mon, 16 Dec 2019 19:00:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 19:00:03 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <herbert@gondor.apana.org.au>, <clabbe.montjoie@gmail.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] crypto: allwinner - remove unneeded semicolon
Date:   Mon, 16 Dec 2019 18:57:04 +0800
Message-ID: <20191216105704.9841-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

./drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c:558:52-53: Unneeded semicolon

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 73a7649..5373950 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -555,7 +555,7 @@ static int sun8i_ce_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ce->base = devm_platform_ioremap_resource(pdev, 0);;
+	ce->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ce->base))
 		return PTR_ERR(ce->base);
 
-- 
2.7.4

