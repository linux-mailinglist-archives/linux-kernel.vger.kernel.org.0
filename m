Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2518817D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 13:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfHELII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 07:08:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbfHELII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:08:08 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C7DDA31F5163EDD1028C;
        Mon,  5 Aug 2019 19:08:04 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 19:07:55 +0800
From:   Lihong Kou <koulihong@huawei.com>
To:     <yuchao0@huawei.com>, <jaegeuk@kernel.org>
CC:     <fangwei1@huawei.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <koulihong@huawei.com>
Subject: [PATCH] f2fs: cleanup the code in build_sit_entries.
Date:   Mon, 5 Aug 2019 19:13:52 +0800
Message-ID: <1565003632-124792-1-git-send-email-koulihong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not need to set the SBI_NEED_FSCK flag in the error paths, if we
return error here, we will not update the checkpoint flag, so the code
is useless, just remove it.

Signed-off-by: Lihong Kou <koulihong@huawei.com>
---
 fs/f2fs/segment.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a661ac3..90e2579 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4161,7 +4161,6 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 		if (start >= MAIN_SEGS(sbi)) {
 			f2fs_err(sbi, "Wrong journal entry on segno %u",
 				 start);
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			err = -EFSCORRUPTED;
 			break;
 		}
@@ -4201,7 +4200,6 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 	if (!err && total_node_blocks != valid_node_count(sbi)) {
 		f2fs_err(sbi, "SIT is corrupted node# %u vs %u",
 			 total_node_blocks, valid_node_count(sbi));
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		err = -EFSCORRUPTED;
 	}
 
-- 
2.7.4

