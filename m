Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE459F5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfH0Vy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 17:54:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45595 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0Vy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:54:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so242386pfq.12;
        Tue, 27 Aug 2019 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NzRYq2NSCkfwa5bIHqtlIzdWu66lzjTkJCH+uxJQSws=;
        b=QSlfON4Q5QL+uaKCX2bJCzRihylGkZNssAwJC7vJZo61pKoDTl6m8DpK39TFHtXy/P
         6ZqCzU00H4Dsh9Q/iLTzVLHwenhjUCqhDR3lF/3a1TodyDl3sav9eDjdEskPv8yw1OXR
         ehd2SPKrjnKeqCOS746QoVpJ4n1xvqfX6aTY2IS8SutaIZ222eOBqD1d4MUAkcGVl2Uu
         foA2CUOAV1hRxchJmpNygBujnSVWYHy6T1AweYXMPnNV3kBmOHNGgliwpLIXLi2pnFHE
         Gnhmb1x+XzEfmELMqtBvsfvGgRtrvGRvKvNiGQOJCCJ6AYrSTQvYg7KIWFXG5POuQ9iV
         jOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NzRYq2NSCkfwa5bIHqtlIzdWu66lzjTkJCH+uxJQSws=;
        b=lBp55jHv7O5IDf4jdDSHzO/fuheREx/SaR+M3oNuf4L/UgXQvlrjxzYRv4s3FOwdYR
         wvhEd9BBc+IDmANPJlQp4hAZc2jdo/CPl29ZHkvoPS3ZgrsA28sKFaFGDArxsa4n1+XM
         rZLBUqueMMLS+r1+dPBQpqw5fsa9/qMEJ2Z5ascvG05gpem8hzjViUdfVAUjMRy13IvJ
         mivE0JAg/UXkRrki8P6uTGVjA4vZ7VYAQ5D9BzeOi6pGdRz24HaupuBWGcNKeEi9pcpM
         8Fa6jkn8sMUukn0Y7yJUa+wSi9bdjp8BbsBvlFjs7ZBTaQZRp5yUmi7gQ0GodSf4ugnH
         2fuw==
X-Gm-Message-State: APjAAAVLn9yT0+NZYLtXDk0I6huV0hxfGr7iDRT5la4tfbCfnCHziTSb
        cfio1NDSV2kS2Capz/KSkio=
X-Google-Smtp-Source: APXvYqyideMqvBIIPMSlJrHSfDS8R/fjsux/TnHTny2TQv6p9KQbdqSlmbH6f5+4jk6x2IlQR8VrHQ==
X-Received: by 2002:a62:1a45:: with SMTP id a66mr817838pfa.142.1566942897116;
        Tue, 27 Aug 2019 14:54:57 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id f26sm304420pfq.38.2019.08.27.14.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 14:54:56 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 8/9] drm/msm: async commit support
Date:   Tue, 27 Aug 2019 14:33:38 -0700
Message-Id: <20190827213421.21917-9-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827213421.21917-1-robdclark@gmail.com>
References: <20190827213421.21917-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Now that flush/wait/complete is decoupled from the "synchronous" part of
atomic commit_tail(), add support to defer flush to a timer that expires
shortly before vblank for async commits.  In this way, multiple atomic
commits (for example, cursor updates) can be coalesced into a single
flush at the end of the frame.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_atomic.c | 153 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_drv.c    |   1 +
 drivers/gpu/drm/msm/msm_drv.h    |   4 +
 drivers/gpu/drm/msm/msm_kms.h    |  50 ++++++++++
 4 files changed, 207 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 3d0424205349..de767a19e193 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -29,6 +29,94 @@ int msm_atomic_prepare_fb(struct drm_plane *plane,
 	return msm_framebuffer_prepare(new_state->fb, kms->aspace);
 }
 
