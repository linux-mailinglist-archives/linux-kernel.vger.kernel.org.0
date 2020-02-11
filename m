Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9187159180
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgBKOFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 09:05:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:52332 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbgBKOFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:05:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 06:05:20 -0800
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="221939655"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 06:05:16 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/12] drm/i915/dp_mst: convert to drm_device based logging macros.
In-Reply-To: <20200206080014.13759-10-wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200206080014.13759-1-wambui.karugax@gmail.com> <20200206080014.13759-10-wambui.karugax@gmail.com>
Date:   Tue, 11 Feb 2020 16:05:13 +0200
Message-ID: <87lfp9z0bq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Feb 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> Conversion of instances of the printk based drm logging macros to the
> struct drm_device based logging macros in i915/display/intel_dp_mst.c.
> This also involves extracting the drm_i915_private device pointer from
> various intel types to use in the macros.

Fails to apply, and needs a rebase. Code looks fine.

BR,
Jani.

>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 30 ++++++++++++++-------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index b8aee506d595..45028faa4409 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -42,6 +42,7 @@ static int intel_dp_mst_compute_link_config(struct intel_encoder *encoder,
>  					    struct drm_connector_state *conn_state,
>  					    struct link_config_limits *limits)
>  {
> +	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
>  	struct drm_atomic_state *state = crtc_state->uapi.state;
>  	struct intel_dp_mst_encoder *intel_mst = enc_to_mst(encoder);
>  	struct intel_dp *intel_dp = &intel_mst->primary->dp;
> @@ -73,7 +74,8 @@ static int intel_dp_mst_compute_link_config(struct intel_encoder *encoder,
>  	}
>  
>  	if (slots < 0) {
> -		DRM_DEBUG_KMS("failed finding vcpi slots:%d\n", slots);
> +		drm_dbg_kms(&i915->drm,
> +			    "failed finding vcpi slots:%d\n", slots);
>  		return slots;
>  	}
>  
> @@ -322,15 +324,18 @@ static void intel_mst_disable_dp(struct intel_encoder *encoder,
>  	struct intel_dp *intel_dp = &intel_dig_port->dp;
>  	struct intel_connector *connector =
>  		to_intel_connector(old_conn_state->connector);
> +	struct drm_i915_private *i915 = to_i915(encoder->base.dev);
>  	int ret;
>  
> -	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
> +	drm_dbg_kms(&i915->drm,
> +		    "active links %d\n", intel_dp->active_mst_links);
>  
>  	drm_dp_mst_reset_vcpi_slots(&intel_dp->mst_mgr, connector->port);
>  
>  	ret = drm_dp_update_payload_part1(&intel_dp->mst_mgr);
>  	if (ret) {
> -		DRM_DEBUG_KMS("failed to update payload %d\n", ret);
> +		drm_dbg_kms(&i915->drm,
> +			    "failed to update payload %d\n", ret);
>  	}
>  	if (old_crtc_state->has_audio)
>  		intel_audio_codec_disable(encoder,
> @@ -371,7 +376,8 @@ static void intel_mst_post_disable_dp(struct intel_encoder *encoder,
>  
>  	if (intel_de_wait_for_set(dev_priv, intel_dp->regs.dp_tp_status,
>  				  DP_TP_STATUS_ACT_SENT, 1))
> -		DRM_ERROR("Timed out waiting for ACT sent when disabling\n");
> +		drm_err(&dev_priv->drm,
> +			"Timed out waiting for ACT sent when disabling\n");
>  	drm_dp_check_act_status(&intel_dp->mst_mgr);
>  
>  	drm_dp_mst_deallocate_vcpi(&intel_dp->mst_mgr, connector->port);
> @@ -405,7 +411,8 @@ static void intel_mst_post_disable_dp(struct intel_encoder *encoder,
>  		intel_dig_port->base.post_disable(&intel_dig_port->base,
>  						  old_crtc_state, NULL);
>  
> -	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
> +	drm_dbg_kms(&dev_priv->drm, "active links %d\n",
> +		    intel_dp->active_mst_links);
>  }
>  
>  static void intel_mst_pre_pll_enable_dp(struct intel_encoder *encoder,
> @@ -445,7 +452,8 @@ static void intel_mst_pre_enable_dp(struct intel_encoder *encoder,
>  		    INTEL_GEN(dev_priv) >= 12 && first_mst_stream &&
>  		    !intel_dp_mst_is_master_trans(pipe_config));
>  
> -	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
> +	drm_dbg_kms(&dev_priv->drm, "active links %d\n",
> +		    intel_dp->active_mst_links);
>  
>  	if (first_mst_stream)
>  		intel_dp_sink_dpms(intel_dp, DRM_MODE_DPMS_ON);
> @@ -461,7 +469,7 @@ static void intel_mst_pre_enable_dp(struct intel_encoder *encoder,
>  				       pipe_config->pbn,
>  				       pipe_config->dp_m_n.tu);
>  	if (!ret)
> -		DRM_ERROR("failed to allocate vcpi\n");
> +		drm_err(&dev_priv->drm, "failed to allocate vcpi\n");
>  
>  	intel_dp->active_mst_links++;
>  	temp = intel_de_read(dev_priv, intel_dp->regs.dp_tp_status);
> @@ -491,11 +499,12 @@ static void intel_mst_enable_dp(struct intel_encoder *encoder,
>  	struct intel_dp *intel_dp = &intel_dig_port->dp;
>  	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
>  
> -	DRM_DEBUG_KMS("active links %d\n", intel_dp->active_mst_links);
> +	drm_dbg_kms(&dev_priv->drm, "active links %d\n",
> +		    intel_dp->active_mst_links);
>  
>  	if (intel_de_wait_for_set(dev_priv, intel_dp->regs.dp_tp_status,
>  				  DP_TP_STATUS_ACT_SENT, 1))
> -		DRM_ERROR("Timed out waiting for ACT sent\n");
> +		drm_err(&dev_priv->drm, "Timed out waiting for ACT sent\n");
>  
>  	drm_dp_check_act_status(&intel_dp->mst_mgr);
>  
> @@ -727,7 +736,8 @@ static void intel_dp_destroy_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_i915_private *dev_priv = to_i915(connector->dev);
>  
> -	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id, connector->name);
> +	drm_dbg_kms(&dev_priv->drm, "[CONNECTOR:%d:%s]\n", connector->base.id,
> +		    connector->name);
>  	drm_connector_unregister(connector);
>  
>  	if (dev_priv->fbdev)

-- 
Jani Nikula, Intel Open Source Graphics Center
