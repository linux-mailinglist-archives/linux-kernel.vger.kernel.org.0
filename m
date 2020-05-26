Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87552198989
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 03:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgCaBcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 21:32:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729021AbgCaBcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 21:32:11 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 38501D422F8AFB709CCE;
        Tue, 31 Mar 2020 09:32:08 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 31 Mar 2020 09:32:01 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <gregkh@linuxfoundation.org>
CC:     <nixiaoming@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wangle6@huawei.com>,
        <zhangweimin12@huawei.com>, <yebin10@huawei.com>,
        <houtao1@huawei.com>
Subject: [PATCH v4] mtd: clear cache_state to avoid writing to bad blocks repeatedly
Date:   Tue, 31 Mar 2020 09:31:59 +0800
Message-ID: <1585618319-119741-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function call process is as follows:
	mtd_blktrans_work()
	  while (1)
	    do_blktrans_request()
	      mtdblock_writesect()
	        do_cached_write()
	          write_cached_data() /*if cache_state is STATE_DIRTY*/
	            erase_write()

write_cached_data() returns failure without modifying cache_state
and cache_offset. So when do_cached_write() is called again,
write_cached_data() will be called again to perform erase_write()
on the same cache_offset.

But if this cache_offset points to a bad block, erase_write() will
always return -EIO. Writing to this mtdblk is equivalent to losing
the current data, and repeatedly writing to the bad block.

Repeatedly writing a bad block has no real benefits,
but brings some negative effects:
1 Lost subsequent data
2 Loss of flash device life
3 erase_write() bad blocks are very time-consuming. For example:
	the function do_erase_oneblock() in chips/cfi_cmdset_0020.c or
	chips/cfi_cmdset_0002.c may take more than 20 seconds to return

Therefore, when erase_write() returns -EIO in write_cached_data(),
clear cache_state to avoid writing to bad blocks repeatedly.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/mtdblock.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index 078e0f6..32e52d8 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -89,8 +89,6 @@ static int write_cached_data (struct mtdblk_dev *mtdblk)
 
 	ret = erase_write (mtd, mtdblk->cache_offset,
 			   mtdblk->cache_size, mtdblk->cache_data);
-	if (ret)
-		return ret;
 
 	/*
 	 * Here we could arguably set the cache state to STATE_CLEAN.
@@ -98,9 +96,14 @@ static int write_cached_data (struct mtdblk_dev *mtdblk)
 	 * be notified if this content is altered on the flash by other
 	 * means.  Let's declare it empty and leave buffering tasks to
 	 * the buffer cache instead.
+	 *
+	 * If this cache_offset points to a bad block, data cannot be
+	 * written to the device. Clear cache_state to avoid writing to
+	 * bad blocks repeatedly.
 	 */
-	mtdblk->cache_state = STATE_EMPTY;
-	return 0;
+	if (ret == 0 || ret == -EIO)
+		mtdblk->cache_state = STATE_EMPTY;
+	return ret;
 }
 
 
-- 
1.8.5.6

