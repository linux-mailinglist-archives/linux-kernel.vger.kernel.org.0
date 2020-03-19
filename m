Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF318B2D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgCSL6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 07:58:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbgCSL6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:58:20 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CDAD0D60325B6375C21F;
        Thu, 19 Mar 2020 19:58:10 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Mar 2020 19:58:03 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/4] f2fs: fix to avoid potential deadlock
Date:   Thu, 19 Mar 2020 19:57:57 +0800
Message-ID: <20200319115800.108926-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should always check F2FS_I(inode)->cp_task condition in prior to other
conditions in __should_serialize_io() to avoid deadloop described in
commit 040d2bb318d1 ("f2fs: fix to avoid deadloop if data_flush is on"),
however we break this rule when we support compression, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dbde309349d0..5c5db09324b7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2962,15 +2962,17 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 static inline bool __should_serialize_io(struct inode *inode,
 					struct writeback_control *wbc)
 {
+	/* to avoid deadlock in path of data flush */
+	if (F2FS_I(inode)->cp_task)
+		return false;
+
 	if (!S_ISREG(inode->i_mode))
 		return false;
-	if (f2fs_compressed_file(inode))
-		return true;
 	if (IS_NOQUOTA(inode))
 		return false;
-	/* to avoid deadlock in path of data flush */
-	if (F2FS_I(inode)->cp_task)
-		return false;
+
+	if (f2fs_compressed_file(inode))
+		return true;
 	if (wbc->sync_mode != WB_SYNC_ALL)
 		return true;
 	if (get_dirty_pages(inode) >= SM_I(F2FS_I_SB(inode))->min_seq_blocks)
-- 
2.18.0.rc1

