Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5699806
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 17:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389551AbfHVPVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 11:21:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34118 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389040AbfHVPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:21:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id e8so7328758wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ELMpUJexjYTcd7MhQ08SZVf3kBnnCO4/j3IIYq4skds=;
        b=auiCoSvIyq9JJI/w/E0uM+TRpA3m+MgN3krMgBBSdol/QQxKZ1xBWl1/XruqMlaJLy
         wtumBUU817GQWPaHUTA4uAKD3/3KDW4vOK/fqNLuDTT8nL6UrxK/U8zc5rwzkr510h+R
         WxH9vikEsZ7u89kG8VRlWLg9zbWcKCCmyNhTGoGUGXVgmJB94PyGH5OXjfGWBN2R3R1d
         LJI6ecAc9veuZj75CnL4Hj0xKW22bvT0knnGZ82n3utvhrGMmS0El4OPG/Tm3hT8v3iN
         yWCq4mVnVxYh4kddPRj8eXR7VhgsWBadW7N6s9LBQa48GbpGrHN/RTCLXo9hyDKJHjVd
         7OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ELMpUJexjYTcd7MhQ08SZVf3kBnnCO4/j3IIYq4skds=;
        b=P1wwMdBp+SUEVFRrdGyTF522weLr3loOdtoHtuKCc+M0B63JZ2jFM67aSL50u0KCdS
         dABNE/Fm/p7ZTgAzkc9yQQFsmIm5xAPJxq/5BfO2lg7CqrmkjNfC0F1aRT4ESxfqEBC5
         oln3DggV1RBbxWw6dJgcJ+5BN9otUGQ+qNpcmgdGn8qp5dHYEueVDfs78ybKYQyP7EFd
         6cb5YO9FFsiW0s4UgRJicl58hTOvBuZquyBxx/wWUfDk1G3e//LrmBi1MPOIwVsQH0pm
         n3nMt2+YHO5O85ZWWyjuMiJiM4GVVUvdcP4LLuBGyTkyFzy4CKv601tLW3QvN6Uer2gJ
         kRZw==
X-Gm-Message-State: APjAAAWsqEm8E1X/1PH98Bc3LisyaBS6/wM8AhLnAkOlDz8OVHel4z3/
        SFvhbsxJgCto8mV4OLgt+5D2vg==
X-Google-Smtp-Source: APXvYqwAwov6sEvyu4LBSFiaSToGiE2k5CeC63VtD8WpA/0WtqYyfTL12TWXaSUmeZ+ldncsYt7BEw==
X-Received: by 2002:a05:600c:d9:: with SMTP id u25mr7254091wmm.26.1566487260240;
        Thu, 22 Aug 2019 08:21:00 -0700 (PDT)
Received: from localhost.localdomain (146-241-115-105.dyn.eolo.it. [146.241.115.105])
        by smtp.gmail.com with ESMTPSA id a19sm79833974wra.2.2019.08.22.08.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 08:20:59 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 1/4] block, bfq: update inject limit only after injection occurred
Date:   Thu, 22 Aug 2019 17:20:34 +0200
Message-Id: <20190822152037.15413-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822152037.15413-1-paolo.valente@linaro.org>
References: <20190822152037.15413-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BFQ updates the injection limit of each bfq_queue as a function of how
much the limit inflates the service times experienced by the I/O
requests of the queue. So only service times affected by injection
must be taken into account. Unfortunately, in the current
implementation of this update scheme, the service time of an I/O
request rq not affected by injection may happen to be considered in
the following case: there is no I/O request in service when rq
arrives.

This commit fixes this issue by making sure that only service times
affected by injection are considered for updating the injection
limit. In particular, the service time of an I/O request rq is now
considered only if at least one of the following two conditions holds:
- the destination bfq_queue for rq underwent injection before rq
arrival, and there is still I/O in service in the drive on rq arrival
(the service of such unfinished I/O may delay the service of rq);
- injection occurs between the arrival and the completion time of rq.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b33be928d164..5a2bbd8613a8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2025,7 +2025,21 @@ static void bfq_add_request(struct request *rq)
 			 * be set when rq will be dispatched.
 			 */
 			bfqd->wait_dispatch = true;
-			bfqd->rqs_injected = false;
+			/*
+			 * If there is no I/O in service in the drive,
+			 * then possible injection occurred before the
+			 * arrival of rq will not affect the total
+			 * service time of rq. So the injection limit
+			 * must not be updated as a function of such
+			 * total service time, unless new injection
+			 * occurs before rq is completed. To have the
+			 * injection limit updated only in the latter
+			 * case, reset rqs_injected here (rqs_injected
+			 * will be set in case injection is performed
+			 * on bfqq before rq is completed).
+			 */
+			if (bfqd->rq_in_driver == 0)
+				bfqd->rqs_injected = false;
 		}
 	}
 
@@ -5784,7 +5798,7 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 	u64 tot_time_ns = ktime_get_ns() - bfqd->last_empty_occupied_ns;
 	unsigned int old_limit = bfqq->inject_limit;
 
-	if (bfqq->last_serv_time_ns > 0) {
+	if (bfqq->last_serv_time_ns > 0 && bfqd->rqs_injected) {
 		u64 threshold = (bfqq->last_serv_time_ns * 3)>>1;
 
 		if (tot_time_ns >= threshold && old_limit > 0) {
@@ -5830,6 +5844,7 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 
 	/* update complete, not waiting for any request completion any longer */
 	bfqd->waited_rq = NULL;
+	bfqd->rqs_injected = false;
 }
 
 /*
-- 
2.20.1

