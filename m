Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F291E195549
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 11:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgC0KaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 06:30:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbgC0KaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:30:12 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7AE4EB349D00C049249D;
        Fri, 27 Mar 2020 18:30:03 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Mar 2020 18:29:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: keep inline_data when compression conversion
Date:   Fri, 27 Mar 2020 18:29:52 +0800
Message-ID: <20200327102953.104035-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200327102953.104035-1-yuchao0@huawei.com>
References: <20200327102953.104035-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can keep compressed inode's data inline before inline conversion.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6cb3c6cae7cd..21f7108ca2ba 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1822,11 +1822,6 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 		if (iflags & F2FS_NOCOMP_FL)
 			return -EINVAL;
 		if (iflags & F2FS_COMPR_FL) {
-			int err = f2fs_convert_inline_inode(inode);
-
-			if (err)
-				return err;
-
 			if (!f2fs_may_compress(inode))
 				return -EINVAL;
 
-- 
2.18.0.rc1

