Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F069F534
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 23:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbfH0VjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 17:39:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46439 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0VjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:39:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so218213pfc.13;
        Tue, 27 Aug 2019 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQ4jwqBG8EsW432GvBdLsYEJC4NIC/EX2i8l181zzqI=;
        b=dgzpdEO5dTkMRYWaawNcZ39lE6kArsjkbmqgdDhn51AmtsLQxm83szxiZElja3WrLD
         UoD2q17YWBfHOslpnXDkQ24WlFYLalV90iu5tZGo5cjEHzivXhUO2cQOzDvsjGh7UusI
         coJtoDQvK3D0+nXi1024xg+KXtb1bdYHBKgOmUFKHYFMI5aN7G6epzqvINSGu3bl6A5X
         KBptfOy752t4nUruov9zo8VGEySJCgiHP04GGoNuFY5EeuIbttZMSVDhj5zaNA5s14B+
         Qk+OKI89qTRPQIHsY6Rmt8Nz9JHTNnYHV6TQCUC3QHgoWfzD+aq2rQfA6PYfKIl2UCSm
         nnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQ4jwqBG8EsW432GvBdLsYEJC4NIC/EX2i8l181zzqI=;
        b=IQoDSBEuQE7d/uW71HYEcDEEiCYlTRebyEy+DvUn2zTOvaFXxxdTBkgXIEHwViGUs1
         1CB9PGgrZdxJL+YGYCEyM63EMnwRWFy+zu7GJaQN7zwxESsBRHx+VBO7rnqaNKt9/fjl
         wsZ8Rx0/+6VTy0eAb0d5Z0aDu4k4wPQZmCkFYorMdkndlYiFUGQfEj9k9/ZRVJoJudoX
         12C91uL1z6ymcCcdvzgytow2hW/w4cw7XXa83n4xCQr388ZW3QvnW90z+Tz9jPuFW4RC
         HRWOpHwkUeaGazzyvS/IL0Nldm/sc7WU+5EJhcyKgDm750O5d9lF5Cb1FlhWcUq95dW2
         qPZg==
X-Gm-Message-State: APjAAAVr+wYLk1alLj8h9Ka6LLBhWMOKJ2XlC+3eq61n9IhMlyKoUBIS
        h7ja7887S5lWItuM/jquHI5B3iLu1Pc=
X-Google-Smtp-Source: APXvYqwydFQYfo/fbLncH7Mq5b3qyULdN8E5231knw2rVs31XiwIWzfs7kV8RtBpzhs5KIe9B5hHDA==
X-Received: by 2002:a63:2807:: with SMTP id o7mr501997pgo.131.1566941942817;
        Tue, 27 Aug 2019 14:39:02 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id h20sm262646pfq.156.2019.08.27.14.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 14:39:02 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Bruce Wang <bzwang@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Fritz Koenig <frkoenig@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/9] drm/msm/dpu: unwind async commit handling
Date:   Tue, 27 Aug 2019 14:33:31 -0700
Message-Id: <20190827213421.21917-2-robdclark@gmail.com>
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

It attempted to avoid fps drops in the presence of cursor updates.  But
it is racing, and can result in hw updates after flush before vblank,
which leads to underruns.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 41 ++++++++++-----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 39 +++++++-------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  5 +--
 drivers/gpu/drm/msm/msm_atomic.c            |  3 +-
 6 files changed, 37 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index a52439e029c9..c3f7154017c4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -610,7 +610,7 @@ static int _dpu_crtc_wait_for_frame_done(struct drm_crtc *crtc)
 	return rc;
 }
 
-void dpu_crtc_commit_kickoff(struct drm_crtc *crtc, bool async)
+void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
 {
 	struct drm_encoder *encoder;
 	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
@@ -636,35 +636,32 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc, bool async)
 				  crtc->state->encoder_mask)
 		dpu_encoder_prepare_for_kickoff(encoder);
 
