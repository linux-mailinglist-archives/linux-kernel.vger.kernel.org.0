Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F946D97F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 05:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfGSDv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 23:51:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2289 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbfGSDv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:51:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E10FE1544804BADD5D11;
        Fri, 19 Jul 2019 11:51:24 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 19 Jul 2019 11:51:17 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid tagging SBI_QUOTA_NEED_REPAIR incorrectly
Date:   Fri, 19 Jul 2019 11:51:11 +0800
Message-ID: <20190719035111.121961-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a quota disabled image, with fault injection, SBI_QUOTA_NEED_REPAIR
will be set incorrectly in error path of f2fs_evict_inode(), fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index a33d7a849b2d..d1998ddf14fd 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -693,7 +693,8 @@ void f2fs_evict_inode(struct inode *inode)
 
 	if (err) {
 		f2fs_update_inode_page(inode);
-		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+		if (dquot_initialize_needed(inode))
+			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
 	}
 	sb_end_intwrite(inode->i_sb);
 no_delete:
-- 
2.18.0.rc1

