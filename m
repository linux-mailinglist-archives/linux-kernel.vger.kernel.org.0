Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4DA6C9C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 09:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbfGRHJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 03:09:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37171 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfGRHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:09:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so24439041wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 00:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MzKYoDyENKk1kK8hXpAc/Oh1w/qduBUwZjhGJuRTr8k=;
        b=XFzMEu/dSHBe9G9sOdqdO7rfr0t+ODPMIMqH6RAux+r8HHINLaQ7moogZvUJL4DkR2
         DJIpqTcjgVn1i+hr1PQmO2YcCp02v2TCwbzv0Q1mPPhagBOu7qg7R+DnLFiBGtfQCJBz
         NEvkBKYarLjuOvs52zG/eQ1rbs0anPrsLvrheNpGF4n/ANrhUOW6aD86mSBd72bHpte6
         6EvfeF9RuaGA3+gouoGhzPIJRS9FljqBOfXYdLnbOSiWIGmbyy3Rw0wDQChjFF9yFzzr
         c2IK6pr2VbAikR44ALmWSXiBAbjw7+2IDlAX6rIpOo4QSww99OfFlvQ6ddTHIco9Duuo
         cFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MzKYoDyENKk1kK8hXpAc/Oh1w/qduBUwZjhGJuRTr8k=;
        b=jZ982Ng3msYq0R004l4K0zpfgoEjSZy/90tjNczjfaxtkMkzukFzmQzNHcXMM52lC2
         dUUInZdVIcl6mZGPsiIrUEsg9eEgPJRgBPzHmIl8+tcsiaygOWQbHhmhYQwgq4v9GG6l
         BUGyjytGQLlDEoT2cBaRTxdSYl9nxge6ZGGJkB5yeLk87jpg5YPU+oMXuZxXSOqg/KIN
         iITUbBprUR4nomGjLcn+aXqmlPY3aNVIySTiA0ONbCjyJnjkKwMa3x9iEwsuVq16tedD
         mjql/xMW3OXg3t0UPsEoeuGtTBbHa6tEPif7zoIkHTRf95Azlkm00jlZBFjthursyaf2
         S9Iw==
X-Gm-Message-State: APjAAAXCtppfelOVAlg3OzzYrTBh/sFTNHX8oxY6j4fNs9aTjWVXQTWP
        7r0pfXoKkKLjAPZy76MVa3LPfQ==
X-Google-Smtp-Source: APXvYqyM6o6bSbcQ9narWyKZyim8pbSFjPVrrmBypQxTV7ODpMggFbNfD0eiMbPCpPVWjQ5I7Y3UFw==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr41543708wmf.51.1563433748588;
        Thu, 18 Jul 2019 00:09:08 -0700 (PDT)
Received: from localhost.localdomain (146-241-85-178.dyn.eolo.it. [146.241.85.178])
        by smtp.gmail.com with ESMTPSA id a64sm26629527wmf.1.2019.07.18.00.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 00:09:07 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V3 1/1] block, bfq: check also in-flight I/O in dispatch plugging
Date:   Thu, 18 Jul 2019 09:08:52 +0200
Message-Id: <20190718070852.34568-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190718070852.34568-1-paolo.valente@linaro.org>
References: <20190718070852.34568-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a sync bfq_queue Q that remains empty while in service, and
suppose that, when this happens, there is a fair amount of already
in-flight I/O not belonging to Q. In such a situation, I/O dispatching
may need to be plugged (until new I/O arrives for Q), for the
following reason.

The drive may decide to serve in-flight non-Q's I/O requests before
Q's ones, thereby delaying the arrival of new I/O requests for Q
(recall that Q is sync). If I/O-dispatching is not plugged, then,
while Q remains empty, a basically uncontrolled amount of I/O from
other queues may be dispatched too, possibly causing the service of
Q's I/O to be delayed even longer in the drive. This problem gets more
and more serious as the speed and the queue depth of the drive grow,
because, as these two quantities grow, the probability to find no
queue busy but many requests in flight grows too.

