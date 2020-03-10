Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 298CC180216
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 16:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCJPll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 11:41:41 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44583 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgCJPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:41:40 -0400
Received: by mail-vs1-f68.google.com with SMTP id u24so8672243vso.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qC62IIKhW9YMr17j8xvm6h6ivRNlHnarpiL0rd3uVKU=;
        b=kvg/jmDC2+FQKCGTxQeEEU6eDVxiDOfi+PHdpb9F44rCDr3iDuhTLKJW1jaTOnoQmE
         w/t7XbVm8bSJu3rJ8x5P6tq6so2jy3ND0Ky5r+nu+Yko4oCB+17s6NFbxoT7+buPLybU
         fktRZY1HUG0Z/x19Mz3x9kUDjs3J5CAFqEgbmx5CzZigtEo6kJF0FSgmgqfCHeh4qgUx
         9wct/UW9csPIXWs9aOrfVews9WbHFSUxPTHHB0lsICKhNACIQHwQ86Wr+yK4lKZS5iSv
         /YRWmjUpWMkrNuOhodF6/HEr02KbVE733HicXMQwZu2lKcaNdJx2WG0Kw4gOxHr1nq7a
         E9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qC62IIKhW9YMr17j8xvm6h6ivRNlHnarpiL0rd3uVKU=;
        b=WQ92nvK90FAKwTzZHronABb7dq51htxJYMRImAdeKTcHfWFAjOO5p+w3zdXBOG4v+p
         hgxDrcobNcx0iDzjN0PKnK+Pk8yifX3RMsfCzAr/JAK5+yeEIm+rPok3dm8XElXw550K
         Qis+gcLzdQj2d1EOZxmde3IqPi+RafC7hs2Xw4X5KtfDNRgPMBJHpPMcC2S/ywxMpzmB
         c/N7uWVIj6fNFnImMI4B1t0ChyXYa0sfMrRFOQhHeVJXATfgDKlLSnp7SCJMq5WX72aL
         1apFvaoPAMhCMVMZz+uEzLXdeKj1Pd7aUbfXj+L3Yg0JHWhuaEkyGkOteOfXRj8qQW2m
         m2eA==
X-Gm-Message-State: ANhLgQ0ZZX9C2YLga6wC/ca3gKJFt5QKCvR/hS1uk8U4zgdxioxzedCW
        KKu7gREqZEIqHnGUHFihCHiVc7ls7dF+nLb0cVX3XQ==
X-Google-Smtp-Source: ADFU+vvRHRssKbGiLu9InPmubuJ6G49Iyj1Gxm04bT4kJkzS/p9pec09o3Xxoe47Pgqc689j19eURg2PLSNAEoxYkK4=
X-Received: by 2002:a05:6102:2051:: with SMTP id q17mr8378399vsr.165.1583854899378;
 Tue, 10 Mar 2020 08:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200212024220.GA32111@seokyung-mobl1> <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
 <BYAPR11MB269638142E2BF2C6E108B40A9CE20@BYAPR11MB2696.namprd11.prod.outlook.com>
 <CAPDyKFr=hE6diZmaVy-os3rFScHe+8OphBS+edkVGK+Z-J_=HA@mail.gmail.com>
 <BYAPR11MB2696D160D6F5B7C98E0503E79CFF0@BYAPR11MB2696.namprd11.prod.outlook.com>
 <CAPDyKFqqDWMsHEb493p__FNzYaEzE6Ry0bkd-2ng7cdM886zjw@mail.gmail.com> <5f3b8cb9-5e55-ee47-46e5-af019d6328b6@intel.com>
In-Reply-To: <5f3b8cb9-5e55-ee47-46e5-af019d6328b6@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Mar 2020 16:41:02 +0100
Message-ID: <CAPDyKFosrju6y5mOKePsNwqgDr=QeBozFTrWKz4MNpsMmeZdCA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Seo, Kyungmin" <kyungmin.seo@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 at 11:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 10/03/20 11:05 am, Ulf Hansson wrote:
> > On Tue, 10 Mar 2020 at 05:28, Seo, Kyungmin <kyungmin.seo@intel.com> wrote:
> >>
> >> I read the link and patch of Chaotian Jing.
> >> I also point out what Chaotian said.
> >> Most host controllers have DLL tuning values for each mode. When host controller is set as HS400 mode with 50MHz clock, host controller uses DLL value which is tuned with 200MHz clock.
> >>
> >> If DLL value in HS400 mode doesn't have the pass range in HS mode, command transfer failing may fail.
> >> In order to make robust sdhci driver, I think the patch needs to be considered.
> >
> > I have, but I am not picking it up in its current form.
> >
> >> Of course, CMD6 with HS400 mode and 200MHz clock should not cause any problem because it's correct configuration.
> >
> > Yes, but not for all cases, as I said in my reply in those email-threads.
> >
> > What I had in mind, is that I I think we should inform
> > mmc_hs400_to_hs200() about under what situation it's getting called.
> > Depending on that, we should either decrease the clock rate before or
> > after we send the CMD6.
> >
> > Would that work for your case?
>
> Ulf, would you consider a new call back e.g.

That could work, but I am not sure what's best, honestly.

The problem may be generic or it could be specific to some host
controller? I think we need to answer that question first.

What do you think?

Br
Uffe

>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c2abd417a84a..1bc18fe2632f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1237,7 +1237,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>
>         /* Reduce frequency to HS */
>         max_dtr = card->ext_csd.hs_max_dtr;
> -       mmc_set_clock(host, max_dtr);
> +       if (host->ops->hs400_to_hs200_prep)
> +               host->ops->hs400_to_hs200_prep(host, max_dtr);
> +       else
> +               mmc_set_clock(host, max_dtr);
>
>         /* Switch HS400 to HS DDR */
>         val = EXT_CSD_TIMING_HS;
>
>

[...]

Kind regards
Uffe
