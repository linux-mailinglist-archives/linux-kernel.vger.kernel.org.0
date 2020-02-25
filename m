Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5816BEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 11:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgBYK06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 05:26:58 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730154AbgBYK05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:26:57 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8C569BA817E84CD5D94D;
        Tue, 25 Feb 2020 18:26:55 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 18:26:48 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to check i_compr_blocks correctly
Date:   Tue, 25 Feb 2020 18:26:46 +0800
Message-ID: <20200225102646.43367-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inode.i_blocks counts based on 512byte sector, we need to convert
to 4kb sized block count before comparing to i_compr_blocks.

In addition, add to print message when sanity check on inode
compression configs failed.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 156cc5ef3044..299611562f7e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -291,13 +291,30 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 			fi->i_flags & F2FS_COMPR_FL &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
 						i_log_cluster_size)) {
-		if (ri->i_compress_algorithm >= COMPRESS_MAX)
+		if (ri->i_compress_algorithm >= COMPRESS_MAX) {
+			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
+				"compress algorithm: %u, run fsck to fix",
+				  __func__, inode->i_ino,
+				  ri->i_compress_algorithm);
 			return false;
-		if (le64_to_cpu(ri->i_compr_blocks) > inode->i_blocks)
+		}
+		if (le64_to_cpu(ri->i_compr_blocks) >
+				SECTOR_TO_BLOCK(inode->i_blocks)) {
+			f2fs_warn(sbi, "%s: inode (ino=%lx) hash inconsistent "
+				"i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
+				  __func__, inode->i_ino,
+				  le64_to_cpu(ri->i_compr_blocks),
+				  SECTOR_TO_BLOCK(inode->i_blocks));
 			return false;
+		}
 		if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
-			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE)
+			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
+			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
+				"log cluster size: %u, run fsck to fix",
+				  __func__, inode->i_ino,
+				  ri->i_log_cluster_size);
 			return false;
+		}
 	}
 
 	return true;
-- 
2.18.0.rc1