If Q has the same weight and priority as the other queues, then the
above delay is unlikely to cause any issue, because all queues tend to
undergo the same treatment. So, since not plugging I/O dispatching is
convenient for throughput, it is better not to plug. Things change in
case Q has a higher weight or priority than some other queue, because
Q's service guarantees may simply be violated. For this reason,
commit 1de0c4cd9ea6 ("block, bfq: reduce idling only in symmetric
scenarios") does plug I/O in such an asymmetric scenario. Plugging
minimizes the delay induced by already in-flight I/O, and enables Q to
recover the bandwidth it may lose because of this delay.

Yet the above commit does not cover the case of weight-raised queues,
for efficiency concerns. For weight-raised queues, I/O-dispatch
plugging is activated simply if not all bfq_queues are
weight-raised. But this check does not handle the case of in-flight
requests, because a bfq_queue may become non busy *before* all its
in-flight requests are completed.

This commit performs I/O-dispatch plugging for weight-raised queues if
there are some in-flight requests.

As a practical example of the resulting recover of control, under
write load on a Samsung SSD 970 PRO, gnome-terminal starts in 1.5
seconds after this fix, against 15 seconds before the fix (as a
reference, gnome-terminal takes about 35 seconds to start with any of
the other I/O schedulers).

Fixes: commit 1de0c4cd9ea6 ("block, bfq: reduce idling only in symmetric scenarios")
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 67 +++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 72860325245a..586fcfe227ea 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3354,38 +3354,57 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
  * there is no active group, then the primary expectation for
  * this device is probably a high throughput.
  *
- * We are now left only with explaining the additional
- * compound condition that is checked below for deciding
- * whether the scenario is asymmetric. To explain this
- * compound condition, we need to add that the function
+ * We are now left only with explaining the two sub-conditions in the
+ * additional compound condition that is checked below for deciding
+ * whether the scenario is asymmetric. To explain the first
+ * sub-condition, we need to add that the function
  * bfq_asymmetric_scenario checks the weights of only
- * non-weight-raised queues, for efficiency reasons (see
- * comments on bfq_weights_tree_add()). Then the fact that
- * bfqq is weight-raised is checked explicitly here. More
- * precisely, the compound condition below takes into account
- * also the fact that, even if bfqq is being weight-raised,
- * the scenario is still symmetric if all queues with requests
- * waiting for completion happen to be
- * weight-raised. Actually, we should be even more precise
- * here, and differentiate between interactive weight raising
- * and soft real-time weight raising.
+ * non-weight-raised queues, for efficiency reasons (see comments on
+ * bfq_weights_tree_add()). Then the fact that bfqq is weight-raised
+ * is checked explicitly here. More precisely, the compound condition
+ * below takes into account also the fact that, even if bfqq is being
+ * weight-raised, the scenario is still symmetric if all queues with
+ * requests waiting for completion happen to be
+ * weight-raised. Actually, we should be even more precise here, and
+ * differentiate between interactive weight raising and soft real-time
+ * weight raising.
+ *
+ * The second sub-condition checked in the compound condition is
+ * whether there is a fair amount of already in-flight I/O not
+ * belonging to bfqq. If so, I/O dispatching is to be plugged, for the
+ * following reason. The drive may decide to serve in-flight
+ * non-bfqq's I/O requests before bfqq's ones, thereby delaying the
+ * arrival of new I/O requests for bfqq (recall that bfqq is sync). If
+ * I/O-dispatching is not plugged, then, while bfqq remains empty, a
+ * basically uncontrolled amount of I/O from other queues may be
+ * dispatched too, possibly causing the service of bfqq's I/O to be
+ * delayed even longer in the drive. This problem gets more and more
+ * serious as the speed and the queue depth of the drive grow,
+ * because, as these two quantities grow, the probability to find no
+ * queue busy but many requests in flight grows too. By contrast,
+ * plugging I/O dispatching minimizes the delay induced by already
+ * in-flight I/O, and enables bfqq to recover the bandwidth it may
+ * lose because of this delay.
  *
  * As a side note, it is worth considering that the above
- * device-idling countermeasures may however fail in the
- * following unlucky scenario: if idling is (correctly)
- * disabled in a time period during which all symmetry
- * sub-conditions hold, and hence the device is allowed to
- * enqueue many requests, but at some later point in time some
- * sub-condition stops to hold, then it may become impossible
- * to let requests be served in the desired order until all
- * the requests already queued in the device have been served.
+ * device-idling countermeasures may however fail in the following
+ * unlucky scenario: if I/O-dispatch plugging is (correctly) disabled
+ * in a time period during which all symmetry sub-conditions hold, and
+ * therefore the device is allowed to enqueue many requests, but at
+ * some later point in time some sub-condition stops to hold, then it
+ * may become impossible to make requests be served in the desired
+ * order until all the requests already queued in the device have been
+ * served. The last sub-condition commented above somewhat mitigates
+ * this problem for weight-raised queues.
  */
 static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
 						 struct bfq_queue *bfqq)
 {
 	return (bfqq->wr_coeff > 1 &&
-		bfqd->wr_busy_queues <
-		bfq_tot_busy_queues(bfqd)) ||
+		(bfqd->wr_busy_queues <
+		 bfq_tot_busy_queues(bfqd) ||
+		 bfqd->rq_in_driver >=
+		 bfqq->dispatched + 4)) ||
 		bfq_asymmetric_scenario(bfqd, bfqq);
 }
 
-- 
2.20.1

