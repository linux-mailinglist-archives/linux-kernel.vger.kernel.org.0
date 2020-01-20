Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C815C1427BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 11:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgATKBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 05:01:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgATKBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:01:06 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C6974633E9A69DAE7EEF;
        Mon, 20 Jan 2020 18:01:04 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 18:00:58 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to force keeping write barrier for strict fsync mode
Date:   Mon, 20 Jan 2020 18:00:45 +0800
Message-ID: <20200120100045.70210-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If barrier is enabled, for strict fsync mode, we should force to
use atomic write semantics to avoid data corruption due to no
barrier support in lower device.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 86ddbb55d2b1..c9dd45f82fbd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -241,6 +241,13 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	};
 	unsigned int seq_id = 0;
 
+	/*
+	 * for strict fsync mode, force to keep atomic write sematics to avoid
+	 * data corruption if lower device doesn't support write barrier.
+	 */
+	if (!atomic && F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
+		atomic = true;
+
 	if (unlikely(f2fs_readonly(inode->i_sb) ||
 				is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return 0;
-- 
2.18.0.rc1

