Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01D143740
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 07:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAUGss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 01:48:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44424 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgAUGss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:48:48 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3B466D0EA86C6B7B2D78;
        Tue, 21 Jan 2020 14:48:45 +0800 (CST)
Received: from architecture4.huawei.com (10.160.196.180) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 Jan
 2020 14:48:35 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 1/2] erofs: fold in postsubmit_is_all_bypassed()
Date:   Tue, 21 Jan 2020 14:47:47 +0800
Message-ID: <20200121064747.138987-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120085709.10320-1-hsiangkao@aol.com>
References: <20200120085709.10320-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.160.196.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to introduce such separated helper since
cache strategy compile configs were changed into
runtime options instead in v5.4. No logic changes.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
changes since v1:
 - fix a wrong condition force_fg -> *forge_fg by mistake.

 fs/erofs/zdata.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4fedeb4496e4..f63a893fe886 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1148,20 +1148,6 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
-static bool postsubmit_is_all_bypassed(struct z_erofs_decompressqueue *q[],
-				       unsigned int nr_bios, bool force_fg)
-{
-	/*
-	 * although background is preferred, no one is pending for submission.
-	 * don't issue workqueue for decompression but drop it directly instead.
-	 */
-	if (force_fg || nr_bios)
-		return false;
-
-	kvfree(q[JQ_SUBMIT]);
-	return true;
-}
-
 static bool z_erofs_submit_queue(struct super_block *sb,
 				 z_erofs_next_pcluster_t owned_head,
 				 struct list_head *pagepool,
@@ -1262,9 +1248,14 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 	if (bio)
 		submit_bio(bio);
 
-	if (postsubmit_is_all_bypassed(q, nr_bios, *force_fg))
+	/*
+	 * although background is preferred, no one is pending for submission.
+	 * don't issue workqueue for decompression but drop it directly instead.
+	 */
+	if (!*force_fg && !nr_bios) {
+		kvfree(q[JQ_SUBMIT]);
 		return true;
-
+	}
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
 	return true;
 }
-- 
2.17.1

