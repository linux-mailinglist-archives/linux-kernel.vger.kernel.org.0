Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3B130A19
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 23:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgAEWG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 17:06:57 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44067 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgAEWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:06:57 -0500
Received: by mail-vs1-f65.google.com with SMTP id p6so30539820vsj.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 14:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uw6b7W2hJ0QLRZ1xDtPnAWhipPvQAM3seWtHwc/JeWI=;
        b=n4jadz24z7JBewNrViqatR++YynQbD5azEZKxjZxFfvD368syVdZM1Ub7qpNXso0kX
         rhnOVjJ964h2axKqSfgW9ZGznWx5H37Wta9Zic+/tf5qtQ3Kw2Jls8ePPuwAIH1LEu9n
         /ITeQn9WUJVapcMrLG2KqGvJlEZkHWC6J9Chv4sGuO13joIoxXIoAoYk7zPjHfgnkxyG
         pC+oU2JPFCZTH5XDn5WF5GCI5f14EuYDHEsIWPn7tdx59Ebsi9LeB6pvCQsmpJ98ToEc
         geFFpUkywXbDL6iGW5LiilUZSb4WgxoECXQMA9oHdFfJkBZb1wyCeHD/MqBNwxnnlp+k
         9zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uw6b7W2hJ0QLRZ1xDtPnAWhipPvQAM3seWtHwc/JeWI=;
        b=JzQIFYp2//EEM2fqcdz8szORkwcJ5+zix93FoXJGIz8sltMyaImKjBSNSrbLCdxtOg
         t9PkrEi99c6eiUhZ3twkmRTPrRndChxL+ESd/XLbmsmydkdlaOC1XMbjeYcQC/6ivx1x
         xVe8ppBpbgMMXfE/otMj2uN4FQ/lLkvIwV58Nnl/pI99UeCponbR40VtShePxaiehNr9
         567e5vq9Us6FFjHC56RbB0W7/E0K/bAO7dle0jEaAx54uFe+6PnJ320ww/FFPPHd+WJU
         HKdCqDCpHcUtL364VY4puH1r02lVh8mYl1U7TLiEbkev53+rpjGgoJGezkLRRIHtRTHA
         nxhA==
X-Gm-Message-State: APjAAAUSp9NedlmUHh3QtVyVlrf5j33GnuL2R1tqvorgwnoPzwKUGNFS
        +4O12/cIgwtzWpNr67x60gC1UenugVsQAOMKo2g=
X-Google-Smtp-Source: APXvYqwbEJS1ZTfGghkXr5NcdUxqdwwl79ExOgPhvtn/LUVDP0xDOgcJaiiG+qAns3Cs0+AZewOfp016/f8BBavPXUI=
X-Received: by 2002:a67:1447:: with SMTP id 68mr34488742vsu.76.1578262016414;
 Sun, 05 Jan 2020 14:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20191231205607.1005-1-wambui.karugax@gmail.com> <20200101184843.GA3856@dvetter-linux.ger.corp.intel.com>
In-Reply-To: <20200101184843.GA3856@dvetter-linux.ger.corp.intel.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 6 Jan 2020 08:06:45 +1000
Message-ID: <CACAvsv5YEB0njcvFBhHWiCumuHroAqMm-T+fA8gJfsXijy+LVg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: remove set but unused variable.
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020 at 04:48, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Dec 31, 2019 at 11:56:07PM +0300, Wambui Karuga wrote:
> > The local variable `pclks` is defined and set but not used and can
> > therefore be removed.
> > Issue found by coccinelle.
> >
> > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > ---
> >  drivers/gpu/drm/nouveau/dispnv04/arb.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> > index 362495535e69..f607a04d262d 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
> > @@ -54,7 +54,7 @@ static void
> >  nv04_calc_arb(struct nv_fifo_info *fifo, struct nv_sim_state *arb)
> >  {
> >       int pagemiss, cas, width, bpp;
> > -     int nvclks, mclks, pclks, crtpagemiss;
> > +     int nvclks, mclks, crtpagemiss;
>
> Hm, reading the code (just from how stuff is named) I wonder whether the
> original idea was that the calculation for us_p should us pclks, not
> nvclks, but given that this code is as old as the initial nouveau merge
> probably not a good idea to touch it. Plus I guess not many with a vintage
> nv04 in working condition around to even test stuff ...
>
> Ben, what should we do here?
I looked at the original code from xf86-video-nv, and pclks is
similarly unused there also, so, I'd vote for just picking up this
patch.  I don't believe anyone has the knowledge+hw anymore to mess
with it in any other way.

Ben.

> -Daniel
>
> >       int found, mclk_extra, mclk_loop, cbs, m1, p1;
> >       int mclk_freq, pclk_freq, nvclk_freq;
> >       int us_m, us_n, us_p, crtc_drain_rate;
> > @@ -69,7 +69,6 @@ nv04_calc_arb(struct nv_fifo_info *fifo, struct nv_sim_state *arb)
> >       bpp = arb->bpp;
> >       cbs = 128;
> >
> > -     pclks = 2;
> >       nvclks = 10;
> >       mclks = 13 + cas;
> >       mclk_extra = 3;
> > --
> > 2.17.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
