Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E116A4CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 12:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgBXLUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 06:20:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727440AbgBXLUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:20:40 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 868F4C071FC789CF4F46;
        Mon, 24 Feb 2020 19:20:36 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Feb 2020 19:20:28 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/5] f2fs: add missing function name in kernel message
Date:   Mon, 24 Feb 2020 19:20:19 +0800
Message-ID: <20200224112019.93829-5-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200224112019.93829-1-yuchao0@huawei.com>
References: <20200224112019.93829-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, we can not distinguish the exact location of messages,
when there are more than one places printing same message.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 fs/f2fs/node.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bd264d8cddaf..4a02edc2454b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2231,7 +2231,7 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 		dquot_free_inode(inode);
 	} else {
 		if (unlikely(inode->i_blocks == 0)) {
-			f2fs_warn(sbi, "Inconsistent i_blocks, ino:%lu, iblocks:%llu",
+			f2fs_warn(sbi, "dec_valid_node_count: inconsistent i_blocks, ino:%lu, iblocks:%llu",
 				  inode->i_ino,
 				  (unsigned long long)inode->i_blocks);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 040ffb09a126..951c66d63350 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1187,8 +1187,9 @@ int f2fs_remove_inode_page(struct inode *inode)
 	}
 
 	if (unlikely(inode->i_blocks != 0 && inode->i_blocks != 8)) {
-		f2fs_warn(F2FS_I_SB(inode), "Inconsistent i_blocks, ino:%lu, iblocks:%llu",
-			  inode->i_ino, (unsigned long long)inode->i_blocks);
+		f2fs_warn(F2FS_I_SB(inode),
+			"f2fs_remove_inode_page: inconsistent i_blocks, ino:%lu, iblocks:%llu",
+			inode->i_ino, (unsigned long long)inode->i_blocks);
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 	}
 
-- 
2.18.0.rc1

