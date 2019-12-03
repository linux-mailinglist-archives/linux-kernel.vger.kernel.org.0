Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44D210FDD7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 13:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCMlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 07:41:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:17530 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfLCMlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:41:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 04:41:07 -0800
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="204962080"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 04:41:03 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/i915: Fix DPCD register order in intel_dp_aux_enable_backlight()
In-Reply-To: <20191122231616.2574-4-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191122231616.2574-1-lyude@redhat.com> <20191122231616.2574-4-lyude@redhat.com>
Date:   Tue, 03 Dec 2019 14:41:00 +0200
Message-ID: <87r21lintv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019, Lyude Paul <lyude@redhat.com> wrote:
> For eDP panels, it appears it's expected that so long as the panel is in
> DPCD control mode that the brightness value is never set to 0. Instead,
> if the desired effect is to set the panel's backlight to 0 we're
> expected to simply turn off the backlight through the
> DP_EDP_DISPLAY_CONTROL_REGISTER.
>
> We already do the latter correctly in intel_dp_aux_disable_backlight().
> But, we make the mistake of writing the DPCD registers in the wrong
> order when enabling the backlight in intel_dp_aux_enable_backlight()
> since we currently enable the backlight through
> DP_EDP_DISPLAY_CONTROL_REGISTER before writing the brightness level. On
> the X1 Extreme 2nd Generation, this appears to have the potential of
> confusing the panel in such a way that further attempts to set the
> brightness don't actually change the backlight as expected and leave it
> off. Presumably, this happens because the incorrect register writing
> order briefly leaves the panel with DPCD mode enabled and a 0 brightness
> level set.
>
> So, reverse the order we write the DPCD registers when enabling the
> panel backlight so that we write the brightness value first, and enable
> the backlight second. This fix appears to be the final bit needed to get
> the backlight on the ThinkPad X1 Extreme 2nd Generation's AMOLED screen
> working.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 0bf8772bc7bb..87b59db9ffe3 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -205,8 +205,9 @@ static void intel_dp_aux_enable_backlight(const struct intel_crtc_state *crtc_st
>  		}
>  	}
>  
> +	intel_dp_aux_set_backlight(conn_state,
> +				   connector->panel.backlight.level);
>  	set_aux_backlight_enable(intel_dp, true);
> -	intel_dp_aux_set_backlight(conn_state, connector->panel.backlight.level);
>  }
>  
>  static void intel_dp_aux_disable_backlight(const struct drm_connector_state *old_conn_state)

-- 
Jani Nikula, Intel Open Source Graphics Center
