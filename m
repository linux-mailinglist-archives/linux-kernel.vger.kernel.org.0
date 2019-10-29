Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE4EE8D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 18:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390703AbfJ2RC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 13:02:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbfJ2RC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:02:58 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A20CA818D8ED80AEB7C5;
        Wed, 30 Oct 2019 01:02:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 30 Oct 2019 01:02:43 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq: Make blk_mq_run_hw_queue() return void
Date:   Wed, 30 Oct 2019 00:59:30 +0800
Message-ID: <1572368370-139412-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 97889f9ac24f ("blk-mq: remove synchronize_rcu() from
blk_mq_del_queue_tag_set()"), the return value of blk_mq_run_hw_queue()
is never checked, so make it return void, which very marginally simplifies
the code.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec791156e9cc..8daa9740929a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1486,7 +1486,7 @@ void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 }
 EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
-bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
+void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
 	int srcu_idx;
 	bool need_run;
@@ -1504,12 +1504,8 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		blk_mq_hctx_has_pending(hctx);
 	hctx_unlock(hctx, srcu_idx);
 
-	if (need_run) {
+	if (need_run)
 		__blk_mq_delay_run_hw_queue(hctx, async, 0);
-		return true;
-	}
-
-	return false;
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queue);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0bf056de5cc3..c963038dfb92 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -324,7 +324,7 @@ void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
-bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
+void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
-- 
2.17.1

