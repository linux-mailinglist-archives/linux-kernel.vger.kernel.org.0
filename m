Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189D4E37D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439877AbfJXQZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 12:25:28 -0400
Received: from foss.arm.com ([217.140.110.172]:55846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439858AbfJXQZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:25:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBE51328;
        Thu, 24 Oct 2019 09:25:11 -0700 (PDT)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4993F71F;
        Thu, 24 Oct 2019 09:25:10 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Steven Price <steven.price@arm.com>
Subject: [RESEND PATCH v4] drm: Don't free jobs in wait_event_interruptible()
Date:   Thu, 24 Oct 2019 17:24:24 +0100
Message-Id: <20191024162424.38548-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_sched_cleanup_jobs() attempts to free finished jobs, however because
it is called as the condition of wait_event_interruptible() it must not
sleep. Unfortuantly some free callbacks (notibly for Panfrost) do sleep.

Instead let's rename drm_sched_cleanup_jobs() to
drm_sched_get_cleanup_job() and simply return a job for processing if
there is one. The caller can then call the free_job() callback outside
the wait_event_interruptible() where sleeping is possible before
re-checking and returning to sleep if necessary.

Signed-off-by: Steven Price <steven.price@arm.com>
---
Previous posting: https://lore.kernel.org/lkml/20190926141630.14258-1-steven.price@arm.com/

 drivers/gpu/drm/scheduler/sched_main.c | 45 +++++++++++++++-----------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 9a0ee74d82dc..148468447ba9 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -622,43 +622,41 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
 }
 
 /**
- * drm_sched_cleanup_jobs - destroy finished jobs
+ * drm_sched_get_cleanup_job - fetch the next finished job to be destroyed
  *
  * @sched: scheduler instance
  *
- * Remove all finished jobs from the mirror list and destroy them.
+ * Returns the next finished job from the mirror list (if there is one)
+ * ready for it to be destroyed.
  */
-static void drm_sched_cleanup_jobs(struct drm_gpu_scheduler *sched)
+static struct drm_sched_job *
+drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 {
+	struct drm_sched_job *job = NULL;
 	unsigned long flags;
 
 	/* Don't destroy jobs while the timeout worker is running */
 	if (sched->timeout != MAX_SCHEDULE_TIMEOUT &&
 	    !cancel_delayed_work(&sched->work_tdr))
-		return;
-
+		return NULL;
 
-	while (!list_empty(&sched->ring_mirror_list)) {
-		struct drm_sched_job *job;
+	spin_lock_irqsave(&sched->job_list_lock, flags);
 
-		job = list_first_entry(&sched->ring_mirror_list,
+	job = list_first_entry_or_null(&sched->ring_mirror_list,
 				       struct drm_sched_job, node);
-		if (!dma_fence_is_signaled(&job->s_fence->finished))
-			break;
 
-		spin_lock_irqsave(&sched->job_list_lock, flags);
+	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
 		/* remove job from ring_mirror_list */
 		list_del_init(&job->node);
-		spin_unlock_irqrestore(&sched->job_list_lock, flags);
-
-		sched->ops->free_job(job);
+	} else {
+		job = NULL;
+		/* queue timeout for next job */
+		drm_sched_start_timeout(sched);
 	}
 
-	/* queue timeout for next job */
-	spin_lock_irqsave(&sched->job_list_lock, flags);
-	drm_sched_start_timeout(sched);
 	spin_unlock_irqrestore(&sched->job_list_lock, flags);
 
+	return job;
 }
 
 /**
@@ -698,12 +696,21 @@ static int drm_sched_main(void *param)
 		struct drm_sched_fence *s_fence;
 		struct drm_sched_job *sched_job;
 		struct dma_fence *fence;
+		struct drm_sched_job *cleanup_job = NULL;
 
 		wait_event_interruptible(sched->wake_up_worker,
-					 (drm_sched_cleanup_jobs(sched),
+					 (cleanup_job = drm_sched_get_cleanup_job(sched)) ||
 					 (!drm_sched_blocked(sched) &&
 					  (entity = drm_sched_select_entity(sched))) ||
-					 kthread_should_stop()));
+					 kthread_should_stop());
+
+		while (cleanup_job) {
+			sched->ops->free_job(cleanup_job);
+			/* queue timeout for next job */
+			drm_sched_start_timeout(sched);
+
+			cleanup_job = drm_sched_get_cleanup_job(sched);
+		}
 
 		if (!entity)
 			continue;
-- 
2.20.1

