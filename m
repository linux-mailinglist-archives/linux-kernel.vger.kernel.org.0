Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CDF10CFED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 00:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfK1XNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 18:13:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32884 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfK1XN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 18:13:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id d6so21173929lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 15:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsTwhFwKQ/dPIkHx6bZaD64lIEnLpBlz/is03aIxIEk=;
        b=GfaaUJ/y2wIh9Btfh7s7HvF4gJTZNFXxrYsCSzKDghMVl1qgaNy9S6pPuXbb0i0tSI
         xNr72FY/qlASeGXTClNVcHWcU8X1YIsKClalUhtYD4HKbK1X1nAYiQLcyzzZzuCEVih3
         V/kUrhfFsFXPxqG0m6O+dqy8/gNuvB6UYYdl+1q/Ka6cXzU4N1q3iF7XgM01Vw44kg28
         fzY425WA5Vnv6J0vTRozNSmZbgVqj2wzKhwWQbxyVx+NCObNFyTUPetc1nienr5aHbw8
         zZbWrB8xU8PKTZku7yQ0W7TyfLaTJgdXv4r9srzJaXPpkSTuYhRn8PcbM6FSzQk2FVUe
         ef4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsTwhFwKQ/dPIkHx6bZaD64lIEnLpBlz/is03aIxIEk=;
        b=OjXM+lA3MdHDEz+3KL79b30f3Mmbn4TtAO3OkK2pyQAWnGpY28gPUJ+s13Sz/9HfSY
         on494MENvrbXVsYexMzCibKOyPGDdoQ/NUrCvV+U6EkWzhtN2qnykTLzMmH7KVHqURGP
         kkN+xF5Ul3NNhr8NClztXyW6wAzs/6EWt/eXKHfsvd5pbp5VVX/m3LjN27yDQh92ifzx
         bVTgOGROSICS9HqsI8CZRQcgfBuBq0qRUb6izVNbAPeUi6em3HajR9N7LawNBV94Lczy
         zZ/gA5nrhOKuL2n2ZQSFE+Z1czb+ClemxZ4GylvVBRWDa5bs70svwjYaCBKnhxXXA5ml
         8S0A==
X-Gm-Message-State: APjAAAVE62CJ1gNEuXGOoi4Wvr+TSaprnXBlWlD7gl4gYX8HF/tfxc0O
        JISO7+PqywP85gXSCc6tigg/LMs9fytSv6fbK5w=
X-Google-Smtp-Source: APXvYqynSnsQwmBCmzDKq2Z+bZR37xEFqy+9Z2KCtDRSXoKnzhC/sTDTWcQr/QC83NqPA9AKm4bgRnYplHceWA8Nt90=
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr18394485lfi.98.1574982807332;
 Thu, 28 Nov 2019 15:13:27 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9ty6MLNc4qYKOAO3-eFDpQtm9hGPg9hPQOm4iRg_8MkmNw@mail.gmail.com>
 <CAHk-=whdhd69G1AiYTQKSB-RApOVbmzmAzO=+oW+yHO-NXLhkQ@mail.gmail.com>
 <CAPM=9tz3pFTOO45pGcZv+nGf29He-p03fXHbG4sNoCYxZzXkRQ@mail.gmail.com> <20191129085502.3e9ffed4@canb.auug.org.au>
In-Reply-To: <20191129085502.3e9ffed4@canb.auug.org.au>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 Nov 2019 09:13:16 +1000
Message-ID: <CAPM=9txFZ+sCXXV3WA0CtFjsmLrY7qziJqrGfr1h+5B-fsqWRA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.5-rc1
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2019 at 07:55, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dave,
>
> On Thu, 28 Nov 2019 12:37:06 +1000 Dave Airlie <airlied@gmail.com> wrote:
> >
> > > And apparently nobody bothered to tell me about the semantic conflict
> > > with the media tree due to the changed calling convention of
> > > cec_notifier_cec_adap_unregister(). Didn't that show up in linux-next?
> >
> > I can see no mention of it, I've got
> >
> > Hans saying
> >
> > "This will only be a problem if a new CEC adapter driver is added to the media
> > subsystem for v5.5, but I am not aware of any plans for that." when I
> > landed that
> > in my tree, but I assume the ao-cec change in the media tree collided with it.
> >
> > But I hadn't seen any mention of it from -next before you mentioned it now.
>
> See https://lore.kernel.org/lkml/20191014111225.66b36035@canb.auug.org.au/

Indeed, the misc team didn't remention that to me, when I pulled their
tree, perhaps I should make them do so, not sure why my search
yesterday failed to find this in my inbox.

Thanks,
Dave.
