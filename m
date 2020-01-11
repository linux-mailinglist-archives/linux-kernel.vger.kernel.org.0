Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A001137CAB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 10:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAKJnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 04:43:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728737AbgAKJnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:43:33 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E12A9E2B3071DDC9B529;
        Sat, 11 Jan 2020 17:43:30 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 11 Jan 2020
 17:43:20 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>, <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ubifs: Fix deadlock in concurrent bulk-read and writepage
Date:   Sat, 11 Jan 2020 17:50:36 +0800
Message-ID: <1578736236-141308-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ubifs, concurrent execution of writepage and bulk read on the same file
may cause ABBA deadlock, for example (Reproduce method see Link):

Process A(Bulk-read starts from page4)         Process B(write page4 back)
  vfs_read                                       wb_workfn or fsync
  ...                                            ...
  generic_file_buffered_read                     write_cache_pages
    ubifs_readpage                                 LOCK(page4)

      ubifs_bulk_read                              ubifs_writepage
        LOCK(ui->ui_mutex)                           ubifs_write_inode

	  ubifs_do_bulk_read                           LOCK(ui->ui_mutex)
	    find_or_create_page(alloc page4)                  ↑
	      LOCK(page4)                   <--     ABBA deadlock occurs!

In order to ensure the serialization execution of bulk read, we can't
remove the big lock 'ui->ui_mutex' in ubifs_bulk_read(). Instead, we
allow ubifs_do_bulk_read() to lock page failed by replacing
find_or_create_page(FGP_LOCK) with
pagecache_get_page(FGP_LOCK | FGP_NOWAIT).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: zhangyi (F) <yi.zhang@huawei.com>
Cc: <Stable@vger.kernel.org>
Fixes: 4793e7c5e1c ("UBIFS: add bulk-read facility")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206153
---
 fs/ubifs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index cd52585..c649048 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -786,7 +786,9 @@ static int ubifs_do_bulk_read(struct ubifs_info *c, struct bu_info *bu,
 
 		if (page_offset > end_index)
 			break;
-		page = find_or_create_page(mapping, page_offset, ra_gfp_mask);
+		page = pagecache_get_page(mapping, page_offset,
+				 FGP_LOCK|FGP_ACCESSED|FGP_CREAT|FGP_NOWAIT,
+				 ra_gfp_mask);
 		if (!page)
 			break;
 		if (!PageUptodate(page))
-- 
2.7.4

