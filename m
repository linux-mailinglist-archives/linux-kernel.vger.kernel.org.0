Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADEC14EA01
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 10:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgAaJZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 04:25:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52113 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgAaJY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:24:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so7095300wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 01:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqMailTmZiDzGAaQzZRxkipnoj+fRUU9PJ6V3DKETq8=;
        b=cg+0ln31NwklwCB7MdEWW8MYShl/I69uRq/+lHKzxdRZ96HLCFrwcuZLt+lSqzk7nW
         qcnS1o0KGzDAJ3Zx4vC3/JQYx7272k6nDjqQZ3fmMVmfmsHLeOQAMrO28UnGbNi3gM15
         CpFeDHgtWvJUnC2HffD6RGczVRbyy9SPQC7gBzHEasBRS3e+1VLcGcmPnhfIu/1Kqswk
         uKU/+fDMpNyB3VUZUWW4p13Iv+F36S3KJ6rMIrmUAD3czTDhzESGp07SwXHe4Ty/0bVA
         A8+3DKtLQtwv9phsvdLm3L6H8F3EbbqjlWpIvD9vARKaGPlD44fJsEsMzNkWhrV/MAgS
         thQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqMailTmZiDzGAaQzZRxkipnoj+fRUU9PJ6V3DKETq8=;
        b=qjwfC85/NN8zji0c70vpYoC1bvZLuw2XoNIQTkIR/WlqzEnz31MHdItTySwrBymvoh
         HGxO6GLQReDr015c5hjEtLmwo+XfvTfjvkKuGzBKz5pvl/HFI39ZkbCe7oTLVhwtIGC8
         Wfy0uOqz8uoLKcoR3eJUS5zRKO32BdTBd0ITlbSw62AFcGKDTIs0GYWGOE8ZQfW4onlz
         XKVT0bVbxUn5NoOqM8QwFu0vv0c7TKzIfSP1hJCkCzDg/c4oz4Mmk3HlXi3qynP4zGDB
         T6Fc37PshVObGmCqjCqVOZ9mQlRKt5soqyktvxv+UpLzSfoPchdMOVKAZMYxu319yhMW
         04Vg==
X-Gm-Message-State: APjAAAX7BlxjA+2Z/6bQXQPFiX4tIEWUZsK3vUW08cOCeUesahW2zXXA
        +ecF6yvu88cc8Nb5kadvZa/5GA==
X-Google-Smtp-Source: APXvYqwrdqLrYbDRrX76bBTfOceHiNyXfbVom/20wFvv7o5waUNKFqTZ4kzC62WNF3Jm9I2zZXHVvA==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr11380404wml.183.1580462696845;
        Fri, 31 Jan 2020 01:24:56 -0800 (PST)
Received: from localhost.localdomain (88-147-73-186.dyn.eolo.it. [88.147.73.186])
        by smtp.gmail.com with ESMTPSA id 16sm10144364wmi.0.2020.01.31.01.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 01:24:56 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 1/6] block, bfq: do not plug I/O for bfq_queues with no proc refs
Date:   Fri, 31 Jan 2020 10:24:04 +0100
Message-Id: <20200131092409.10867-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200131092409.10867-1-paolo.valente@linaro.org>
References: <20200131092409.10867-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 478de3380c1c ("block, bfq: deschedule empty bfq_queues not
referred by any process") fixed commit 3726112ec731 ("block, bfq:
re-schedule empty queues if they deserve I/O plugging") by
descheduling an empty bfq_queue when it remains with not process
reference. Yet, this still left a case uncovered: an empty bfq_queue
with not process reference that remains in service. This happens for
an in-service sync bfq_queue that is deemed to deserve I/O-dispatch
plugging when it remains empty. Yet no new requests will arrive for
such a bfq_queue if no process sends requests to it any longer. Even
worse, the bfq_queue may happen to be prematurely freed while still in
service (because there may remain no reference to it any longer).

This commit solves this problem by preventing I/O dispatch from being
plugged for the in-service bfq_queue, if the latter has no process
reference (the bfq_queue is then prevented from remaining in service).

Fixes: 3726112ec731 ("block, bfq: re-schedule empty queues if they deserve I/O plugging")
Reported-by: Patrick Dung <patdung100@gmail.com>
Tested-by: Patrick Dung <patdung100@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4686b68b48b4..55d4328e7c12 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3443,6 +3443,10 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
 static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
 						 struct bfq_queue *bfqq)
 {
+	/* No point in idling for bfqq if it won't get requests any longer */
+	if (unlikely(!bfqq_process_refs(bfqq)))
+		return false;
+
 	return (bfqq->wr_coeff > 1 &&
 		(bfqd->wr_busy_queues <
 		 bfq_tot_busy_queues(bfqd) ||
@@ -4076,6 +4080,10 @@ static bool idling_boosts_thr_without_issues(struct bfq_data *bfqd,
 		bfqq_sequential_and_IO_bound,
 		idling_boosts_thr;
 
+	/* No point in idling for bfqq if it won't get requests any longer */
+	if (unlikely(!bfqq_process_refs(bfqq)))
+		return false;
+
 	bfqq_sequential_and_IO_bound = !BFQQ_SEEKY(bfqq) &&
 		bfq_bfqq_IO_bound(bfqq) && bfq_bfqq_has_short_ttime(bfqq);
 
@@ -4169,6 +4177,10 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	struct bfq_data *bfqd = bfqq->bfqd;
 	bool idling_boosts_thr_with_no_issue, idling_needed_for_service_guar;
 
+	/* No point in idling for bfqq if it won't get requests any longer */
+	if (unlikely(!bfqq_process_refs(bfqq)))
+		return false;
+
 	if (unlikely(bfqd->strict_guarantees))
 		return true;
 
-- 
2.20.1

