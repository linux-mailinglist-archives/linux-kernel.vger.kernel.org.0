Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1CE18CB58
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 11:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCTKSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 06:18:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbgCTKSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:18:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 90D8F7D434C29BE33801;
        Fri, 20 Mar 2020 18:18:07 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Mar 2020 18:17:59 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't change inode status under page lock
Date:   Fri, 20 Mar 2020 18:17:54 +0800
Message-ID: <20200320101754.36958-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to shrink page lock coverage.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 27d0dd7a16d6..0971ccc4664a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -850,12 +850,6 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 			0);
 	set_page_dirty(page);
 
-	dir->i_ctime = dir->i_mtime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir, false);
-
-	if (inode)
-		f2fs_drop_nlink(dir, inode);
-
 	if (bit_pos == NR_DENTRY_IN_BLOCK &&
 		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
 		f2fs_clear_page_cache_dirty_tag(page);
@@ -867,6 +861,12 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		f2fs_remove_dirty_inode(dir);
 	}
 	f2fs_put_page(page, 1);
+
+	dir->i_ctime = dir->i_mtime = current_time(dir);
+	f2fs_mark_inode_dirty_sync(dir, false);
+
+	if (inode)
+		f2fs_drop_nlink(dir, inode);
 }
 
 bool f2fs_empty_dir(struct inode *dir)
-- 
2.18.0.rc1

