Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1479418661D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 09:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgCPIIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 04:08:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39298 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgCPIIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:08:32 -0400
Received: by mail-io1-f67.google.com with SMTP id c19so15096397ioo.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4C2QkAKPFn1QPCfwIwQSCmTCJeHSpIXw2b0k4lFrSqw=;
        b=fm03qKP6u2MIv0CLrzY6ofU6yjZHgvQe+TbeLEntGXpI0hO9eXYatpS9h57CEiZIr6
         1ySpUt7WdvD5OnUwPShXMoisuWsd4epIw+0qkyDd/uc0RF8KmlYU3tI8eFCcexvH4rAA
         Eqizgf7FiaTXaWdZ50zDduVks6W5BQE7rxDRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4C2QkAKPFn1QPCfwIwQSCmTCJeHSpIXw2b0k4lFrSqw=;
        b=h7CXSWx9d/6cGQ1s176/bwNsoNSxvIM0a0UvnXa5pWZHxfcsp6EGU7H2BnfsIN/fpq
         itBq7vQwSWhcH3z/7NwrpEpOZAmp2MfdlUdfXEs9uXFA3l8AFG3mY3z10W3XqWQhjSg+
         FPHpFTaMwstGf8AIyLUWgHuBJnuo5Ly34UyhakAm5FoxUsTruvqIGWcCBKSRdJRL5Cic
         FuBrAra7chgcVf6gGDPtarZoLkGoPxsQ2dmpHOGsI8kjRz1/nUr/I2TabeIKJ5mogUp7
         TwsM2ttEpa07cA2/+HS9xof7wP4NIcBdlGPh8iTgxsA7WlC9K6QaVOadlaeqAQ3T7egj
         xtRw==
X-Gm-Message-State: ANhLgQ1+5gKnwmcIDeEotJdIyVRa0JtAkiuHHnsleGemmZq4cDicN1vl
        kH7HOoMHahRyTq0yeTBaTyZgn2EWsKUd4hQYdYIjeg==
X-Google-Smtp-Source: ADFU+vvUoUlnuc+QBhJPp+Zphd2rGyw07LcSM/dHzCQLm0j6Q1O+0HputdWdJU3Z6rEnbvLjs0RfwrkIUSOkBCmF23M=
X-Received: by 2002:a02:3b4a:: with SMTP id i10mr25473277jaf.131.1584346111516;
 Mon, 16 Mar 2020 01:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <5e6afe0d.1c69fb81.25912.f2eb@mx.google.com> <20200315124955.207d515c@archlinux>
In-Reply-To: <20200315124955.207d515c@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 16 Mar 2020 01:08:20 -0700
Message-ID: <CAJCx=gk-oycno_NPtNFAvuX8ibsLEGLq0FrLvfXeaJwuvuTjcg@mail.gmail.com>
Subject: Re: [PATCH] iio: health: max30100: use generic property handler
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        dragos.bogdan@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 5:50 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 13 Mar 2020 08:59:13 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
>
> > Instead of of_property_read_xxx use device_property_read_xxx as it is
> > compatible with ACPI too as opposed to only device tree.
> >
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
>
> Look at how this driver is probing from DT.  There is another thing you need
> to do to make it possible to use PRP001 ACPI based bindings.
>
> (check what Andy Shevchenko did in a similar patch)
>
> I'm being deliberately vague as useful for you to understand what is going
> on here for yourself :)
>
> Also, make sure to check you have cc'd everyone relevant.  Here you are missing
> the driver author. +cc Matt
> Jonathan
>

Highly doubt anyone is using this in an ACPI setting. Am I missing
something though?

- Matt

> > ---
> >  drivers/iio/health/max30100.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> > index 84010501762d..8249c6b36818 100644
> > --- a/drivers/iio/health/max30100.c
> > +++ b/drivers/iio/health/max30100.c
> > @@ -16,7 +16,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/i2c.h>
> >  #include <linux/mutex.h>
> > -#include <linux/of.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/buffer.h>
> > @@ -267,11 +267,10 @@ static int max30100_get_current_idx(unsigned int val, int *reg)
> >  static int max30100_led_init(struct max30100_data *data)
> >  {
> >       struct device *dev = &data->client->dev;
> > -     struct device_node *np = dev->of_node;
> >       unsigned int val[2];
> >       int reg, ret;
> >
> > -     ret = of_property_read_u32_array(np, "maxim,led-current-microamp",
> > +     ret = device_property_read_u32_array(dev, "maxim,led-current-microamp",
> >                                       (unsigned int *) &val, 2);
> >       if (ret) {
> >               /* Default to 24 mA RED LED, 50 mA IR LED */
>
