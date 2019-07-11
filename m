Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E755964FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 03:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfGKB3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 21:29:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727619AbfGKB3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 21:29:31 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B0C853725FF5F02D06FC;
        Thu, 11 Jul 2019 09:29:29 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 11 Jul 2019 09:29:18 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH v2] f2fs: improve print log in f2fs_sanity_check_ckpt()
Date:   Thu, 11 Jul 2019 09:29:15 +0800
Message-ID: <20190711012915.5581-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Park Ju Hyung suggested:

"I'd like to suggest to write down an actual version of f2fs-tools
here as we've seen older versions of fsck doing even more damage
and the users might not have the latest f2fs-tools installed."

This patch give a more detailed info of how we fix such corruption
to user to avoid damageable repair with low version fsck.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- add fixing patch's title in log suggested by Jaegeuk.
 fs/f2fs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1a6d82d558e4..47dae7c3ae4f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2696,7 +2696,9 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 
 	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG) &&
 		le32_to_cpu(ckpt->checksum_offset) != CP_MIN_CHKSUM_OFFSET) {
-		f2fs_warn(sbi, "layout of large_nat_bitmap is deprecated, run fsck to repair, chksum_offset: %u",
+		f2fs_warn(sbi, "using deprecated layout of large_nat_bitmap, "
+			  "please run fsck v1.13.0 or higher to repair, chksum_offset: %u, "
+			  "fixed with patch: \"f2fs-tools: relocate chksum_offset for large_nat_bitmap feature\"",
 			  le32_to_cpu(ckpt->checksum_offset));
 		return 1;
 	}
-- 
2.18.0.rc1

