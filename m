Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A14F6FD45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfGVJ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 05:58:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35912 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727624AbfGVJ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:58:00 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1E0733DEEFCCD6DE3289;
        Mon, 22 Jul 2019 17:57:53 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Mon, 22 Jul 2019 17:57:46 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <drosen@google.com>, Chao Yu <yuchao0@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: fix to detect cp error in f2fs_setxattr()
Date:   Mon, 22 Jul 2019 17:57:06 +0800
Message-ID: <20190722095706.116545-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190722095706.116545-1-yuchao0@huawei.com>
References: <20190722095706.116545-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It needs to return -EIO if filesystem has been shutdown, fix the
miss case in f2fs_setxattr().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 3c92f4122044..f85c810e33ca 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -730,6 +730,8 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;
 
+	if (unlikely(f2fs_cp_error(sbi)))
+		return -EIO;
 	err = f2fs_is_checkpoint_ready(sbi);
 	if (err)
 		return err;
-- 
2.18.0.rc1

