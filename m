Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C3D72E23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 13:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfGXLtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 07:49:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45223 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfGXLtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:49:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id x19so40928990eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ky6MiqknUauxBZH/dFB9V8N7cSZFbXcp813AEssc034=;
        b=K38QiI9z0UqP/jOGfZgUBdANryYHFccCp4EpAHFXhr18n9XPmRDBNkulDfwEzUlJt6
         zauV896QRGbFz/vfGhitFSXoEG210dh16UprC6STA5QWoi8Q8/fLuF1A7bYa+L/CtiOG
         SsKMSUs0mIzX1EFoodnQBTAEIlWL5lIs1EcVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ky6MiqknUauxBZH/dFB9V8N7cSZFbXcp813AEssc034=;
        b=ngG5Aqyzx848xzEjy+maATLlI+4law/4xw4yzpp1Ff67MdeT+ikd4uF5a7jkXt8auj
         82wWxznNlwzt9h5RP3VfEkSkR7h+XmELXhCXpT8t9M9N9y4Y0YZDQPp8552J4IqZFh+1
         yTQ0i0DRgWrrazbU3GJSb9sCNT7pg11WizMNmW9ZMLaXaGQQICCwwflp2qtTurZssYN6
         UHtYxja/D4vphruKOiZhOdyVgE/yTRUlgWfhbE/vEgQBLQ6TZrmliOJNB+nTizy6bZcp
         4w3kPtx6UNaaXgpVG1IVGImApnYc7im40o0HSzCUXpaA8AHNNNV1vAiV2xMpcnfTJIQm
         yAjw==
X-Gm-Message-State: APjAAAXcyjEZQv7BZ0ECjbKdg1gNL3mjFBQfmLQNZ5NHbXGPLL6kcQjx
        T6o3SW+Kwpo9KQMf/+FdIms=
X-Google-Smtp-Source: APXvYqwxJaa6d48jFA2r5dQ4BfamVvHN3hDlPbM+EjOINhA7XXW533p+MIuVnfd7kvr+TWyx1PBo2Q==
X-Received: by 2002:a17:906:a39a:: with SMTP id k26mr13973104ejz.82.1563968956237;
        Wed, 24 Jul 2019 04:49:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x11sm9268496eju.26.2019.07.24.04.49.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 04:49:15 -0700 (PDT)
Date:   Wed, 24 Jul 2019 13:49:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] MAINTAINERS: handle fbdev changes through drm-misc tree
Message-ID: <20190724114913.GZ15868@phenom.ffwll.local>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <CGME20190723143329eucas1p211688de2902dbac72998fda9e694083d@eucas1p2.samsung.com>
 <d449f697-ed25-8a3f-16d5-b981f1a52217@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d449f697-ed25-8a3f-16d5-b981f1a52217@samsung.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 04:33:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
> fbdev patches will now go to upstream through drm-misc tree (IOW
> starting with v5.4 merge window fbdev changes will be included in
> DRM pull request) for improved maintainership and better integration
> testing. Update MAINTAINERS file accordingly.
> 
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  MAINTAINERS |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/MAINTAINERS
> ===================================================================
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6389,7 +6389,7 @@ FRAMEBUFFER LAYER
>  M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>  L:	dri-devel@lists.freedesktop.org
>  L:	linux-fbdev@vger.kernel.org
> -T:	git git://github.com/bzolnier/linux.git
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
>  Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
>  S:	Maintained
>  F:	Documentation/fb/

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
