Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30CC4C5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 05:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfFTDh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 23:37:28 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:34698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfFTDh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:37:28 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 5AC34836891678334CF5;
        Thu, 20 Jun 2019 11:37:26 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Jun 2019 11:37:25 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 20 Jun 2019 11:37:25 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>, <pavel@ucw.cz>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: set SBI_NEED_FSCK for xattr corruption case
Date:   Thu, 20 Jun 2019 11:36:15 +0800
Message-ID: <20190620033615.32284-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190620033615.32284-1-yuchao0@huawei.com>
References: <20190620033615.32284-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If xattr is corrupted, let's print kernel message and set SBI_NEED_FSCK
for further repair.

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/xattr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 963242018663..b32c45621679 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -346,6 +346,9 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
 
 	*xe = __find_xattr(cur_addr, last_txattr_addr, index, len, name);
 	if (!*xe) {
+		f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
+								inode->i_ino);
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 		err = -EFSCORRUPTED;
 		goto out;
 	}
@@ -622,6 +625,9 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	/* find entry with wanted name. */
 	here = __find_xattr(base_addr, last_base_addr, index, len, name);
 	if (!here) {
+		f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
+								inode->i_ino);
+		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 		error = -EFSCORRUPTED;
 		goto exit;
 	}
-- 
2.18.0.rc1