+static void msm_atomic_async_commit(struct msm_kms *kms, int crtc_idx)
+{
+	unsigned crtc_mask = BIT(crtc_idx);
+
+	mutex_lock(&kms->commit_lock);
+
+	if (!(kms->pending_crtc_mask & crtc_mask))
+		goto out;
+
+	kms->pending_crtc_mask &= ~crtc_mask;
+
+	kms->funcs->enable_commit(kms);
+
+	/*
+	 * Flush hardware updates:
+	 */
+	DRM_DEBUG_ATOMIC("triggering async commit\n");
+	kms->funcs->flush_commit(kms, crtc_mask);
+
+	/*
+	 * Wait for flush to complete:
+	 */
+	kms->funcs->wait_flush(kms, crtc_mask);
+
+	kms->funcs->complete_commit(kms, crtc_mask);
+	kms->funcs->disable_commit(kms);
+
+out:
+	mutex_unlock(&kms->commit_lock);
+
+}
+
+static enum hrtimer_restart msm_atomic_pending_timer(struct hrtimer *t)
+{
+	struct msm_pending_timer *timer = container_of(t,
+			struct msm_pending_timer, timer);
+	struct msm_drm_private *priv = timer->kms->dev->dev_private;
+
+	queue_work(priv->wq, &timer->work);
+
+	return HRTIMER_NORESTART;
+}
+
+static void msm_atomic_pending_work(struct work_struct *work)
+{
+	struct msm_pending_timer *timer = container_of(work,
+			struct msm_pending_timer, work);
+
+	msm_atomic_async_commit(timer->kms, timer->crtc_idx);
+}
+
+void msm_atomic_init_pending_timer(struct msm_pending_timer *timer,
+		struct msm_kms *kms, int crtc_idx)
+{
+	timer->kms = kms;
+	timer->crtc_idx = crtc_idx;
+	hrtimer_init(&timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	timer->timer.function = msm_atomic_pending_timer;
+	INIT_WORK(&timer->work, msm_atomic_pending_work);
+}
+
+static bool can_do_async(struct drm_atomic_state *state,
+		struct drm_crtc **async_crtc)
+{
+	struct drm_connector_state *connector_state;
+	struct drm_connector *connector;
+	struct drm_crtc_state *crtc_state;
+	struct drm_crtc *crtc;
+	int i, num_crtcs = 0;
+
+	if (!(state->legacy_cursor_update || state->async_update))
+		return false;
+
+	/* any connector change, means slow path: */
+	for_each_new_connector_in_state(state, connector, connector_state, i)
+		return false;
+
+	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+		if (drm_atomic_crtc_needs_modeset(crtc_state))
+			return false;
+		if (++num_crtcs > 1)
+			return false;
+		*async_crtc = crtc;
+	}
+
+	return true;
+}
+
 /* Get bitmask of crtcs that will need to be flushed.  The bitmask
  * can be used with for_each_crtc_mask() iterator, to iterate
  * effected crtcs without needing to preserve the atomic state.
@@ -50,9 +138,25 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 	struct drm_device *dev = state->dev;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_kms *kms = priv->kms;
+	struct drm_crtc *async_crtc = NULL;
 	unsigned crtc_mask = get_crtc_mask(state);
+	bool async = kms->funcs->vsync_time &&
+			can_do_async(state, &async_crtc);
 
 	kms->funcs->enable_commit(kms);
+
+	/*
+	 * Ensure any previous (potentially async) commit has
+	 * completed:
+	 */
+	kms->funcs->wait_flush(kms, crtc_mask);
+
+	mutex_lock(&kms->commit_lock);
+
+	/*
+	 * Now that there is no in-progress flush is complete,
+	 * prepare the current update:
+	 */
 	kms->funcs->prepare_commit(kms, state);
 
 	/*
@@ -62,6 +166,49 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 	drm_atomic_helper_commit_planes(dev, state, 0);
 	drm_atomic_helper_commit_modeset_enables(dev, state);
 
+	if (async) {
+		struct msm_pending_timer *timer =
+			&kms->pending_timers[async_crtc->index];
+
+		/* async updates are limited to single-crtc updates: */
+		WARN_ON(crtc_mask != BIT(async_crtc->index));
+
+		/*
+		 * Start timer if we don't already have an update pending
+		 * on this crtc:
+		 */
+		if (!(kms->pending_crtc_mask & crtc_mask)) {
+			ktime_t vsync_time, wakeup_time;
+
+			kms->pending_crtc_mask |= crtc_mask;
+
+			vsync_time = kms->funcs->vsync_time(kms, async_crtc);
+			wakeup_time = ktime_sub(vsync_time, ms_to_ktime(1));
+
+			hrtimer_start(&timer->timer, wakeup_time,
+					HRTIMER_MODE_ABS);
+		}
+
+		kms->funcs->disable_commit(kms);
+		mutex_unlock(&kms->commit_lock);
+
+		/*
+		 * At this point, from drm core's perspective, we
+		 * are done with the atomic update, so we can just
+		 * go ahead and signal that it is done:
+		 */
+		drm_atomic_helper_commit_hw_done(state);
+		drm_atomic_helper_cleanup_planes(dev, state);
+
+		return;
+	}
+
+	/*
+	 * If there is any async flush pending on updated crtcs, fold
+	 * them into the current flush.
+	 */
+	kms->pending_crtc_mask &= ~crtc_mask;
+
 	/*
 	 * Flush hardware updates:
 	 */
@@ -71,11 +218,15 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 	}
 	kms->funcs->flush_commit(kms, crtc_mask);
 
