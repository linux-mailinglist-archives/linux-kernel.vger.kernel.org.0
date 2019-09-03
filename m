Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3227A66F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 12:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfICK6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 06:58:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33732 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:58:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id o9so6545412edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1fmMyGS0tNg2ZrUjMXrQHItun5hzN9B9+GAHYDnxm80=;
        b=UMkvzjLsCC2sjAxyLFkC+oxnIHOCVIrCP8LNWhgtHwHfHVoDJNqWNA1lb/Wtp8jGo2
         GCGAA8VSliVvR7CFYm9CMTgUUn06B+IoCzWE6JtVQRmjVzPXu3RQfegMMdsswRxHLQfT
         B+9IEE/xV2uvU/uuhS+1E9HVKQPPbYYMvBYLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=1fmMyGS0tNg2ZrUjMXrQHItun5hzN9B9+GAHYDnxm80=;
        b=sCnTtgxhfZj/ejwq7JuHhvxqRTv342Ull1/1HpJhp9Tv4NQTla268fgXvyK/KyI0Zh
         plyUL90ywt1JC6HBOkdIOcQS3Jw7VvCFu0ucwiRYK3XCm8dIg9dfH8rw03Cghld83k45
         AkKT+MMU33Q+HtjUbqwQ4XRYv6FkLCVIhQf3HuJeZMPqDaANrorYb1J+ZaE9JhP3ZWZv
         VTlFIy+5lik8kfI+TvhhhUmdjfMnzWGzgBcVcfP2k0FQo0BPKlegWj7QsLESa8F5YCwt
         iAUtICvmPHzRF+xrfpIADYV99oFPG2gnwxb7UAxYrvSTJA1zPTcs+6AI/0UssmBJlcTH
         oOvQ==
X-Gm-Message-State: APjAAAVtXhzMuWq+jdk7+Fc0izOryMhnognGaPnFKXhlVHIjv2IPpoa3
        D0rt5pp8DG1Fv+tdsT29ScJ7Qg==
X-Google-Smtp-Source: APXvYqw5isHmx06+1+EN3i1c9akHWdMgAFkS8ga2Hxp68Sh6sDTlsUNHiff4YPNE1vu4FjaDz+IcUQ==
X-Received: by 2002:a17:906:ce48:: with SMTP id se8mr22871363ejb.98.1567508310915;
        Tue, 03 Sep 2019 03:58:30 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id p11sm146389edh.77.2019.09.03.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 03:58:30 -0700 (PDT)
Date:   Tue, 3 Sep 2019 12:58:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] drm/vram: use drm_gem_ttm_print_info
Message-ID: <20190903105828.GW2112@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190903101248.12879-1-kraxel@redhat.com>
 <20190903101248.12879-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903101248.12879-4-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 12:12:45PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_gem_vram_helper.c | 4 +++-
>  drivers/gpu/drm/Kconfig               | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> index fd751078bae1..71552f757b4a 100644
> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
> +#include <drm/drm_gem_ttm_helper.h>
>  #include <drm/drm_gem_vram_helper.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_mode.h>
> @@ -633,5 +634,6 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs = {
>  	.pin	= drm_gem_vram_object_pin,
>  	.unpin	= drm_gem_vram_object_unpin,
>  	.vmap	= drm_gem_vram_object_vmap,
> -	.vunmap	= drm_gem_vram_object_vunmap
> +	.vunmap	= drm_gem_vram_object_vunmap,
> +	.print_info = drm_gem_ttm_print_info,

Yeah definitely link to the new way of doing stuff in the kerneldoc of the
previous patch. For this.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  };
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index f7b25519f95c..1be8ad30d8fe 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -169,6 +169,7 @@ config DRM_VRAM_HELPER
>  	tristate
>  	depends on DRM
>  	select DRM_TTM
> +	select DRM_TTM_HELPER

Select isn't recursive, which means anyone who selects vram helpers now
also needs to select ttm helpers. This is already broken with DRM_TTM I
think ...
-Daniel


>  	help
>  	  Helpers for VRAM memory management
>  
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
