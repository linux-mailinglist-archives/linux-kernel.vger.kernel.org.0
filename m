Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7717464B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 11:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgB2KtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 05:49:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11123 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgB2KtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 05:49:21 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 378EF698CDA89C8DF401;
        Sat, 29 Feb 2020 18:49:17 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 29 Feb 2020 18:49:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove redundant compress inode check
Date:   Sat, 29 Feb 2020 18:49:06 +0800
Message-ID: <20200229104906.12061-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

due to f2fs_post_read_required() has did that.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f4bcbbd5e9ed..882f9ad3445b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4006,8 +4006,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 		return true;
 	if (f2fs_is_multi_device(sbi))
 		return true;
-	if (f2fs_compressed_file(inode))
-		return true;
 	/*
 	 * for blkzoned device, fallback direct IO to buffered IO, so
 	 * all IOs can be serialized by log-structured write.
-- 
2.18.0.rc1