+	/*
+	 * Wait for flush to complete:
+	 */
 	kms->funcs->wait_flush(kms, crtc_mask);
+
 	kms->funcs->complete_commit(kms, crtc_mask);
 	kms->funcs->disable_commit(kms);
+	mutex_unlock(&kms->commit_lock);
 
 	drm_atomic_helper_commit_hw_done(state);
-
 	drm_atomic_helper_cleanup_planes(dev, state);
 }
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 336a6d0a4cd3..65262a993440 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -532,6 +532,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	ddev->mode_config.normalize_zpos = true;
 
 	if (kms) {
+		kms->dev = ddev;
 		ret = kms->funcs->hw_init(kms);
 		if (ret) {
 			DRM_DEV_ERROR(dev, "kms hw init failed: %d\n", ret);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 79d480a7d97d..7d164d5c18b4 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -222,8 +222,12 @@ struct msm_format {
 	uint32_t pixel_format;
 };
 
+struct msm_pending_timer;
+
 int msm_atomic_prepare_fb(struct drm_plane *plane,
 			  struct drm_plane_state *new_state);
+void msm_atomic_init_pending_timer(struct msm_pending_timer *timer,
+		struct msm_kms *kms, int crtc_idx);
 void msm_atomic_commit_tail(struct drm_atomic_state *state);
 struct drm_atomic_state *msm_atomic_state_alloc(struct drm_device *dev);
 void msm_atomic_state_clear(struct drm_atomic_state *state);
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index f9847eb39143..9a0236eb6487 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -33,6 +33,20 @@ struct msm_kms_funcs {
 
 	/*
 	 * Atomic commit handling:
+	 *
+	 * Note that in the case of async commits, the funcs which take
+	 * a crtc_mask (ie. ->flush_commit(), and ->complete_commit())
+	 * might not be evenly balanced with ->prepare_commit(), however
+	 * each crtc that effected by a ->perpare_commit() (potentially
+	 * multiple times) will eventually (at end of vsync period) be
+	 * flushed and completed.
+	 *
+	 * This has some implications about tracking of cleanup state,
+	 * for example SMP blocks to release after commit completes.  Ie.
+	 * cleanup state should be also duplicated in the various
+	 * duplicate_state() methods, as the current cleanup state at
+	 * ->complete_commit() time may have accumulated cleanup work
+	 * from multiple commits.
 	 */
 
 	/**
@@ -45,6 +59,14 @@ struct msm_kms_funcs {
 	void (*enable_commit)(struct msm_kms *kms);
 	void (*disable_commit)(struct msm_kms *kms);
 
+	/**
+	 * If the kms backend supports async commit, it should implement
+	 * this method to return the time of the next vsync.  This is
+	 * used to determine a time slightly before vsync, for the async
+	 * commit timer to run and complete an async commit.
+	 */
+	ktime_t (*vsync_time)(struct msm_kms *kms, struct drm_crtc *crtc);
+
 	/**
 	 * Prepare for atomic commit.  This is called after any previous
 	 * (async or otherwise) commit has completed.
@@ -109,20 +131,48 @@ struct msm_kms_funcs {
 #endif
 };
 
+struct msm_kms;
+
+/*
+ * A per-crtc timer for pending async atomic flushes.  Scheduled to expire
+ * shortly before vblank to flush pending async updates.
+ */
+struct msm_pending_timer {
+	struct hrtimer timer;
+	struct work_struct work;
+	struct msm_kms *kms;
+	unsigned crtc_idx;
+};
+
 struct msm_kms {
 	const struct msm_kms_funcs *funcs;
+	struct drm_device *dev;
 
 	/* irq number to be passed on to drm_irq_install */
 	int irq;
 
 	/* mapper-id used to request GEM buffer mapped for scanout: */
 	struct msm_gem_address_space *aspace;
+
+	/*
+	 * For async commit, where ->flush_commit() and later happens
+	 * from the crtc's pending_timer close to end of the frame:
+	 */
+	struct mutex commit_lock;
+	unsigned pending_crtc_mask;
+	struct msm_pending_timer pending_timers[MAX_CRTCS];
 };
 
 static inline void msm_kms_init(struct msm_kms *kms,
 		const struct msm_kms_funcs *funcs)
 {
+	unsigned i;
+
+	mutex_init(&kms->commit_lock);
 	kms->funcs = funcs;
+
+	for (i = 0; i < ARRAY_SIZE(kms->pending_timers); i++)
+		msm_atomic_init_pending_timer(&kms->pending_timers[i], kms, i);
 }
 
 struct msm_kms *mdp4_kms_init(struct drm_device *dev);
-- 
2.21.0

