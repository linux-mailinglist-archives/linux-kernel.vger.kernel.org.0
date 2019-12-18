Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052C3124616
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 12:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfLRLs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 06:48:58 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34143 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLRLs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:48:57 -0500
Received: by mail-vs1-f65.google.com with SMTP id g15so1201121vsf.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 03:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1mHuB8yUnmQS9SpnJEkcOHQjoqYysF0srh4TVk8yKQ=;
        b=LsfhdNnomA+RaZ39fgqS0Kqnx6OFiMGTmVA4ehQ0EOYu8i0rslntCqfKIY7CrpQqo8
         HqGKZ1twIJXoKgwNOtSQJq1HL1yu4BwTpMsQc55gl3AbreV4pTzxmBuiwrc6crVj2+0z
         ekCAL5nmr9Q3SRYlkRy4hL77GC8q8UgK1+aGc9oZTPjAS/4mNfVZBEMLtrG+JrLNJcTW
         N2H/Yxt/tPlj9glYmnASKFo7T/V7ImuuBvRQLFQWGIrVPE47ZguZPpZLYNeaOkg1bdId
         BXorMRB6S8WwnyywnTkuYyms4ak0SvxJnzsNyXLThU/1f7lZjqW1a1CEq1i5Eg8XS+8t
         uv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1mHuB8yUnmQS9SpnJEkcOHQjoqYysF0srh4TVk8yKQ=;
        b=hRnl2Va3bC1+KAjl1JKQ3wF2xf6rd+DgGYVrEd14/78gbgEkLDwWoLPdaHsVYbISla
         LRgEloY+L2n8j1UFzIVpVPcW9cfoF9ki7dcu+RP8Y+vyBkitI/Y6clY2G/68tl16V7XW
         rWIncYetgts056sNeZThBWA27dadK6fd6xYsIpn6Kc8nigrJKetqZFs9U+UxcF2oTPW/
         QVidicwPUzp0uNvgecK73HWfSldSqI7ls1p7H6IZprBlekxunugdwQ/aDVgmaepoWnLU
         zyC+OV7MlvWtizqyobmllOol1OdnVOAPQtStVDVpMpT356B4ui4yvmQYcugVbnuQEyXK
         scUw==
X-Gm-Message-State: APjAAAWr+ommPZ8qDT1ZR7/KBlAr7MhMqxcWFRu7p35CH7pnUtBswkeo
        OrNLDfbqFQOZdUEaIh38AugZTm0vAZd2UmgXw/1FQlCD
X-Google-Smtp-Source: APXvYqyH0GBNeyTrGXQVb1OsOS5eB50xXlLvgb2rhAYmaBmDtlHg3pf7emYk+wUfgtEKJoE+sCeQkyONMe1gbqIh4w4=
X-Received: by 2002:a67:b649:: with SMTP id e9mr1082793vsm.34.1576669736873;
 Wed, 18 Dec 2019 03:48:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576540906.git.nguyenb@codeaurora.org> <68b936a67e67cd25597915cbd76b73ed046d1ce4.1576540908.git.nguyenb@codeaurora.org>
 <20191218083448.GE1554871@kroah.com>
In-Reply-To: <20191218083448.GE1554871@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 12:48:20 +0100
Message-ID: <CAPDyKFr2t3w1wXY+DD27vHF23mSjnUwCh7iZyuQ=ua=s+KvyVA@mail.gmail.com>
Subject: Re: [<PATCH v1> 7/9] mmc: core: Skip frequency retries for SDCC slots
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>, cang@codeaurora.org,
        Sujith Reddy Thumma <sthumma@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Xiaonian Wang <xiaonian@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 at 09:34, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 16, 2019 at 06:50:40PM -0800, Bao D. Nguyen wrote:
> > From: Sujith Reddy Thumma <sthumma@codeaurora.org>
> >
> > Qualcomm SDCC controller supports minimum SD clock frequency
> > which is required for card initialization. This information is
> > exported through platform data for each SDCC controller. There is
> > no need of retrying higher frequencies than the minimum supported
> > by controller for Qualcomm chipsets which inturn add delay in
> > detection process if there is no card during suspend/resume cycles.
> > Hence, skip multiple frequency retries.
> >
> > Signed-off-by: Sujith Reddy Thumma <sthumma@codeaurora.org>
> > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> > Signed-off-by: Xiaonian Wang <xiaonian@codeaurora.org>
> > Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> > ---
> >  drivers/mmc/core/core.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 1e37f78..38b0cec 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2281,7 +2281,6 @@ void mmc_rescan(struct work_struct *work)
> >  {
> >       struct mmc_host *host =
> >               container_of(work, struct mmc_host, detect.work);
> > -     int i;
> >
> >       if (host->rescan_disable)
> >               return;
> > @@ -2332,13 +2331,7 @@ void mmc_rescan(struct work_struct *work)
> >               mmc_release_host(host);
> >               goto out;
> >       }
> > -
> > -     for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> > -             if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
> > -                     break;
> > -             if (freqs[i] <= host->f_min)
> > -                     break;
> > -     }
> > +     mmc_rescan_try_freq(host, host->f_min);
>
> What about for non-qualcomm controllers?  Did this just break their
> functionality?

Yes it does, obviously.

Greg, thanks for providing some valuable feedback for Bao for a couple
of the patches in this series.

I have also browsed through the series, but stopped providing feedback
after patch1, when I realized that these are all just downstream
vendor specific hacks.

Sure, I guess most of the patches can be reworked as upstreamable
solutions, but rather than looking at them all at once, please post
them separately. Additionally, in general I would appreciate more
details in the changelogs to fully understand the problems your are
solving.

Kind regards
Uffe
