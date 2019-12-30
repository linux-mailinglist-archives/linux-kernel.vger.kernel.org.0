Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0479F12CBFC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 03:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfL3CxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 21:53:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbfL3CxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 21:53:07 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1B6937ABC077D7266686;
        Mon, 30 Dec 2019 10:53:05 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Dec 2019
 10:52:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <frieder.schrempf@kontron.de>, <masonccyang@mxic.com.tw>,
        <allison@lohutok.net>, <yuehaibing@huawei.com>,
        <tglx@linutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mtd: rawnand: macronix: Use match_string() helper to simplify the code
Date:   Mon, 30 Dec 2019 10:52:17 +0800
Message-ID: <20191230025217.30812-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the array index of a matching string.
Use it instead of the open-coded implementation.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/nand/raw/nand_macronix.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 58511ae..5619289 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -80,12 +80,9 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
 	if (!chip->parameters.supports_set_get_features)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(broken_get_timings); i++) {
-		if (!strcmp(broken_get_timings[i], chip->parameters.model))
-			break;
-	}
-
-	if (i == ARRAY_SIZE(broken_get_timings))
+	i = match_string(broken_get_timings, ARRAY_SIZE(broken_get_timings),
+			 chip->parameters.model);
+	if (i < 0)
 		return;
 
 	bitmap_clear(chip->parameters.get_feature_list,
-- 
2.7.4


