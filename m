Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F21105D70
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 00:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKUXyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 18:54:24 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34564 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:54:23 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so5852691iof.1;
        Thu, 21 Nov 2019 15:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyapT21g2Wp2Czfv/8wlid7Ppv2pGmOS7MkDneciDk0=;
        b=Dhr8OW0+rXQ6hfoqwiFwuU2MXAN3Q9p9W3C8xMAP2hmHwpRF6mCcVE902BWmQcatrg
         6w6Fa0+61ptq/6uzMmP07QH8PnaX9pUhcAB7Vo+dFyi+k/EaoHlQpXf6eZojJcB3vCvM
         lpyAgiMpwpPScj9AJOAbuNBdLGBtdeBhTvwR284NyiSnuI1s/igjIhjp1UvlHK+kV++V
         LDAWfNTSvlj/9ytLJyK9ZsylPZR1E47ndFxQGsSp3YZQ2ni9oqVfCT7AQ+ZPmkBwKqEU
         7/XsAAYZo9/s8yE4cAO090hpVSft7MYF0ZCrvSsq7ADyqmV33tNXlIUNrtJnZF4/dUDL
         AUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyapT21g2Wp2Czfv/8wlid7Ppv2pGmOS7MkDneciDk0=;
        b=dGYGrJe7IYkS9KoLfWRrrsh6XQwliHQCyENEXET6I3Y2OXkIX5O3qwRW+hViI9ByX3
         wZFT8ZxktKJMtVxLjLo0cbwe8R34QENlqAqFIb/7j0EE0ta69ijlSML1wzFoMMw5KSTP
         GtlrkVGFavocFISlKXPt7cQDsxDNPuXu8ttm/rRFQTctsA9Qo5DsldqOMpNv+4GMJnOC
         buqPbtk2/1pDatiji4rT7lx3VHwgCwhSpy1Q9U9vNsKb5+NLsXERnDmiki22KY4Zx1xe
         C/todbzAyXU1xf/IevP0NUtBYceOc0lR8A253UgyHZvSi4M9wUcU8+zgUNpKe5DMdHFc
         GPKQ==
X-Gm-Message-State: APjAAAVUOY8Fs44whyhYmioas917QJXEzKXjzHPLGO8oGJPU9cn5t+yE
        YU+gLryjczaORiYwnVZlcDjhKB+VKQpqj0hSzBsA1zdx
X-Google-Smtp-Source: APXvYqzG6egS8+w1Kq3TxJBXfd2WNTwoJ/dmy4k1vmmgzoH2WGd8f5qke4NYjuXLMeERbYgmQ4yolyt5NV6VWaVyJV8=
X-Received: by 2002:a6b:7614:: with SMTP id g20mr8134308iom.294.1574380462584;
 Thu, 21 Nov 2019 15:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20190917033124.1077-1-navid.emamdoost@gmail.com>
 <CAEkB2EQTO3wtCrZgLv068xGpxJYwir_SuMUBK0jGaTU6KdCRNg@mail.gmail.com> <20191121233535.GW18024@yoga>
In-Reply-To: <20191121233535.GW18024@yoga>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Thu, 21 Nov 2019 17:54:11 -0600
Message-ID: <CAEkB2ERykJBh0V7vVVUtBT-yXpdvNap_NTAEuShDBb+hX69ObA@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: char: release allocated memory
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the update.

On Thu, Nov 21, 2019 at 5:35 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 21 Nov 10:20 PST 2019, Navid Emamdoost wrote:
>
> > On Mon, Sep 16, 2019 at 10:31 PM Navid Emamdoost
> > <navid.emamdoost@gmail.com> wrote:
> > >
> > > In rpmsg_eptdev_write_iter, if copy_from_iter_full fails the allocated
> > > buffer needs to be released.
> > >
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> >
> > Would you please review this patch?
> >
>
> I'm sorry, I must have missed to reply as I applied the patch. You can
> find it in the rpmsg-next branch [1] and it will be part of the pull
> request for v5.5
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git/log/?h=rpmsg-next
>
> Regards,
> Bjorn
>
> > Thank you,
> >
> > > ---
> > >  drivers/rpmsg/rpmsg_char.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> > > index eea5ebbb5119..c655074c07c2 100644
> > > --- a/drivers/rpmsg/rpmsg_char.c
> > > +++ b/drivers/rpmsg/rpmsg_char.c
> > > @@ -227,8 +227,10 @@ static ssize_t rpmsg_eptdev_write_iter(struct kiocb *iocb,
> > >         if (!kbuf)
> > >                 return -ENOMEM;
> > >
> > > -       if (!copy_from_iter_full(kbuf, len, from))
> > > -               return -EFAULT;
> > > +       if (!copy_from_iter_full(kbuf, len, from)) {
> > > +               ret = -EFAULT;
> > > +               goto free_kbuf;
> > > +       }
> > >
> > >         if (mutex_lock_interruptible(&eptdev->ept_lock)) {
> > >                 ret = -ERESTARTSYS;
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > Navid.



-- 
Navid.
