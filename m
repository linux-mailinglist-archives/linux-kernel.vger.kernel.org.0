Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5399FE8E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 11:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfH1JeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 05:34:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfH1JeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:34:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B51C7E97F49E86C47173;
        Wed, 28 Aug 2019 17:33:51 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Wed, 28 Aug 2019 17:33:41 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] f2fs: fix to handle error path correctly in f2fs_map_blocks
Date:   Wed, 28 Aug 2019 17:33:36 +0800
Message-ID: <20190828093338.29446-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190828093338.29446-1-yuchao0@huawei.com>
References: <20190828093338.29446-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_map_blocks(), we should bail out once __allocate_data_block()
failed.

Fixes: f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 727df32382c6..777888ba171a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1195,10 +1195,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		if (test_opt(sbi, LFS) && flag == F2FS_GET_BLOCK_DIO &&
 							map->m_may_create) {
 			err = __allocate_data_block(&dn, map->m_seg_type);
-			if (!err) {
-				blkaddr = dn.data_blkaddr;
-				set_inode_flag(inode, FI_APPEND_WRITE);
-			}
+			if (err)
+				goto sync_out;
+			blkaddr = dn.data_blkaddr;
+			set_inode_flag(inode, FI_APPEND_WRITE);
 		}
 	} else {
 		if (create) {
-- 
2.18.0.rc1

