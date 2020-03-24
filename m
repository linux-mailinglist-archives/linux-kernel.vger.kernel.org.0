Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3AC81905A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 07:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCXGV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 02:21:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbgCXGV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:21:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 217FDB9B832C6BE91BF2;
        Tue, 24 Mar 2020 14:21:09 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Mar 2020 14:21:00 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid double unlock
Date:   Tue, 24 Mar 2020 14:20:57 +0800
Message-ID: <20200324062057.52222-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On image that has verity and compression feature, if compressed pages
and non-compressed pages are mixed in one bio, we may double unlock
non-compressed page in below flow:

- f2fs_post_read_work
 - f2fs_decompress_work
  - f2fs_decompress_bio
   - __read_end_io
    - unlock_page
 - fsverity_enqueue_verify_work
  - f2fs_verity_work
   - f2fs_verify_bio
    - unlock_page

So it should skip handling non-compressed page in f2fs_decompress_work()
if verity is on.

Besides, add missing dec_page_count() in f2fs_verify_bio().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0197b7b80d19..24643680489b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -139,6 +139,8 @@ static void __read_end_io(struct bio *bio, bool compr, bool verity)
 			f2fs_decompress_pages(bio, page, verity);
 			continue;
 		}
+		if (verity)
+			continue;
 #endif
 
 		/* PG_error was set if any post_read step failed */
@@ -216,6 +218,7 @@ static void f2fs_verify_bio(struct bio *bio)
 		ClearPageUptodate(page);
 		ClearPageError(page);
 unlock:
+		dec_page_count(F2FS_P_SB(page), __read_io_type(page));
 		unlock_page(page);
 	}
 }
-- 
2.18.0.rc1

