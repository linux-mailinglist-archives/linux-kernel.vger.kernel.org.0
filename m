Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C19FE9EA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 01:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfKPAvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 19:51:01 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50086 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfKPAvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 19:51:01 -0500
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 174192007690; Fri, 15 Nov 2019 16:51:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 174192007690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1573865460;
        bh=DehnQsYkGnfpWqfC6bFuZD9CR2Eiz11eNsWa14hueAU=;
        h=From:To:Cc:Subject:Date:From;
        b=OsTLUICOgO7D2YJEDt0vaht/J8xsQ6YNXHjtLlW/9RHuySud09LgkUvtpLDqe6Jaa
         YlfNGmDqKq2Kf0hhyx3pLdxtXH/I8GxwLUtJPyysCaSbi6Yaz/inPUGyNpT79b+Pz3
         DJEbTJjregk+fasUxYtz+zLyjlydqSncK1/TY1v0=
From:   longli@linuxonhyperv.com
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dongli Zhang <dongli.zhang@oracle.com>, damien.lemoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v2] blk-mq: avoid repeatedly scheduling the same work to run hardware queue
Date:   Fri, 15 Nov 2019 16:50:28 -0800
Message-Id: <1573865428-24958-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

SCSI layer calls blk_mq_run_hw_queues() in scsi_end_request(), for every
completed I/O. blk_mq_run_hw_queues() in turn schedules some works to run
the hardware queues.

The actual work is queued by mod_delayed_work_on(), it turns out the cost of
this function is high on locking and CPU usage, when the I/O workload has
high queue depth. Most of these calls are not necessary since the queue is
already scheduled to run, and has not started yet.

This patch tries to solve this problem by avoiding scheduling work when it's
already scheduled.

Benchmark results:
The following tests are run on a RAM backed virtual disk on Hyper-V, with 8
FIO jobs with 4k random read I/O. The test numbers are for IOPS.

queue_depth	pre-patch	after-patch	improvement
16		190k		190k		0%
64		235k		240k		2%
256		180k		256k		42%
1024		156k		250k		60%

Signed-off-by: Long Li <longli@microsoft.com>
---
Change in v2: Clear bit for delayed runs to allow successive non-delayed runs

 block/blk-mq.c         | 20 ++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec791156e9cc..f103d336f9c8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1476,6 +1476,24 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		put_cpu();
 	}
 
+	/*
+	 * Queue a work to run queue.
+	 *
+	 * If this is a non-delayed run and a non-delayed work is already
+	 * scheduled, avoid scheduling the same work again.
+	 *
+	 * If this is a delayed run, unconditinally clear the
+	 * BLK_MQ_S_WORK_QUEUED bit so the next possible non-delayed run can
+	 * be queued before this delayed run gets to start.
+	 */
+
+	if (!msecs) {
+		if (test_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state))
+			return;
+		set_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);
+	} else
+		clear_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);
+
 	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
 				    msecs_to_jiffies(msecs));
 }
@@ -1561,6 +1579,7 @@ void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
 	cancel_delayed_work(&hctx->run_work);
 
 	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	clear_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);
 }
 EXPORT_SYMBOL(blk_mq_stop_hw_queue);
 
@@ -1626,6 +1645,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	struct blk_mq_hw_ctx *hctx;
 
 	hctx = container_of(work, struct blk_mq_hw_ctx, run_work.work);
+	clear_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);
 
 	/*
 	 * If we are stopped, don't run the queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0bf056de5cc3..98269d3fd141 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -234,6 +234,7 @@ enum {
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
 	BLK_MQ_S_SCHED_RESTART	= 2,
+	BLK_MQ_S_WORK_QUEUED	= 3,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
-- 
2.17.1

