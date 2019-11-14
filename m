Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8BFC2AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKNJdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:33:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54876 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfKNJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:33:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id z26so4881256wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 01:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMxHk04F3k6Cl2QlH6VuWL+3w3xnAMx199fCB+OqBGk=;
        b=ORDdpXq8fuvjmdKFM7rMHzFzVMRo7pArVNa5VsqJ08egyC8CsXlE/ctueq8EUiLKqL
         FoZtA7vPQLOwB+2dMd6pzATkUxyiDxWwDaI4V+Uhj+r20Uw+rm9X6tB2hoNsrwjG1WY8
         6RzApTh5dQa/C4lRWrVlvYZXeWgNPma4rkNNqf3t/ZTnA0nCcX+PAVOUEq/UqC2WLABk
         12X8oCSO4d+U8cYNVWCDk76gEdkqlsbV+g6ZMgZVLPN8HY9yhITMElNLlLH2jdCsGU7j
         J04NiAm8gpRHP9GUlm0fHOaCZkrTnS+ZwL4VQ8IjLKbRSB80tRTS6Crzdt1GaUOtFBjm
         ke7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMxHk04F3k6Cl2QlH6VuWL+3w3xnAMx199fCB+OqBGk=;
        b=FlIb9SShGMM35jmIrUTdzzYxQGawbyjgc94jo2AUdMRUFWX3bDQvuK6Yw3rgglTZpj
         oO//Iw/AVV0Lgr0GOSE2uXYYa6dWbDL+/M3cHMlR+KpCKdy3CEHT6D1VHeXqjpCMRMDB
         8QiRiukrTLAkeH6REpmTSZacaKeQEs8iTXvUF16WMEuF/l0W/WOxyV2bUTa3CSvBHGdI
         r7ni50hFKtRA47nz+A3nPWWZjaS3ZlzbS6OethahvV6UevGgZv/YGDMLyjUkITc1WNWQ
         4O9VCq9ICMI29o2qJYACIbPxbPmwYt7TLqzvoH+Mz9etjIkEghpdU+wlkZfd9FBerU0N
         HM9w==
X-Gm-Message-State: APjAAAU8zx5lyw/Xax/7QggwguvilF8qZ6Gu/PVeULVKJKxWmTJ9oBWx
        fTNGECQ2ZAwYRkXU3iECPp/zkg==
X-Google-Smtp-Source: APXvYqwOeXP71H3D16a9eLlpfyGMZ5nkC2myjOVWRo8oee9ndgiAsfzQzpbSxv8aywtnYw4MOsW1Nw==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr6420046wmc.37.1573724011034;
        Thu, 14 Nov 2019 01:33:31 -0800 (PST)
Received: from localhost.localdomain (hipert-gw1.mat.unimo.it. [155.185.5.1])
        by smtp.gmail.com with ESMTPSA id j22sm7523409wrd.41.2019.11.14.01.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 01:33:30 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        tschubert@bafh.org, patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 1/1] block, bfq: deschedule empty bfq_queues not referred by any process
Date:   Thu, 14 Nov 2019 10:33:11 +0100
Message-Id: <20191114093311.47877-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114093311.47877-1-paolo.valente@linaro.org>
References: <20191114093311.47877-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3726112ec731 ("block, bfq: re-schedule empty queues if
they deserve I/O plugging"), to prevent the service guarantees of a
bfq_queue from being violated, the bfq_queue may be left busy, i.e.,
scheduled for service, even if empty (see comments in
__bfq_bfqq_expire() for details). But, if no process will send
requests to the bfq_queue any longer, then there is no point in
keeping the bfq_queue scheduled for service.

In addition, keeping the bfq_queue scheduled for service, but with no
process reference any longer, may cause the bfq_queue to be freed when
descheduled from service. But this is assumed to never happen, and
causes a UAF if it happens. This, in turn, caused crashes [1, 2].

This commit fixes this issue by descheduling an empty bfq_queue when
it remains with not process reference.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
[2] https://bugzilla.kernel.org/show_bug.cgi?id=205447

Fixes: 3726112ec731 ("block, bfq: re-schedule empty queues if they deserve I/O plugging")
Reported-by: Chris Evich <cevich@redhat.com>
Reported-by: Patrick Dung <patdung100@gmail.com>
Reported-by: Thorsten Schubert <tschubert@bafh.org>
Tested-by: Thorsten Schubert <tschubert@bafh.org>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0319d6339822..0c6214497fcc 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2713,6 +2713,28 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	}
 }
 
+
+static
+void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+{
+	/*
+	 * To prevent bfqq's service guarantees from being violated,
+	 * bfqq may be left busy, i.e., queued for service, even if
+	 * empty (see comments in __bfq_bfqq_expire() for
+	 * details). But, if no process will send requests to bfqq any
+	 * longer, then there is no point in keeping bfqq queued for
+	 * service. In addition, keeping bfqq queued for service, but
+	 * with no process ref any longer, may have caused bfqq to be
+	 * freed when dequeued from service. But this is assumed to
+	 * never happen.
+	 */
+	if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list) &&
+	    bfqq != bfqd->in_service_queue)
+		bfq_del_bfqq_busy(bfqd, bfqq, false);
+
+	bfq_put_queue(bfqq);
+}
+
 static void
 bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 		struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
@@ -2783,8 +2805,7 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 	 */
 	new_bfqq->pid = -1;
 	bfqq->bic = NULL;
-	/* release process reference to bfqq */
-	bfq_put_queue(bfqq);
+	bfq_release_process_ref(bfqd, bfqq);
 }
 
 static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
@@ -4899,7 +4920,7 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	bfq_put_cooperator(bfqq);
 
-	bfq_put_queue(bfqq); /* release process reference */
+	bfq_release_process_ref(bfqd, bfqq);
 }
 
 static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
@@ -5001,8 +5022,7 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 
 	bfqq = bic_to_bfqq(bic, false);
 	if (bfqq) {
-		/* release process reference on this queue */
-		bfq_put_queue(bfqq);
+		bfq_release_process_ref(bfqd, bfqq);
 		bfqq = bfq_get_queue(bfqd, bio, BLK_RW_ASYNC, bic);
 		bic_set_bfqq(bic, bfqq, false);
 	}
@@ -5963,7 +5983,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
 
 	bfq_put_cooperator(bfqq);
 
-	bfq_put_queue(bfqq);
+	bfq_release_process_ref(bfqq->bfqd, bfqq);
 	return NULL;
 }
 
-- 
2.20.1

