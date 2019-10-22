Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74CEE0800
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 17:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbfJVPx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 11:53:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38221 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388866AbfJVPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:53:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id q78so2627604lje.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhtC62v3n6zmy08FKulqslkQbjt/OC56JJA6sqKbbEI=;
        b=UcYTz4a7WI8YJuFZ85FxcekxfaPXLr7TxsJ2U6KWML5x+HxuEl2IvCvKhALdV3vz/S
         iSXd9yW+BB/SRFFZO2moBPElSPog8UZfyOYp/+a30LMJEWBpMaxU5Xq9PcLjK/ol0fY1
         VmRkXk6iYklRWmO5pNt9bgmgzaL8I9njwDTEZgaQmEUV8xiMCGTQNoaTVO/Udd2lCga4
         NJH6KxJyXm42dj8KjH+XBPxv5NxF0a2WlJywFVd4q7ztJrC5xV9xfXfGFKKrr66FgMSM
         x8w4TyqkvdtyLq3TlHmWDkI6UEjblKeTOCGZ9az8QUsLKez0b9G5miqI6gjHN4gIPmzq
         iJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhtC62v3n6zmy08FKulqslkQbjt/OC56JJA6sqKbbEI=;
        b=jBktcsLG5GTirp5shqXj5pqo36KJXqjVDx8A24Y2Xzq0/2o7ODWSNFwDpzix3aXLmM
         PMdPTwr6bunZXKtSzFF1ZdbnfUNKXboaKHAManFQhd9EdFlfiw3CKfkIuCYHR74Nemc3
         bAa21kQxRsqiwwFyI1d9DBpDqXTapniMEcOYbDbQUJSU/hcqXIErInepWpBqq/EFF9tA
         lHe3Soxsk6S/4AFt9YREvojY25J8to1y0aGTTRfYg1ia7kNmkMZRfGqL9nw85eZKlEPh
         ojbAa3n6zykdbGzzyBIVvNnz0vtIhLpifB/fPn/a/tZvjndQ3lE1rDwXN9tkkbR0UyCJ
         gWqw==
X-Gm-Message-State: APjAAAVwBnQ/9K9j4E6ViulcpsH7fB2YPWDesVvopXGjGctBMXvylFF2
        lx4NyVvpiGYaSaajPNE5w0Ta8ZKZeyoWrAe1PrY=
X-Google-Smtp-Source: APXvYqwMAh2Xf8XGTmUZ0oAFhZ+aXz7e3Xm4is5aYh8CbOVrKF19FvuDYEfcrvLjMVfNISfByHZYxzhm66qKmBvqX7E=
X-Received: by 2002:a2e:8417:: with SMTP id z23mr19232916ljg.46.1571759635304;
 Tue, 22 Oct 2019 08:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191016123342.19119-1-patrik.r.jakobsson@gmail.com>
 <87lftdfb4c.fsf@intel.com> <20191022084423.GB1531961@ulmo> <87imohf6rf.fsf@intel.com>
In-Reply-To: <87imohf6rf.fsf@intel.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Tue, 22 Oct 2019 17:53:44 +0200
Message-ID: <CAMeQTsYbY+2=w1m_zMo95vrR008otQESYQJ5K1PfyYOi_Ff2BQ@mail.gmail.com>
Subject: Re: [PATCH] drm/scdc: Fix typo in bit definition of SCDC_STATUS_FLAGS
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <treding@nvidia.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 11:51 AM Jani Nikula
<jani.nikula@linux.intel.com> wrote:
>
> On Tue, 22 Oct 2019, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Tue, Oct 22, 2019 at 11:16:51AM +0300, Jani Nikula wrote:
> >> On Wed, 16 Oct 2019, Patrik Jakobsson <patrik.r.jakobsson@gmail.com> wrote:
> >> > Fix typo where bits got compared (x < y) instead of shifted (x << y).
> >>
> >> Fixes: 3ad33ae2bc80 ("drm: Add SCDC helpers")
> >> Cc: Thierry Reding <treding@nvidia.com>
> >
> > I'm not sure we really need the Fixes: tag here. These defines aren't
> > used anywhere, so technically there's no bug.
>
> Yeah well, I just logged it here as I happened to do the drive-by git
> blame.

I think we can skip the fixes tag here. Thanks for review!

Did anyone apply this or can I take it through drm-misc-next?

-Patrik

>
> BR,
> Jani.
>
>
>
> >
> > Thierry
> >
> >>
> >> > Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> >> > ---
> >> >  include/drm/drm_scdc_helper.h | 6 +++---
> >> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/include/drm/drm_scdc_helper.h b/include/drm/drm_scdc_helper.h
> >> > index f92eb2094d6b..6a483533aae4 100644
> >> > --- a/include/drm/drm_scdc_helper.h
> >> > +++ b/include/drm/drm_scdc_helper.h
> >> > @@ -50,9 +50,9 @@
> >> >  #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
> >> >
> >> >  #define SCDC_STATUS_FLAGS_0 0x40
> >> > -#define  SCDC_CH2_LOCK (1 < 3)
> >> > -#define  SCDC_CH1_LOCK (1 < 2)
> >> > -#define  SCDC_CH0_LOCK (1 < 1)
> >> > +#define  SCDC_CH2_LOCK (1 << 3)
> >> > +#define  SCDC_CH1_LOCK (1 << 2)
> >> > +#define  SCDC_CH0_LOCK (1 << 1)
> >> >  #define  SCDC_CH_LOCK_MASK (SCDC_CH2_LOCK | SCDC_CH1_LOCK | SCDC_CH0_LOCK)
> >> >  #define  SCDC_CLOCK_DETECT (1 << 0)
> >>
> >> --
> >> Jani Nikula, Intel Open Source Graphics Center
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Jani Nikula, Intel Open Source Graphics Center
