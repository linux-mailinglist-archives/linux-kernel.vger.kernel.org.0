Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042D5FB676
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 18:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfKMRau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 12:30:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726392AbfKMRap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:30:45 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D7A63D7FBDBE91609F52;
        Thu, 14 Nov 2019 01:30:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 14 Nov 2019 01:30:36 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/2] blk-mq: Delete blk_mq_has_free_tags() and blk_mq_can_queue()
Date:   Thu, 14 Nov 2019 01:27:21 +0800
Message-ID: <1573666042-176756-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1573666042-176756-1-git-send-email-john.garry@huawei.com>
References: <1573666042-176756-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are not referenced, so delete them.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq-tag.c     | 8 --------
 block/blk-mq-tag.h     | 1 -
 block/blk-mq.c         | 6 ------
 include/linux/blk-mq.h | 1 -
 4 files changed, 16 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 008388e82b5c..fbacde454718 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -15,14 +15,6 @@
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
-bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
-{
-	if (!tags)
-		return true;
-
-	return sbitmap_any_bit_clear(&tags->bitmap_tags.sb);
-}
-
 /*
  * If a previously inactive queue goes active, bump the active user count.
  * We need to do this before try to allocate driver tag, then even if fail
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..15bc74acb57e 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -28,7 +28,6 @@ extern void blk_mq_free_tags(struct blk_mq_tags *tags);
 extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
 extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
 			   struct blk_mq_ctx *ctx, unsigned int tag);
-extern bool blk_mq_has_free_tags(struct blk_mq_tags *tags);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5c9adcaa27ac..323c9cb28066 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,12 +260,6 @@ void blk_mq_wake_waiters(struct request_queue *q)
 			blk_mq_tag_wakeup_all(hctx->tags, true);
 }
 
-bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
-{
-	return blk_mq_has_free_tags(hctx->tags);
-}
-EXPORT_SYMBOL(blk_mq_can_queue);
-
 /*
  * Only need start/end time stamping if we have iostat or
  * blk stats enabled, or using an IO scheduler.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dc03e059fdff..11cfd6470b1a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -424,7 +424,6 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
 
 void blk_mq_free_request(struct request *rq);
-bool blk_mq_can_queue(struct blk_mq_hw_ctx *);
 
 bool blk_mq_queue_inflight(struct request_queue *q);
 
-- 
2.17.1