-	if (!async) {
-		/* wait for previous frame_event_done completion */
-		DPU_ATRACE_BEGIN("wait_for_frame_done_event");
-		ret = _dpu_crtc_wait_for_frame_done(crtc);
-		DPU_ATRACE_END("wait_for_frame_done_event");
-		if (ret) {
-			DPU_ERROR("crtc%d wait for frame done failed;frame_pending%d\n",
-					crtc->base.id,
-					atomic_read(&dpu_crtc->frame_pending));
-			goto end;
-		}
+	/* wait for previous frame_event_done completion */
+	DPU_ATRACE_BEGIN("wait_for_frame_done_event");
+	ret = _dpu_crtc_wait_for_frame_done(crtc);
+	DPU_ATRACE_END("wait_for_frame_done_event");
+	if (ret) {
+		DPU_ERROR("crtc%d wait for frame done failed;frame_pending%d\n",
+				crtc->base.id,
+				atomic_read(&dpu_crtc->frame_pending));
+		goto end;
+	}
 
-		if (atomic_inc_return(&dpu_crtc->frame_pending) == 1) {
-			/* acquire bandwidth and other resources */
-			DPU_DEBUG("crtc%d first commit\n", crtc->base.id);
-		} else
-			DPU_DEBUG("crtc%d commit\n", crtc->base.id);
+	if (atomic_inc_return(&dpu_crtc->frame_pending) == 1) {
+		/* acquire bandwidth and other resources */
+		DPU_DEBUG("crtc%d first commit\n", crtc->base.id);
+	} else
+		DPU_DEBUG("crtc%d commit\n", crtc->base.id);
 
-		dpu_crtc->play_count++;
-	}
+	dpu_crtc->play_count++;
 
 	dpu_vbif_clear_errors(dpu_kms);
 
 	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
-		dpu_encoder_kickoff(encoder, async);
+		dpu_encoder_kickoff(encoder);
 
 end:
-	if (!async)
-		reinit_completion(&dpu_crtc->frame_done_comp);
+	reinit_completion(&dpu_crtc->frame_done_comp);
 	DPU_ATRACE_END("crtc_commit");
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
index 5181f079a6a1..10f78459f6c2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
@@ -238,9 +238,8 @@ void dpu_crtc_vblank_callback(struct drm_crtc *crtc);
 /**
  * dpu_crtc_commit_kickoff - trigger kickoff of the commit for this crtc
  * @crtc: Pointer to drm crtc object
- * @async: true if the commit is asynchronous, false otherwise
  */
-void dpu_crtc_commit_kickoff(struct drm_crtc *crtc, bool async);
+void dpu_crtc_commit_kickoff(struct drm_crtc *crtc);
 
 /**
  * dpu_crtc_complete_commit - callback signalling completion of current commit
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 627c57594221..ac2d534bf59e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1421,8 +1421,7 @@ static void dpu_encoder_off_work(struct work_struct *work)
  * extra_flush_bits: Additional bit mask to include in flush trigger
  */
 static void _dpu_encoder_trigger_flush(struct drm_encoder *drm_enc,
-		struct dpu_encoder_phys *phys, uint32_t extra_flush_bits,
-		bool async)
+		struct dpu_encoder_phys *phys, uint32_t extra_flush_bits)
 {
 	struct dpu_hw_ctl *ctl;
 	int pending_kickoff_cnt;
@@ -1439,10 +1438,7 @@ static void _dpu_encoder_trigger_flush(struct drm_encoder *drm_enc,
 		return;
 	}
 
-	if (!async)
-		pending_kickoff_cnt = dpu_encoder_phys_inc_pending(phys);
-	else
-		pending_kickoff_cnt = atomic_read(&phys->pending_kickoff_cnt);
+	pending_kickoff_cnt = dpu_encoder_phys_inc_pending(phys);
 
 	if (extra_flush_bits && ctl->ops.update_pending_flush)
 		ctl->ops.update_pending_flush(ctl, extra_flush_bits);
@@ -1553,8 +1549,7 @@ static void dpu_encoder_helper_hw_reset(struct dpu_encoder_phys *phys_enc)
  *	a time.
  * dpu_enc: Pointer to virtual encoder structure
  */
-static void _dpu_encoder_kickoff_phys(struct dpu_encoder_virt *dpu_enc,
-				      bool async)
+static void _dpu_encoder_kickoff_phys(struct dpu_encoder_virt *dpu_enc)
 {
 	struct dpu_hw_ctl *ctl;
 	uint32_t i, pending_flush;
@@ -1581,13 +1576,12 @@ static void _dpu_encoder_kickoff_phys(struct dpu_encoder_virt *dpu_enc,
 		 * for async commits. So don't set this for async, since it'll
 		 * roll over to the next commit.
 		 */
-		if (!async && phys->split_role != ENC_ROLE_SLAVE)
+		if (phys->split_role != ENC_ROLE_SLAVE)
 			set_bit(i, dpu_enc->frame_busy_mask);
 
 		if (!phys->ops.needs_single_flush ||
 				!phys->ops.needs_single_flush(phys))
-			_dpu_encoder_trigger_flush(&dpu_enc->base, phys, 0x0,
-						   async);
+			_dpu_encoder_trigger_flush(&dpu_enc->base, phys, 0x0);
 		else if (ctl->ops.get_pending_flush)
 			pending_flush |= ctl->ops.get_pending_flush(ctl);
 	}
@@ -1597,7 +1591,7 @@ static void _dpu_encoder_kickoff_phys(struct dpu_encoder_virt *dpu_enc,
 		_dpu_encoder_trigger_flush(
 				&dpu_enc->base,
 				dpu_enc->cur_master,
-				pending_flush, async);
+				pending_flush);
 	}
 
 	_dpu_encoder_trigger_start(dpu_enc->cur_master);
@@ -1815,11 +1809,12 @@ void dpu_encoder_prepare_for_kickoff(struct drm_encoder *drm_enc)
 	}
 }
 
