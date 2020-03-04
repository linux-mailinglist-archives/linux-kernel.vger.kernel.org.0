Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B39AC1786C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 00:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgCCX7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 18:59:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41199 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgCCX7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:59:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id y17so4301838lfe.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 15:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ep7YwJ1cSlx/EG1MvH0nW0IG2SdE9N1g2AvP7NSxP1Q=;
        b=jCHZxkkoQbFtzw3oJIeqzx3ybE1ypCB/gQqxwJX7mDyeDnNo2othEGc6L7RReLgt6f
         E7wyMQE8emqs/hMxJNkC0eowip7GM2a77vD4uT6RSzEYmb4mCTCqFqb0LAURWhyIm0rR
         fK42QAAQoFwrVIlXuZnjo1RLe2YDU2CZtGlzykpN7Gm5N0AXDsA6Wzz2PIu6cOY+mkow
         p96sjfsjOGC9ncXpvwTSKcEctrDMm9kg2wtRF4bClgZEkH/GcDe01WRwFph1VpD2ggKg
         b1YKHsP1W4ObjWXdfesX8kriJlidMsuO+BIfvrAiLG+JV8V56oQ4yT67AEoXku+9m35J
         fzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ep7YwJ1cSlx/EG1MvH0nW0IG2SdE9N1g2AvP7NSxP1Q=;
        b=CD0pBCkSLsCrsjZDnnBKZ5ZRpMN4vafqsWl/HPf9Q7XQTPsV2kOM0cMEikeSo2fqcd
         ICAlaiIrTVeS2q6z6gKEviJ5c9uKuYTCXhj0gsNFGmIHHHjs9dRYpbZbqDZESFjCP+K4
         QBG/SFZjuDtuzSdsIiuDpbaocONmV4unynN84cveo7SvqHYjfMRn5puc7yF4Vbsp5MFt
         2cCP2FOPIOgZGcwuJi3uJlO4ozgf47vM7xPBfpJ9DR00NG+pdttyD2zr+WoCnYXTLJR4
         ucA2WCdU0MBmMiznvXXCKSsA5XWa7m6g6aNGnjGolba9ptGML7QE0krKxeaNd1nGW0G3
         cUwQ==
X-Gm-Message-State: ANhLgQ1g3RwSuaT1IiyUfBlqbHLEpRKIcay5CrXgrvkOuRIOv4EDgnKq
        lGIGl+6akbuGJ7ueh1VlepRyw2xFo2kn+fnPyRLawKefkMQ=
X-Google-Smtp-Source: ADFU+vsYdW1PWvdtTgFwZdS0gcHuzS2Ejh4OwwOiq2uZGhxcRiL165XFJD8NN5wd2hf6HXHJ7Ikk/4Cf5nRu7kPpYg0=
X-Received: by 2002:ac2:5f7c:: with SMTP id c28mr248231lfc.204.1583279978879;
 Tue, 03 Mar 2020 15:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20200303005645.237763-1-rajatja@google.com> <fe4e0010826d4d18843b148dc088c2b01c7e2072.camel@hadess.net>
In-Reply-To: <fe4e0010826d4d18843b148dc088c2b01c7e2072.camel@hadess.net>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 3 Mar 2020 15:59:02 -0800
Message-ID: <CACK8Z6HFC6Vx8NcnZ1Hi7btxdEpsNjumWTyDkufVMtOunOPjuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: Add keycodes for keyboard backlight control
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 12:15 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Mon, 2020-03-02 at 16:56 -0800, Rajat Jain wrote:
> > New keyboards can have backlight control keys. Allocating keycodes
> > for them. Such keyboards are already available in ChromeOS.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  include/uapi/linux/input-event-codes.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/uapi/linux/input-event-codes.h
> > b/include/uapi/linux/input-event-codes.h
> > index 0f1db1cccc3fd..e12a19dc30262 100644
> > --- a/include/uapi/linux/input-event-codes.h
> > +++ b/include/uapi/linux/input-event-codes.h
> > @@ -652,6 +652,10 @@
> >  /* Electronic privacy screen control */
> >  #define KEY_PRIVACY_SCREEN_TOGGLE    0x279
> >
> > +/* Keyboard Backlight control */
> > +#define KEY_KBD_BKLIGHT_UP              0x280
> > +#define KEY_KBD_BKLIGHT_DOWN            0x281
>
> There's already KEY_KBDILLUMDOWN and KEY_KBDILLUMUP, used since the
> aluminium PowerBook G4 in 2005 (commit
> 146a4b3bdfb5641bfbf975e29680b482b8b343ba)

Thank you for pointing out. Yes, I think those key codes will work for
me. I will use those instead.

Please consider this patch withdrawn.

Thanks & Best Regards,

Rajat Jain

>
> > +
> >  /*
> >   * Some keyboards have keys which do not have a defined meaning,
> > these keys
> >   * are intended to be programmed / bound to macros by the user. For
> > most
>
