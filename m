Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3364B522A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 07:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfFYFNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 01:13:32 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36733 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfFYFNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:13:13 -0400
Received: by mail-wr1-f41.google.com with SMTP id n4so15026684wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w8UfFEEZ6K2E6c2JKmDSUWjvlUsE4oPmj8NaEsXohpk=;
        b=BC/Npn6sXzor82m17/Mr98ygwLXHbmRoz79qYX4mRpjYQkzfd816L1FGyb8WpRSTn8
         2lifyti1cbi/IRSf78EMcs3r+9vyMM74gZzYlDA3AssY20PWEiY/KXSOLlz6fR/4jzml
         +W2AKbU0IUyjVB80M4QF2JixqXF8C3o9gbp66ELn0EHSleNoUBXb0khiuiPlOqsl0s8M
         GYq6ZOtH54VbeOfrdt5KgtxEBP0p7Xmxrx9DVkGSVgeuevA/bAw6mveo6khgU4aP6jHM
         svoa6sgylUlZe8/jymzEQmPCbEGknWshFqAjGG1TBBYo7v+gm3iu9lSMHcL8jtPfZaTU
         HoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w8UfFEEZ6K2E6c2JKmDSUWjvlUsE4oPmj8NaEsXohpk=;
        b=laZDFYZ577BbV0hBkJZYH7MZFbF1sLdcf0IBLjSyY/q+6meTsC6HbtRJosgj33O+Q9
         xArpmxZw4ExpMGMi7A4iQrxPVTTVeGRIufuegE3XkDC6t/W4AZh3pN502XaCsTCjRGPj
         MFszgtQNp6OPATqu8wDBIYjQGMfK3M1ltRfZtUIk+k/HXJ4LN/2tNeW/I0AC3B2D5Usm
         j3tKWAZAJ6924N9w4Qlin9hyX4DkIuOT6nz/TLmTZZn+x7C2BvxwO2sUEgJJGga3U+Lo
         Uk6SFqogJbP7CjzVyFhREHDaVck7CnxY8gytSfaAFXA7/RuP3m19FrLDOakWf7i0PAqx
         84UA==
X-Gm-Message-State: APjAAAXo0BMoz1+O+A+rTPqEpq8R+pxYJboJM+2oQfVaQn3R7KIFhVo2
        S7S3qiiNutzsehS3XTR1f0Q9ew==
X-Google-Smtp-Source: APXvYqw9k0SbV44cqg3Ji1B1zhu93bugOYiU3DW9ILwgG5CpzSJcF+p7/76hFyj+1emPmyoAKukBKg==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr94842180wrr.5.1561439590043;
        Mon, 24 Jun 2019 22:13:10 -0700 (PDT)
Received: from localhost.localdomain (146-241-102-168.dyn.eolo.it. [146.241.102.168])
        by smtp.gmail.com with ESMTPSA id q20sm28543149wra.36.2019.06.24.22.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 22:13:09 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 5/7] block, bfq: detect wakers and unconditionally inject their I/O
Date:   Tue, 25 Jun 2019 07:12:47 +0200
Message-Id: <20190625051249.39265-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625051249.39265-1-paolo.valente@linaro.org>
References: <20190625051249.39265-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bfq_queue Q may happen to be synchronized with another
bfq_queue Q2, i.e., the I/O of Q2 may need to be completed for Q to
receive new I/O. We call Q2 "waker queue".

If I/O plugging is being performed for Q, and Q is not receiving any
more I/O because of the above synchronization, then, thanks to BFQ's
injection mechanism, the waker queue is likely to get served before
the I/O-plugging timeout fires.

Unfortunately, this fact may not be sufficient to guarantee a high
throughput during the I/O plugging, because the inject limit for Q may
be too low to guarantee a lot of injected I/O. In addition, the
duration of the plugging, i.e., the time before Q finally receives new
I/O, may not be minimized, because the waker queue may happen to be
served only after other queues.

To address these issues, this commit introduces the explicit detection
of the waker queue, and the unconditional injection of a pending I/O
request of the waker queue on each invocation of
bfq_dispatch_request().

One may be concerned that this systematic injection of I/O from the
waker queue delays the service of Q's I/O. Fortunately, it doesn't. On
the contrary, next Q's I/O is brought forward dramatically, for it is
not blocked for milliseconds.

Reported-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Tested-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 270 ++++++++++++++++++++++++++++++++++++++------
 block/bfq-iosched.h |  25 +++-
 2 files changed, 261 insertions(+), 34 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d5bc32371ace..9e2fbb7d1fb6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -157,6 +157,7 @@ BFQ_BFQQ_FNS(in_large_burst);
 BFQ_BFQQ_FNS(coop);
 BFQ_BFQQ_FNS(split_coop);
 BFQ_BFQQ_FNS(softrt_update);
