Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D620E9E59A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 12:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfH0KYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 06:24:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47850 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728772AbfH0KYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:24:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CA05F9AD2FBE58188BD3;
        Tue, 27 Aug 2019 18:24:36 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 18:24:27 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: introduce get_available_block_count() for cleanup
Date:   Tue, 27 Aug 2019 18:24:24 +0800
Message-ID: <20190827102425.29607-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are very similar codes in inc_valid_block_count() and
inc_valid_node_count() which is used for available user block
count calculation.

This patch introduces a new helper get_available_block_count()
to include those common codes, and used it instead for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aafd9ff30f9e..c7b2b68c8c85 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1765,6 +1765,28 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
 	return false;
 }
 
+static inline unsigned int get_available_block_count(struct inode *inode,
+								bool cap)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	block_t avail_user_block_count;
+
+	avail_user_block_count = sbi->user_block_count -
+					sbi->current_reserved_blocks;
+
+	if (!__allow_reserved_blocks(sbi, inode, cap))
+		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
+
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		if (avail_user_block_count > sbi->unusable_block_count)
+			avail_user_block_count -= sbi->unusable_block_count;
+		else
+			avail_user_block_count = 0;
+	}
+
+	return avail_user_block_count;
+}
+
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count)
@@ -1791,17 +1813,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 	sbi->total_valid_block_count += (block_t)(*count);
-	avail_user_block_count = sbi->user_block_count -
-					sbi->current_reserved_blocks;
+	avail_user_block_count = get_available_block_count(inode, true);
 
-	if (!__allow_reserved_blocks(sbi, inode, true))
-		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
-	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
-		if (avail_user_block_count > sbi->unusable_block_count)
-			avail_user_block_count -= sbi->unusable_block_count;
-		else
-			avail_user_block_count = 0;
-	}
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
 		if (diff > *count)
@@ -2014,7 +2027,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
 	block_t	valid_block_count;
-	unsigned int valid_node_count, user_block_count;
+	unsigned int valid_node_count;
+	unsigned int avail_user_block_count;
 	int err;
 
 	if (is_inode) {
@@ -2036,16 +2050,10 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 
-	valid_block_count = sbi->total_valid_block_count +
-					sbi->current_reserved_blocks + 1;
-
-	if (!__allow_reserved_blocks(sbi, inode, false))
-		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
-	user_block_count = sbi->user_block_count;
-	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
-		user_block_count -= sbi->unusable_block_count;
+	valid_block_count = sbi->total_valid_block_count + 1;
+	avail_user_block_count = get_available_block_count(inode, false);
 
-	if (unlikely(valid_block_count > user_block_count)) {
+	if (unlikely(valid_block_count > avail_user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
 	}
-- 
2.18.0.rc1

