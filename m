Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408A278E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 17:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfG2PDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 11:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbfG2PDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:03:12 -0400
Received: from localhost.localdomain (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D379216C8;
        Mon, 29 Jul 2019 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564412591;
        bh=UjF/AwvKhVxU6D/HTh8Hq1nLgczmyOG6CMrKwunrSbc=;
        h=From:To:Cc:Subject:Date:From;
        b=Yy1NJQiT9GgkQ0qR1k5P1ZVp85SrdeWvmz8xBGwi+4V8vyxUb96PRkJahlMm2sGx0
         3j6PSU6phRDYOF76GM80X1+lAKWcwc6xbio1PfOJvJFNcLRHS9HRFE9zBk9BeMeaKP
         SIkf7DP4jjkYcn5jiJqRP+hbvhegrn7m67o+vlJE=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RESEND] f2fs: fix to migrate blocks correctly during defragment
Date:   Mon, 29 Jul 2019 23:02:29 +0800
Message-Id: <20190729150229.12121-1-chao@kernel.org>
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

