Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61011172198
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgB0OwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 09:52:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38226 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgB0OwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:52:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so3769163wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/1hMWgL+/roNZg97VWLxg6DgSTHVBn237xKe/xBE1A=;
        b=L6x8yGfA63ukgocswY4Jirn51OxkY+RxdUftaRLhph+SOKvsSGIzbpuopKlY4N7dez
         xdHGZC0tSE6futrR3OlEUQ6g85Cx+4xwfahH9ffD/lKsMPLllqj0yVfH9Yx2FvAVAGHW
         7GNnD58L9gy+cD8DdQsmP5cC5CAzlSIezJqwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=q/1hMWgL+/roNZg97VWLxg6DgSTHVBn237xKe/xBE1A=;
        b=bKP/REMEC8BS6e7H0xWpCg7dL+/vZH1PD63cJvpW2H63NEk/EM+h4DT6YoQL2djFqR
         /Pv6jcJ/N1djFo5nRJfSEYUdj4qYPrFHIWIZtje5cw7uqnCCP2tqBUlUFF+rGkAnC/3z
         aM7IvTPct7ZcOtB/ZQADrd1iZaLHqcJbNtD97BTHxjuOCpOXBXJ6OJ7afjfoIEgbZ4n+
         MlT+Pu8gQWmjTvD21vcR2ZDIHkwqgPOQnNWZk2rkIIa1v8GWDeuRWe0cjWpAWsAScEYD
         suw5OXSkmD4LKE9wiNtuSPYM5/rjYgc5k/SaadDdWLUWk0JGvE3/2G+wPdpHh0eaqBHl
         o5wg==
X-Gm-Message-State: APjAAAXsyNk5m1V/M4KDg7bKDNNuavLB8CR5pp8hww5gr5x5spu94s4O
        A2ozzowEVHc8Ro5aEpuhTyFsuQ==
X-Google-Smtp-Source: APXvYqwa9SuWIW3cO0tbgMLJmHTFAfEYiWAnG1uuvlnpp7F+EIwvu0hbNtxLEB5R//Ix2JUgdry4ZA==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr5949079wmf.56.1582815121069;
        Thu, 27 Feb 2020 06:52:01 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l6sm8658873wrn.26.2020.02.27.06.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 06:52:00 -0800 (PST)
Date:   Thu, 27 Feb 2020 15:51:58 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 15/21] drm/sti: remove use drm_debugfs functions as
 return value
Message-ID: <20200227145158.GX2363188@phenom.ffwll.local>
Mail-Followup-To: Wambui Karuga <wambui.karugax@gmail.com>,
        airlied@linux.ie, Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
 <20200227120232.19413-16-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227120232.19413-16-wambui.karugax@gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:02:26PM +0300, Wambui Karuga wrote:
