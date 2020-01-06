Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D211130E49
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 09:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgAFIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 03:01:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbgAFIB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:01:58 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE27F63262B5E8685A10;
        Mon,  6 Jan 2020 16:01:55 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 16:01:47 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] f2fs: compress: revert error path fix
Date:   Mon, 6 Jan 2020 16:01:42 +0800
Message-ID: <20200106080144.52363-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200106080144.52363-1-yuchao0@huawei.com>
References: <20200106080144.52363-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert incorrect fix in ("TEMP: f2fs: support data compression - fix1")

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index f993b4ce1970..fc4510729654 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -601,7 +601,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 							fgp_flag, GFP_NOFS);
 		if (!page) {
 			ret = -ENOMEM;
-			goto release_pages;
+			goto unlock_pages;
 		}
 
 		if (PageUptodate(page))
@@ -616,13 +616,13 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
 						&last_block_in_bio, false);
 		if (ret)
-			goto unlock_pages;
+			goto release_pages;
 		if (bio)
 			f2fs_submit_bio(sbi, bio, DATA);
 
 		ret = f2fs_init_compress_ctx(cc);
 		if (ret)
-			goto unlock_pages;
+			goto release_pages;
 	}
 
 	for (i = 0; i < cc->cluster_size; i++) {
-- 
2.18.0.rc1

