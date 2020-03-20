Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053CB18C59E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 04:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCTDPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 23:15:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbgCTDPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:15:43 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CC4E57B9517B1FB8A471;
        Fri, 20 Mar 2020 11:15:22 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Mar 2020 11:15:13 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <nixiaoming@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangweimin12@huawei.com>,
        <wangle6@huawei.com>
Subject: [PATCH] mtd:Fix issue where write_cached_data() fails but write() still returns success
Date:   Fri, 20 Mar 2020 11:15:11 +0800
Message-ID: <1584674111-101462-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtdblock_flush()
	-->write_cached_data()
		--->erase_write()
		     mtdblock: erase of region [0x40000, 0x20000] on "xxx" failed

Because mtdblock_flush() always returns 0,
even if write_cached_data() fails and data is not written to the device,
syscall_write() still returns success

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 drivers/mtd/mtdblock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index c06b532..078e0f6 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -294,12 +294,13 @@ static void mtdblock_release(struct mtd_blktrans_dev *mbd)
 static int mtdblock_flush(struct mtd_blktrans_dev *dev)
 {
 	struct mtdblk_dev *mtdblk = container_of(dev, struct mtdblk_dev, mbd);
+	int ret;
 
 	mutex_lock(&mtdblk->cache_mutex);
-	write_cached_data(mtdblk);
+	ret = write_cached_data(mtdblk);
 	mutex_unlock(&mtdblk->cache_mutex);
 	mtd_sync(dev->mtd);
-	return 0;
+	return ret;
 }
 
 static void mtdblock_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
-- 
1.8.5.6

