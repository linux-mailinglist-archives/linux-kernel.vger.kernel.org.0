Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF0D18DD86
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 02:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgCUBr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 21:47:27 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:62612 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUBr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:47:27 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 21:47:26 EDT
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 265C4350981665369FE6;
        Sat, 21 Mar 2020 09:32:03 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 02L1W2TI095392;
        Sat, 21 Mar 2020 09:32:02 +0800 (GMT-8)
        (envelope-from chen.ying153@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020032109324331-2829488 ;
          Sat, 21 Mar 2020 09:32:43 +0800 
From:   chenying <chen.ying153@zte.com.cn>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        chenying <chen.ying153@zte.com.cn>
Subject: [PATCH] ENOSPC returned but there still many free segments
Date:   Sat, 21 Mar 2020 09:31:48 +0800
Message-Id: <1584754308-39299-1-git-send-email-chen.ying153@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-03-21 09:32:43,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-03-21 09:32:07,
        Serialize complete at 2020-03-21 09:32:07
X-MAIL: mse-fl2.zte.com.cn 02L1W2TI095392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I write data to a compressed file when the disk space is almost full
and it return -ENOSPC error, but cat /sys/kernel/debug/f2fs/status
shows that there still many free segments.

Signed-off-by: chenying <chen.ying153@zte.com.cn>
---
 fs/f2fs/compress.c | 5 ++++-
 fs/f2fs/file.c     | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d8a64be..6ca058b 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -854,6 +854,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 				fio.compr_blocks++;
 			if (__is_valid_data_blkaddr(blkaddr))
 				f2fs_invalidate_blocks(sbi, blkaddr);
+			else if (blkaddr != NULL_ADDR)
+				dec_valid_block_count(sbi, dn.inode, 1);
 			f2fs_update_data_blkaddr(&dn, COMPRESS_ADDR);
 			goto unlock_continue;
 		}
@@ -865,7 +867,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 			if (__is_valid_data_blkaddr(blkaddr)) {
 				f2fs_invalidate_blocks(sbi, blkaddr);
 				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
-			}
+			} else if (blkaddr != NULL_ADDR)
+				dec_valid_block_count(sbi, dn.inode, 1);
 			goto unlock_continue;
 		}
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0d4da64..f07c9e2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -589,6 +589,10 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 			clear_inode_flag(dn->inode, FI_FIRST_BLOCK_WRITTEN);
 
 		f2fs_invalidate_blocks(sbi, blkaddr);
+		if (compressed_cluster &&
+			(blkaddr == NEW_ADDR || blkaddr == COMPRESS_ADDR))
+			continue;
+
 		nr_free++;
 	}
 
-- 
2.15.2

