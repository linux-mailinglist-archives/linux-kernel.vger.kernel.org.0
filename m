Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED16E3755
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393948AbfJXP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 11:59:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55148 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389313AbfJXP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:59:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id g7so3438760wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJbQ89hF9RW6SSlk8EDSb3r+Mf7JAiqwXmPkxbcOPek=;
        b=JuzUwj7xmxtzYGSHjKQchMasKYs0hf2WWPDVInp7z0HBv7JPUVZU4yEZ3cT546842v
         sdBLssVvpZp5/VAAQZqdUCyH6Yw2r9DD/fYcNrsUAN8Qx9/uR4u5PO+XfivlUZyl8NKZ
         3BrDcIbrv+v8JjQNn2lV9blvnxj16BRBqk2nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NJbQ89hF9RW6SSlk8EDSb3r+Mf7JAiqwXmPkxbcOPek=;
        b=AXCO7jM94+aTyOb6rZygUcKBm5IyjHhw6Yvo80U7YjTlC3msIOY5kNbWhfIBEx84eK
         fAD4wZU4KC2Er/7aqhblJF7gYX9ztTbkz0qgiQWHfCqt2Y5UAdcbAXPV/Sgp/MeWR5dy
         njEeBjXMkV68toqbCOmA9E8lB2pOK+yfJlfpPenOT9M+l/fA17B+LZxL8tVK+ytJJzS+
         EIjy1BzA/9+nz2ovXXiB0fWufDVNjzkxDvxutoyrji+whMr7kt5gMUUqoPi4H6BiTP+U
         vUWEPRmnsnQ8RTAv6k+4wLav7RQUVuH3o9ecS41r2FjUMJRPVuETOnhUmevEziBxcQQ0
         fAMg==
X-Gm-Message-State: APjAAAWWfQBatogW+yoYTS5hMF449YdqJqFOrjVhkGF6EjHO+ZP2ybVL
        WaMwO8zCx8EJnsHrBNnrtF8G8w==
X-Google-Smtp-Source: APXvYqwHh+NpYPMqC8toe5xDBmGW+H7S71mUP4y3yRJQ/zyv9OC6TruS/Yu0iRjoqGFuyVvu3g9i7A==
X-Received: by 2002:a1c:6854:: with SMTP id d81mr5933299wmc.75.1571932781046;
        Thu, 24 Oct 2019 08:59:41 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id z13sm29372745wrm.64.2019.10.24.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:59:40 -0700 (PDT)
Date:   Thu, 24 Oct 2019 17:59:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jiri Kosina <trivial@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] drm: Spelling s/connet/connect/
Message-ID: <20191024155938.GJ11828@phenom.ffwll.local>
Mail-Followup-To: Geert Uytterhoeven <geert+renesas@glider.be>,
        David Airlie <airlied@linux.ie>, Jiri Kosina <trivial@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191024151737.29287-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024151737.29287-1-geert+renesas@glider.be>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:17:37PM +0200, Geert Uytterhoeven wrote:
> Fix misspellings of "connector" and "connection"
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/gma500/mdfld_dsi_output.c | 2 +-
>  include/uapi/drm/exynos_drm.h             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_output.c b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
> index 03023fa0fb6f9d3c..f350ac1ead18213e 100644
> --- a/drivers/gpu/drm/gma500/mdfld_dsi_output.c
> +++ b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
> @@ -498,7 +498,7 @@ void mdfld_dsi_output_init(struct drm_device *dev,
>  		return;
>  	}
>  
> -	/*create a new connetor*/
> +	/*create a new connector*/
>  	dsi_connector = kzalloc(sizeof(struct mdfld_dsi_connector), GFP_KERNEL);
>  	if (!dsi_connector) {
>  		DRM_ERROR("No memory");
> diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
> index 3e59b8382dd8cead..45c6582b3df31dbf 100644
> --- a/include/uapi/drm/exynos_drm.h
> +++ b/include/uapi/drm/exynos_drm.h
> @@ -68,7 +68,7 @@ struct drm_exynos_gem_info {
>  /**
>   * A structure for user connection request of virtual display.
>   *
> - * @connection: indicate whether doing connetion or not by user.
> + * @connection: indicate whether doing connection or not by user.
>   * @extensions: if this value is 1 then the vidi driver would need additional
>   *	128bytes edid data.
>   * @edid: the edid data pointer from user side.
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
