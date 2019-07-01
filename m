Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1584C51B92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 21:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfFXTlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 15:41:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36781 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730612AbfFXTlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:41:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so531105wmm.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCzYwH1lRICR2ykOvmQ5ORaT4+N7Xt8pYNhzGo4EKys=;
        b=Z9c+O36hxLaYmGCt3jQnOcBc8cPaM6x0e+7fVcOyr6HcWsQDCPG996xyEWcImxuGMO
         Pa90yU3mhwLiXg7ca/zMg3kcJyD1bvRJxCB+df+U8SiXyAVCdd9Y58Xz0862BEfTIC5K
         404RjiKa2XhSX1s70mU94fAvi9+g9DQvAfgY8S1qfEWnQg3Ug9eJo2muVPgJ9kz3432h
         eu1xnGZCXb+MoMdhoPwdlrcM9Xxk1O2V+sKbVEpOvKkbykZty5PsiLWslv6wL3x/KGRX
         7NqfwS3yL2uSkk+vwg3Gyh+XHytjI0LkhqfeM6ZBnYX43xlIYBilWvfMHuDe1RMR74Hj
         pkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCzYwH1lRICR2ykOvmQ5ORaT4+N7Xt8pYNhzGo4EKys=;
        b=rP4f8ve4m8GOEyspa9lsTG/sXlM+pe/pnikiOHeepobht0g4eeKwYqMgBIu3ss9fST
         V31T019LpyNpHYq4YOeoQ2QI+l3bVNOXBtFJjAWwgs1gBNig/Dr53SidkwkhGFW2Gs6q
         J5QLF6WqhY6ziaVGRyzWylJG7eJ/sq6nHVnoEvVMXqatlzl93TNU3I+90VRNLlZ+tFLC
         7kcJyZz2G1kJzMupOJiNITktug+zyOgEwsdFM8a8yf984klLkp2+Y5BkwKqOM/3cz61T
         LSY2G9lDblpIMKipevZ2IEFzf0/d5t7jxEcknZEYX6l5/TGWRafrf4elAcGjqCXuGIEP
         2UeA==
X-Gm-Message-State: APjAAAVRbu8TgU3f2Qk5pKDBBdrIbRhtTTGawrsUJGBeFTOHPeM3x8zr
        5XT/BD/2qrojGTdPwyid3SuOCQ==
X-Google-Smtp-Source: APXvYqzgO4ZmaaCfgw+skRFn79fD+OINQ9hSzKYcSfuIIvwFrZpz4BVq/FNpPUAy9635lzIm0vqbxQ==
X-Received: by 2002:a05:600c:214e:: with SMTP id v14mr13914984wml.96.1561405270215;
        Mon, 24 Jun 2019 12:41:10 -0700 (PDT)
Received: from localhost.localdomain (146-241-101-27.dyn.eolo.it. [146.241.101.27])
        by smtp.gmail.com with ESMTPSA id q25sm17615395wrc.68.2019.06.24.12.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:41:09 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 4/7] block, bfq: bring forward seek&think time update
Date:   Mon, 24 Jun 2019 21:40:39 +0200
Message-Id: <20190624194042.38747-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624194042.38747-1-paolo.valente@linaro.org>
References: <20190624194042.38747-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until the base value for request service times gets finally computed
for a bfq_queue, the inject limit for that queue does depend on the
think-time state (short|long) of the queue. A timely update of the
think time then guarantees a quicker activation or deactivation of the
injection. Fortunately, the think time of a bfq_queue is updated in
the same code path as the inject limit; but after the inject limit.

This commits moves the update of the think time before the update of
the inject limit. For coherence, it moves the update of the seek time
too.

Tested-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 62442083b147..d5bc32371ace 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4979,19 +4979,9 @@ static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
 static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			    struct request *rq)
 {
-	struct bfq_io_cq *bic = RQ_BIC(rq);
-
 	if (rq->cmd_flags & REQ_META)
 		bfqq->meta_pending++;
 
-	bfq_update_io_thinktime(bfqd, bfqq);
-	bfq_update_has_short_ttime(bfqd, bfqq, bic);
-	bfq_update_io_seektime(bfqd, bfqq, rq);
-
-	bfq_log_bfqq(bfqd, bfqq,
-		     "rq_enqueued: has_short_ttime=%d (seeky %d)",
-		     bfq_bfqq_has_short_ttime(bfqq), BFQQ_SEEKY(bfqq));
-
 	bfqq->last_request_pos = blk_rq_pos(rq) + blk_rq_sectors(rq);
 
 	if (bfqq == bfqd->in_service_queue && bfq_bfqq_wait_request(bfqq)) {
@@ -5079,6 +5069,10 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		bfqq = new_bfqq;
 	}
 
+	bfq_update_io_thinktime(bfqd, bfqq);
+	bfq_update_has_short_ttime(bfqd, bfqq, RQ_BIC(rq));
+	bfq_update_io_seektime(bfqd, bfqq, rq);
+
 	waiting = bfqq && bfq_bfqq_wait_request(bfqq);
 	bfq_add_request(rq);
 	idle_timer_disabled = waiting && !bfq_bfqq_wait_request(bfqq);
-- 
2.20.1

