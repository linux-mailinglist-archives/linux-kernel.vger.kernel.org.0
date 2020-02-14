Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1A15D4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 10:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgBNJpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 04:45:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729111AbgBNJpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:45:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0EB4224E2402592F2897;
        Fri, 14 Feb 2020 17:45:06 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Feb 2020 17:44:59 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] f2fs: clean up parameter of macro XATTR_SIZE()
Date:   Fri, 14 Feb 2020 17:44:11 +0800
Message-ID: <20200214094413.12784-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200214094413.12784-1-yuchao0@huawei.com>
References: <20200214094413.12784-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 10 ++++------
 fs/f2fs/xattr.h |  3 ++-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 296b3189448a..a3360a97e624 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -312,12 +312,12 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 	if (!xnid && !inline_size)
 		return -ENODATA;
 
-	*base_size = XATTR_SIZE(xnid, inode) + XATTR_PADDING_SIZE;
+	*base_size = XATTR_SIZE(inode) + XATTR_PADDING_SIZE;
 	txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode), *base_size, GFP_NOFS);
 	if (!txattr_addr)
 		return -ENOMEM;
 
-	last_txattr_addr = (void *)txattr_addr + XATTR_SIZE(xnid, inode);
+	last_txattr_addr = (void *)txattr_addr + XATTR_SIZE(inode);
 
 	/* read from inline xattr */
 	if (inline_size) {
@@ -539,7 +539,6 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
 	struct inode *inode = d_inode(dentry);
-	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	struct f2fs_xattr_entry *entry;
 	void *base_addr, *last_base_addr;
 	int error = 0;
@@ -551,7 +550,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 	if (error)
 		return error;
 
-	last_base_addr = (void *)base_addr + XATTR_SIZE(xnid, inode);
+	last_base_addr = (void *)base_addr + XATTR_SIZE(inode);
 
 	list_for_each_xattr(entry, base_addr) {
 		const struct xattr_handler *handler =
@@ -609,7 +608,6 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 {
 	struct f2fs_xattr_entry *here, *last;
 	void *base_addr, *last_base_addr;
-	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	int found, newsize;
 	size_t len;
 	__u32 new_hsize;
@@ -633,7 +631,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (error)
 		return error;
 
-	last_base_addr = (void *)base_addr + XATTR_SIZE(xnid, inode);
+	last_base_addr = (void *)base_addr + XATTR_SIZE(inode);
 
 	/* find entry with wanted name. */
 	here = __find_xattr(base_addr, last_base_addr, index, len, name);
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index de0c600b9cab..574beea46494 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -73,7 +73,8 @@ struct f2fs_xattr_entry {
 				entry = XATTR_NEXT_ENTRY(entry))
 #define VALID_XATTR_BLOCK_SIZE	(PAGE_SIZE - sizeof(struct node_footer))
 #define XATTR_PADDING_SIZE	(sizeof(__u32))
-#define XATTR_SIZE(x,i)		(((x) ? VALID_XATTR_BLOCK_SIZE : 0) +	\
+#define XATTR_SIZE(i)		((F2FS_I(i)->i_xattr_nid ?		\
+					VALID_XATTR_BLOCK_SIZE : 0) +	\
 						(inline_xattr_size(i)))
 #define MIN_OFFSET(i)		XATTR_ALIGN(inline_xattr_size(i) +	\
 						VALID_XATTR_BLOCK_SIZE)
-- 
2.18.0.rc1

