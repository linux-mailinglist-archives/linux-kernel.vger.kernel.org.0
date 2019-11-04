Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD57ED7CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 03:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfKDCrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 21:47:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728227AbfKDCrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 21:47:08 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DBFE7DE1AF02E49B7528;
        Mon,  4 Nov 2019 10:47:06 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019
 10:46:56 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <chao@kernel.org>, <linux-erofs@lists.ozlabs.org>
CC:     Pratik Shinde <pratikshinde320@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v7] erofs: support superblock checksum
Date:   Mon, 4 Nov 2019 10:49:37 +0800
Message-ID: <20191104024937.113939-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030050846.175623-1-gaoxiang25@huawei.com>
References: <20191030050846.175623-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pratik Shinde <pratikshinde320@gmail.com>

Introduce superblock checksum feature in order to
check at mounting time.

Note that the first 1024 bytes are ignore for x86
boot sectors and other oddities.

Link: https://lore.kernel.org/r/20191030050846.175623-1-gaoxiang25@huawei.com
Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
changes since v6:
 - fix kunmap(data) to kunmap(page) by mistake
   reported by Dan Carpenter;

 fs/erofs/Kconfig    |  1 +
 fs/erofs/erofs_fs.h |  3 ++-
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 36 ++++++++++++++++++++++++++++++++++--
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 9d634d3a1845..74b0aaa7114c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -3,6 +3,7 @@
 config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
+	select LIBCRC32C
 	help
 	  EROFS (Enhanced Read-Only File System) is a lightweight
 	  read-only file system with modern designs (eg. page-sized
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b1ee5654750d..385fa49c7749 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -11,6 +11,8 @@
 
 #define EROFS_SUPER_OFFSET      1024
 
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
+
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
  * be incompatible with this kernel version.
@@ -37,7 +39,6 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-
 	__u8 reserved2[44];
 };
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 544a453f3076..96d97eab88e3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -85,6 +85,7 @@ struct erofs_sb_info {
 
 	u8 uuid[16];                    /* 128-bit uuid for volume */
 	u8 volume_name[16];             /* volume name */
+	u32 feature_compat;
 	u32 feature_incompat;
 
 	unsigned int mount_opt;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0e369494f2f2..849c0bdf49d9 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -9,6 +9,7 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/crc32c.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -46,6 +47,30 @@ void _erofs_info(struct super_block *sb, const char *function,
 	va_end(args);
 }
 
+static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
+{
+	struct erofs_super_block *dsb;
+	u32 expected_crc, crc;
+
+	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET,
+		      EROFS_BLKSIZ - EROFS_SUPER_OFFSET, GFP_KERNEL);
+	if (!dsb)
+		return -ENOMEM;
+
+	expected_crc = le32_to_cpu(dsb->checksum);
+	dsb->checksum = 0;
+	/* to allow for x86 boot sectors and other oddities. */
+	crc = crc32c(~0, dsb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
+	kfree(dsb);
+
+	if (crc != expected_crc) {
+		erofs_err(sb, "invalid checksum 0x%08x, 0x%08x expected",
+			  crc, expected_crc);
+		return -EBADMSG;
+	}
+	return 0;
+}
+
 static void erofs_inode_init_once(void *ptr)
 {
 	struct erofs_inode *vi = ptr;
@@ -112,7 +137,7 @@ static int erofs_read_superblock(struct super_block *sb)
 
 	sbi = EROFS_SB(sb);
 
-	data = kmap_atomic(page);
+	data = kmap(page);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
@@ -121,6 +146,13 @@ static int erofs_read_superblock(struct super_block *sb)
 		goto out;
 	}
 
+	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
+	if (sbi->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
+		ret = erofs_superblock_csum_verify(sb, data);
+		if (ret)
+			goto out;
+	}
+
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
@@ -155,7 +187,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 	ret = 0;
 out:
-	kunmap_atomic(data);
+	kunmap(page);
 	put_page(page);
 	return ret;
 }
-- 
2.17.1

