Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7399D17E27
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfEHQfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 12:35:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38373 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfEHQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:35:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id w11so22668220edl.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AM9PBM1/6EU/hBClmaMnI8HDFWndSZzTntOq5fREA7w=;
        b=M0mBKCDyfUgoEiRRi+Hh0SF7h2Y+wv36doocU+RL9eOH2Fzy5I8A1pKQNumJxRcTLl
         4rGi+lFBQnxfxqR0tKI9WayQGWBJMy9282EiNbQpQGolU5TwQfLVcZzxyu8Du1SUhFoI
         sOOAAm58UMm6TGT1URqBtYTZg7BYT3meukyJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AM9PBM1/6EU/hBClmaMnI8HDFWndSZzTntOq5fREA7w=;
        b=p+gRjGpnazgdr7dwv5fqVZYTgINun0AGKGNV8uNs/cdFieew086UD/WdZQGnkR3vUI
         l0STCvx7r2S/w4ujPE0eu0Xj6+sqc3aOrdzW6M3HPjZPpCZH/nRQayqeegR86Z4BJwH6
         DG8ctvEHtE/GTFp8ZCK9k4ZExRhI/gJexYKByDQlVeCP4bfwdKzruo1jtz/rtRVOH6S0
         rQt1PwUz0kJANgXH04wnNVdS7RGB++WzpDsoCVCcMsmOj/j9ZxCrrUgupY84Hn0Ev0Ce
         89xrpRUXXX9oQYuwJAFU7xQZeQ09edFyPIVHXbFCR7ai0dtK4aQuu0ksLEuzr+4p50iz
         bUBw==
X-Gm-Message-State: APjAAAWRGz4UNL9uBzYNJKGXj6W4nRD2fxJjB/kqtkonuCk7mi3nkHt5
        nfaEiDLC7P/FGYmiO6FtIfCu7A==
X-Google-Smtp-Source: APXvYqwDyOkgGsbQkEn45qDOv2HjyTYxh7QpLbSWIqvzp8ddEUv8T3cCAytuxuOBSpIVkY9VD94Tdw==
X-Received: by 2002:a17:906:e0c5:: with SMTP id gl5mr5438174ejb.212.1557333316072;
        Wed, 08 May 2019 09:35:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f40sm5395808edb.55.2019.05.08.09.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 09:35:15 -0700 (PDT)
Date:   Wed, 8 May 2019 18:35:12 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jose Souza <jose.souza@intel.com>,
        Zain Wang <wzz@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/11] drm: Add helpers to kick off self refresh mode
 in drivers
Message-ID: <20190508163512.GA17751@phenom.ffwll.local>
Mail-Followup-To: Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Jose Souza <jose.souza@intel.com>, Zain Wang <wzz@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190508160920.144739-1-sean@poorly.run>
 <20190508160920.144739-6-sean@poorly.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508160920.144739-6-sean@poorly.run>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 12:09:10PM -0400, Sean Paul wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch adds a new drm helper library to help drivers implement
> self refresh. Drivers choosing to use it will register crtcs and
> will receive callbacks when it's time to enter or exit self refresh
> mode.
> 
> In its current form, it has a timer which will trigger after a
> driver-specified amount of inactivity. When the timer triggers, the
> helpers will submit a new atomic commit to shut the refreshing pipe
> off. On the next atomic commit, the drm core will revert the self
> refresh state and bring everything back up to be actively driven.
> 
> From the driver's perspective, this works like a regular disable/enable
> cycle. The driver need only check the 'self_refresh_active' state in
> crtc_state. It should initiate self refresh mode on the panel and enter
> an off or low-power state.
> 
> Changes in v2:
> - s/psr/self_refresh/ (Daniel)
> - integrated the psr exit into the commit that wakes it up (Jose/Daniel)
> - made the psr state per-crtc (Jose/Daniel)
> Changes in v3:
> - Remove the self_refresh_(active|changed) from connector state (Daniel)
> - Simplify loop in drm_self_refresh_helper_alter_state (Daniel)
> - Improve self_refresh_aware comment (Daniel)
> - s/self_refresh_state/self_refresh_data/ (Daniel)
> Changes in v4:
> - Move docbook location below panel (Daniel)
> - Improve docbook with references and more detailed explanation (Daniel)
> - Instead of register/unregister, use init/cleanup (Daniel)

