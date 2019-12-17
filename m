Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10186122962
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 12:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfLQLAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 06:00:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39151 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfLQLAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:00:16 -0500
Received: by mail-qk1-f196.google.com with SMTP id c16so4129444qko.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 03:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mG99GA6/Xiwz9qwjNacdCgRQBNUN/DJm+EdzhM5zdJk=;
        b=ZKi2ffTW6CKhiLlUehhNua4oR+IQVrnfldGgSCvYobXyaxf4QGLMGV1ZZ6p4OBl2tI
         FkPzuoOceoPyusSCU5xvdzfD0Jr7XdnBsgcW7GlTB8qKVhWCSKtCBYlgVotmWsyfUHm2
         GL9Y+50K4eb6Wx3TwS6+mOVTAmbDmPtwNFU0USc1pvW0N98+98OXqgU/O1e0K/WRt0Hj
         q+4ovQ8zbfrAtOkcQotudiZmC2nGxboSBOmLjkpvV5f2Qu9PixHe4hYSngMd6J3ELeNH
         8pgdbSEjSs7FVMvOEIbXJ+gOTGPRFEGOfa1bVyhCWL92V8E5Moi4UQ7aOev0/NGOIhLz
         1ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mG99GA6/Xiwz9qwjNacdCgRQBNUN/DJm+EdzhM5zdJk=;
        b=KY3Oz0qtVg/ZpZywbG+5uUnbQazjKxUbzeqiorNRxJHcooM9Tnom3rPFAHWmje34M1
         YmBD0q1XsQUe3qXeIRePe0zOIeQ6inv0bd0UX4385bbCXYGvMsI+kM9TNIi5PdkRtdfd
         LGznWJEHv4zpxplMFntBi0Lkm++zkAsdt/k7ITVuxveIzoeDCc69AFhqXOuD9J29nTlj
         TjcYqMpcJ31NI4cuECP2bP/pQzFkhnnHnce4TUjNlSaLsYaSqYrLrdaoh8L+d72t5bUw
         ij8z4k3Snl9t1rk4LeM76tCToK3/QfaLxnGgDfYg4i7NoEM4x1WoJ2DsIiAGwd+5KAeu
         a/nw==
X-Gm-Message-State: APjAAAVHaKeOk6NTrZ4m1emDleQRr1O0sq1vwbpafjml41YNFK1VIZ2P
        H6C39z75QBM8e/ngzujehXmN/3FDPl8Nu3+hpZICcQ==
X-Google-Smtp-Source: APXvYqywDIx8QZijrqsCgnbP1i8WSjZej+2z1QKYbvCx4iGWrKY4auHMIOJEyC9uciCsefBQ0G4vqX+E02yg22qADrU=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr4157084qkg.43.1576580415093;
 Tue, 17 Dec 2019 03:00:15 -0800 (PST)
MIME-Version: 1.0
References: <95e7a12ac909e7de584133772efc7ef982a16bbb.1576170740.git.andreyknvl@google.com>
 <Pine.LNX.4.44L0.1912121313030.1352-100000@iolanthe.rowland.org> <CAAeHK+yOBcNz_iopRs6PEu=1-rZn6Gkm+Urq+iVBFQeSjSXqNA@mail.gmail.com>
In-Reply-To: <CAAeHK+yOBcNz_iopRs6PEu=1-rZn6Gkm+Urq+iVBFQeSjSXqNA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Dec 2019 12:00:03 +0100
Message-ID: <CACT4Y+aN20NXxXhe9qv_WRLntAHbL98Shj8NAvg0WafDw8C=jA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] kcov: collect coverage from interrupts
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 1:09 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Thu, Dec 12, 2019 at 7:15 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, 12 Dec 2019, Andrey Konovalov wrote:
> >
> > > This change extends kcov remote coverage support to allow collecting
> > > coverage from interrupts in addition to kernel background threads.
> > >
> > > To collect coverage from code that is executed in interrupt context, a
> > > part of that code has to be annotated with kcov_remote_start/stop() in a
> > > similar way as how it is done for global kernel background threads. Then
> > > the handle used for the annotations has to be passed to the
> > > KCOV_REMOTE_ENABLE ioctl.
> > >
> > > Internally this patch adjusts the __sanitizer_cov_trace_pc() compiler
> > > inserted callback to not bail out when called from interrupt context.
> > > kcov_remote_start/stop() are updated to save/restore the current per
> > > task kcov state in a per-cpu area (in case the interrupt came when the
> > > kernel was already collecting coverage in task context). Coverage from
> > > interrupts is collected into pre-allocated per-cpu areas, whose size is
> > > controlled by the new CONFIG_KCOV_IRQ_AREA_SIZE.
> > >
> > > This patch also cleans up some of kcov debug messages.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> >
> > > diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> > > index 4c9d1e49d5ed..faf84ada71a5 100644
> > > --- a/drivers/usb/gadget/udc/dummy_hcd.c
> > > +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> > > @@ -38,6 +38,7 @@
> > >  #include <linux/usb/gadget.h>
> > >  #include <linux/usb/hcd.h>
> > >  #include <linux/scatterlist.h>
> > > +#include <linux/kcov.h>
> > >
> > >  #include <asm/byteorder.h>
> > >  #include <linux/io.h>
> >
> > That's the only change to this driver.  As such, it doesn't appear to
> > be needed, judging by the patch description.
>
> Right, will fix in the next version, thanks!

Please also post a github or gerrit link. These small scraps of
changes without context and better visualisation are extremely hard to
review meaningfully.
