Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C522E2C11
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 10:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438172AbfJXIZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 04:25:59 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:32868 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfJXIZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:25:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id B0B9A18108D3A;
        Thu, 24 Oct 2019 10:25:56 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6mNXa_C_RHjG; Thu, 24 Oct 2019 10:25:55 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4GDjBp6oxDFB; Thu, 24 Oct 2019 10:25:55 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Wenwen Wang <wenwen@cs.uga.edu>
Subject: [PATCH] Revert "ubifs: Fix memory leak bug in alloc_ubifs_info() error path"
Date:   Thu, 24 Oct 2019 10:25:35 +0200
Message-Id: <20191024082535.1022-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9163e0184bd7d5f779934d34581843f699ad2ffd.

At the point when ubifs_fill_super() runs, we have already a reference
to the super block. So upon deactivate_locked_super() c will get
free()'ed via ->kill_sb().

Cc: Wenwen Wang <wenwen@cs.uga.edu>
Fixes: 9163e0184bd7 ("ubifs: Fix memory leak bug in alloc_ubifs_info() error path")
Reported-by: https://twitter.com/grsecurity/status/1180609139359277056
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 7d4547e5202d..5e1e8ec0589e 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2267,10 +2267,8 @@ static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
 		}
 	} else {
 		err = ubifs_fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
-		if (err) {
-			kfree(c);
+		if (err)
 			goto out_deact;
-		}
 		/* We do not support atime */
 		sb->s_flags |= SB_ACTIVE;
 		if (IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))
-- 
2.16.4

