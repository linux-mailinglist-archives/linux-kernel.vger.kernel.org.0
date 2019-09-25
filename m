Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D879BDB04
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbfIYJbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 05:31:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731125AbfIYJbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:31:08 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 058D34ACA01DBEB8F009;
        Wed, 25 Sep 2019 17:31:06 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 25 Sep 2019 17:30:58 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix comment of f2fs_evict_inode
Date:   Wed, 25 Sep 2019 17:30:50 +0800
Message-ID: <20190925093050.118921-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

evict() should be called once i_count is zero, rather than i_nlinke
is zero.

Reported-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index db4fec30c30d..8262f4a483d3 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -632,7 +632,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 }
 
 /*
- * Called at the last iput() if i_nlink is zero
+ * Called at the last iput() if i_count is zero
  */
 void f2fs_evict_inode(struct inode *inode)
 {
-- 
2.18.0.rc1