+BFQ_BFQQ_FNS(has_waker);
 #undef BFQ_BFQQ_FNS						\
 
 /* Expiration time of sync (0) and async (1) requests, in ns. */
@@ -1814,6 +1815,111 @@ static void bfq_add_request(struct request *rq)
 	bfqd->queued++;
 
 	if (RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_sync(bfqq)) {
+		/*
+		 * Detect whether bfqq's I/O seems synchronized with
+		 * that of some other queue, i.e., whether bfqq, after
+		 * remaining empty, happens to receive new I/O only
+		 * right after some I/O request of the other queue has
+		 * been completed. We call waker queue the other
+		 * queue, and we assume, for simplicity, that bfqq may
+		 * have at most one waker queue.
+		 *
+		 * A remarkable throughput boost can be reached by
+		 * unconditionally injecting the I/O of the waker
+		 * queue, every time a new bfq_dispatch_request
+		 * happens to be invoked while I/O is being plugged
+		 * for bfqq.  In addition to boosting throughput, this
+		 * unblocks bfqq's I/O, thereby improving bandwidth
+		 * and latency for bfqq. Note that these same results
+		 * may be achieved with the general injection
+		 * mechanism, but less effectively. For details on
+		 * this aspect, see the comments on the choice of the
+		 * queue for injection in bfq_select_queue().
+		 *
+		 * Turning back to the detection of a waker queue, a
+		 * queue Q is deemed as a waker queue for bfqq if, for
+		 * two consecutive times, bfqq happens to become non
+		 * empty right after a request of Q has been
+		 * completed. In particular, on the first time, Q is
+		 * tentatively set as a candidate waker queue, while
+		 * on the second time, the flag
+		 * bfq_bfqq_has_waker(bfqq) is set to confirm that Q
+		 * is a waker queue for bfqq. These detection steps
+		 * are performed only if bfqq has a long think time,
+		 * so as to make it more likely that bfqq's I/O is
+		 * actually being blocked by a synchronization. This
+		 * last filter, plus the above two-times requirement,
+		 * make false positives less likely.
+		 *
+		 * NOTE
+		 *
+		 * The sooner a waker queue is detected, the sooner
+		 * throughput can be boosted by injecting I/O from the
+		 * waker queue. Fortunately, detection is likely to be
+		 * actually fast, for the following reasons. While
+		 * blocked by synchronization, bfqq has a long think
+		 * time. This implies that bfqq's inject limit is at
+		 * least equal to 1 (see the comments in
+		 * bfq_update_inject_limit()). So, thanks to
+		 * injection, the waker queue is likely to be served
+		 * during the very first I/O-plugging time interval
+		 * for bfqq. This triggers the first step of the
+		 * detection mechanism. Thanks again to injection, the
+		 * candidate waker queue is then likely to be
+		 * confirmed no later than during the next
+		 * I/O-plugging interval for bfqq.
+		 */
+		if (!bfq_bfqq_has_short_ttime(bfqq) &&
+		    ktime_get_ns() - bfqd->last_completion <
+		    200 * NSEC_PER_USEC) {
+			if (bfqd->last_completed_rq_bfqq != bfqq &&
+				   bfqd->last_completed_rq_bfqq !=
+				   bfqq->waker_bfqq) {
+				/*
+				 * First synchronization detected with
+				 * a candidate waker queue, or with a
+				 * different candidate waker queue
+				 * from the current one.
+				 */
+				bfqq->waker_bfqq = bfqd->last_completed_rq_bfqq;
+
+				/*
+				 * If the waker queue disappears, then
+				 * bfqq->waker_bfqq must be reset. To
+				 * this goal, we maintain in each
+				 * waker queue a list, woken_list, of
+				 * all the queues that reference the
+				 * waker queue through their
+				 * waker_bfqq pointer. When the waker
+				 * queue exits, the waker_bfqq pointer
+				 * of all the queues in the woken_list
+				 * is reset.
+				 *
+				 * In addition, if bfqq is already in
+				 * the woken_list of a waker queue,
+				 * then, before being inserted into
+				 * the woken_list of a new waker
+				 * queue, bfqq must be removed from
+				 * the woken_list of the old waker
+				 * queue.
+				 */
+				if (!hlist_unhashed(&bfqq->woken_list_node))
+					hlist_del_init(&bfqq->woken_list_node);
+				hlist_add_head(&bfqq->woken_list_node,
+				    &bfqd->last_completed_rq_bfqq->woken_list);
+
+				bfq_clear_bfqq_has_waker(bfqq);
+			} else if (bfqd->last_completed_rq_bfqq ==
+				   bfqq->waker_bfqq &&
+				   !bfq_bfqq_has_waker(bfqq)) {
+				/*
+				 * synchronization with waker_bfqq
+				 * seen for the second time
+				 */
+				bfq_mark_bfqq_has_waker(bfqq);
+			}
+		}
+
 		/*
 		 * Periodically reset inject limit, to make sure that
 		 * the latter eventually drops in case workload
@@ -4164,18 +4270,89 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 			bfqq->bic->bfqq[0] : NULL;
 
 		/*
-		 * If the process associated with bfqq has also async
-		 * I/O pending, then inject it
-		 * unconditionally. Injecting I/O from the same
-		 * process can cause no harm to the process. On the
-		 * contrary, it can only increase bandwidth and reduce
-		 * latency for the process.
+		 * The next three mutually-exclusive ifs decide
+		 * whether to try injection, and choose the queue to
+		 * pick an I/O request from.
+		 *
+		 * The first if checks whether the process associated
+		 * with bfqq has also async I/O pending. If so, it
+		 * injects such I/O unconditionally. Injecting async
+		 * I/O from the same process can cause no harm to the
+		 * process. On the contrary, it can only increase
+		 * bandwidth and reduce latency for the process.
+		 *
+		 * The second if checks whether there happens to be a
+		 * non-empty waker queue for bfqq, i.e., a queue whose
+		 * I/O needs to be completed for bfqq to receive new
+		 * I/O. This happens, e.g., if bfqq is associated with
+		 * a process that does some sync. A sync generates
+		 * extra blocking I/O, which must be completed before
+		 * the process associated with bfqq can go on with its
+		 * I/O. If the I/O of the waker queue is not served,
+		 * then bfqq remains empty, and no I/O is dispatched,
+		 * until the idle timeout fires for bfqq. This is
+		 * likely to result in lower bandwidth and higher
+		 * latencies for bfqq, and in a severe loss of total
+		 * throughput. The best action to take is therefore to
+		 * serve the waker queue as soon as possible. So do it
+		 * (without relying on the third alternative below for
+		 * eventually serving waker_bfqq's I/O; see the last
+		 * paragraph for further details). This systematic
+		 * injection of I/O from the waker queue does not
+		 * cause any delay to bfqq's I/O. On the contrary,
+		 * next bfqq's I/O is brought forward dramatically,
+		 * for it is not blocked for milliseconds.
+		 *
+		 * The third if checks whether bfqq is a queue for
+		 * which it is better to avoid injection. It is so if
+		 * bfqq delivers more throughput when served without
+		 * any further I/O from other queues in the middle, or
+		 * if the service times of bfqq's I/O requests both
+		 * count more than overall throughput, and may be
+		 * easily increased by injection (this happens if bfqq
+		 * has a short think time). If none of these
+		 * conditions holds, then a candidate queue for
+		 * injection is looked for through
+		 * bfq_choose_bfqq_for_injection(). Note that the
+		 * latter may return NULL (for example if the inject
+		 * limit for bfqq is currently 0).
+		 *
+		 * NOTE: motivation for the second alternative
+		 *
+		 * Thanks to the way the inject limit is updated in
+		 * bfq_update_has_short_ttime(), it is rather likely
+		 * that, if I/O is being plugged for bfqq and the
+		 * waker queue has pending I/O requests that are
+		 * blocking bfqq's I/O, then the third alternative
+		 * above lets the waker queue get served before the
+		 * I/O-plugging timeout fires. So one may deem the
+		 * second alternative superfluous. It is not, because
+		 * the third alternative may be way less effective in
+		 * case of a synchronization. For two main
+		 * reasons. First, throughput may be low because the
+		 * inject limit may be too low to guarantee the same
+		 * amount of injected I/O, from the waker queue or
+		 * other queues, that the second alternative
+		 * guarantees (the second alternative unconditionally
+		 * injects a pending I/O request of the waker queue
+		 * for each bfq_dispatch_request()). Second, with the
+		 * third alternative, the duration of the plugging,
+		 * i.e., the time before bfqq finally receives new I/O,
+		 * may not be minimized, because the waker queue may
+		 * happen to be served only after other queues.
 		 */
 		if (async_bfqq &&
 		    icq_to_bic(async_bfqq->next_rq->elv.icq) == bfqq->bic &&
 		    bfq_serv_to_charge(async_bfqq->next_rq, async_bfqq) <=
 		    bfq_bfqq_budget_left(async_bfqq))
 			bfqq = bfqq->bic->bfqq[0];
+		else if (bfq_bfqq_has_waker(bfqq) &&
+			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
+			   bfq_serv_to_charge(bfqq->waker_bfqq->next_rq,
+					      bfqq->waker_bfqq) <=
+			   bfq_bfqq_budget_left(bfqq->waker_bfqq)
+			)
+			bfqq = bfqq->waker_bfqq;
 		else if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
 			 (bfqq->wr_coeff == 1 || bfqd->wr_busy_queues > 1 ||
 			  !bfq_bfqq_has_short_ttime(bfqq)))
