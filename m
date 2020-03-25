Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB81191EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 03:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgCYCW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 22:22:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727253AbgCYCWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:22:25 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2423E8143BBFC871EF9E;
        Wed, 25 Mar 2020 10:22:22 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Mar 2020 10:22:13 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: show compression in statx
Date:   Wed, 25 Mar 2020 10:22:09 +0800
Message-ID: <20200325022209.66156-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fstest reports below message when compression is on:

generic/424 1s ... - output mismatch
    --- tests/generic/424.out
    +++ results/generic/424.out.bad
    @@ -1,2 +1,26 @@
     QA output created by 424
    +[!] Attribute compressed should be set
    +Failed
    +stat_test failed
    +[!] Attribute compressed should be set
    +Failed
    +stat_test failed

We missed to set STATX_ATTR_COMPRESSED on compressed inode in getattr(),
fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1cc6919e1c5e..5c24f2ca3465 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -818,6 +818,8 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 	}
 
 	flags = fi->i_flags;
+	if (flags & F2FS_COMPR_FL)
+		stat->attributes |= STATX_ATTR_COMPRESSED;
 	if (flags & F2FS_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
 	if (IS_ENCRYPTED(inode))
@@ -829,7 +831,8 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 	if (IS_VERITY(inode))
 		stat->attributes |= STATX_ATTR_VERITY;
 
-	stat->attributes_mask |= (STATX_ATTR_APPEND |
+	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
+				  STATX_ATTR_APPEND |
 				  STATX_ATTR_ENCRYPTED |
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP |
-- 
2.18.0.rc1