> Since commit 987d65d01356 (drm: debugfs: make
> drm_debugfs_create_files() never fail), drm_debugfs_create_files() never
> fails, and should return void. This change therefore removes it uses as
> a return value in various functions across drm/sti.
> 
> With these changes, the affected functions have been changed to use a void
> return value.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/sti/sti_cursor.c | 14 ++++++++------
>  drivers/gpu/drm/sti/sti_drv.c    | 16 ++++------------
>  drivers/gpu/drm/sti/sti_dvo.c    | 13 +++++--------
>  drivers/gpu/drm/sti/sti_gdp.c    |  7 ++++---
>  drivers/gpu/drm/sti/sti_hda.c    | 13 +++++--------
>  drivers/gpu/drm/sti/sti_hdmi.c   | 13 +++++--------
>  drivers/gpu/drm/sti/sti_hqvdp.c  | 12 +++++++-----
>  drivers/gpu/drm/sti/sti_mixer.c  |  7 ++++---
>  drivers/gpu/drm/sti/sti_tvout.c  | 13 +++++--------
>  drivers/gpu/drm/sti/sti_vid.c    |  8 ++++----
>  drivers/gpu/drm/sti/sti_vid.h    |  2 +-
>  11 files changed, 52 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
> index ea64c1dcaf63..a98057431023 100644
> --- a/drivers/gpu/drm/sti/sti_cursor.c
> +++ b/drivers/gpu/drm/sti/sti_cursor.c
> @@ -131,17 +131,17 @@ static struct drm_info_list cursor_debugfs_files[] = {
>  	{ "cursor", cursor_dbg_show, 0, NULL },
>  };
>  
> -static int cursor_debugfs_init(struct sti_cursor *cursor,
> -			       struct drm_minor *minor)
> +static void cursor_debugfs_init(struct sti_cursor *cursor,
> +				struct drm_minor *minor)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(cursor_debugfs_files); i++)
>  		cursor_debugfs_files[i].data = cursor;
>  
> -	return drm_debugfs_create_files(cursor_debugfs_files,
> -					ARRAY_SIZE(cursor_debugfs_files),
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(cursor_debugfs_files,
> +				 ARRAY_SIZE(cursor_debugfs_files),
> +				 minor->debugfs_root, minor);
>  }
>  
>  static void sti_cursor_argb8888_to_clut8(struct sti_cursor *cursor, u32 *src)
> @@ -342,7 +342,9 @@ static int sti_cursor_late_register(struct drm_plane *drm_plane)
>  	struct sti_plane *plane = to_sti_plane(drm_plane);
>  	struct sti_cursor *cursor = to_sti_cursor(plane);
>  
> -	return cursor_debugfs_init(cursor, drm_plane->dev->primary);
> +	cursor_debugfs_init(cursor, drm_plane->dev->primary);
> +
> +	return 0;
>  }
>  
>  static const struct drm_plane_funcs sti_cursor_plane_helpers_funcs = {
> diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
> index 50870d8cbb76..3f9db3e3f397 100644
> --- a/drivers/gpu/drm/sti/sti_drv.c
> +++ b/drivers/gpu/drm/sti/sti_drv.c
> @@ -92,24 +92,16 @@ static struct drm_info_list sti_drm_dbg_list[] = {
>  	{"fps_get", sti_drm_fps_dbg_show, 0},
>  };
>  
> -static int sti_drm_dbg_init(struct drm_minor *minor)
> +static void sti_drm_dbg_init(struct drm_minor *minor)
>  {
> -	int ret;
> -
> -	ret = drm_debugfs_create_files(sti_drm_dbg_list,
> -				       ARRAY_SIZE(sti_drm_dbg_list),
> -				       minor->debugfs_root, minor);
> -	if (ret)
> -		goto err;
> +	drm_debugfs_create_files(sti_drm_dbg_list,
> +				 ARRAY_SIZE(sti_drm_dbg_list),
> +				 minor->debugfs_root, minor);
>  
>  	debugfs_create_file("fps_show", S_IRUGO | S_IWUSR, minor->debugfs_root,
>  			    minor->dev, &sti_drm_fps_fops);
>  
>  	DRM_INFO("%s: debugfs installed\n", DRIVER_NAME);
> -	return 0;
> -err:
> -	DRM_ERROR("%s: cannot install debugfs\n", DRIVER_NAME);
> -	return ret;
>  }
>  
>  static const struct drm_mode_config_funcs sti_mode_config_funcs = {
> diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
> index a0709647f678..0032e1830bc5 100644
> --- a/drivers/gpu/drm/sti/sti_dvo.c
> +++ b/drivers/gpu/drm/sti/sti_dvo.c
> @@ -197,16 +197,16 @@ static struct drm_info_list dvo_debugfs_files[] = {
>  	{ "dvo", dvo_dbg_show, 0, NULL },
>  };
>  
> -static int dvo_debugfs_init(struct sti_dvo *dvo, struct drm_minor *minor)
> +static void dvo_debugfs_init(struct sti_dvo *dvo, struct drm_minor *minor)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(dvo_debugfs_files); i++)
>  		dvo_debugfs_files[i].data = dvo;
>  
> -	return drm_debugfs_create_files(dvo_debugfs_files,
> -					ARRAY_SIZE(dvo_debugfs_files),
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(dvo_debugfs_files,
> +				 ARRAY_SIZE(dvo_debugfs_files),
> +				 minor->debugfs_root, minor);
>  }
>  
>  static void sti_dvo_disable(struct drm_bridge *bridge)
> @@ -406,10 +406,7 @@ static int sti_dvo_late_register(struct drm_connector *connector)
>  		= to_sti_dvo_connector(connector);
>  	struct sti_dvo *dvo = dvo_connector->dvo;
>  
> -	if (dvo_debugfs_init(dvo, dvo->drm_dev->primary)) {
> -		DRM_ERROR("DVO debugfs setup failed\n");
> -		return -EINVAL;
> -	}
> +	dvo_debugfs_init(dvo, dvo->drm_dev->primary);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
> index 11595c748844..2d5a2b5b78b8 100644
> --- a/drivers/gpu/drm/sti/sti_gdp.c
> +++ b/drivers/gpu/drm/sti/sti_gdp.c
> @@ -343,9 +343,10 @@ static int gdp_debugfs_init(struct sti_gdp *gdp, struct drm_minor *minor)
>  	for (i = 0; i < nb_files; i++)
>  		gdp_debugfs_files[i].data = gdp;
>  
> -	return drm_debugfs_create_files(gdp_debugfs_files,
> -					nb_files,
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(gdp_debugfs_files,
> +				 nb_files,
> +				 minor->debugfs_root, minor);
> +	return 0;
>  }
>  
>  static int sti_gdp_fourcc2format(int fourcc)
> diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
> index f3f28d79b0e4..a1ec891eaf3a 100644
> --- a/drivers/gpu/drm/sti/sti_hda.c
> +++ b/drivers/gpu/drm/sti/sti_hda.c
> @@ -367,16 +367,16 @@ static struct drm_info_list hda_debugfs_files[] = {
>  	{ "hda", hda_dbg_show, 0, NULL },
>  };
>  
> -static int hda_debugfs_init(struct sti_hda *hda, struct drm_minor *minor)
> +static void hda_debugfs_init(struct sti_hda *hda, struct drm_minor *minor)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(hda_debugfs_files); i++)
>  		hda_debugfs_files[i].data = hda;
>  
> -	return drm_debugfs_create_files(hda_debugfs_files,
> -					ARRAY_SIZE(hda_debugfs_files),
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(hda_debugfs_files,
> +				 ARRAY_SIZE(hda_debugfs_files),
> +				 minor->debugfs_root, minor);
>  }
>  
>  /**
> @@ -643,10 +643,7 @@ static int sti_hda_late_register(struct drm_connector *connector)
>  		= to_sti_hda_connector(connector);
>  	struct sti_hda *hda = hda_connector->hda;
>  
> -	if (hda_debugfs_init(hda, hda->drm_dev->primary)) {
> -		DRM_ERROR("HDA debugfs setup failed\n");
> -		return -EINVAL;
> -	}
> +	hda_debugfs_init(hda, hda->drm_dev->primary);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> index 18eaf786ffa4..5b15c4974e6b 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -727,16 +727,16 @@ static struct drm_info_list hdmi_debugfs_files[] = {
>  	{ "hdmi", hdmi_dbg_show, 0, NULL },
>  };
>  
> -static int hdmi_debugfs_init(struct sti_hdmi *hdmi, struct drm_minor *minor)
> +static void hdmi_debugfs_init(struct sti_hdmi *hdmi, struct drm_minor *minor)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(hdmi_debugfs_files); i++)
>  		hdmi_debugfs_files[i].data = hdmi;
>  
> -	return drm_debugfs_create_files(hdmi_debugfs_files,
> -					ARRAY_SIZE(hdmi_debugfs_files),
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(hdmi_debugfs_files,
> +				 ARRAY_SIZE(hdmi_debugfs_files),
> +				 minor->debugfs_root, minor);
>  }
>  
>  static void sti_hdmi_disable(struct drm_bridge *bridge)
> @@ -1113,10 +1113,7 @@ static int sti_hdmi_late_register(struct drm_connector *connector)
>  		= to_sti_hdmi_connector(connector);
>  	struct sti_hdmi *hdmi = hdmi_connector->hdmi;
>  
> -	if (hdmi_debugfs_init(hdmi, hdmi->drm_dev->primary)) {
> -		DRM_ERROR("HDMI debugfs setup failed\n");
> -		return -EINVAL;
> -	}
> +	hdmi_debugfs_init(hdmi, hdmi->drm_dev->primary);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
> index 1015abe0ce08..5a4e12194a77 100644
> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> @@ -639,16 +639,16 @@ static struct drm_info_list hqvdp_debugfs_files[] = {
>  	{ "hqvdp", hqvdp_dbg_show, 0, NULL },
>  };
>  
> -static int hqvdp_debugfs_init(struct sti_hqvdp *hqvdp, struct drm_minor *minor)
> +static void hqvdp_debugfs_init(struct sti_hqvdp *hqvdp, struct drm_minor *minor)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(hqvdp_debugfs_files); i++)
>  		hqvdp_debugfs_files[i].data = hqvdp;
>  
> -	return drm_debugfs_create_files(hqvdp_debugfs_files,
> -					ARRAY_SIZE(hqvdp_debugfs_files),
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(hqvdp_debugfs_files,
> +				 ARRAY_SIZE(hqvdp_debugfs_files),
> +				 minor->debugfs_root, minor);
>  }
>  
>  /**
> @@ -1274,7 +1274,9 @@ static int sti_hqvdp_late_register(struct drm_plane *drm_plane)
>  	struct sti_plane *plane = to_sti_plane(drm_plane);
>  	struct sti_hqvdp *hqvdp = to_sti_hqvdp(plane);
>  
> -	return hqvdp_debugfs_init(hqvdp, drm_plane->dev->primary);
> +	hqvdp_debugfs_init(hqvdp, drm_plane->dev->primary);
> +
> +	return 0;
>  }
>  
>  static const struct drm_plane_funcs sti_hqvdp_plane_helpers_funcs = {
> diff --git a/drivers/gpu/drm/sti/sti_mixer.c b/drivers/gpu/drm/sti/sti_mixer.c
> index c3a3e1e5fc8a..0ee084049555 100644
> --- a/drivers/gpu/drm/sti/sti_mixer.c
> +++ b/drivers/gpu/drm/sti/sti_mixer.c
> @@ -200,9 +200,10 @@ int sti_mixer_debugfs_init(struct sti_mixer *mixer, struct drm_minor *minor)

I think sti_mixer_debugfs_init can also be made to return void, and then
sti_compositor_debugfs_init can also be converted void return value.

Otherwise I think looks good.
-Daniel

>  	for (i = 0; i < nb_files; i++)
>  		mixer_debugfs_files[i].data = mixer;
>  
> -	return drm_debugfs_create_files(mixer_debugfs_files,
> -					nb_files,
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(mixer_debugfs_files,
> +				 nb_files,
> +				 minor->debugfs_root, minor);
> +	return 0;
>  }
>  
>  void sti_mixer_set_background_status(struct sti_mixer *mixer, bool enable)
> diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
> index c36a8da373cb..df3817f0fd30 100644
> --- a/drivers/gpu/drm/sti/sti_tvout.c
> +++ b/drivers/gpu/drm/sti/sti_tvout.c
> @@ -570,16 +570,16 @@ static struct drm_info_list tvout_debugfs_files[] = {
>  	{ "tvout", tvout_dbg_show, 0, NULL },
>  };
>  
> -static int tvout_debugfs_init(struct sti_tvout *tvout, struct drm_minor *minor)
> +static void tvout_debugfs_init(struct sti_tvout *tvout, struct drm_minor *minor)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(tvout_debugfs_files); i++)
>  		tvout_debugfs_files[i].data = tvout;
>  
> -	return drm_debugfs_create_files(tvout_debugfs_files,
> -					ARRAY_SIZE(tvout_debugfs_files),
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(tvout_debugfs_files,
> +				 ARRAY_SIZE(tvout_debugfs_files),
> +				 minor->debugfs_root, minor);
>  }
>  
>  static void sti_tvout_encoder_dpms(struct drm_encoder *encoder, int mode)
> @@ -603,14 +603,11 @@ static void sti_tvout_encoder_destroy(struct drm_encoder *encoder)
>  static int sti_tvout_late_register(struct drm_encoder *encoder)
>  {
>  	struct sti_tvout *tvout = to_sti_tvout(encoder);
> -	int ret;
>  
>  	if (tvout->debugfs_registered)
>  		return 0;
>  
> -	ret = tvout_debugfs_init(tvout, encoder->dev->primary);
> -	if (ret)
> -		return ret;
> +	tvout_debugfs_init(tvout, encoder->dev->primary);
>  
>  	tvout->debugfs_registered = true;
>  	return 0;
> diff --git a/drivers/gpu/drm/sti/sti_vid.c b/drivers/gpu/drm/sti/sti_vid.c
> index 2d4230410464..2d818397918d 100644
> --- a/drivers/gpu/drm/sti/sti_vid.c
> +++ b/drivers/gpu/drm/sti/sti_vid.c
> @@ -124,16 +124,16 @@ static struct drm_info_list vid_debugfs_files[] = {
>  	{ "vid", vid_dbg_show, 0, NULL },
>  };
>  
> -int vid_debugfs_init(struct sti_vid *vid, struct drm_minor *minor)
> +void vid_debugfs_init(struct sti_vid *vid, struct drm_minor *minor)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(vid_debugfs_files); i++)
>  		vid_debugfs_files[i].data = vid;
>  
> -	return drm_debugfs_create_files(vid_debugfs_files,
> -					ARRAY_SIZE(vid_debugfs_files),
> -					minor->debugfs_root, minor);
> +	drm_debugfs_create_files(vid_debugfs_files,
> +				 ARRAY_SIZE(vid_debugfs_files),
> +				 minor->debugfs_root, minor);
>  }
>  
>  void sti_vid_commit(struct sti_vid *vid,
> diff --git a/drivers/gpu/drm/sti/sti_vid.h b/drivers/gpu/drm/sti/sti_vid.h
> index 9dbd78461de1..991849ba50b5 100644
> --- a/drivers/gpu/drm/sti/sti_vid.h
> +++ b/drivers/gpu/drm/sti/sti_vid.h
> @@ -26,6 +26,6 @@ void sti_vid_disable(struct sti_vid *vid);
>  struct sti_vid *sti_vid_create(struct device *dev, struct drm_device *drm_dev,
>  			       int id, void __iomem *baseaddr);
>  
> -int vid_debugfs_init(struct sti_vid *vid, struct drm_minor *minor);
> +void vid_debugfs_init(struct sti_vid *vid, struct drm_minor *minor);
>  
>  #endif
> -- 
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
