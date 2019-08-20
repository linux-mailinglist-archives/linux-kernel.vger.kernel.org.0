Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5A496289
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfHTOfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729812AbfHTOfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:35:24 -0400
Received: from localhost.localdomain (unknown [180.111.132.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0421214DA;
        Tue, 20 Aug 2019 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566311723;
        bh=KZ3+f1X6H8F4tdCkHq5J6hMugLIxLtLvPMyf8pCWZmE=;
        h=From:To:Cc:Subject:Date:From;
        b=lbMQfYwzX02ZUEfPxZ55RFYYjFcsyixNVlUY5BzWkjRyFeFFIuG1Wj8KYaU6Bh+Ey
         6U04GCgMt+xEeNt61/UuAEfkx6nZWPxKva44w2TXBEkMDNy81Ou229IhCcBlII+hTF
         pi0FXkeQ9rna58o/2kEaCIwaoM2USVYrAG9O0PDY=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid corruption during inline conversion
Date:   Tue, 20 Aug 2019 22:34:22 +0800
Message-Id: <20190820143422.3458-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

- f2fs_setattr
 - truncate_setsize (expand i_size)
  - f2fs_convert_inline_inode
   - f2fs_convert_inline_page
    - f2fs_reserve_block
    - f2fs_get_node_info failed

Once we fail in above path, inline flag will remain, however
- we've reserved one block at inode.i_addr[0]
- i_size has expanded

Fix error path to avoid inode corruption.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c   | 8 ++++++--
 fs/f2fs/inline.c | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2284ec706a40..05d60082da3a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -812,7 +812,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		bool to_smaller = (attr->ia_size <= i_size_read(inode));
+		loff_t old_size = i_size_read(inode);
+		bool to_smaller = (attr->ia_size <= old_size);
 
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		down_write(&F2FS_I(inode)->i_mmap_sem);
@@ -835,8 +836,11 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			/* should convert inline inode here */
 			if (!f2fs_may_inline_data(inode)) {
 				err = f2fs_convert_inline_inode(inode);
-				if (err)
+				if (err) {
+					/* recover old i_size */
+					i_size_write(inode, old_size);
 					return err;
+				}
 			}
 			inode->i_mtime = inode->i_ctime = current_time(inode);
 		}
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 78d6ebe165cd..16ebdd4d1f2c 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -131,6 +131,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 
 	err = f2fs_get_node_info(fio.sbi, dn->nid, &ni);
 	if (err) {
+		f2fs_truncate_data_blocks_range(dn, 1);
 		f2fs_put_dnode(dn);
 		return err;
 	}
-- 
2.22.0

