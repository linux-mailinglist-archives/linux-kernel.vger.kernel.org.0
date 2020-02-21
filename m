Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB2167E80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 14:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgBUN1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 08:27:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52347 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgBUN1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:27:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so1799352wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2jv58e7XYQhyiOZ8oB+F6DiHwvlWPcUvM4iYr9/nM+k=;
        b=CUM+1FS1wIwzwu76hP5YN1+YQ0C2iku0Lx7PsSOXrOAsEKmXQOismOAzpVoD4QiLnl
         fIJMk5FHHupX+IOXTFXB/9yraI4Knu4j7Y9xZLd7DTnT5AyzQgSnj/w6YJWD/fJW5zlT
         DjcMBhsMjHk6//0Wwjz2cPZyZZi9XOfywDvZnksKiInytQxOCooARMIeXuS+yoEeng5o
         JF1DZeWT9r8jguTw4bQJ0cP7H09ytIsFJbuMolUHuawB9otw94ES0eamwGDT6MeU6Uf1
         6rsjyD4R/5rBBEsQGUe8kpUTyS2UWVYPu+ih1rAGKmLZ0jGlpXoAKZ7l1aoLxeVVGaOH
         lbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2jv58e7XYQhyiOZ8oB+F6DiHwvlWPcUvM4iYr9/nM+k=;
        b=Q5InxM650w6wEbFTGLHxSaOvKuiNUBu4Mqs5V6HrNVlBkyJ41QCVzj3GmH/2CEO0NC
         ZKMfJkylhBf5v4e1RkMarSQ6TAZY7X6ZqZ/jLuOqd3PFu+fGzWNF4JjwXpB0nfzSH04i
         2Tk9G4eU/+VgOPbt3BSiFVXqVpLOrZF5u0xTNMW8HETMN46i3eSi7TzB0X3i/RqsvnVM
         8yk2q9g7EqUzi8PP45r5O/jqfneNZKW944l8LFehBu0Q6AZDjluVSEp7c3iOZ+c5hUtc
         Sf3jx3JL2yQfF15KtTJCcoOI1edyIIWnnQsM2wIRj0EjRP3Lc0RTxk9nz1qSKlSkcMvK
         8yyA==
X-Gm-Message-State: APjAAAWnXStypfeapvpU/alq6t7zTr2t9APsjniux0nv5jreMgyX9K47
        PKuOywThV+B2OkbK+bB7Lf569g==
X-Google-Smtp-Source: APXvYqwHNTLCbACEbRn63ByOPDZJlbKSRBCR5E5GeowHzNIok84kpMsrScP4ydgUFy9Ua8Vf9LhCHw==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr4009982wmc.126.1582291652169;
        Fri, 21 Feb 2020 05:27:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:1c35:eef1:1bd1:92a7])
        by smtp.gmail.com with ESMTPSA id y185sm4058308wmg.2.2020.02.21.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 05:27:31 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 1/5] sched/fair: Reorder enqueue/dequeue_task_fair path
Date:   Fri, 21 Feb 2020 14:27:11 +0100
Message-Id: <20200221132715.20648-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221132715.20648-1-vincent.guittot@linaro.org>
References: <20200221132715.20648-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The walk through the cgroup hierarchy during the enqueue/dequeue of a task
is split in 2 distinct parts for throttled cfs_rq without any added value
but making code less readable.

Change the code ordering such that everything related to a cfs_rq
(throttled or not) will be done in the same loop.

In addition, the same steps ordering is used when updating a cfs_rq:
- update_load_avg
- update_cfs_group
- update *h_nr_running

This reordering enables the use of h_nr_running in PELT algorithm.

No functional and performance changes are expected and have been noticed
during tests.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
---
 kernel/sched/fair.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a7e11b1bb64c..27450c4ddc81 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5259,32 +5259,31 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq = cfs_rq_of(se);
 		enqueue_entity(cfs_rq, se, flags);
 
-		/*
-		 * end evaluation on encountering a throttled cfs_rq
-		 *
-		 * note: in the case of encountering a throttled cfs_rq we will
-		 * post the final h_nr_running increment below.
-		 */
-		if (cfs_rq_throttled(cfs_rq))
-			break;
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
+		/* end evaluation on encountering a throttled cfs_rq */
+		if (cfs_rq_throttled(cfs_rq))
+			goto enqueue_throttle;
+
 		flags = ENQUEUE_WAKEUP;
 	}
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_nr_running++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
+		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			break;
+			goto enqueue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		update_cfs_group(se);
+
+		cfs_rq->h_nr_running++;
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 	}
 
+enqueue_throttle:
 	if (!se) {
 		add_nr_running(rq, 1);
 		/*
@@ -5345,17 +5344,13 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
 
-		/*
-		 * end evaluation on encountering a throttled cfs_rq
-		 *
-		 * note: in the case of encountering a throttled cfs_rq we will
-		 * post the final h_nr_running decrement below.
-		*/
-		if (cfs_rq_throttled(cfs_rq))
-			break;
 		cfs_rq->h_nr_running--;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
+		/* end evaluation on encountering a throttled cfs_rq */
+		if (cfs_rq_throttled(cfs_rq))
+			goto dequeue_throttle;
+
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -5373,16 +5368,19 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_nr_running--;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
+		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			break;
+			goto dequeue_throttle;
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		update_cfs_group(se);
+
+		cfs_rq->h_nr_running--;
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 	}
 
+dequeue_throttle:
 	if (!se)
 		sub_nr_running(rq, 1);
 
-- 
2.17.1

