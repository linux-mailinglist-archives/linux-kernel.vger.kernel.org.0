Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9593D12CC21
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 04:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfL3DbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 22:31:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726894AbfL3DbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 22:31:20 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D81DEA0DB7585CF34E70;
        Mon, 30 Dec 2019 11:31:17 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Dec 2019
 11:31:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <andrea.adami@gmail.com>, <bbrezillon@kernel.org>,
        <yuehaibing@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mtd: sharpslpart: Fix unsigned comparison to zero
Date:   Mon, 30 Dec 2019 11:29:45 +0800
Message-ID: <20191230032945.18708-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unsigned variable log_num is being assigned a return value
from the call to sharpsl_nand_get_logical_num that can return
-EINVAL.

Detected using Coccinelle:
./drivers/mtd/parsers/sharpslpart.c:207:6-13: WARNING: Unsigned expression compared with zero: log_num > 0

Fixes: 8a4580e4d298 ("mtd: sharpslpart: Add sharpslpart partition parser")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/parsers/sharpslpart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/parsers/sharpslpart.c b/drivers/mtd/parsers/sharpslpart.c
index e5ea612..671a618 100644
--- a/drivers/mtd/parsers/sharpslpart.c
+++ b/drivers/mtd/parsers/sharpslpart.c
@@ -165,10 +165,10 @@ static int sharpsl_nand_get_logical_num(u8 *oob)
 
 static int sharpsl_nand_init_ftl(struct mtd_info *mtd, struct sharpsl_ftl *ftl)
 {
-	unsigned int block_num, log_num, phymax;
+	unsigned int block_num, phymax;
+	int i, ret, log_num;
 	loff_t block_adr;
 	u8 *oob;
-	int i, ret;
 
 	oob = kzalloc(mtd->oobsize, GFP_KERNEL);
 	if (!oob)
-- 
2.7.4


