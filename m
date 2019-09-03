Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D43A75B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 22:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfICUxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 16:53:33 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38999 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfICUxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:53:32 -0400
Received: by mail-yb1-f194.google.com with SMTP id s142so6468904ybc.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DVCAlPVbkFVUUY0m3QHNEjd44dKZmdmbFtu5A1aFNa0=;
        b=ZPoPyHbqPgyxvbln8u0nj1GIq7LuOwPrpqH4wcbc4vjYZOglYF5QvJhPJoRpZzQzrQ
         EKDic6KRJVphi9Z2FpmFC0qQnwt9abqY8IuAB273Lr/hetuiPak4jKqfxdTYLraLqaIM
         hGSCFhgvIKM6ttXCsUX8pWgoWY1JsSR69Fwt3CzvLkEkH7cr8R8UzBBYAZBDJcG1N4ME
         fEi/y2cMUDREvjYfXFFwyNv53GWYIVek9hhn/G1enuwqBJZFF4RlW0KDBLATU8VSPM3U
         A0X/qQce/9zbitu3uO4PIPkPj9ZNAaIO7ILoJe3x0pbQvP2A2zSF4gaDDTLJZInylzuZ
         BRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DVCAlPVbkFVUUY0m3QHNEjd44dKZmdmbFtu5A1aFNa0=;
        b=Ruj4YHMaKVDdNksqdx9H0RK5atUYCHutUoX0k/DDy3e/axtzvv/GWFquZhNGGg2Wcs
         ztD3zjHFv2qw+dRVmEbVGvjlBM3+j7BmA5BduT3H3VlBvWiZHXyEiS0fXJjQNXclwDx1
         HAMfOfn9bEUgSCAWSqw4VMhfJRyMX+mPubWTLTnMUrL0kxfx86axSJKRcIN2bB7IVHPJ
         OSqxOSiKWmB5uSOi1N3jln0W/xYEdky+pAlE4j9KQ5HREq2dYlnf0ui5ozjMDX04hStO
         cMMJSeuPECC0mjIWcoozk09W0dNDRy3kVumIafhEG8m1XGiCcvXq6dvf3ux55t8Ensnb
         k2Uw==
X-Gm-Message-State: APjAAAU5ncxoS+rQGun0SJuK5VTVyd2GhXjmmyt9AQLpssaAUD+6bvjB
        szLk1xCbqCAeMAv2xP4UBwDqhA==
X-Google-Smtp-Source: APXvYqwwF8e17CbF2QARWpYcAXUXzdFfVy3IASKyxBY/LkAREyoEGmNH2lNFSEDNGqlBtD2Mazs/Uw==
X-Received: by 2002:a25:c708:: with SMTP id w8mr12139170ybe.358.1567544011931;
        Tue, 03 Sep 2019 13:53:31 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id i62sm1390955ywi.102.2019.09.03.13.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 13:53:31 -0700 (PDT)
Date:   Tue, 3 Sep 2019 16:53:31 -0400
From:   Sean Paul <sean@poorly.run>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Bruce Wang <bzwang@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] drm/msm/dpu: async commit support
Message-ID: <20190903205331.GN218215@art_vandelay>
References: <20190829164601.11615-1-robdclark@gmail.com>
 <20190829164601.11615-10-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829164601.11615-10-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:45:17AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In addition, moving to kms->flush_commit() lets us drop the only user
