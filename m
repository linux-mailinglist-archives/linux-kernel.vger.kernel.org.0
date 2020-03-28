Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963C31965BA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 12:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgC1L1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 07:27:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbgC1L1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:27:53 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 82E2438E4A91D745D7AF;
        Sat, 28 Mar 2020 19:27:46 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 28 Mar 2020
 19:27:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <qkrwngud825@gmail.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] f2fs: xattr.h: Make stub helpers inline
Date:   Sat, 28 Mar 2020 19:27:36 +0800
Message-ID: <20200328112736.28852-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc warnings:

In file included from fs/f2fs/dir.c:15:0:
fs/f2fs/xattr.h:157:13: warning: 'f2fs_destroy_xattr_caches' defined but not used [-Wunused-function]
 static void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi) { }
             ^~~~~~~~~~~~~~~~~~~~~~~~~
fs/f2fs/xattr.h:156:12: warning: 'f2fs_init_xattr_caches' defined but not used [-Wunused-function]
 static int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: a999150f4fe3 ("f2fs: use kmem_cache pool during inline xattr lookups")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/f2fs/xattr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index e471be77f8f0..938fcd20565d 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -153,8 +153,8 @@ static inline ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer,
 {
 	return -EOPNOTSUPP;
 }
-static int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }
-static void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi) { }
+static inline int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }
+static inline void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi) { }
 #endif
 
 #ifdef CONFIG_F2FS_FS_SECURITY
-- 
2.17.1


