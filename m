Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631F4117928
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 23:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLIWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 17:23:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfLIWXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:23:47 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D999420637;
        Mon,  9 Dec 2019 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575930226;
        bh=G9qjQO+B2Dn9SuDL3dmoqef8NbNq/p9c0YfBUHGG4R0=;
        h=From:To:Cc:Subject:Date:From;
        b=xI4+0U1Ugd2CKiM9SP7G7RfDwtGtjomS3HWdQrNe6MT1BVCVJJnzhkLTRw1ewyYHX
         TPNu9xc7pwGFCiAT5VPbArPvbiDLQ7nNEQqSytwMRQyMKeOpzv81Yc9zrIKe7TkudA
         AzfwuMnZRWnB20zj2rKT/D1FW2bCAgt3p9JzlA94=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/6] f2fs: call f2fs_balance_fs outside of locked page
Date:   Mon,  9 Dec 2019 14:23:40 -0800
Message-Id: <20191209222345.1078-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, we can hit deadlock by waiting for the locked page in
move_data_block in GC.

 Thread A                     Thread B
 - do_page_mkwrite
  - f2fs_vm_page_mkwrite
   - lock_page
                              - f2fs_balance_fs
                                  - mutex_lock(gc_mutex)
                               - f2fs_gc
                                - do_garbage_collect
                                 - ra_data_block
                                  - grab_cache_page
   - f2fs_balance_fs
    - mutex_lock(gc_mutex)

Fixes: 39a8695824510 ("f2fs: refactor ->page_mkwrite() flow")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e7fcbd8c23f4..6cebc6681487 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -50,7 +50,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct dnode_of_data dn = { .node_changed = false };
+	struct dnode_of_data dn;
 	int err;
 
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -63,6 +63,9 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto err;
 	}
 
+	/* should do out of any locked page */
+	f2fs_balance_fs(sbi, true);
+
 	sb_start_pagefault(inode->i_sb);
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
@@ -120,8 +123,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 out_sem:
 	up_read(&F2FS_I(inode)->i_mmap_sem);
 
-	f2fs_balance_fs(sbi, dn.node_changed);
-
 	sb_end_pagefault(inode->i_sb);
 err:
 	return block_page_mkwrite_return(err);
-- 
2.19.0.605.g01d371f741-goog

