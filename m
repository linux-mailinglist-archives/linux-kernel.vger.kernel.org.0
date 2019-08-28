Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42C49FE87
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 11:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfH1Jdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 05:33:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfH1Jdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:33:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9D1DA661CCA65AFB3D68;
        Wed, 28 Aug 2019 17:33:46 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Wed, 28 Aug 2019 17:33:40 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/4] f2fs: fix extent corrupotion during directIO in LFS mode
Date:   Wed, 28 Aug 2019 17:33:35 +0800
Message-ID: <20190828093338.29446-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In LFS mode, por_fsstress testcase reports a bug as below:

[ASSERT] (fsck_chk_inode_blk: 931)  --> ino: 0x12fe has wrong ext: [pgofs:142, blk:215424, len:16]

Since commit f847c699cff3 ("f2fs: allow out-place-update for direct
IO in LFS mode"), we start to allow OPU mode for direct IO, however,
we missed to update extent cache in __allocate_data_block(), finally,
it cause extent field being inconsistent with physical block address,
fix it.

Fixes: f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bf648c8c50ad..727df32382c6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1018,7 +1018,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
 		invalidate_mapping_pages(META_MAPPING(sbi),
 					old_blkaddr, old_blkaddr);
-	f2fs_set_data_blkaddr(dn);
+	f2fs_update_data_blkaddr(dn, dn->data_blkaddr);
 
 	/*
 	 * i_size will be updated by direct_IO. Otherwise, we'll get stale
-- 
2.18.0.rc1