> of kms->commit().
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 13 ------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  7 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  5 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 46 +++++++++++----------
>  drivers/gpu/drm/msm/msm_atomic.c            |  5 +--
>  drivers/gpu/drm/msm/msm_kms.h               |  3 --
>  6 files changed, 34 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 31debd31ab8c..f38a7d27a1c0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -606,7 +606,6 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
>  	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
>  	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
>  	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
> -	int ret;
>  
>  	/*
>  	 * If no mixers has been allocated in dpu_crtc_atomic_check(),
> @@ -626,17 +625,6 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
>  				  crtc->state->encoder_mask)
>  		dpu_encoder_prepare_for_kickoff(encoder);
>  
> -	/* wait for previous frame_event_done completion */
> -	DPU_ATRACE_BEGIN("wait_for_frame_done_event");
> -	ret = _dpu_crtc_wait_for_frame_done(crtc);
> -	DPU_ATRACE_END("wait_for_frame_done_event");
> -	if (ret) {
> -		DPU_ERROR("crtc%d wait for frame done failed;frame_pending%d\n",
> -				crtc->base.id,
> -				atomic_read(&dpu_crtc->frame_pending));
> -		goto end;
> -	}
> -
>  	if (atomic_inc_return(&dpu_crtc->frame_pending) == 1) {
>  		/* acquire bandwidth and other resources */
>  		DPU_DEBUG("crtc%d first commit\n", crtc->base.id);
> @@ -650,7 +638,6 @@ void dpu_crtc_commit_kickoff(struct drm_crtc *crtc)
>  	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
>  		dpu_encoder_kickoff(encoder);
>  
> -end:
>  	reinit_completion(&dpu_crtc->frame_done_comp);
>  	DPU_ATRACE_END("crtc_commit");
>  }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index ac2d534bf59e..3a69b93d8fb6 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1678,8 +1678,7 @@ static u32 _dpu_encoder_calculate_linetime(struct dpu_encoder_virt *dpu_enc,
>  	return line_time;
>  }
>  
> -static int _dpu_encoder_wakeup_time(struct drm_encoder *drm_enc,
> -		ktime_t *wakeup_time)
> +int dpu_encoder_vsync_time(struct drm_encoder *drm_enc, ktime_t *wakeup_time)
>  {
>  	struct drm_display_mode *mode;
>  	struct dpu_encoder_virt *dpu_enc;
> @@ -1766,7 +1765,7 @@ static void dpu_encoder_vsync_event_work_handler(struct kthread_work *work)
>  		return;
>  	}
>  
> -	if (_dpu_encoder_wakeup_time(&dpu_enc->base, &wakeup_time))
> +	if (dpu_encoder_vsync_time(&dpu_enc->base, &wakeup_time))
>  		return;
>  
>  	trace_dpu_enc_vsync_event_work(DRMID(&dpu_enc->base), wakeup_time);
> @@ -1840,7 +1839,7 @@ void dpu_encoder_kickoff(struct drm_encoder *drm_enc)
>  	}
>  
>  	if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI &&
> -			!_dpu_encoder_wakeup_time(drm_enc, &wakeup_time)) {
> +			!dpu_encoder_vsync_time(drm_enc, &wakeup_time)) {
>  		trace_dpu_enc_early_kickoff(DRMID(drm_enc),
>  					    ktime_to_ms(wakeup_time));
>  		mod_timer(&dpu_enc->vsync_event_timer,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 8465b37adf3b..b4913465e602 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -85,6 +85,11 @@ void dpu_encoder_trigger_kickoff_pending(struct drm_encoder *encoder);
>   */
>  void dpu_encoder_kickoff(struct drm_encoder *encoder);
>  
> +/**
> + * dpu_encoder_wakeup_time - get the time of the next vsync
> + */
> +int dpu_encoder_vsync_time(struct drm_encoder *drm_enc, ktime_t *wakeup_time);
> +
>  /**
>   * dpu_encoder_wait_for_event - Waits for encoder events
>   * @encoder:	encoder pointer
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index d54741f3ad9f..af41af1731c2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -260,6 +260,20 @@ static void dpu_kms_disable_commit(struct msm_kms *kms)
>  	pm_runtime_put_sync(&dpu_kms->pdev->dev);
>  }
>  
> +static ktime_t dpu_kms_vsync_time(struct msm_kms *kms, struct drm_crtc *crtc)
> +{
> +	struct drm_encoder *encoder;
> +
> +	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask) {
> +		ktime_t vsync_time;
> +
> +		if (dpu_encoder_vsync_time(encoder, &vsync_time) == 0)
> +			return vsync_time;
> +	}
> +
> +	return ktime_get();
> +}
> +
>  static void dpu_kms_prepare_commit(struct msm_kms *kms,
>  		struct drm_atomic_state *state)
>  {
> @@ -291,7 +305,16 @@ static void dpu_kms_prepare_commit(struct msm_kms *kms,
>  
>  static void dpu_kms_flush_commit(struct msm_kms *kms, unsigned crtc_mask)
>  {
> -	/* TODO */
> +	struct dpu_kms *dpu_kms = to_dpu_kms(kms);
> +	struct drm_crtc *crtc;
> +
> +	for_each_crtc_mask(dpu_kms->dev, crtc, crtc_mask) {
> +		if (!crtc->state->active)
> +			continue;
> +
> +		trace_dpu_kms_commit(DRMID(crtc));
> +		dpu_crtc_commit_kickoff(crtc);
> +	}
>  }
>  
>  /*
> @@ -314,25 +337,6 @@ void dpu_kms_encoder_enable(struct drm_encoder *encoder)
>  			continue;
>  
>  		trace_dpu_kms_enc_enable(DRMID(crtc));
> -		dpu_crtc_commit_kickoff(crtc);
> -	}
> -}
> -
> -static void dpu_kms_commit(struct msm_kms *kms, struct drm_atomic_state *state)
> -{
> -	struct drm_crtc *crtc;
> -	struct drm_crtc_state *crtc_state;
> -	int i;
> -
> -	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
> -		/* If modeset is required, kickoff is run in encoder_enable */
> -		if (drm_atomic_crtc_needs_modeset(crtc_state))
> -			continue;
> -
> -		if (crtc->state->active) {
> -			trace_dpu_kms_commit(DRMID(crtc));
> -			dpu_crtc_commit_kickoff(crtc);
> -		}
>  	}
>  }
>  
> @@ -693,9 +697,9 @@ static const struct msm_kms_funcs kms_funcs = {
>  	.irq             = dpu_irq,
>  	.enable_commit   = dpu_kms_enable_commit,
>  	.disable_commit  = dpu_kms_disable_commit,
> +	.vsync_time      = dpu_kms_vsync_time,
>  	.prepare_commit  = dpu_kms_prepare_commit,
>  	.flush_commit    = dpu_kms_flush_commit,
> -	.commit          = dpu_kms_commit,
>  	.wait_flush      = dpu_kms_wait_flush,
>  	.complete_commit = dpu_kms_complete_commit,
>  	.enable_vblank   = dpu_kms_enable_vblank,
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index 8f8f74337cb4..80536538967b 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -213,10 +213,7 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
>  	/*
>  	 * Flush hardware updates:
>  	 */
> -	if (kms->funcs->commit) {
> -		DRM_DEBUG_ATOMIC("triggering commit\n");
> -		kms->funcs->commit(kms, state);
> -	}
> +	DRM_DEBUG_ATOMIC("triggering commit\n");
>  	kms->funcs->flush_commit(kms, crtc_mask);
>  	mutex_unlock(&kms->commit_lock);
>  
> diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
> index 5eafc9686d29..32ff2e070ea2 100644
> --- a/drivers/gpu/drm/msm/msm_kms.h
> +++ b/drivers/gpu/drm/msm/msm_kms.h
> @@ -80,9 +80,6 @@ struct msm_kms_funcs {
>  	 */
>  	void (*flush_commit)(struct msm_kms *kms, unsigned crtc_mask);
>  
> -	/* TODO remove ->commit(), use ->flush_commit() instead: */
> -	void (*commit)(struct msm_kms *kms, struct drm_atomic_state *state);
> -
>  	/**
>  	 * Wait for any in-progress flush to complete on the specified
>  	 * crtcs.  This should not block if there is no in-progress
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
