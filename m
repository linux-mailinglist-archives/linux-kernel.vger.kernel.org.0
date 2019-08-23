Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D39AC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 11:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403801AbfHWJ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 05:58:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726508AbfHWJ6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:58:49 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A9DD7CAD03B67576FF9E;
        Fri, 23 Aug 2019 17:58:46 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 23 Aug 2019 17:58:38 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: fix wrong error injection path in inc_valid_block_count()
Date:   Fri, 23 Aug 2019 17:58:34 +0800
Message-ID: <20190823095836.28569-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If FAULT_BLOCK type error injection is on, in inc_valid_block_count()
we may decrease sbi->alloc_valid_block_count percpu stat count
incorrectly, fix it.

Fixes: 36b877af7992 ("f2fs: Keep alloc_valid_block_count in sync")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2b8b6b305164..4673c3152508 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1791,7 +1791,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	if (time_to_inject(sbi, FAULT_BLOCK)) {
 		f2fs_show_injection_info(FAULT_BLOCK);
 		release = *count;
-		goto enospc;
+		goto release_quota;
 	}
 
 	/*
@@ -1836,6 +1836,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 enospc:
 	percpu_counter_sub(&sbi->alloc_valid_block_count, release);
+release_quota:
 	dquot_release_reservation_block(inode, release);
 	return -ENOSPC;
 }
-- 
2.18.0.rc1

