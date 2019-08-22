Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE779931D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 14:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbfHVMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 08:18:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729996AbfHVMSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:18:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B70F94066537A04BD966;
        Thu, 22 Aug 2019 20:18:23 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 22 Aug 2019 20:18:16 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to writeout dirty inode during node flush
Date:   Thu, 22 Aug 2019 20:17:56 +0800
Message-ID: <20190822121756.107187-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Eric reported:

On xfstest generic/204 on f2fs, I'm getting a kernel BUG.

 allocate_segment_by_default+0x9d/0x100 [f2fs]
 f2fs_allocate_data_block+0x3c0/0x5c0 [f2fs]
 do_write_page+0x62/0x110 [f2fs]
 f2fs_do_write_node_page+0x2b/0xa0 [f2fs]
 __write_node_page+0x2ec/0x590 [f2fs]
 f2fs_sync_node_pages+0x756/0x7e0 [f2fs]
 block_operations+0x25b/0x350 [f2fs]
 f2fs_write_checkpoint+0x104/0x1150 [f2fs]
 f2fs_sync_fs+0xa2/0x120 [f2fs]
 f2fs_balance_fs_bg+0x33c/0x390 [f2fs]
 f2fs_write_node_pages+0x4c/0x1f0 [f2fs]
 do_writepages+0x1c/0x70
 __writeback_single_inode+0x45/0x320
 writeback_sb_inodes+0x273/0x5c0
 wb_writeback+0xff/0x2e0
 wb_workfn+0xa1/0x370
 process_one_work+0x138/0x350
 worker_thread+0x4d/0x3d0
 kthread+0x109/0x140

The root cause of this issue is, in a very small partition, e.g.
in generic/204 testcase of fstest suit, filesystem's free space
is 50MB, so at most we can write 12800 inline inode with command:
`echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX > $SCRATCH_MNT/$i`,
then filesystem will have:
- 12800 dirty inline data page
- 12800 dirty inode page
- and 12800 dirty imeta (dirty inode)

When we flush node-inode's page cache, we can also flush inline
data with each inode page, however it will run out-of-free-space
in device, then once it triggers checkpoint, there is no room for
huge number of imeta, at this time, GC is useless, as there is no
dirty segment at all.

In order to fix this, we try to recognize inode page during
node_inode's page flushing, and update inode page from dirty inode,
so that later another imeta (dirty inode) flush can be avoided.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: fix potential deadlock
 fs/f2fs/node.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d9ba1db2d01e..e5044eec8097 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1762,6 +1762,47 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	return ret ? -EIO: 0;
 }
 
+static int f2fs_match_ino(struct inode *inode, unsigned long ino, void *data)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	bool clean;
+
+	if (inode->i_ino != ino)
+		return 0;
+
+	if (!is_inode_flag_set(inode, FI_DIRTY_INODE))
+		return 0;
+
+	spin_lock(&sbi->inode_lock[DIRTY_META]);
+	clean = list_empty(&F2FS_I(inode)->gdirty_list);
+	spin_unlock(&sbi->inode_lock[DIRTY_META]);
+
+	if (clean)
+		return 0;
+
+	inode = igrab(inode);
+	if (!inode)
+		return 0;
+	return 1;
+}
+
+static bool flush_dirty_inode(struct page *page)
+{
+	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
+	struct inode *inode;
+	nid_t ino = ino_of_node(page);
+
+	inode = find_inode_nowait(sbi->sb, ino, f2fs_match_ino, NULL);
+	if (!inode)
+		return false;
+
+	f2fs_update_inode(inode, page);
+	unlock_page(page);
+
+	iput(inode);
+	return true;
+}
+
 int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				struct writeback_control *wbc,
 				bool do_balance, enum iostat_type io_type)
@@ -1785,6 +1826,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 			bool submitted = false;
+			bool may_dirty = true;
 
 			/* give a priority to WB_SYNC threads */
 			if (atomic_read(&sbi->wb_sync_req[NODE]) &&
@@ -1832,6 +1874,13 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				goto lock_node;
 			}
 
+			/* flush dirty inode */
+			if (IS_INODE(page) && may_dirty) {
+				may_dirty = false;
+				if (flush_dirty_inode(page))
+					goto lock_node;
+			}
+
 			f2fs_wait_on_page_writeback(page, NODE, true, true);
 
 			if (!clear_page_dirty_for_io(page))
-- 
2.18.0.rc1