@@ -4564,6 +4741,9 @@ static void bfq_put_cooperator(struct bfq_queue *bfqq)
 
 static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
+	struct bfq_queue *item;
+	struct hlist_node *n;
+
 	if (bfqq == bfqd->in_service_queue) {
 		__bfq_bfqq_expire(bfqd, bfqq);
 		bfq_schedule_dispatch(bfqd);
@@ -4573,6 +4753,18 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	bfq_put_cooperator(bfqq);
 
+	/* remove bfqq from woken list */
+	if (!hlist_unhashed(&bfqq->woken_list_node))
+		hlist_del_init(&bfqq->woken_list_node);
+
+	/* reset waker for all queues in woken list */
+	hlist_for_each_entry_safe(item, n, &bfqq->woken_list,
+				  woken_list_node) {
+		item->waker_bfqq = NULL;
+		bfq_clear_bfqq_has_waker(item);
+		hlist_del_init(&item->woken_list_node);
+	}
+
 	bfq_put_queue(bfqq); /* release process reference */
 }
 
@@ -4691,6 +4883,8 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	RB_CLEAR_NODE(&bfqq->entity.rb_node);
 	INIT_LIST_HEAD(&bfqq->fifo);
 	INIT_HLIST_NODE(&bfqq->burst_list_node);
