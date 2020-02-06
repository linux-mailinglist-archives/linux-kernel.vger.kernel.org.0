Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED4154DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 22:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBFVMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 16:12:30 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:32774 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFVM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 16:12:29 -0500
Received: by mail-ua1-f73.google.com with SMTP id z7so17339uai.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 13:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M/uylP+O2LMA2B9C+rW8Rx9lky5lbsAF0tAZt5+spyU=;
        b=S938oPiqoyR38GSzPnxeYiov9Qi36UgJMkMv0iSp1iPTbat6jCfKi+MqClj5bbz7co
         sgtdL/vGsFzr49gFgyXUGvBkok+Wu/CC3KUXiUOInqWoles67Oji/aO2Xa/r3Y8BVk1I
         XN8xZWcl3MdPub3KprwG7pasxNqHWFuXtabcni5KRyZ4Z4eBQf9F5EEY8vW2H3wRH38Z
         B6VtJwFswLKAytE8u5Ly+j9cno0FgsbPwv14ZXtfZxPxbSuXMVTuTzc1uMDEtzbOopGT
         i/hpfArbMd7/+gX19KcJjSdOD/cwNGVrf4nCV5Qo3WSQnVS+1kHnTulBjooMZO9fwUGI
         HsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M/uylP+O2LMA2B9C+rW8Rx9lky5lbsAF0tAZt5+spyU=;
        b=QYWi+j/lbcekB2JP7NtgW0bo7YXtfxWLEqVqIyEqDFFZVMOMs6gsaWDDcIhzg16KgV
         QbcWefpdBNnlB5LoX9TBGyzvaTIJjiRTgrsjdm+F+OCnxvMIBj9wUCuL18pUJqErzW5e
         jT++9TuYLFqRm2D4aXlbyOYWNpyvYJizw/UesRf4i2NbR/AKzpNqIxYJ11XS613iAZyb
         36T/1ikk0bEsaGcpp4wzSMlHk/jq/g9hhzbNib7bV+fif8JMuJ0AFI1snoGR3+7N32vn
         Z1HM9vuIfyuexjk5oK9VQ3D1ZHw3AEfItYq72XuuxJn0DwHbMmcPsJoKw7Pwbd4+Ih27
         AOHQ==
X-Gm-Message-State: APjAAAUsqxNqwVN+YJYX/0mEFsKSaF+YOoXv7vKMz7bzJXBtbN3EUWs3
        UJgsydWMX8w/NuAMOYx61Ys2Y+lszA==
X-Google-Smtp-Source: APXvYqxGmHfTZs3aXF5hXV0zbuI/8vZIC61aJzFBl8MGZvk3rWB7hL1pTW6p+Qk733FGavBN2HXih1Cj5A==
X-Received: by 2002:a1f:7c0c:: with SMTP id x12mr2906722vkc.41.1581023547890;
 Thu, 06 Feb 2020 13:12:27 -0800 (PST)
Date:   Thu,  6 Feb 2020 13:12:22 -0800
In-Reply-To: <20200206101833.GA20943@ming.t460p>
Message-Id: <20200206211222.83170-1-sqazi@google.com>
Mime-Version: 1.0
References: <20200206101833.GA20943@ming.t460p>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] block: Limit number of items taken from the I/O scheduler in
 one go
From:   Salman Qazi <sqazi@google.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Salman Qazi <sqazi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flushes bypass the I/O scheduler and get added to hctx->dispatch
in blk_mq_sched_bypass_insert.  This can happen while a kworker is running
hctx->run_work work item and is past the point in
blk_mq_sched_dispatch_requests where hctx->dispatch is checked.

The blk_mq_do_dispatch_sched call is not guaranteed to end in bounded time,
because the I/O scheduler can feed an arbitrary number of commands.

Since we have only one hctx->run_work, the commands waiting in
hctx->dispatch will wait an arbitrary length of time for run_work to be
rerun.

A similar phenomenon exists with dispatches from the software queue.

The solution is to poll hctx->dispatch in blk_mq_do_dispatch_sched and
blk_mq_do_dispatch_ctx and return from the run_work handler and let it
rerun.

Signed-off-by: Salman Qazi <sqazi@google.com>
---
 block/blk-mq-sched.c | 47 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ca22afd47b3d..84dde147f646 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -84,12 +84,16 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
+ *
+ * Returns true if hctx->dispatch was found non-empty and
+ * run_work has to be run again.
  */
-static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	LIST_HEAD(rq_list);
+	bool ret = false;
 
 	do {
 		struct request *rq;
@@ -97,6 +101,11 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
 
+		if (!list_empty_careful(&hctx->dispatch)) {
+			ret = true;
+			break;
+		}
+
 		if (!blk_mq_get_dispatch_budget(hctx))
 			break;
 
@@ -113,6 +122,8 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 */
 		list_add(&rq->queuelist, &rq_list);
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
+
+	return ret;
 }
 
 static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
@@ -130,16 +141,25 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
+ *
+ * Returns true if hctx->dispatch was found non-empty and
+ * run_work has to be run again.
  */
-static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
+static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	LIST_HEAD(rq_list);
 	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
+	bool ret = false;
 
 	do {
 		struct request *rq;
 
+		if (!list_empty_careful(&hctx->dispatch)) {
+			ret = true;
+			break;
+		}
+
 		if (!sbitmap_any_bit_set(&hctx->ctx_map))
 			break;
 
@@ -165,6 +185,7 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
 
 	WRITE_ONCE(hctx->dispatch_from, ctx);
+	return ret;
 }
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
@@ -172,6 +193,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
+	bool run_again;
+	bool restarted = false;
 	LIST_HEAD(rq_list);
 
 	/* RCU or SRCU read lock is needed before checking quiesced flag */
@@ -180,6 +203,9 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 
 	hctx->run++;
 
+again:
+	run_again = false;
+
 	/*
 	 * If we have previous entries on our dispatch list, grab them first for
 	 * more fair dispatch.
@@ -208,19 +234,28 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		blk_mq_sched_mark_restart_hctx(hctx);
 		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
 			if (has_sched_dispatch)
-				blk_mq_do_dispatch_sched(hctx);
+				run_again = blk_mq_do_dispatch_sched(hctx);
 			else
-				blk_mq_do_dispatch_ctx(hctx);
+				run_again = blk_mq_do_dispatch_ctx(hctx);
 		}
 	} else if (has_sched_dispatch) {
-		blk_mq_do_dispatch_sched(hctx);
+		run_again = blk_mq_do_dispatch_sched(hctx);
 	} else if (hctx->dispatch_busy) {
 		/* dequeue request one by one from sw queue if queue is busy */
-		blk_mq_do_dispatch_ctx(hctx);
+		run_again = blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
 		blk_mq_dispatch_rq_list(q, &rq_list, false);
 	}
+
+	if (run_again) {
+		if (!restarted) {
+			restarted = true;
+			goto again;
+		}
+
+		blk_mq_run_hw_queue(hctx, true);
+	}
 }
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-- 
2.25.0.341.g760bfbb309-goog

