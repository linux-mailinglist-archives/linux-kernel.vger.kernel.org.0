Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7F6865C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfGOJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 05:32:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43160 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfGOJcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:32:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so16253574wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XY6uMFDpyd5Sb/D44V2DuZasBvPQUw/5AeqlUOCrBVk=;
        b=BxEJpF4ENRRLiT4Njdp0BlI+017tozpowFfpa0ojf6zePDxsoUAmlG1yg0ix1KSbT5
         36fmmf+wxNPtw6BsyQRRk3XhrveCG5LMtqwr4Vc5puRj1AXcLo/+RQKz6JgKv+p2V/vY
         frgYSPbE58HzEwZyFr6M1HoPyLzDwEhTL+o5OfD5QeKJg6GizNZGS1AldpNP7P2gQwPI
         tf1CHG//qT7/5QAhpNEFcbr9tp0el8Q4LtMu3lHzo0x6vPD8um7CpydssJtw4tB1g+iK
         +dYSrAd8ACPHmZF+6Of299tsyIFFis3xaXjQrBwWm1yZ8QWn5Nt38rcntWIEpVJIhnTU
         c2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XY6uMFDpyd5Sb/D44V2DuZasBvPQUw/5AeqlUOCrBVk=;
        b=IGI5M03Tk+tH13OKu6XJxHtDfNN+x1NsijpbAW2qH8eosjZ7yIEFQgoHNcIFY0eLGJ
         sSAd4O+s9GllIJ4NbpDoE3RrcoI33lgPB+KZWB+8ioxeGTNYp7zQTa38QWParQfKKmyA
         Uda1y+wwVPuHyKx5wgePkDlpPU6mUQGY2gqnvxl4ZfOO8YW9PDSrdJJJy74///GmasU4
         EjrSnLYTRT6lXXZJUlGDNR92PnWMLea2jxV8D3B1bLXBgxxfVU6YjsqBSvr461lgTPCI
         Skll4VN2PyYV3QNhtMTmpLSXb73hMzXyc+1ichs57pFAenIejwacppPGUj8skF59Ip/q
         Locg==
X-Gm-Message-State: APjAAAUlIb7NiBoBlehsBw5qyZhIsgxKXmfjsmbjYLA5ADmD2+1sLkV5
        YvxQ3E1TtJYo3qBlmHhIAA5WKg==
X-Google-Smtp-Source: APXvYqy0MeafiEeT7l5137lDRrIJH0lOJ9vNcUhopUgLW/bX0DJeY8wYuAJUrLwy3SpALaY/a0wpIA==
X-Received: by 2002:a5d:5348:: with SMTP id t8mr27162017wrv.159.1563183128309;
        Mon, 15 Jul 2019 02:32:08 -0700 (PDT)
Received: from localhost.localdomain (146-241-97-230.dyn.eolo.it. [146.241.97.230])
        by smtp.gmail.com with ESMTPSA id g12sm22544993wrv.9.2019.07.15.02.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 02:32:07 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 1/1] block, bfq: check also in-flight I/O in dispatch plugging
Date:   Mon, 15 Jul 2019 11:31:53 +0200
Message-Id: <20190715093153.19821-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715093153.19821-1-paolo.valente@linaro.org>
References: <20190715093153.19821-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a sync bfq_queue Q that remains empty while in service, and
suppose that, when this happens, there is a fair amount of already
in-flight I/O not belonging to Q. This situation is not considered
when deciding whether to plug I/O dispatching (until new I/O arrives
for Q). But it has to be checked, for the following reason.

The drive may decide to serve in-flight non-Q's I/O requests before
Q's ones, thereby delaying the arrival of new I/O requests for Q
(recall that Q is sync). If I/O-dispatching is not plugged, then,
while Q remains empty, a basically uncontrolled amount of I/O from
other queues may be dispatched too, possibly causing the service of
Q's I/O to be delayed even longer in the drive. This problem gets more
and more serious as the speed and the queue depth of the drive grow,
because, as these two quantities grow, the probability to find no
queue busy but many requests in flight grows too.

This commit performs I/O-dispatch plugging in this scenario.  Plugging
minimizes the delay induced by already in-flight I/O, and enables Q to
recover the bandwidth it may lose because of this delay.

As a practical example, under write load on a Samsung SSD 970 PRO,
gnome-terminal starts in 1.5 seconds after this fix, against 15
seconds before the fix (as a reference, gnome-terminal takes about 35
seconds to start with any of the other I/O schedulers).

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 67 +++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ddf042b36549..c719020fa121 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3744,38 +3744,57 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
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
 	bool asymmetric_scenario = (bfqq->wr_coeff > 1 &&
-				    bfqd->wr_busy_queues <
-				    bfq_tot_busy_queues(bfqd)) ||
+				    (bfqd->wr_busy_queues <
+				     bfq_tot_busy_queues(bfqd) ||
+				     bfqd->rq_in_driver >=
+				     bfqq->dispatched + 4)) ||
 		bfq_asymmetric_scenario(bfqd, bfqq);
 
 	bfq_log_bfqq(bfqd, bfqq,
-- 
2.20.1