+	INIT_HLIST_NODE(&bfqq->woken_list_node);
+	INIT_HLIST_HEAD(&bfqq->woken_list);
 
 	bfqq->ref = 0;
 	bfqq->bfqd = bfqd;
@@ -4909,28 +5103,27 @@ static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
 	 * bfqq may have a long think time because of a
 	 * synchronization with some other queue, i.e., because the
 	 * I/O of some other queue may need to be completed for bfqq
-	 * to receive new I/O. This happens, e.g., if bfqq is
-	 * associated with a process that does some sync. A sync
-	 * generates extra blocking I/O, which must be completed
-	 * before the process associated with bfqq can go on with its
-	 * I/O.
+	 * to receive new I/O. Details in the comments on the choice
+	 * of the queue for injection in bfq_select_queue().
 	 *
-	 * If such a synchronization is actually in place, then,
-	 * without injection on bfqq, the blocking I/O cannot happen
-	 * to served while bfqq is in service. As a consequence, if
-	 * bfqq is granted I/O-dispatch-plugging, then bfqq remains
-	 * empty, and no I/O is dispatched, until the idle timeout
-	 * fires. This is likely to result in lower bandwidth and
-	 * higher latencies for bfqq, and in a severe loss of total
-	 * throughput.
+	 * As stressed in those comments, if such a synchronization is
+	 * actually in place, then, without injection on bfqq, the
+	 * blocking I/O cannot happen to served while bfqq is in
+	 * service. As a consequence, if bfqq is granted
+	 * I/O-dispatch-plugging, then bfqq remains empty, and no I/O
+	 * is dispatched, until the idle timeout fires. This is likely
+	 * to result in lower bandwidth and higher latencies for bfqq,
+	 * and in a severe loss of total throughput.
 	 *
 	 * On the opposite end, a non-zero inject limit may allow the
 	 * I/O that blocks bfqq to be executed soon, and therefore
-	 * bfqq to receive new I/O soon. But, if this actually
-	 * happens, then the next think-time sample for bfqq may be
-	 * very low. This in turn may cause bfqq's think time to be
-	 * deemed short. Without the 100 ms barrier, this new state
-	 * change would cause the body of the next if to be executed
+	 * bfqq to receive new I/O soon.
+	 *
+	 * But, if the blocking gets actually eliminated, then the
+	 * next think-time sample for bfqq may be very low. This in
+	 * turn may cause bfqq's think time to be deemed
+	 * short. Without the 100 ms barrier, this new state change
+	 * would cause the body of the next if to be executed
 	 * immediately. But this would set to 0 the inject
 	 * limit. Without injection, the blocking I/O would cause the
 	 * think time of bfqq to become long again, and therefore the
