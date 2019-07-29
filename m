Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC478567
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfG2Gwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 02:52:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727234AbfG2Gwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3EC1F87E38B0EC7EB497;
        Mon, 29 Jul 2019 14:52:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:32 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 17/22] staging: erofs: remove clusterbits in sbi
Date:   Mon, 29 Jul 2019 14:51:54 +0800
Message-ID: <20190729065159.62378-18-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clustersize can now be set on per-file basis
rather than per-filesystem basis.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h | 5 -----
 drivers/staging/erofs/super.c    | 9 ---------
 drivers/staging/erofs/zmap.c     | 3 +--
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index e35c7d8f75d2..be856c9facd1 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -77,8 +77,6 @@ struct erofs_sb_info {
 	struct list_head list;
 	struct mutex umount_mutex;
 
-	/* cluster size in bit shift */
-	unsigned char clusterbits;
 	/* the dedicated workstation for compression */
 	struct radix_tree_root workstn_tree;
 
@@ -267,9 +265,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 /* hard limit of pages per compressed cluster */
 #define Z_EROFS_CLUSTER_MAX_PAGES       (CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT)
 
-/* page count of a compressed cluster */
-#define erofs_clusterpages(sbi)         ((1 << (sbi)->clusterbits) / PAGE_SIZE)
-
 #define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_CLUSTER_MAX_PAGES
 #else
 #define EROFS_PCPUBUF_NR_PAGES          0
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index af5d87793e4d..dad5a3137988 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -124,15 +124,6 @@ static int superblock_read(struct super_block *sb)
 	sbi->xattr_blkaddr = le32_to_cpu(layout->xattr_blkaddr);
 #endif
 	sbi->islotbits = ffs(sizeof(struct erofs_inode_v1)) - 1;
-#ifdef CONFIG_EROFS_FS_ZIP
-	/* TODO: clusterbits should be related to inode */
-	sbi->clusterbits = blkszbits;
-
-	if (1 << (sbi->clusterbits - PAGE_SHIFT) > Z_EROFS_CLUSTER_MAX_PAGES)
-		errln("clusterbits %u is not supported on this kernel",
-		      sbi->clusterbits);
-#endif
-
 	sbi->root_nid = le16_to_cpu(layout->root_nid);
 	sbi->inos = le64_to_cpu(layout->inos);
 
diff --git a/drivers/staging/erofs/zmap.c b/drivers/staging/erofs/zmap.c
index 205e884ca4e0..aeed5c674d9e 100644
--- a/drivers/staging/erofs/zmap.c
+++ b/drivers/staging/erofs/zmap.c
@@ -13,13 +13,12 @@
 int z_erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_vnode *const vi = EROFS_V(inode);
-	struct super_block *const sb = inode->i_sb;
 
 	if (vi->datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
-		vi->z_logical_clusterbits = EROFS_SB(sb)->clusterbits;
+		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
 		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
 		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
 		set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
-- 
2.17.1

