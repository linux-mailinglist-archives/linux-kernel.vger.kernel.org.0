Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE17A842
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 14:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfG3MZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 08:25:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33510 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbfG3MZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:25:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id r6so58534480qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vg24wzBIc+D+Hmv+R1GPqhgrmLOPVkmrpAuvjDtlIDU=;
        b=HTYpVHgcKfw3qjT7bgNIzF/J064+hCL62azBCtPvqrMGTRWJRTfa6OmXjl5UGTjfUB
         TAYx0n8THuIxaZ2BHWbEem7UeZRBj7KdlVi5MX5ukq0sXke3CfqEKyKL7LeRA3aj7clv
         kzSjyme9g1lpQfunxAWBWySJihV45rpoRFczqTwhzUKluKi3Y1YE6MUDUnxc1fHepAuw
         ycH4PXHjWBkG1fu5qYxoEgtcq+YC0PYytoJsB1YFkCq4hiG3mOuYa2FSrk8mJgm2oWYt
         VmLYEc59uDmG57w43gtvWdWmQFUt+HVPPAzV0+Tc94eZExyo4bWpje0VAxfmmj8Is1Gy
         lM6w==
X-Gm-Message-State: APjAAAVbxBNyGD9pfU9i8c6L6kjo4yuTSUEJq+U9KuzJpPF3UljuaLYa
        UIndKqTnVJVOTzDeAiJ+9pHxPOCou8LRJlo9RyM=
X-Google-Smtp-Source: APXvYqzfoZoBuiAjwAqXgbVNXXKwoEiH6dY5V72EFZ3ka6brjjn9cMP5XNNFWJ1mx1f3K5mwNQb5H6XBvPEoDQjUWN0=
X-Received: by 2002:a0c:ba2c:: with SMTP id w44mr81948752qvf.62.1564489499864;
 Tue, 30 Jul 2019 05:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3jjDh6aEVf0bBFYc=8GtB38kL6sWVZGJiUe427A7m2ng@mail.gmail.com>
In-Reply-To: <CAK8P3a3jjDh6aEVf0bBFYc=8GtB38kL6sWVZGJiUe427A7m2ng@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 14:24:43 +0200
Message-ID: <CAK8P3a1i3fV_qzx_q6nucqh4aNLi0a+iwvcis9BpYfMOkoew8Q@mail.gmail.com>
Subject: Re: RFC: remove Nuvoton w90x900/nuc900 platform?
To:     Wan ZongShun <mcuos.com@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 2:09 PM Mail Delivery Subsystem
<mailer-daemon@googlemail.com> wrote:
> On Tue, Jul 30, 2019 at 2:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > As the mach-netx and mach-8695 platforms are being removed now,
> > I wonder whether we should do the same with w90x00: Here is what
> > I found after looking at the git history and external material for it.
> >
> >     - The supported chips (nuc910/950/960) are no longer marketed
> >       by the manufacturer
> >
> >     - Newer chips from the same family (nuc97x, nuc980, n329x)
> >       that are still marketed have Linux BSPs but those were never
> >       submitted for upstream inclusion.
> >
> >     - Wan ZongShun is listed as maintainer, but the last patch he wrote
> >       was in 2011.
> >
> >     - All patches to w90x900 platform specific files afterwards
> >       are cleanups that were apparently done without access to
> >       test hardware.
> >
> >     - The http://www.mcuos.com/ website listed in the MAINTAINERS
> >        file is no longer reachable.
>
> Recipient inbox full
>
> Your message couldn't be delivered to mcuos.com@gmail.com. Their inbox is full, or it's getting too much mail right now.

Yes, that too.

        Arnd