@@ -4941,11 +5134,11 @@ static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
 	 * In contrast, if the inject limit is not reset during such a
 	 * long time interval as 100 ms, then the number of short
 	 * think time samples can grow significantly before the reset
-	 * is allowed. As a consequence, the think time state can
-	 * become stable before the reset. There will be no state
-	 * change when the 100 ms elapse, and therefore no reset of
-	 * the inject limit. The inject limit remains steadily equal
-	 * to 1 both during and after the 100 ms. So injection can be
+	 * is performed. As a consequence, the think time state can
+	 * become stable before the reset. Therefore there will be no
+	 * state change when the 100 ms elapse, and no reset of the
+	 * inject limit. The inject limit remains steadily equal to 1
+	 * both during and after the 100 ms. So injection can be
 	 * performed at all times, and throughput gets boosted.
 	 *
 	 * An inject limit equal to 1 is however in conflict, in
@@ -4960,10 +5153,20 @@ static void bfq_update_has_short_ttime(struct bfq_data *bfqd,
 	 * brought forward, because it is not blocked for
 	 * milliseconds.
 	 *
-	 * In addition, during the 100 ms, the base value for the
-	 * total service time is likely to get finally computed,
-	 * freeing the inject limit from its relation with the think
-	 * time.
+	 * In addition, serving the blocking I/O much sooner, and much
+	 * more frequently than once per I/O-plugging timeout, makes
+	 * it much quicker to detect a waker queue (the concept of
+	 * waker queue is defined in the comments in
+	 * bfq_add_request()). This makes it possible to start sooner
+	 * to boost throughput more effectively, by injecting the I/O
+	 * of the waker queue unconditionally on every
+	 * bfq_dispatch_request().
+	 *
+	 * One last, important benefit of not resetting the inject
+	 * limit before 100 ms is that, during this time interval, the
+	 * base value for the total service time is likely to get
+	 * finally computed for bfqq, freeing the inject limit from
+	 * its relation with the think time.
 	 */
 	if (state_changed && bfqq->last_serv_time_ns == 0 &&
 	    (time_is_before_eq_jiffies(bfqq->decrease_time_jif +
@@ -5278,6 +5481,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 			1UL<<(BFQ_RATE_SHIFT - 10))
 		bfq_update_rate_reset(bfqd, NULL);
 	bfqd->last_completion = now_ns;
+	bfqd->last_completed_rq_bfqq = bfqq;
 
 	/*
 	 * If we are waiting to discover whether the request pattern
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 584d3c9ed8ba..e80adf822bbe 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -357,6 +357,24 @@ struct bfq_queue {
 
 	/* max service rate measured so far */
 	u32 max_service_rate;
+
+	/*
+	 * Pointer to the waker queue for this queue, i.e., to the
+	 * queue Q such that this queue happens to get new I/O right
+	 * after some I/O request of Q is completed. For details, see
+	 * the comments on the choice of the queue for injection in
+	 * bfq_select_queue().
+	 */
+	struct bfq_queue *waker_bfqq;
+	/* node for woken_list, see below */
+	struct hlist_node woken_list_node;
+	/*
+	 * Head of the list of the woken queues for this queue, i.e.,
+	 * of the list of the queues for which this queue is a waker
+	 * queue. This list is used to reset the waker_bfqq pointer in
+	 * the woken queues when this queue exits.
+	 */
+	struct hlist_head woken_list;
 };
 
 /**
@@ -533,6 +551,9 @@ struct bfq_data {
 	/* time of last request completion (ns) */
 	u64 last_completion;
 
+	/* bfqq owning the last completed rq */
+	struct bfq_queue *last_completed_rq_bfqq;
+
 	/* time of last transition from empty to non-empty (ns) */
 	u64 last_empty_occupied_ns;
 
@@ -743,7 +764,8 @@ enum bfqq_state_flags {
 				 * update
 				 */
 	BFQQF_coop,		/* bfqq is shared */
-	BFQQF_split_coop	/* shared bfqq will be split */
+	BFQQF_split_coop,	/* shared bfqq will be split */
+	BFQQF_has_waker		/* bfqq has a waker queue */
 };
 
 #define BFQ_BFQQ_FNS(name)						\
@@ -763,6 +785,7 @@ BFQ_BFQQ_FNS(in_large_burst);
 BFQ_BFQQ_FNS(coop);
 BFQ_BFQQ_FNS(split_coop);
 BFQ_BFQQ_FNS(softrt_update);
+BFQ_BFQQ_FNS(has_waker);
 #undef BFQ_BFQQ_FNS
 
 /* Expiration reasons. */
-- 
2.20.1

