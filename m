Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 603F5CC250
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 20:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfJDSJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 14:09:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34674 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfJDSJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:09:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id y35so4210967pgl.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jva9qpw4IbtlmZPIgeyGwpLF5rIlYvV+DqrMYfpP5/I=;
        b=UV9gzpUSsb+C2yovB0qxRDPkWrR/a+CCc3JIvwAZVmam3WQdRwyxRsbwvJEMsqNwic
         fVYkivtx48Yaai7PACW4ELyoS2yCC2RsqOl6VNJJdpWUfSjlUVEzig17xvhxcY3v8kxG
         g3kpgrFkQ9fL8HLqDPYRvpUonqGwDJprTbxxbYUCeY7EZ3/2sMgyO6kS5KBGBzWjg+wu
         Jp+pfgmst2qEm2HPeOtABbFe9WzIPKXpmf7ZA9fiDULInx7xmidnwV9Q57TDW7wKzBOV
         XlQeyJMmQd9xMrU527bnljs18d/TdJZYiLXZtO+quz65/+cTK/U+uyko1dRZx2tB0HUr
         0aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jva9qpw4IbtlmZPIgeyGwpLF5rIlYvV+DqrMYfpP5/I=;
        b=sAgetqGTq0DW/+4ma9Lz/1AFmTvdADgUCQcdxH7Ne+F7KvIEMx9LG2qNINhc1URvqq
         BUKCQpocEzFj0HzIwC2S6/R7pS8xyb6WAivrNyxyrnWM/gFSdE2FoIbsZDZuRtLaY2kO
         PHZh/0M1ufNBbR7YOHdUBHl+gqXgxS8ZtkqqgoOiWkHCAv6RVuBAiIhNurfH2Pje48w7
         8GQAky8aByQkhIPkHexti+SAqsnHLfg/peia1idzXHg2LXhZPwwLn9tOfYR16b9wJ3u4
         eE2gVEVnOyGyRqb7IrwgUFghZ4rcUVZoxm0eF6Pe7mNWeFw5fuVjNYdbk2PzqxMe6TBD
         yK3w==
X-Gm-Message-State: APjAAAXfoZ5/WYXuNhztCSeoisho2aJtWq8IMKKh169ZwuYsaiLDdscO
        a/U+7hI8kjNFU+1z9bbwocguQxHl
X-Google-Smtp-Source: APXvYqx6g0GBSVTclmaGs4MtPq/WkOVlGeEfjg8JHrWM5P0cF7C/n0prQ9zbazU0j8yb2b2JB6/a+w==
X-Received: by 2002:a63:cb:: with SMTP id 194mr3304854pga.172.1570212567208;
        Fri, 04 Oct 2019 11:09:27 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id u31sm8906719pgn.93.2019.10.04.11.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:09:26 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH] blk-wbt: fix performance regression in wbt scale_up/scale_down
Date:   Fri,  4 Oct 2019 11:09:20 -0700
Message-Id: <20191004180920.105572-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scale_up wakes up waiters after scaling up. But after scaling max, it
should not wake up more waiters as waiters will not have anything to
do. This patch fixes this by making scale_up (and also scale_down)
return when threshold is reached.

This bug causes increased fdatasync latency when fdatasync and dd
conv=sync are performed in parallel on 4.19 compared to 4.14. This
bug was introduced during refactoring of blk-wbt code.

Fixes: a79050434b45 ("blk-rq-qos: refactor out common elements of blk-wbt")
Cc: Josef Bacik <jbacik@fb.com>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 block/blk-rq-qos.c | 14 +++++++++-----
 block/blk-rq-qos.h |  4 ++--
 block/blk-wbt.c    |  6 ++++--
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 3954c0dc1443..d92abb43000c 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -142,24 +142,27 @@ bool rq_depth_calc_max_depth(struct rq_depth *rqd)
 	return ret;
 }
 
-void rq_depth_scale_up(struct rq_depth *rqd)
+/* Returns true on success and false if scaling up wasn't possible */
+bool rq_depth_scale_up(struct rq_depth *rqd)
 {
 	/*
 	 * Hit max in previous round, stop here
 	 */
 	if (rqd->scaled_max)
-		return;
+		return false;
 
 	rqd->scale_step--;
 
 	rqd->scaled_max = rq_depth_calc_max_depth(rqd);
+	return true;
 }
 
 /*
  * Scale rwb down. If 'hard_throttle' is set, do it quicker, since we
- * had a latency violation.
+ * had a latency violation. Returns true on success and returns false if
+ * scaling down wasn't possible.
  */
-void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
+bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
 {
 	/*
 	 * Stop scaling down when we've hit the limit. This also prevents
@@ -167,7 +170,7 @@ void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
 	 * keep up.
 	 */
 	if (rqd->max_depth == 1)
-		return;
+		return false;
 
 	if (rqd->scale_step < 0 && hard_throttle)
 		rqd->scale_step = 0;
@@ -176,6 +179,7 @@ void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
 
 	rqd->scaled_max = false;
 	rq_depth_calc_max_depth(rqd);
+	return 0;
 }
 
 struct rq_qos_wait_data {
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 2300e038b9fa..c0f0778d5396 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -125,8 +125,8 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		 acquire_inflight_cb_t *acquire_inflight_cb,
 		 cleanup_cb_t *cleanup_cb);
 bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit);
-void rq_depth_scale_up(struct rq_depth *rqd);
-void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
+bool rq_depth_scale_up(struct rq_depth *rqd);
+bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
 bool rq_depth_calc_max_depth(struct rq_depth *rqd);
 
 void __rq_qos_cleanup(struct rq_qos *rqos, struct bio *bio);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 313f45a37e9d..5a96881e7a52 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -308,7 +308,8 @@ static void calc_wb_limits(struct rq_wb *rwb)
 
 static void scale_up(struct rq_wb *rwb)
 {
-	rq_depth_scale_up(&rwb->rq_depth);
+	if (!rq_depth_scale_up(&rwb->rq_depth))
+		return;
 	calc_wb_limits(rwb);
 	rwb->unknown_cnt = 0;
 	rwb_wake_all(rwb);
@@ -317,7 +318,8 @@ static void scale_up(struct rq_wb *rwb)
 
 static void scale_down(struct rq_wb *rwb, bool hard_throttle)
 {
-	rq_depth_scale_down(&rwb->rq_depth, hard_throttle);
+	if (!rq_depth_scale_down(&rwb->rq_depth, hard_throttle))
+		return;
 	calc_wb_limits(rwb);
 	rwb->unknown_cnt = 0;
 	rwb_trace_step(rwb, "scale down");
-- 
2.23.0.581.g78d2f28ef7-goog

