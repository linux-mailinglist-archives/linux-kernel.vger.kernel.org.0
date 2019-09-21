Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9EEB9CEC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 09:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437700AbfIUHcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 03:32:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731097AbfIUHcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 03:32:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0EA66880282CD6222434;
        Sat, 21 Sep 2019 15:32:02 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 21 Sep
 2019 15:31:54 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] erofs: fix erofs_get_meta_page locking by a cleanup
Date:   Sat, 21 Sep 2019 15:30:35 +0800
Message-ID: <20190921073035.209811-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After doing more drop_caches stress test on
our products, I found the mistake introduced by
a very recent cleanup [1].

The current rule is that "erofs_get_meta_page"
should be returned with page locked (although
it's mostly unnecessary for read-only fs after
pages are PG_Uptodate), but a fix should be
done for this.

[1] https://lore.kernel.org/r/20190904020912.63925-26-gaoxiang25@huawei.com
Fixes: 618f40ea026b ("erofs: use read_cache_page_gfp for erofs_get_meta_page")
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 8a9fcbd0e8ac..e0207dba31cb 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -34,11 +34,17 @@ static void erofs_readendio(struct bio *bio)
 
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 {
-	struct inode *const bd_inode = sb->s_bdev->bd_inode;
-	struct address_space *const mapping = bd_inode->i_mapping;
+	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct page *page;
 
-	return read_cache_page_gfp(mapping, blkaddr,
+	page = read_cache_page_gfp(mapping, blkaddr,
 				   mapping_gfp_constraint(mapping, ~__GFP_FS));
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	/* should already be PageUptodate */
+	lock_page(page);
+	return page;
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
-- 
2.17.1

