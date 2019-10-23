Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76316E22FD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 21:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391029AbfJWTAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 15:00:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34084 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387929AbfJWTAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:00:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so18130672wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+OWjpvr+IZedd7nljlYA8XWBRBItw4xtW0mvQ/KD8Fk=;
        b=M95LDREgblcKjvAHssdy4GOnOy+idPXh9WTEOZZdiOlwBVlvkmYF8XPlBP0lSR3FUJ
         PhSUgbLA9MuLMfPxCT7kyPf4tDIinnMjcd6POSe8NgDzz7Tux6+w57eymqpz9vtYVSB3
         30QGpwWmCbAdm1D3IBvAg+C2kg9CjJSyUfU9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=+OWjpvr+IZedd7nljlYA8XWBRBItw4xtW0mvQ/KD8Fk=;
        b=L4q8uxEQ4UaAfn4bnlhaqE29mIZnb97nrX/PY0LUCm/8tr2YnGKa8WFZ7FWXlchjbZ
         wYIiW+0NMnN6y2jXWRFwEhjYk46f7g7LmLqmeKBkjSaUc/47G2aeQ19iYqgVsp2EhAGt
         FADOV1eHSbMCREEzcy/BzmYjRG+n6Bygb/3Se78COpslpn1/jLL7tCJMmHhoJDkX/H5v
         o7xEO4c/rNy1C3U/q1KrePuJtwFRPOZv71x050Uy/0YTlCmEPnI/l7t00C55iMII1lNv
         tL1+y7k4pNcGI7bFAIg7/X88kZwUJ3qQ1ntkTDtJB1aPrpNTQ+QUgZgHeT+X8ytvaltc
         XvVg==
X-Gm-Message-State: APjAAAUuyqaJ06H39a5KUebzEUM/1ylWX9ulHMqt4Vu+0Jg0V9gDVF08
        SbUfiRJ7UNFPyo8JAlSbY2RG4Q==
X-Google-Smtp-Source: APXvYqwQW7fShJRSiaDGCH+qmp4vWbgbdvriTea73n3kmGp5rVj6c+beXl6Ds2NKz1NgdfjTGKBsmA==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr205718wrq.101.1571857198467;
        Wed, 23 Oct 2019 11:59:58 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id r3sm38184702wre.29.2019.10.23.11.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 11:59:55 -0700 (PDT)
Date:   Wed, 23 Oct 2019 20:59:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/v3d: Fix memory leak in v3d_submit_cl_ioctl
Message-ID: <20191023185952.GZ11828@phenom.ffwll.local>
Mail-Followup-To: Navid Emamdoost <navid.emamdoost@gmail.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191021185250.26130-1-navid.emamdoost@gmail.com>
 <20191022093654.GF11828@phenom.ffwll.local>
 <CAEkB2ETFM7u6YiUOT3fz4UQ3U_za9iM1arTnYNg-rjs5+wxOfw@mail.gmail.com>
 <20191023091601.GX11828@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023091601.GX11828@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:16:01AM +0200, Daniel Vetter wrote:
> On Tue, Oct 22, 2019 at 10:53:57PM -0500, Navid Emamdoost wrote:
> > On Tue, Oct 22, 2019 at 4:36 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Mon, Oct 21, 2019 at 01:52:49PM -0500, Navid Emamdoost wrote:
> > > > In the impelementation of v3d_submit_cl_ioctl() there are two memory
> > > > leaks. One is when allocation for bin fails, and the other is when bin
> > > > initialization fails. If kcalloc fails to allocate memory for bin then
> > > > render->base should be put. Also, if v3d_job_init() fails to initialize
> > > > bin->base then allocated memory for bin should be released.
> > > >
> > > > Fixes: a783a09ee76d ("drm/v3d: Refactor job management.")
> > > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/v3d/v3d_gem.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> > > > index 5d80507b539b..19c092d75266 100644
> > > > --- a/drivers/gpu/drm/v3d/v3d_gem.c
> > > > +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> > > > @@ -557,13 +557,16 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
> > > >
> > > >       if (args->bcl_start != args->bcl_end) {
> > > >               bin = kcalloc(1, sizeof(*bin), GFP_KERNEL);
> > > > -             if (!bin)
> > > > +             if (!bin) {
> > > > +                     v3d_job_put(&render->base);
> > >
> > > The job isn't initialized yet, this doesn't work.
> > Do you mean we have to release render via kfree() here?
> > 
> > >
> > > >                       return -ENOMEM;
> > > > +             }
> > > >
> > > >               ret = v3d_job_init(v3d, file_priv, &bin->base,
> > > >                                  v3d_job_free, args->in_sync_bcl);
> > > >               if (ret) {
> > > >                       v3d_job_put(&render->base);
> > >
> > > v3d_job_put will call kfree, if you chase the callchain long enough (in
> > > v3d_job_free). So no bug here, this would lead to a double kfree and
> > > crash.
> > Yes, v3d_job_put() takes care of render,
> > 
> > > -Daniel
> > >
> > > > +                     kfree(bin);
> > but how about leaking bin?
> 
> Sorry, I totally missed that this is bin, no render. Patch looks correct
> to me.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Double-checked with Eric and applied to drm-misc-fixes.
-Daniel

> 
> > 
> > > >                       return ret;
> > > >               }
> > > >
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> > 
> > 
> > 
> > -- 
> > Navid.
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
