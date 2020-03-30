Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E26197EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 16:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgC3Otu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 10:49:50 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50943 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgC3Ots (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:49:48 -0400
Received: by mail-pj1-f67.google.com with SMTP id v13so7689002pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EuYDssEB7evYPsaury7cjtqe0bY7Z307ltbStlf8RcQ=;
        b=UBWR7VA4YVLrQ4url646yT9vaphZOdutTIcpjIf1GGc5cotZ+uLa+tx6myCbsioNFX
         sYlHMeHc7+D13OD7Mj6fe2dZeZWYErqeEBHVOGbey2hnrkH2b9scF5mD0xZZX4I1HTx9
         gnHhtytjx3/ylt0WG5LnhKfBzOMRRjqSBwvm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EuYDssEB7evYPsaury7cjtqe0bY7Z307ltbStlf8RcQ=;
        b=irWx/Rk4wMPCL+bzvuvzmMjpdPylnENj6/STS40TX/LzYnJTuFKVlbSll/W37v6/Mj
         WhHD3h27eLcoyvOFQKQFcotAlogmNlkA88n1cYgDE/Q5HLFnnBPaorT/WXgqYAFoUy2J
         4UBZlKO43tLJ1iKGNjdDLRWNReN29DV4qScBXCJq7Pj+OUhzwe8nVSC8qpLw1UOjfybL
         sAj4IQYCThXK6izNv+jC9Nc4mRgN03HAOBzUuAPP8i+1FrE0HrRnDm9Q55HpqcQ+03/j
         TBa0K/NiJbnqnPvEVplOGWye3JEVocLkURdR7OfpX9Ob7qVvy1X59V8cDNlCiGFc2BZj
         HulQ==
X-Gm-Message-State: ANhLgQ2PIg/dYOP8lXX44KbFNPSyah2/zyy/VnDVRQw3u44jKes7y+9n
        mcNxIwoWAOeZTZfs6R9Ce5/L0w==
X-Google-Smtp-Source: ADFU+vtMF+C5nJkLwJJYZ4lY+Y0gDiTaA2EAiSmNSROpCrQpUyOrjK9YEVRtmJDI6+R7RJoZyMiZtQ==
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr16921059pjr.55.1585579788020;
        Mon, 30 Mar 2020 07:49:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y198sm1460972pfg.123.2020.03.30.07.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:49:47 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, groeck@chromium.org,
        paolo.valente@linaro.org, linux-scsi@vger.kernel.org,
        sqazi@google.com, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: In blk_mq_dispatch_rq_list() "no budget" is a reason to kick
Date:   Mon, 30 Mar 2020 07:49:05 -0700
Message-Id: <20200330074856.1.I1f95c459e51962b8d2c83e869913b6befda2255c@changeid>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330144907.13011-1-dianders@chromium.org>
References: <20200330144907.13011-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In blk_mq_dispatch_rq_list(), if blk_mq_sched_needs_restart() returns
true and the driver returns BLK_STS_RESOURCE then we'll kick the
queue.  However, there's another case where we might need to kick it.
If we were unable to get budget we can be in much the same state as
when the driver returns BLK_STS_RESOURCE, so we should treat it the
same.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 block/blk-mq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d92088dec6c3..2cd8d2b49ff4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1189,6 +1189,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
+	bool no_budget_avail = false;
 
 	if (list_empty(list))
 		return false;
@@ -1205,8 +1206,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		hctx = rq->mq_hctx;
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
+		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
+			no_budget_avail = true;
 			break;
+		}
 
 		if (!blk_mq_get_driver_tag(rq)) {
 			/*
@@ -1311,13 +1314,15 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 *
 		 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
 		 * bit is set, run queue after a delay to avoid IO stalls
-		 * that could otherwise occur if the queue is idle.
+		 * that could otherwise occur if the queue is idle.  We'll do
+		 * similar if we couldn't get budget and SCHED_RESTART is set.
 		 */
 		needs_restart = blk_mq_sched_needs_restart(hctx);
 		if (!needs_restart ||
 		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
-		else if (needs_restart && (ret == BLK_STS_RESOURCE))
+		else if (needs_restart && (ret == BLK_STS_RESOURCE ||
+					   no_budget_avail))
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
 
 		blk_mq_update_dispatch_busy(hctx, true);
-- 
2.26.0.rc2.310.g2932bb562d-goog

