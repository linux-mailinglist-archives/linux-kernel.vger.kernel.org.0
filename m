Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06BC18AE73
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 09:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCSIkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 04:40:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35630 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSIkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 04:40:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id k8so1873955oik.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACN5TXHytCQ9oPIhIdCfNcH/pNHuSSltZdjJw7+EaRg=;
        b=A7NboF2/Hz8lWvoBTGeYPrQgAwRxBjdgXIJR/1akF0SZVx5wIQu0CN/7CL80GXNQmg
         4rmVYRb0lYTdlQaiJRmDTsoYiGLCBJ+IDGv1Lp33jY1utb0+pr9jXvzBwAbmqtuCuxtb
         rbnTIa/mG4eu6te9zzbxaeRET942OOWKDEDgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACN5TXHytCQ9oPIhIdCfNcH/pNHuSSltZdjJw7+EaRg=;
        b=mGECFn0LFOoG2E9rcUtwcXi7p1DuKICxUQIB1kk6Z7N7X+AymGkr7W8fpaHx0jbHY7
         6x8YAQTjl3y7N6AlyT2Gs30H1AkTzIZdL9r08Me0u+VKSDVol8KBibGvyJfTXPEm4UFM
         0LVp8MexU+UI9lJEud+cO0VHnUi+8IebCXgBHIfkQJQH2dyGNo3Cx5q4zIHqtpQCRWxr
         5oQTCV1X2Ai1brEHIvjXow8MSE29xZ/2Q75T7Scnw/lnSrCgVEa3vSvHWWK9BXgj2g2O
         QuMLm6pHmOqjr5Hfcuhs6DF1deT67Gns7v0axBpM2RMz5ol7rYPq+vj0cjVveqbfvXjQ
         YgaQ==
X-Gm-Message-State: ANhLgQ1qQt13ulGcNpbckfORfjTiWY7gSFpFX0yEWnDPzhl93WOhr7Hd
        a3tN9YrwdvAHwz2KzoQrOTziQI+HNW06bz46JOkMWg==
X-Google-Smtp-Source: ADFU+vt3ZzgRUF2QVHwIZ2Dg+soGlY7nM/mYmDu2kjCnCgsthelSdzxb44Mh83yzZ1MJ1ma3yWffDCZUEBGsisIAZiA=
X-Received: by 2002:aca:be08:: with SMTP id o8mr1404601oif.101.1584607203202;
 Thu, 19 Mar 2020 01:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200313084152.2734-1-kraxel@redhat.com> <20200317164941.GP2363188@phenom.ffwll.local>
 <20200318064211.rg5s4sgrnqhht3f4@sirius.home.kraxel.org>
In-Reply-To: <20200318064211.rg5s4sgrnqhht3f4@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 19 Mar 2020 09:39:52 +0100
Message-ID: <CAKMK7uE52i2_BhFoH0timOG_jUQP3OThA+wUWoMx6tfH9mMT6w@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bochs: downgrade pci_request_region failure from
 error to warning
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        marmarek@invisiblethingslab.com, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 7:49 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Mar 17, 2020 at 05:49:41PM +0100, Daniel Vetter wrote:
> > On Fri, Mar 13, 2020 at 09:41:52AM +0100, Gerd Hoffmann wrote:
> > > Shutdown of firmware framebuffer has a bunch of problems.  Because
> > > of this the framebuffer region might still be reserved even after
> > > drm_fb_helper_remove_conflicting_pci_framebuffers() returned.
> >
> > Is that still the fbdev lifetime fun where the cleanup might be delayed if
> > the char device node is still open?
>
> Yes.

In that case I think a FIXME comment that this should be upgraded
again to a full error once fbdev unloading is fixed should be added.
With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I guess you might want a cc: stable on this too?
-Daniel

>
> cheers,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
