Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88287182BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 09:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCLI6v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Mar 2020 04:58:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:12996 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLI6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:58:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 01:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="236757961"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga008.jf.intel.com with ESMTP; 12 Mar 2020 01:58:47 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 01:58:47 -0700
Received: from bgsmsx101.gar.corp.intel.com (10.223.4.170) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 01:58:47 -0700
Received: from BGSMSX107.gar.corp.intel.com ([169.254.9.15]) by
 BGSMSX101.gar.corp.intel.com ([169.254.1.153]) with mapi id 14.03.0439.000;
 Thu, 12 Mar 2020 14:28:43 +0530
From:   "Laxminarayan Bharadiya, Pankaj" 
        <pankaj.laxminarayan.bharadiya@intel.com>
To:     =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC:     "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "mihail.atanassov@arm.com" <mihail.atanassov@arm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Souza, Jose" <jose.souza@intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
Subject: RE: [RFC][PATCH 3/5] drm/i915: Enable scaling filter for plane and
 pipe
Thread-Topic: [RFC][PATCH 3/5] drm/i915: Enable scaling filter for plane and
 pipe
Thread-Index: AQHV66uR0nE+V83KFEm4O/sSi5gKVahBt/iAgAMIn3A=
Date:   Thu, 12 Mar 2020 08:58:42 +0000
Message-ID: <E92BA18FDE0A5B43B7B3DA7FCA031286057B2BE5@BGSMSX107.gar.corp.intel.com>
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
 <20200225070545.4482-4-pankaj.laxminarayan.bharadiya@intel.com>
 <20200310160545.GI13686@intel.com>
In-Reply-To: <20200310160545.GI13686@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ville Syrj�l� <ville.syrjala@linux.intel.com>
> Sent: 10 March 2020 21:36
> To: Laxminarayan Bharadiya, Pankaj
> <pankaj.laxminarayan.bharadiya@intel.com>
> Cc: jani.nikula@linux.intel.com; daniel@ffwll.ch; intel-
> gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; airlied@linux.ie;
> maarten.lankhorst@linux.intel.com; tzimmermann@suse.de;
> mripard@kernel.org; mihail.atanassov@arm.com; Joonas Lahtinen
> <joonas.lahtinen@linux.intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>;
> Chris Wilson <chris@chris-wilson.co.uk>; Souza, Jose
> <jose.souza@intel.com>; Juha-Pekka Heikkila
> <juhapekka.heikkila@gmail.com>; linux-kernel@vger.kernel.org; Nautiyal,
> Ankit K <ankit.k.nautiyal@intel.com>
> Subject: Re: [RFC][PATCH 3/5] drm/i915: Enable scaling filter for plane and
> pipe
> 
> On Tue, Feb 25, 2020 at 12:35:43PM +0530, Pankaj Bharadiya wrote:
> > Attach scaling filter property for crtc and plane and program the
> > scaler control register for the selected filter type.
> >
> > This is preparatory patch to enable Nearest-neighbor integer scaling.
> >
> > Signed-off-by: Pankaj Bharadiya
> > <pankaj.laxminarayan.bharadiya@intel.com>
> > Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_display.c | 17 +++++++++++++++--
> > drivers/gpu/drm/i915/display/intel_sprite.c  | 12 +++++++++++-
> >  drivers/gpu/drm/i915/i915_reg.h              |  1 +
> >  3 files changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c
> > b/drivers/gpu/drm/i915/display/intel_display.c
> > index 3031e64ee518..b5903ef3c5a0 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -6242,6 +6242,8 @@ static void skl_pfit_enable(const struct
> intel_crtc_state *crtc_state)
> >  	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
> >  	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
> >  	enum pipe pipe = crtc->pipe;
> > +	const struct drm_crtc_state *state = &crtc_state->uapi;
> > +	u32 scaling_filter = PS_FILTER_MEDIUM;
> >  	const struct intel_crtc_scaler_state *scaler_state =
> >  		&crtc_state->scaler_state;
> >
> > @@ -6258,6 +6260,11 @@ static void skl_pfit_enable(const struct
> intel_crtc_state *crtc_state)
> >  		pfit_w = (crtc_state->pch_pfit.size >> 16) & 0xFFFF;
> >  		pfit_h = crtc_state->pch_pfit.size & 0xFFFF;
> >
> > +		if (state->scaling_filter ==
> > +		    DRM_SCALING_FILTER_NEAREST_NEIGHBOR) {
> > +			scaling_filter = PS_FILTER_PROGRAMMED;
> > +		}
> 
> Just make that a function that can be used all over.
> skl_scaler_filter(scaling_filter) or something.
> 
> > +
> >  		hscale = (crtc_state->pipe_src_w << 16) / pfit_w;
> >  		vscale = (crtc_state->pipe_src_h << 16) / pfit_h;
> >
> > @@ -6268,8 +6275,10 @@ static void skl_pfit_enable(const struct
> > intel_crtc_state *crtc_state)
> >
> >  		spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
> >
> > -		intel_de_write_fw(dev_priv, SKL_PS_CTRL(pipe, id),
> PS_SCALER_EN |
> > -				  PS_FILTER_MEDIUM | scaler_state-
> >scalers[id].mode);
> > +		intel_de_write_fw(dev_priv, SKL_PS_CTRL(pipe, id),
> > +				  PS_SCALER_EN |
> > +				  scaling_filter |
> > +				  scaler_state->scalers[id].mode);
> >  		intel_de_write_fw(dev_priv, SKL_PS_VPHASE(pipe, id),
> >  				  PS_Y_PHASE(0) |
> PS_UV_RGB_PHASE(uv_rgb_vphase));
> >  		intel_de_write_fw(dev_priv, SKL_PS_HPHASE(pipe, id), @@
> -16695,6
> > +16704,10 @@ static int intel_crtc_init(struct drm_i915_private *dev_priv,
> enum pipe pipe)
> >  		dev_priv->plane_to_crtc_mapping[i9xx_plane] = crtc;
> >  	}
> >
> > +
> > +	if (INTEL_GEN(dev_priv) >= 11)
> 
> gen >= 10 actually. Even glk seems to have it but bspec says not to use it on
> glk. Supposedly not validated.
> 
> ilk/snb/ivb pfits also has programmable coefficients actually. So IMO we
> should enable this on those as well.

