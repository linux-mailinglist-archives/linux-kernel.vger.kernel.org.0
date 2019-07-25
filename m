Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC174DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 14:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfGYMED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 08:04:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41324 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfGYMED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:04:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id p15so49972295eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cy0ew9uPB8kVgEkmAFM7ms4faY7aDGiLUN/eaDicKPg=;
        b=WPZhZWmRLRFJE8jPPQtDSMQzuxgwp3LQMY9ubs6jUiptnchPg7kFyCCu6lCq07dzQM
         Bv+b5kp750NTw97eMhhEIN/2+zSUClyeCkEsIT/KpeyftRjloI9FYcvGhe7H6n21aHB7
         QXdsWpYtCXLTZIJx5CLvoTfenLF2F848/TPPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=cy0ew9uPB8kVgEkmAFM7ms4faY7aDGiLUN/eaDicKPg=;
        b=JZVHr784zyL1QWyZDhMqmCoNhZCR3509fpAB48O/qGY1B0uyyNCObGvEI3ttNWC6tz
         T5s1jTDsO7ax1kF3bhzMofs7k0Zx3LGPOsGLyHl6ZmJ6ZqUnu/zw2svunJxs4J6hgbbd
         fgE7SsU/uHnOyY6/bpA0pnVWFea8VHOr4tutY1Ni4rfF7UIr8wRInd9LNjSpN+FEVLPK
         2LzWstzjZwxCe9YDPDgyKQZvpLV5IcTNa6yXgAM2SaOCrPzTm682w3w0VgnqgkkDyS+z
         brq3iE6DA7GK5Y+SPP8y6BNYGlAxY0M3cRvfxhNOpsDLq1UmOaY+fpxsLmEEoPL1oP3V
         FYuA==
X-Gm-Message-State: APjAAAUUgPBCrsm74/5MZefCzpGr4VvaKB1jsSryMUwqDte7vWB7G5sr
        5zT75mVON+wTTvkxI6/TflQ=
X-Google-Smtp-Source: APXvYqyaIPnd0FN+ekWkoKh4vPAtSWP2GBKrYKSJbcPhM7k3XbUpl7CE1EwxPieoU4WbQXNb3+RMyA==
X-Received: by 2002:a50:9871:: with SMTP id h46mr76005765edb.69.1564056241883;
        Thu, 25 Jul 2019 05:04:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k8sm13001747edr.31.2019.07.25.05.04.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 05:04:01 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:03:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     airlied@redhat.com, kraxel@redhat.com, airlied@linux.ie,
        daniel@ffwll.ch, virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: drm: qxl: Fix possible null-pointer dereferences in
 qxl_crtc_atomic_flush()
Message-ID: <20190725120359.GB15868@phenom.ffwll.local>
Mail-Followup-To: Jia-Ju Bai <baijiaju1990@gmail.com>, airlied@redhat.com,
        kraxel@redhat.com, airlied@linux.ie,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190725102127.16086-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725102127.16086-1-baijiaju1990@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:21:27PM +0800, Jia-Ju Bai wrote:
> In qxl_crtc_atomic_flush(), there is an if statement on line 376 to
> check whether crtc->state is NULL:
>     if (crtc->state && crtc->state->event)
> 
> When crtc->state is NULL and qxl_crtc_update_monitors_config() is call, 
> qxl_crtc_update_monitors_config() uses crtc->state on line 326:
>     if (crtc->state->active)
> and on line 358:
>     DRM_DEBUG_KMS(..., crtc->state->active, ...);
> 
> Thus, possible null-pointer dereferences may occur.
> 
> To fix these bugs, crtc->state is checked before calling
> qxl_crtc_update_monitors_config().
> 
> These bugs are found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

crtc->state should never be NULL in this function, ever. Imo correct fix
is to remove that other NULL check (since obviously it would blow up,
hence it's dead code).

Atomic kms drivers use drm_mode_config_reset() to make sure the various
->state pointers are always set and valid.
-Daniel

> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 8b319ebbb0fb..fae18ef1ba59 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -382,7 +382,8 @@ static void qxl_crtc_atomic_flush(struct drm_crtc *crtc,
>  		spin_unlock_irqrestore(&dev->event_lock, flags);
>  	}
>  
> -	qxl_crtc_update_monitors_config(crtc, "flush");
> +	if (crtc->state)
> +		qxl_crtc_update_monitors_config(crtc, "flush");
>  }
>  
>  static void qxl_crtc_destroy(struct drm_crtc *crtc)
> -- 
> 2.17.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
