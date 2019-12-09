Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9011792F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 23:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLIWXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 17:23:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfLIWXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:23:48 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2071320721;
        Mon,  9 Dec 2019 22:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575930228;
        bh=TaaCS8RTMLVqjYqfCHXD8HZCQIXSSSjJveEkKOckY4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEnd3J1oeG0+9T5erKTz7uO3O/W4upU6IBhql845eAAUb9M1shFMafFgW7msGEALi
         x8BqBGByDYM3xHhe+beDrAFBDqRPC4WbiGdKYT/QtdK9i1nLpVh9WmAkErHZuYnOVH
         VJb7p6YckhqOTppjiXn/BsBoQcBSpfGpSxKxcxzM=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] f2fs: keep quota data on write_begin failure
Date:   Mon,  9 Dec 2019 14:23:42 -0800
Message-Id: <20191209222345.1078-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20191209222345.1078-1-jaegeuk@kernel.org>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids some unnecessary locks for quota files when write_begin
fails.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fc40a72f7827..3b2945121557 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2600,14 +2600,16 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 	struct inode *inode = mapping->host;
 	loff_t i_size = i_size_read(inode);
 
+	if (IS_NOQUOTA(inode))
+		return;
+
 	/* In the fs-verity case, f2fs_end_enable_verity() does the truncate */
 	if (to > i_size && !f2fs_verity_in_progress(inode)) {
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		down_write(&F2FS_I(inode)->i_mmap_sem);
 
 		truncate_pagecache(inode, i_size);
-		if (!IS_NOQUOTA(inode))
-			f2fs_truncate_blocks(inode, i_size, true);
+		f2fs_truncate_blocks(inode, i_size, true);
 
 		up_write(&F2FS_I(inode)->i_mmap_sem);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-- 
2.19.0.605.g01d371f741-goog