OK. I need to explore bspec more for these platforms.
To begin with I would like to stick to gen >=10.

> 
> The bigger problem will be how is userspace supposed to use this if it's a crtc
> property? Those will not get automagically exposed via xrandr.
> 
> > +		drm_crtc_enable_scaling_filter(&crtc->base);
> > +
> >  	intel_color_init(crtc);
> >
> >  	drm_WARN_ON(&dev_priv->drm, drm_crtc_index(&crtc->base) !=
> > crtc->pipe); diff --git a/drivers/gpu/drm/i915/display/intel_sprite.c
> > b/drivers/gpu/drm/i915/display/intel_sprite.c
> > index 7abeefe8dce5..fd7b31a21723 100644
> > --- a/drivers/gpu/drm/i915/display/intel_sprite.c
> > +++ b/drivers/gpu/drm/i915/display/intel_sprite.c
> > @@ -414,6 +414,12 @@ skl_program_scaler(struct intel_plane *plane,
> >  	u16 y_hphase, uv_rgb_hphase;
> >  	u16 y_vphase, uv_rgb_vphase;
> >  	int hscale, vscale;
> > +	const struct drm_plane_state *state = &plane_state->uapi;
> > +	u32 scaling_filter = PS_FILTER_MEDIUM;
> > +
> > +	if (state->scaling_filter ==
> DRM_SCALING_FILTER_NEAREST_NEIGHBOR) {
> > +		scaling_filter = PS_FILTER_PROGRAMMED;
> > +	}
> >
> >  	hscale = drm_rect_calc_hscale(&plane_state->uapi.src,
> >  				      &plane_state->uapi.dst,
> > @@ -441,7 +447,8 @@ skl_program_scaler(struct intel_plane *plane,
> >  	}
> >
> >  	intel_de_write_fw(dev_priv, SKL_PS_CTRL(pipe, scaler_id),
> > -			  PS_SCALER_EN | PS_PLANE_SEL(plane->id) | scaler-
> >mode);
> > +			  scaling_filter | PS_SCALER_EN |
> > +			  PS_PLANE_SEL(plane->id) | scaler->mode);
> >  	intel_de_write_fw(dev_priv, SKL_PS_VPHASE(pipe, scaler_id),
> >  			  PS_Y_PHASE(y_vphase) |
> PS_UV_RGB_PHASE(uv_rgb_vphase));
> >  	intel_de_write_fw(dev_priv, SKL_PS_HPHASE(pipe, scaler_id), @@
> > -3104,6 +3111,9 @@ skl_universal_plane_create(struct drm_i915_private
> > *dev_priv,
> >
> >  	drm_plane_create_zpos_immutable_property(&plane->base,
> plane_id);
> >
> > +	if (INTEL_GEN(dev_priv) >= 11)
> 
> also gen>=10
> 
> Also this patch breaks things as we don't yet have the code to program the
> coefficients. So the series needs to be reordered.

Will reorder the series.

Thanks,
Pankaj
> 
> > +		drm_plane_enable_scaling_filter(&plane->base);
> > +
> >  	drm_plane_helper_add(&plane->base, &intel_plane_helper_funcs);
> >
> >  	return plane;
> > diff --git a/drivers/gpu/drm/i915/i915_reg.h
> > b/drivers/gpu/drm/i915/i915_reg.h index f45b5e86ec63..34923b1c284c
> > 100644
> > --- a/drivers/gpu/drm/i915/i915_reg.h
> > +++ b/drivers/gpu/drm/i915/i915_reg.h
> > @@ -7212,6 +7212,7 @@ enum {
> >  #define PS_PLANE_SEL(plane) (((plane) + 1) << 25)
> >  #define PS_FILTER_MASK         (3 << 23)
> >  #define PS_FILTER_MEDIUM       (0 << 23)
> > +#define PS_FILTER_PROGRAMMED   (1 << 23)
> >  #define PS_FILTER_EDGE_ENHANCE (2 << 23)
> >  #define PS_FILTER_BILINEAR     (3 << 23)
> >  #define PS_VERT3TAP            (1 << 21)
> > --
> > 2.23.0
> 
> --
> Ville Syrj�l�
> Intel