Again missed my r-b or didn't apply all my suggestions? I'm feeling a bit
blue and all that today so don't want to do more than necessary with
actual patch review :-)

Cheers, Daniel


> 
> Link to v1: https://patchwork.freedesktop.org/patch/msgid/20190228210939.83386-2-sean@poorly.run
> Link to v2: https://patchwork.freedesktop.org/patch/msgid/20190326204509.96515-1-sean@poorly.run
> Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-6-sean@poorly.run
> 
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Jose Souza <jose.souza@intel.com>
> Cc: Zain Wang <wzz@rock-chips.com>
> Cc: Tomasz Figa <tfiga@chromium.org>
> Cc: Ville Syrj�l� <ville.syrjala@linux.intel.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  Documentation/gpu/drm-kms-helpers.rst     |   9 +
>  drivers/gpu/drm/Makefile                  |   2 +-
>  drivers/gpu/drm/drm_atomic.c              |   2 +
>  drivers/gpu/drm/drm_atomic_helper.c       |  35 +++-
>  drivers/gpu/drm/drm_atomic_state_helper.c |   4 +
>  drivers/gpu/drm/drm_atomic_uapi.c         |   7 +-
>  drivers/gpu/drm/drm_self_refresh_helper.c | 213 ++++++++++++++++++++++
>  include/drm/drm_atomic.h                  |  15 ++
>  include/drm/drm_connector.h               |  14 ++
>  include/drm/drm_crtc.h                    |  19 ++
>  include/drm/drm_self_refresh_helper.h     |  22 +++
>  11 files changed, 337 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_self_refresh_helper.c
>  create mode 100644 include/drm/drm_self_refresh_helper.h
> 
> diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
> index 14102ae035dc..86dbb56aef51 100644
> --- a/Documentation/gpu/drm-kms-helpers.rst
> +++ b/Documentation/gpu/drm-kms-helpers.rst
> @@ -181,6 +181,15 @@ Panel Helper Reference
>  .. kernel-doc:: drivers/gpu/drm/drm_panel_orientation_quirks.c
>     :export:
>  
> +Panel Self Refresh Helper Reference
> +===================================
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_self_refresh_helper.c
> +   :doc: overview
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_self_refresh_helper.c
> +   :export:
> +
>  Display Port Helper Functions Reference
>  =======================================
>  
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 3d0c75cd687c..c4852604fc1d 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -39,7 +39,7 @@ drm_kms_helper-y := drm_crtc_helper.o drm_dp_helper.o drm_dsc.o drm_probe_helper
>  		drm_simple_kms_helper.o drm_modeset_helper.o \
>  		drm_scdc_helper.o drm_gem_framebuffer_helper.o \
>  		drm_atomic_state_helper.o drm_damage_helper.o \
> -		drm_format_helper.o
> +		drm_format_helper.o drm_self_refresh_helper.o
>  
>  drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
>  drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 936002495523..2b92648ce196 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -379,6 +379,7 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
>  	drm_printf(p, "crtc[%u]: %s\n", crtc->base.id, crtc->name);
>  	drm_printf(p, "\tenable=%d\n", state->enable);
>  	drm_printf(p, "\tactive=%d\n", state->active);
> +	drm_printf(p, "\tself_refresh_active=%d\n", state->self_refresh_active);
>  	drm_printf(p, "\tplanes_changed=%d\n", state->planes_changed);
>  	drm_printf(p, "\tmode_changed=%d\n", state->mode_changed);
>  	drm_printf(p, "\tactive_changed=%d\n", state->active_changed);
> @@ -951,6 +952,7 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
>  
>  	drm_printf(p, "connector[%u]: %s\n", connector->base.id, connector->name);
>  	drm_printf(p, "\tcrtc=%s\n", state->crtc ? state->crtc->name : "(null)");
> +	drm_printf(p, "\tself_refresh_aware=%d\n", state->self_refresh_aware);
>  
>  	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
>  		if (state->writeback_job && state->writeback_job->fb)
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index ee945d6f1cba..9ee7a288f52a 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -30,6 +30,7 @@
>  #include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_self_refresh_helper.h>
>  #include <drm/drm_writeback.h>
>  #include <drm/drm_damage_helper.h>
>  #include <linux/dma-fence.h>
> @@ -950,10 +951,33 @@ int drm_atomic_helper_check(struct drm_device *dev,
>  	if (state->legacy_cursor_update)
>  		state->async_update = !drm_atomic_helper_async_check(dev, state);
>  
> +	drm_self_refresh_helper_alter_state(state);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_check);
>  
> +static bool
> +crtc_needs_disable(struct drm_crtc_state *old_state,
> +		   struct drm_crtc_state *new_state)
> +{
> +	/*
> +	 * No new_state means the crtc is off, so the only criteria is whether
> +	 * it's currently active or in self refresh mode.
> +	 */
> +	if (!new_state)
> +		return drm_atomic_crtc_effectively_active(old_state);
> +
> +	/*
> +	 * We need to run through the crtc_funcs->disable() function if the crtc
> +	 * is currently on, if it's transitioning to self refresh mode, or if
> +	 * it's in self refresh mode and needs to be fully disabled.
> +	 */
> +	return old_state->active ||
> +	       (old_state->self_refresh_active && !new_state->enable) ||
> +	       new_state->self_refresh_active;
> +}
> +
>  static void
>  disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  {
> @@ -974,7 +998,14 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  
>  		old_crtc_state = drm_atomic_get_old_crtc_state(old_state, old_conn_state->crtc);
>  
> -		if (!old_crtc_state->active ||
> +		if (new_conn_state->crtc)
> +			new_crtc_state = drm_atomic_get_new_crtc_state(
> +						old_state,
> +						new_conn_state->crtc);
> +		else
> +			new_crtc_state = NULL;
> +
> +		if (!crtc_needs_disable(old_crtc_state, new_crtc_state) ||
>  		    !drm_atomic_crtc_needs_modeset(old_conn_state->crtc->state))
>  			continue;
>  
> @@ -1020,7 +1051,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
>  		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
>  			continue;
>  
> -		if (!old_crtc_state->active)
> +		if (!crtc_needs_disable(old_crtc_state, new_crtc_state))
>  			continue;
>  
>  		funcs = crtc->helper_private;
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index ac929f68ff31..ca18008043e5 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -128,6 +128,10 @@ void __drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc,
>  	state->commit = NULL;
>  	state->event = NULL;
>  	state->pageflip_flags = 0;
> +
> +	/* Self refresh should be canceled when a new update is available */
> +	state->active = drm_atomic_crtc_effectively_active(state);
> +	state->self_refresh_active = false;
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_crtc_duplicate_state);
>  
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index ea797d4c82ee..a75c633ff0c0 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -490,7 +490,7 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
>  	struct drm_mode_config *config = &dev->mode_config;
>  
>  	if (property == config->prop_active)
> -		*val = state->active;
> +		*val = drm_atomic_crtc_effectively_active(state);
>  	else if (property == config->prop_mode_id)
>  		*val = (state->mode_blob) ? state->mode_blob->base.id : 0;
>  	else if (property == config->prop_vrr_enabled)
> @@ -772,7 +772,10 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>  	if (property == config->prop_crtc_id) {
>  		*val = (state->crtc) ? state->crtc->base.id : 0;
>  	} else if (property == config->dpms_property) {
> -		*val = connector->dpms;
> +		if (state->crtc && state->crtc->state->self_refresh_active)
> +			*val = DRM_MODE_DPMS_ON;
> +		else
> +			*val = connector->dpms;
>  	} else if (property == config->tv_select_subconnector_property) {
>  		*val = state->tv.subconnector;
>  	} else if (property == config->tv_left_margin_property) {
> diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
> new file mode 100644
> index 000000000000..c7083c5694fe
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_self_refresh_helper.c
> @@ -0,0 +1,213 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2019 Google, Inc.
> + *
> + * Authors:
> + * Sean Paul <seanpaul@chromium.org>
> + */
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_mode_config.h>
> +#include <drm/drm_modeset_lock.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_self_refresh_helper.h>
> +#include <linux/bitops.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +/**
> + * DOC: overview
> + *
> + * This helper library provides an easy way for drivers to leverage the atomic
> + * framework to implement panel self refresh (SR) support. Drivers are
> + * responsible for initializing and cleaning up the SR helpers on load/unload
> + * (see &drm_self_refresh_helper_init/&drm_self_refresh_helper_cleanup).
> + * The connector is responsible for setting
> + * &drm_connector_state.self_refresh_aware to true at runtime if it is SR-aware
> + * (meaning it knows how to initiate self refresh on the panel).
> + *
> + * Once a crtc has enabled SR using &drm_self_refresh_helper_init, the
> + * helpers will monitor activity and call back into the driver to enable/disable
> + * SR as appropriate. The best way to think about this is that it's a DPMS
> + * on/off request with &drm_crtc_state.self_refresh_active set in crtc state
> + * that tells you to disable/enable SR on the panel instead of power-cycling it.
> + *
> + * During SR, drivers may choose to fully disable their crtc/encoder/bridge
> + * hardware (in which case no driver changes are necessary), or they can inspect
> + * &drm_crtc_state.self_refresh_active if they want to enter low power mode
> + * without full disable (in case full disable/enable is too slow).
> + *
> + * SR will be deactivated if there are any atomic updates affecting the
> + * pipe that is in SR mode. If a crtc is driving multiple connectors, all
> + * connectors must be SR aware and all will enter/exit SR mode at the same time.
> + *
> + * If the crtc and connector are SR aware, but the panel connected does not
> + * support it (or is otherwise unable to enter SR), the driver should fail
> + * atomic_check when &drm_crtc_state.self_refresh_active is true.
> + */
> +
> +struct drm_self_refresh_data {
> +	struct drm_crtc *crtc;
> +	struct delayed_work entry_work;
> +	struct drm_atomic_state *save_state;
> +	unsigned int entry_delay_ms;
> +};
> +
> +static void drm_self_refresh_helper_entry_work(struct work_struct *work)
> +{
> +	struct drm_self_refresh_data *sr_data = container_of(
> +				to_delayed_work(work),
> +				struct drm_self_refresh_data, entry_work);
> +	struct drm_crtc *crtc = sr_data->crtc;
> +	struct drm_device *dev = crtc->dev;
> +	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_atomic_state *state;
> +	struct drm_connector *conn;
> +	struct drm_connector_state *conn_state;
> +	struct drm_crtc_state *crtc_state;
> +	int i, ret;
> +
> +	drm_modeset_acquire_init(&ctx, 0);
> +
> +	state = drm_atomic_state_alloc(dev);
> +	if (!state) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +retry:
> +	state->acquire_ctx = &ctx;
> +
> +	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> +	if (IS_ERR(crtc_state)) {
> +		ret = PTR_ERR(crtc_state);
> +		goto out;
> +	}
> +
> +	if (!crtc_state->enable)
> +		goto out;
> +
> +	ret = drm_atomic_add_affected_connectors(state, crtc);
> +	if (ret)
> +		goto out;
> +
> +	for_each_new_connector_in_state(state, conn, conn_state, i) {
> +		if (!conn_state->self_refresh_aware)
> +			goto out;
> +	}
> +
> +	crtc_state->active = false;
> +	crtc_state->self_refresh_active = true;
> +
> +	ret = drm_atomic_commit(state);
> +	if (ret)
> +		goto out;
> +
> +out:
> +	if (ret == -EDEADLK) {
> +		drm_atomic_state_clear(state);
> +		ret = drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry;
> +	}
> +
> +	drm_atomic_state_put(state);
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +}
> +
> +/**
> + * drm_self_refresh_helper_alter_state - Alters the atomic state for SR exit
> + * @state: the state currently being checked
> + *
> + * Called at the end of atomic check. This function checks the state for flags
> + * incompatible with self refresh exit and changes them. This is a bit
> + * disingenuous since userspace is expecting one thing and we're giving it
> + * another. However in order to keep self refresh entirely hidden from
> + * userspace, this is required.
> + *
> + * At the end, we queue up the self refresh entry work so we can enter PSR after
> + * the desired delay.
> + */
> +void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state)
> +{
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *crtc_state;
> +	int i;
> +
> +	if (state->async_update || !state->allow_modeset) {
> +		for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
> +			if (crtc_state->self_refresh_active) {
> +				state->async_update = false;
> +				state->allow_modeset = true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
> +		struct drm_self_refresh_data *sr_data;
> +
> +		/* Don't trigger the entry timer when we're already in SR */
> +		if (crtc_state->self_refresh_active)
> +			continue;
> +
> +		sr_data = crtc->self_refresh_data;
> +		if (!sr_data)
> +			continue;
> +
> +		mod_delayed_work(system_wq, &sr_data->entry_work,
> +				 msecs_to_jiffies(sr_data->entry_delay_ms));
> +	}
> +}
> +EXPORT_SYMBOL(drm_self_refresh_helper_alter_state);
> +
> +/**
> + * drm_self_refresh_helper_init - Initializes self refresh helpers for a crtc
> + * @crtc: the crtc which supports self refresh supported displays
> + * @entry_delay_ms: amount of inactivity to wait before entering self refresh
> + */
> +int drm_self_refresh_helper_init(struct drm_crtc *crtc,
> +				 unsigned int entry_delay_ms)
> +{
> +	struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
> +
> +	/* Helper is already initialized */
> +	if (WARN_ON(sr_data))
> +		return -EINVAL;
> +
> +	sr_data = kzalloc(sizeof(*sr_data), GFP_KERNEL);
> +	if (!sr_data)
> +		return -ENOMEM;
> +
> +	INIT_DELAYED_WORK(&sr_data->entry_work,
> +			  drm_self_refresh_helper_entry_work);
> +	sr_data->entry_delay_ms = entry_delay_ms;
> +	sr_data->crtc = crtc;
> +
> +	crtc->self_refresh_data = sr_data;
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_self_refresh_helper_init);
> +
> +/**
> + * drm_self_refresh_helper_cleanup - Cleans up self refresh helpers for a crtc
> + * @crtc: the crtc to cleanup
> + */
> +void drm_self_refresh_helper_cleanup(struct drm_crtc *crtc)
> +{
> +	struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
> +
> +	/* Helper is already uninitialized */
> +	if (sr_data)
> +		return;
> +
> +	crtc->self_refresh_data = NULL;
> +
> +	cancel_delayed_work_sync(&sr_data->entry_work);
> +	kfree(sr_data);
> +}
> +EXPORT_SYMBOL(drm_self_refresh_helper_cleanup);
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index d6b3acd34e1c..f76777c72264 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -951,4 +951,19 @@ drm_atomic_crtc_needs_modeset(const struct drm_crtc_state *state)
>  	       state->connectors_changed;
>  }
>  
> +/**
> + * drm_atomic_crtc_effectively_active - compute whether crtc is actually active
> + * @state: &drm_crtc_state for the CRTC
> + *
> + * When in self refresh mode, the crtc_state->active value will be false, since
> + * the crtc is off. However in some cases we're interested in whether the crtc
> + * is active, or effectively active (ie: it's connected to an active display).
> + * In these cases, use this function instead of just checking active.
> + */
> +static inline bool
> +drm_atomic_crtc_effectively_active(const struct drm_crtc_state *state)
> +{
> +	return state->active || state->self_refresh_active;
> +}
> +
>  #endif /* DRM_ATOMIC_H_ */
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index f43f40d5888a..02d0c73e267d 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -543,6 +543,20 @@ struct drm_connector_state {
>  	/** @tv: TV connector state */
>  	struct drm_tv_connector_state tv;
>  
> +	/**
> +	 * @self_refresh_aware:
> +	 *
> +	 * This tracks whether a connector is aware of the self refresh state.
> +	 * It should be set to true for those connector implementations which
> +	 * understand the self refresh state. This is needed since the crtc
> +	 * registers the self refresh helpers and it doesn't know if the
> +	 * connectors downstream have implemented self refresh entry/exit.
> +	 *
> +	 * Drivers should set this to true in atomic_check if they know how to
> +	 * handle self_refresh requests.
> +	 */
> +	bool self_refresh_aware;
> +
>  	/**
>  	 * @picture_aspect_ratio: Connector property to control the
>  	 * HDMI infoframe aspect ratio setting.
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 58ad983d7cd6..67e3075a8784 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -53,6 +53,7 @@ struct drm_mode_set;
>  struct drm_file;
>  struct drm_clip_rect;
>  struct drm_printer;
> +struct drm_self_refresh_data;
>  struct device_node;
>  struct dma_fence;
>  struct edid;
> @@ -299,6 +300,17 @@ struct drm_crtc_state {
>  	 */
>  	bool vrr_enabled;
>  
> +	/**
> +	 * @self_refresh_active:
> +	 *
> +	 * Used by the self refresh helpers to denote when a self refresh
> +	 * transition is occuring. This will be set on enable/disable callbacks
> +	 * when self refresh is being enabled or disabled. In some cases, it may
> +	 * not be desirable to fully shut off the crtc during self refresh.
> +	 * CRTC's can inspect this flag and determine the best course of action.
> +	 */
> +	bool self_refresh_active;
> +
>  	/**
>  	 * @event:
>  	 *
> @@ -1087,6 +1099,13 @@ struct drm_crtc {
>  	 * The name of the CRTC's fence timeline.
>  	 */
>  	char timeline_name[32];
> +
> +	/**
> +	 * @self_refresh_data: Holds the state for the self refresh helpers
> +	 *
> +	 * Initialized via drm_self_refresh_helper_register().
> +	 */
> +	struct drm_self_refresh_data *self_refresh_data;
>  };
>  
>  /**
> diff --git a/include/drm/drm_self_refresh_helper.h b/include/drm/drm_self_refresh_helper.h
> new file mode 100644
> index 000000000000..405e86fb8461
> --- /dev/null
> +++ b/include/drm/drm_self_refresh_helper.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2019 Google, Inc.
> + *
> + * Authors:
> + * Sean Paul <seanpaul@chromium.org>
> + */
> +#ifndef DRM_SELF_REFRESH_HELPER_H_
> +#define DRM_SELF_REFRESH_HELPER_H_
> +
> +struct drm_atomic_state;
> +struct drm_connector;
> +struct drm_device;
> +struct drm_modeset_acquire_ctx;
> +
> +void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state);
> +
> +int drm_self_refresh_helper_init(struct drm_crtc *crtc,
> +				     unsigned int entry_delay_ms);
> +
> +void drm_self_refresh_helper_cleanup(struct drm_crtc *crtc);
> +#endif
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
