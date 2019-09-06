Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7576EAB66A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391382AbfIFKyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 06:54:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728218AbfIFKym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:54:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 049A9D59D406580C3DA1;
        Fri,  6 Sep 2019 18:54:41 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Sep 2019 18:54:30 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid accessing uninitialized field of inode page in is_alive()
Date:   Fri, 6 Sep 2019 18:54:26 +0800
Message-ID: <20190906105426.109151-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If inode is newly created, inode page may not synchronize with inode cache,
so fields like .i_inline or .i_extra_isize could be wrong, in below call
path, we may access such wrong fields, result in failing to migrate valid
target block.

- gc_data_segment
 - is_alive
  - datablock_addr
   - offset_in_addr

Fixes: 7a2af766af15 ("f2fs: enhance on-disk inode structure scalability")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 765f13354d3f..b1840852967e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -479,6 +479,9 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
 		if (IS_ERR(page))
 			return page;
 
+		/* synchronize inode page's data from inode cache */
+		f2fs_update_inode(inode, page);
+
 		if (S_ISDIR(inode->i_mode)) {
 			/* in order to handle error case */
 			get_page(page);
-- 
2.18.0.rc1

