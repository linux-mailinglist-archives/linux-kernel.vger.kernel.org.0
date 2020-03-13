Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12DC184A11
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgCMO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 10:56:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37979 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:56:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so4362588plz.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6VRmjxt/RLuEV3vnRanaLSMonZS+QrB7w914S386sk=;
        b=cx2qTH6sC970pnUA6vaQYxDBliAsFLKpx5jgY/1l7mE1/koc3rjku94As1o/Q1Giwc
         lh5Ov0bnx2tmzuty4qSKnHAhRLLijzBjLNbfd92vBUi+Xo7SYQq5nLEu5pgYvkQQooir
         oDAN6iKicD+pDQoGrYezZSUB72PeP0bHomMLvT5TVYJL5ZAK5dLeSAL2MKOAJDcSyDlb
         8F/+0XzLtjTWok0EoOeCCPMzMXcLjWsL8yuMLkIueMfM1vW0xVizPRB25FIiBz/DHe7M
         vf0nPC0/NxdiKx8RYjo11F2plWtpyA7aS2UTtn5PCKUIM5P96c+XNiFwvXayVNkWUQco
         D5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6VRmjxt/RLuEV3vnRanaLSMonZS+QrB7w914S386sk=;
        b=qtdJ5pY+gOgC4D+W/3wrLncgHsHO+6be6q9KdOkwCsBYQ+pCa+jtjXfVbiwj7w3jzS
         stcUm+6U9O0fgZ+BfFCFAA96xbuYhEgap6meQrfXsAkajZpPMthHZvXAdk1pMIJ7qtbw
         Sry6lZqt2emIBV+3y0Tkhr7j2MN62SSEenqMLy6Wb6chwJ8TQSHVQq20Dc6ZxyoqA/fH
         jRruj7o5suwIBg9zKf0mEX9JS5RGvrGcmG78mxvbMKfMUMq8BakC66nULl9BAGyV6p4h
         eReB9z6lTvsMSwriusYp1kwj7wWGNLnEk1wxCEUEcPOfPTThJk41uzR/ZioIYksvWFrg
         MOLg==
X-Gm-Message-State: ANhLgQ3LesKn188RpVG+eHzNbTM2lSr/H8wyX0z8CTzNMPqBjgPE3PiN
        enMxKBg6S2zX3KdkekAmojGwfJWJ42dM8T8WSytzYQ==
X-Google-Smtp-Source: ADFU+vuhhw0Ig3FeJf7sHNwTyURe80VBP0AJ5DzMG6Pzz6M4bqpHJu5itSRP30AMNbYDh7Ql5moWNWo2vTsmwOM/MPc=
X-Received: by 2002:a17:902:8492:: with SMTP id c18mr14107191plo.147.1584111406059;
 Fri, 13 Mar 2020 07:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583778264.git.andreyknvl@google.com> <32bce32c8b88c2f88cd0a8acfcdb5d3a6e894632.1583778264.git.andreyknvl@google.com>
 <20200312093920.GD14625@b29397-desktop>
In-Reply-To: <20200312093920.GD14625@b29397-desktop>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 13 Mar 2020 15:56:35 +0100
Message-ID: <CAAeHK+yuEPcCqQ=N7BLTkohXkDUnXjFb=Kfb6R663LLe=moG6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] usb: core: kcov: collect coverage from usb
 complete callback
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:39 AM Peter Chen <peter.chen@nxp.com> wrote:
>
> On 20-03-09 19:27:06, Andrey Konovalov wrote:
> > This patch adds kcov_remote_start/stop() callbacks around the urb
> > complete() callback that is executed in softirq context when dummy_hcd
> > is in use. As the result, kcov can be used to collect coverage from those
> > those callbacks, which is used to facilitate coverage-guided fuzzing with
>
> Typo, One more "those"

Will fix in v3, thanks Peter!

>
> Peter
>
> > syzkaller.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  drivers/usb/core/hcd.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index aa45840d8273..de624c47e190 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/types.h>
> >  #include <linux/genalloc.h>
> >  #include <linux/io.h>
> > +#include <linux/kcov.h>
> >
> >  #include <linux/phy/phy.h>
> >  #include <linux/usb.h>
> > @@ -1645,7 +1646,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
> >
> >       /* pass ownership to the completion handler */
> >       urb->status = status;
> > +     kcov_remote_start_usb((u64)urb->dev->bus->busnum);
> >       urb->complete(urb);
> > +     kcov_remote_stop();
> >
> >       usb_anchor_resume_wakeups(anchor);
> >       atomic_dec(&urb->use_count);
> > --
> > 2.25.1.481.gfbce0eb801-goog
> >
>
> --
>
> Thanks,
> Peter Chen
