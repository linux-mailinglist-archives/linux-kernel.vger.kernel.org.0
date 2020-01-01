Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018CD12E039
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 19:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgAASvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 13:51:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55031 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgAASvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:51:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so3973323wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 10:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8uPCxi3Y1/pc0576oAFGCcv9ILxWB3/3GiCiHCXgko=;
        b=CovNZjlE6y41FxRRV2dQgC2LXmUHj1E8p0Nrv8qiRfWxbkQdYpbWLSMjj/b+oII78U
         wl3wEHZITaqtJDiX2UUnM3rU9Poj3VDz0KTlFfXfgsLsgcwqUU8n+ad18kAFMtdYP3Nl
         H6F+gk0amyScbp2FsWH2Pzgq8Mylv+lGIT/y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=D8uPCxi3Y1/pc0576oAFGCcv9ILxWB3/3GiCiHCXgko=;
        b=X5afWAIkhnPv1AqPp40LBJzwAz2crIlHEj2QxicWgaDe+mRtRUIvF7HgQsE/JGPErd
         2zgXwBzkO7bYBM7Tk22wuQrY96442EdVTbkqInAPce0pg6HKWINpWE6atBuhdlok/q6V
         3/fSZMynW9u+pm1JfcfUDoEWXP5UXIQs/ZJ4awzcgZQm336GCo/hXJxcOSkaqqgSI5yw
         Od4JGVt/QbUW5oRtZ7BVe4/b/7Han78ggWcJWAvJVfmpKFgz3Apr3i/iAehufOYdllwC
         NOI2FhJg4EjEcfV78oQvq+rrRU6It26JzRzA2j26iPrlxrezQ/9iCSmLUJ56MXaVKPZQ
         rA2Q==
X-Gm-Message-State: APjAAAWJ8b5ZkplEUNxZ3rZtte6hoEb1XAD3KZLZdSKFs93/z4rxHG9F
        Fs5Lt6YZGVmHkMMUbuysde+OxHPmiMk=
X-Google-Smtp-Source: APXvYqyjqRvgYGtxavvSSbnVsxx3hbCvsLvioRActoXXQldrptMzEMi+l6Q2nwcO1dPqXP/rbpsjRA==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr10459265wmm.70.1577904711502;
        Wed, 01 Jan 2020 10:51:51 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.125])
        by smtp.gmail.com with ESMTPSA id b21sm6272694wmd.37.2020.01.01.10.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 10:51:50 -0800 (PST)
Date:   Wed, 1 Jan 2020 19:51:47 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: use NULL for pointer assignment.
Message-ID: <20200101185147.GB3856@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Wambui Karuga <wambui.karugax@gmail.com>,
        bskeggs@redhat.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20191231205734.1452-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231205734.1452-1-wambui.karugax@gmail.com>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 5.2.11-200.fc30.x86_64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 11:57:34PM +0300, Wambui Karuga wrote:
> Replace the use of 0 in the pointer assignment with NULL to address the
> following sparse warning:
> drivers/gpu/drm/nouveau/nouveau_hwmon.c:744:29: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'll check with Ben next week or so whether he wants to pick these up or
whether I should stuff them into drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/nouveau/nouveau_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> index d445c6f3fece..1c3104d20571 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> @@ -741,7 +741,7 @@ nouveau_hwmon_init(struct drm_device *dev)
>  			special_groups[i++] = &pwm_fan_sensor_group;
>  	}
>  
> -	special_groups[i] = 0;
> +	special_groups[i] = NULL;
>  	hwmon_dev = hwmon_device_register_with_info(dev->dev, "nouveau", dev,
>  							&nouveau_chip_info,
>  							special_groups);
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
