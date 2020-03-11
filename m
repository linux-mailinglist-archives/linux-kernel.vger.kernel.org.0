Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E31816EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 12:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgCKLgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 07:36:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:61402 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgCKLgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:36:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 04:36:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="353866031"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 11 Mar 2020 04:36:04 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 11 Mar 2020 13:36:03 +0200
Date:   Wed, 11 Mar 2020 13:36:03 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] drm/i915: Init lspcon after HPD in intel_dp_detect()
Message-ID: <20200311113603.GU13686@intel.com>
References: <20200214175646.25532-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200214175646.25532-1-kai.heng.feng@canonical.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 01:56:27AM +0800, Kai-Heng Feng wrote:
> On HP 800 G4 DM, if HDMI cable isn't plugged before boot, the HDMI port
> becomes useless and never responds to cable hotplugging:
> [    3.031904] [drm:lspcon_init [i915]] *ERROR* Failed to probe lspcon
> [    3.031945] [drm:intel_ddi_init [i915]] *ERROR* LSPCON init failed on port D
> 
> Seems like the lspcon chip on the system in question only gets powered
> after the cable is plugged.
> 
> So let's call lspcon_init() dynamically to properly initialize the
> lspcon chip and make HDMI port work.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v4:
>  - Trust VBT in intel_infoframe_init().
>  - Init lspcon in intel_dp_detect().
> 
> v3:
>  - Make sure it's handled under long HPD case.
> 
> v2: 
>  - Move lspcon_init() inside of intel_dp_hpd_pulse().
> 
>  drivers/gpu/drm/i915/display/intel_ddi.c  | 17 +----------------
>  drivers/gpu/drm/i915/display/intel_dp.c   | 13 ++++++++++++-
>  drivers/gpu/drm/i915/display/intel_hdmi.c |  2 +-
>  3 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> index 33f1dc3d7c1a..ca717434b406 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -4741,7 +4741,7 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
>  		&dev_priv->vbt.ddi_port_info[port];
>  	struct intel_digital_port *intel_dig_port;
>  	struct intel_encoder *encoder;
> -	bool init_hdmi, init_dp, init_lspcon = false;
> +	bool init_hdmi, init_dp;
>  	enum phy phy = intel_port_to_phy(dev_priv, port);
>  
>  	init_hdmi = port_info->supports_dvi || port_info->supports_hdmi;
> @@ -4754,7 +4754,6 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
>  		 * is initialized before lspcon.
>  		 */
>  		init_dp = true;
> -		init_lspcon = true;
>  		init_hdmi = false;
>  		DRM_DEBUG_KMS("VBT says port %c has lspcon\n", port_name(port));
>  	}
> @@ -4833,20 +4832,6 @@ void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port)
>  			goto err;
>  	}
>  
> -	if (init_lspcon) {
> -		if (lspcon_init(intel_dig_port))
> -			/* TODO: handle hdmi info frame part */
> -			DRM_DEBUG_KMS("LSPCON init success on port %c\n",
> -				port_name(port));
> -		else
> -			/*
> -			 * LSPCON init faied, but DP init was success, so
> -			 * lets try to drive as DP++ port.
> -			 */
> -			DRM_ERROR("LSPCON init failed on port %c\n",
> -				port_name(port));
> -	}
> -
>  	intel_infoframe_init(intel_dig_port);
>  
>  	return;
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index c7424e2a04a3..43117aa86292 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -5663,8 +5663,19 @@ intel_dp_detect(struct drm_connector *connector,
>  	/* Can't disconnect eDP */
>  	if (intel_dp_is_edp(intel_dp))
>  		status = edp_detect(intel_dp);
> -	else if (intel_digital_port_connected(encoder))
> +	else if (intel_digital_port_connected(encoder)) {
> +		if (intel_bios_is_lspcon_present(dev_priv, dig_port->base.port) &&
> +		    !dig_port->lspcon.active) {
> +			if (lspcon_init(dig_port))
> +				DRM_DEBUG_KMS("LSPCON init success on port %c\n",
> +					      port_name(dig_port->base.port));
> +			else
> +				DRM_DEBUG_KMS("LSPCON init failed on port %c\n",
> +					      port_name(dig_port->base.port));
> +		}

I was going to ask what happens when you unplug+replug, but looks like
we already have lspcon_resume()in intel_dp_detect_dpcd(). This should
be there as well. In fact I think we should just move all the logic
into the lspcon code and let it decide on its own whether to take the init
path or the resume path (assuming there is even any difference between
the two).

Not sure what we should do with the lspcon_resume() call in
intel_dp_encoder_reset()...

> +
>  		status = intel_dp_detect_dpcd(intel_dp);
> +	}
>  	else
>  		status = connector_status_disconnected;
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index 93ac0f296852..27a5aa8cefc9 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -3100,7 +3100,7 @@ void intel_infoframe_init(struct intel_digital_port *intel_dig_port)
>  		intel_dig_port->set_infoframes = g4x_set_infoframes;
>  		intel_dig_port->infoframes_enabled = g4x_infoframes_enabled;
>  	} else if (HAS_DDI(dev_priv)) {
> -		if (intel_dig_port->lspcon.active) {
> +		if (intel_bios_is_lspcon_present(dev_priv, intel_dig_port->base.port)) {
>  			intel_dig_port->write_infoframe = lspcon_write_infoframe;
>  			intel_dig_port->read_infoframe = lspcon_read_infoframe;
>  			intel_dig_port->set_infoframes = lspcon_set_infoframes;
> -- 
> 2.17.1

-- 
Ville Syrj�l�
Intel
