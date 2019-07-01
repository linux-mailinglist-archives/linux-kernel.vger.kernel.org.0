Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA892A4C7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfEYOHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 10:07:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17157 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbfEYOHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:07:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 818245DBAAB06E20B619;
        Sat, 25 May 2019 22:07:27 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 22:07:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dushistov@mail.ru>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ufs: remove set but not used variable 'usb3'
Date:   Sat, 25 May 2019 22:06:54 +0800
Message-ID: <20190525140654.15924-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/ufs/super.c: In function ufs_statfs:
fs/ufs/super.c:1409:32: warning: variable usb3 set but not used [-Wunused-but-set-variable]

It is not used since commmit c596961d1b4c ("ufs: fix s_size/s_dsize users")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ufs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3d247c0d92aa..4ed0dca52ec8 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1407,11 +1407,9 @@ static int ufs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct super_block *sb = dentry->d_sb;
 	struct ufs_sb_private_info *uspi= UFS_SB(sb)->s_uspi;
 	unsigned  flags = UFS_SB(sb)->s_flags;
-	struct ufs_super_block_third *usb3;
 	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
 
 	mutex_lock(&UFS_SB(sb)->s_lock);
-	usb3 = ubh_get_usb_third(uspi);
 	
 	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
 		buf->f_type = UFS2_MAGIC;
-- 
2.17.1


