Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1993981704
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 12:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfHEK1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 06:27:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbfHEK1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:27:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E864EAC6A14037319C23;
        Mon,  5 Aug 2019 18:27:36 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 18:27:28 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix wrong available node count calculation
Date:   Mon, 5 Aug 2019 18:27:25 +0800
Message-ID: <20190805102725.27834-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mkfs, we have counted quota file's node number in cp.valid_node_count,
so we have to avoid wrong substraction of quota node number in
.available_nid/.avail_node_count calculation.

f2fs_write_check_point_pack()
{
..
	set_cp(valid_node_count, 1 + c.quota_inum + c.lpf_inum);

Fixes: 292c196a3695 ("reserve nid resource for quota sysfile")
Fixes: 7b63f72f73af ("f2fs: fix to do sanity check on valid node/block count")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c  | 2 +-
 fs/f2fs/super.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a18b2a895771..d9ba1db2d01e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2964,7 +2964,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
 	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
-				sbi->nquota_files - F2FS_RESERVED_NODE_NUM;
+						F2FS_RESERVED_NODE_NUM;
 	nm_i->nid_cnt[FREE_NID] = 0;
 	nm_i->nid_cnt[PREALLOC_NID] = 0;
 	nm_i->nat_cnt = 0;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6a7f1166d068..118a31f90a37 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1297,8 +1297,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	else
 		buf->f_bavail = 0;
 
-	avail_node_count = sbi->total_node_count - sbi->nquota_files -
-						F2FS_RESERVED_NODE_NUM;
+	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
 
 	if (avail_node_count > user_block_count) {
 		buf->f_files = user_block_count;
@@ -2750,8 +2749,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	}
 
 	valid_node_count = le32_to_cpu(ckpt->valid_node_count);
-	avail_node_count = sbi->total_node_count - sbi->nquota_files -
-						F2FS_RESERVED_NODE_NUM;
+	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
 	if (valid_node_count > avail_node_count) {
 		f2fs_err(sbi, "Wrong valid_node_count: %u, avail_node_count: %u",
 			 valid_node_count, avail_node_count);
-- 
2.18.0.rc1

