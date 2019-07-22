Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 192A36FD5F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfGVKEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 06:04:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727624AbfGVKEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:04:10 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D4D54B4D1110DC8883F8;
        Mon, 22 Jul 2019 18:04:05 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Mon, 22 Jul 2019 18:03:55 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: support fiemap() for directory inode
Date:   Mon, 22 Jul 2019 18:03:50 +0800
Message-ID: <20190722100350.117428-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust f2fs_fiemap() to support fiemap() on directory inode.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c   | 2 +-
 fs/f2fs/inline.c | 8 +++++++-
 fs/f2fs/namei.c  | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 15fb8954c363..0f1dc65c9d43 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1539,7 +1539,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
-	if (f2fs_has_inline_data(inode)) {
+	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode)) {
 		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
 		if (ret != -EAGAIN)
 			goto out;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 3613efca8c00..8c0712154fb1 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -704,7 +704,13 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
-	if (!f2fs_has_inline_data(inode)) {
+	if ((S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
+				!f2fs_has_inline_data(inode)) {
+		err = -EAGAIN;
+		goto out;
+	}
+
+	if (S_ISDIR(inode->i_mode) && !f2fs_has_inline_dentry(inode)) {
 		err = -EAGAIN;
 		goto out;
 	}
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 09fb4f31576e..7560c7ed38b1 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1254,6 +1254,7 @@ const struct inode_operations f2fs_dir_inode_operations = {
 #ifdef CONFIG_F2FS_FS_XATTR
 	.listxattr	= f2fs_listxattr,
 #endif
+	.fiemap		= f2fs_fiemap,
 };
 
 const struct inode_operations f2fs_symlink_inode_operations = {
-- 
2.18.0.rc1

