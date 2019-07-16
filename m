Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7F6A984
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 15:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbfGPNVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 09:21:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbfGPNVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:21:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A18796ABEF2862102AA7;
        Tue, 16 Jul 2019 21:21:33 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 16 Jul 2019
 21:21:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mark@fasheh.com>, <jlbec@evilplan.org>,
        <joseph.qi@linux.alibaba.com>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ocfs2: remove set but not used variable 'last_hash'
Date:   Tue, 16 Jul 2019 21:21:10 +0800
Message-ID: <20190716132110.34836-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/ocfs2/xattr.c: In function ocfs2_xattr_bucket_find:
fs/ocfs2/xattr.c:3828:6: warning: variable last_hash set but not used [-Wunused-but-set-variable]

It's never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ocfs2/xattr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 385f3aa..90c830e3 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -3825,7 +3825,6 @@ static int ocfs2_xattr_bucket_find(struct inode *inode,
 	u16 blk_per_bucket = ocfs2_blocks_per_xattr_bucket(inode->i_sb);
 	int low_bucket = 0, bucket, high_bucket;
 	struct ocfs2_xattr_bucket *search;
-	u32 last_hash;
 	u64 blkno, lower_blkno = 0;
 
 	search = ocfs2_xattr_bucket_new(inode);
@@ -3869,8 +3868,6 @@ static int ocfs2_xattr_bucket_find(struct inode *inode,
 		if (xh->xh_count)
 			xe = &xh->xh_entries[le16_to_cpu(xh->xh_count) - 1];
 
-		last_hash = le32_to_cpu(xe->xe_name_hash);
-
 		/* record lower_blkno which may be the insert place. */
 		lower_blkno = blkno;
 
-- 
2.7.4


