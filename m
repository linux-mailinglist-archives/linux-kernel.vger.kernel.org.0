Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF112165F15
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgBTNrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 08:47:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:42624 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgBTNrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:47:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 05:47:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,464,1574150400"; 
   d="scan'208";a="229483538"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 20 Feb 2020 05:47:15 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 20 Feb 2020 15:47:15 +0200
Date:   Thu, 20 Feb 2020 15:47:15 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Distribute switch variables for
 initialization
Message-ID: <20200220134715.GY13686@intel.com>
References: <20200220062258.68854-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220062258.68854-1-keescook@chromium.org>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:22:58PM -0800, Kees Cook wrote:
> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> doesn't initialize such variables[1].

Silly compilers.

> Note that these warnings (or silent
> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
> 
> To avoid these problems, move such variables into the "case" where
> they're used or lift them up into the main function body.
> 
> drivers/gpu/drm/i915/display/intel_display.c: In function ‘check_digital_port_conflicts’:
> drivers/gpu/drm/i915/display/intel_display.c:12963:17: warning: statement will never be executed [-Wswitch-unreachable]
> 12963 |    unsigned int port_mask;
>       |                 ^~~~~~~~~
> 
> drivers/gpu/drm/i915/intel_pm.c: In function ‘vlv_get_fifo_size’:
> drivers/gpu/drm/i915/intel_pm.c:474:7: warning: statement will never be executed [-Wswitch-unreachable]
>   474 |   u32 dsparb, dsparb2, dsparb3;
>       |       ^~~~~~
> drivers/gpu/drm/i915/intel_pm.c: In function ‘vlv_atomic_update_fifo’:
> drivers/gpu/drm/i915/intel_pm.c:1997:7: warning: statement will never be executed [-Wswitch-unreachable]
>  1997 |   u32 dsparb, dsparb2, dsparb3;
>       |       ^~~~~~
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c |    6 ++++--
>  drivers/gpu/drm/i915/intel_pm.c              |    4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 064dd99bbc49..c829cd26f99e 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -12960,14 +12960,15 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
>  		WARN_ON(!connector_state->crtc);
>  
>  		switch (encoder->type) {
> -			unsigned int port_mask;
>  		case INTEL_OUTPUT_DDI:
>  			if (WARN_ON(!HAS_DDI(to_i915(dev))))
>  				break;
>  			/* else, fall through */
>  		case INTEL_OUTPUT_DP:
>  		case INTEL_OUTPUT_HDMI:
> -		case INTEL_OUTPUT_EDP:
> +		case INTEL_OUTPUT_EDP: {
> +			unsigned int port_mask;

This one I'd just remove and s/port_mask/BIT(encoder->port)/
everywhere. Otherwise lgtm.

> +
>  			port_mask = 1 << encoder->port;
>  
>  			/* the same port mustn't appear more than once */
> @@ -12976,6 +12977,7 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
>  
>  			used_ports |= port_mask;
>  			break;
> +		}
>  		case INTEL_OUTPUT_DP_MST:
>  			used_mst_ports |=
>  				1 << encoder->port;
> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> index bd2d30ecc030..17d8833787c4 100644
> --- a/drivers/gpu/drm/i915/intel_pm.c
> +++ b/drivers/gpu/drm/i915/intel_pm.c
> @@ -469,9 +469,9 @@ static void vlv_get_fifo_size(struct intel_crtc_state *crtc_state)
>  	struct vlv_fifo_state *fifo_state = &crtc_state->wm.vlv.fifo_state;
>  	enum pipe pipe = crtc->pipe;
>  	int sprite0_start, sprite1_start;
> +	u32 dsparb, dsparb2, dsparb3;
>  
>  	switch (pipe) {
> -		u32 dsparb, dsparb2, dsparb3;
>  	case PIPE_A:
>  		dsparb = I915_READ(DSPARB);
>  		dsparb2 = I915_READ(DSPARB2);
> @@ -1969,6 +1969,7 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
>  	const struct vlv_fifo_state *fifo_state =
>  		&crtc_state->wm.vlv.fifo_state;
>  	int sprite0_start, sprite1_start, fifo_size;
> +	u32 dsparb, dsparb2, dsparb3;
>  
>  	if (!crtc_state->fifo_changed)
>  		return;
> @@ -1994,7 +1995,6 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
>  	spin_lock(&uncore->lock);
>  
>  	switch (crtc->pipe) {
> -		u32 dsparb, dsparb2, dsparb3;
>  	case PIPE_A:
>  		dsparb = intel_uncore_read_fw(uncore, DSPARB);
>  		dsparb2 = intel_uncore_read_fw(uncore, DSPARB2);
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
