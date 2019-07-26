Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130E676003
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 09:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfGZHnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 03:43:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbfGZHnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:43:32 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5AE36A10F49F44F065CE;
        Fri, 26 Jul 2019 15:43:29 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 26 Jul 2019 15:43:19 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid call kvfree under spinlock
Date:   Fri, 26 Jul 2019 15:43:17 +0800
Message-ID: <20190726074317.4416-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfree() don't wish to be called from interrupt context, move it
out of spin_lock_irqsave() coverage.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 29da1ea3e160..529b32f81c6b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1643,6 +1643,7 @@ static inline void clear_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
 static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
 {
 	unsigned long flags;
+	unsigned char *nat_bits;
 
 	/*
 	 * In order to re-enable nat_bits we need to call fsck.f2fs by
@@ -1653,10 +1654,12 @@ static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
 	if (lock)
 		spin_lock_irqsave(&sbi->cp_lock, flags);
 	__clear_ckpt_flags(F2FS_CKPT(sbi), CP_NAT_BITS_FLAG);
-	kvfree(NM_I(sbi)->nat_bits);
+	nat_bits = NM_I(sbi)->nat_bits;
 	NM_I(sbi)->nat_bits = NULL;
 	if (lock)
 		spin_unlock_irqrestore(&sbi->cp_lock, flags);
+
+	kvfree(nat_bits);
 }
 
 static inline bool enabled_nat_bits(struct f2fs_sb_info *sbi,
-- 
2.18.0.rc1

