Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB278E06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfG2ObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 10:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfG2ObK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:31:10 -0400
Received: from localhost.localdomain (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD51206DD;
        Mon, 29 Jul 2019 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564410670;
        bh=UjF/AwvKhVxU6D/HTh8Hq1nLgczmyOG6CMrKwunrSbc=;
        h=From:To:Cc:Subject:Date:From;
        b=V5dxupUlfgUZEBYpjvlt723xj/TcjTDF9WMaKoEZENPx/o+C8axJ7+2DL915XzMHT
         eLvON8oyYmDW03M6gYX5TmSFYAC1hrf6qdp6i6kZfbJHy8fIDz3xBDw2tZHEcqQOeg
         eUp1nCiwek9wdItlegOE6c9ShlnKpDle7SKw+oKA=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to migrate blocks correctly during defragment
Date:   Sun, 28 Jul 2019 23:01:52 +0800
Message-Id: <20190728150152.8533-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

During defragment, we missed to trigger fragmented blocks migration
for below condition:

In defragment region:
- total number of valid blocks is smaller than 512;
- the tail part of the region are all holes;

In addtion, return zero to user via range->len if there is no
fragmented blocks.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ff93066ed515..ff2ffa850a6f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2384,8 +2384,10 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		map.m_lblk += map.m_len;
 	}
 
-	if (!fragmented)
+	if (!fragmented) {
+		total = 0;
 		goto out;
+	}
 
 	sec_num = DIV_ROUND_UP(total, BLKS_PER_SEC(sbi));
 
@@ -2415,7 +2417,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
 			map.m_lblk = next_pgofs;
-			continue;
+			goto check;
 		}
 
 		set_inode_flag(inode, FI_DO_DEFRAG);
@@ -2439,8 +2441,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		}
 
 		map.m_lblk = idx;
-
-		if (idx < pg_end && cnt < blk_per_seg)
+check:
+		if (map.m_lblk < pg_end && cnt < blk_per_seg)
 			goto do_map;
 
 		clear_inode_flag(inode, FI_DO_DEFRAG);
-- 
2.22.0

