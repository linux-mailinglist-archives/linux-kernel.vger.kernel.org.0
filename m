Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6C19707
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 05:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfEJDW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 23:22:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbfEJDW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:22:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0EDE877DFFF3D5616573;
        Fri, 10 May 2019 11:22:26 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 11:22:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <richard@nod.at>, <dedekind1@gmail.com>, <adrian.hunter@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ubifs: Fix build error without CONFIG_UBIFS_FS_XATTR
Date:   Fri, 10 May 2019 11:21:44 +0800
Message-ID: <20190510032144.15060-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc build error while CONFIG_UBIFS_FS_XATTR
is not set

fs/ubifs/dir.o: In function `ubifs_unlink':
dir.c:(.text+0x260): undefined reference to `ubifs_purge_xattrs'
fs/ubifs/dir.o: In function `do_rename':
dir.c:(.text+0x1edc): undefined reference to `ubifs_purge_xattrs'
fs/ubifs/dir.o: In function `ubifs_rmdir':
dir.c:(.text+0x2638): undefined reference to `ubifs_purge_xattrs'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 9ca2d7326444 ("ubifs: Limit number of xattrs per inode")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ubifs/ubifs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 379b9f7..fd7f399 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2015,13 +2015,17 @@ int ubifs_xattr_set(struct inode *host, const char *name, const void *value,
 		    size_t size, int flags, bool check_lock);
 ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
 			size_t size);
-int ubifs_purge_xattrs(struct inode *host);
 
 #ifdef CONFIG_UBIFS_FS_XATTR
 void ubifs_evict_xattr_inode(struct ubifs_info *c, ino_t xattr_inum);
+int ubifs_purge_xattrs(struct inode *host);
 #else
 static inline void ubifs_evict_xattr_inode(struct ubifs_info *c,
 					   ino_t xattr_inum) { }
+static inline int ubifs_purge_xattrs(struct inode *host)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_UBIFS_FS_SECURITY
-- 
2.7.4