-void dpu_encoder_kickoff(struct drm_encoder *drm_enc, bool async)
+void dpu_encoder_kickoff(struct drm_encoder *drm_enc)
 {
 	struct dpu_encoder_virt *dpu_enc;
 	struct dpu_encoder_phys *phys;
 	ktime_t wakeup_time;
+	unsigned long timeout_ms;
 	unsigned int i;
 
 	DPU_ATRACE_BEGIN("encoder_kickoff");
@@ -1827,23 +1822,15 @@ void dpu_encoder_kickoff(struct drm_encoder *drm_enc, bool async)
 
 	trace_dpu_enc_kickoff(DRMID(drm_enc));
 
-	/*
-	 * Asynchronous frames don't handle FRAME_DONE events. As such, they
-	 * shouldn't enable the frame_done watchdog since it will always time
-	 * out.
-	 */
-	if (!async) {
-		unsigned long timeout_ms;
-		timeout_ms = DPU_ENCODER_FRAME_DONE_TIMEOUT_FRAMES * 1000 /
+	timeout_ms = DPU_ENCODER_FRAME_DONE_TIMEOUT_FRAMES * 1000 /
 			drm_mode_vrefresh(&drm_enc->crtc->state->adjusted_mode);
 
-		atomic_set(&dpu_enc->frame_done_timeout_ms, timeout_ms);
-		mod_timer(&dpu_enc->frame_done_timer,
-			  jiffies + msecs_to_jiffies(timeout_ms));
-	}
+	atomic_set(&dpu_enc->frame_done_timeout_ms, timeout_ms);
+	mod_timer(&dpu_enc->frame_done_timer,
+			jiffies + msecs_to_jiffies(timeout_ms));
 
 	/* All phys encs are ready to go, trigger the kickoff */
-	_dpu_encoder_kickoff_phys(dpu_enc, async);
+	_dpu_encoder_kickoff_phys(dpu_enc);
 
 	/* allow phys encs to handle any post-kickoff business */
 	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 997d131c2440..8465b37adf3b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -82,9 +82,8 @@ void dpu_encoder_trigger_kickoff_pending(struct drm_encoder *encoder);
  * dpu_encoder_kickoff - trigger a double buffer flip of the ctl path
  *	(i.e. ctl flush and start) immediately.
  * @encoder:	encoder pointer
- * @async:	true if this is an asynchronous commit
  */
-void dpu_encoder_kickoff(struct drm_encoder *encoder, bool async);
+void dpu_encoder_kickoff(struct drm_encoder *encoder);
 
 /**
  * dpu_encoder_wait_for_event - Waits for encoder events
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index b8d264bd15df..31454cc5d8c5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -298,7 +298,7 @@ void dpu_kms_encoder_enable(struct drm_encoder *encoder)
 			continue;
 
 		trace_dpu_kms_enc_enable(DRMID(crtc));
-		dpu_crtc_commit_kickoff(crtc, false);
+		dpu_crtc_commit_kickoff(crtc);
 	}
 }
 
@@ -315,8 +315,7 @@ static void dpu_kms_commit(struct msm_kms *kms, struct drm_atomic_state *state)
 
 		if (crtc->state->active) {
 			trace_dpu_kms_commit(DRMID(crtc));
-			dpu_crtc_commit_kickoff(crtc,
-						state->legacy_cursor_update);
+			dpu_crtc_commit_kickoff(crtc);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index dd16babdd8c0..e5aae1645933 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -70,8 +70,7 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 		kms->funcs->commit(kms, state);
 	}
 
-	if (!state->legacy_cursor_update)
-		msm_atomic_wait_for_commit_done(dev, state);
+	msm_atomic_wait_for_commit_done(dev, state);
 
 	kms->funcs->complete_commit(kms, state);
 
-- 
2.21.0

