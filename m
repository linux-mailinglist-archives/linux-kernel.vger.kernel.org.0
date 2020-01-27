Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E842B14AB2E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 21:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA0UgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 15:36:09 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43534 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgA0UgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:36:09 -0500
Received: by mail-qk1-f196.google.com with SMTP id j20so11020491qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 12:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jeIUpeh4Yswut4pRuWFrQhyeR8XRgwbORCyDxrSirrg=;
        b=GA1c4pctZziuKzjHaqUbZw8CZ7cznKcz/Djo1odwjZqRlUv50//rv8QeQKG8mm85vV
         xLDbdnsvXQxjrFOiz8GonJ6dTlUE/ONpuLmoD4K4CE5a18hHoAfAj2S/HkbCHhdRGjqU
         FDtLmECGn9MFWyLbsl1Xebva5+jFkZZRl+6zG7z3JECsHa0OenDd1tyW6fEH/+OUh0DI
         nqborKFlY4OJFFEgaQNOQbIVs1/yerR7ldDPBx9l2GQuzG9FRa2GDGJTjPcQD0AEnfig
         wOBWMpaCe0iRVlFMn61KkmVottLUe/ctdEbcl0RFjwoIe6fLsK2KZWvBVbAjKmsOtaUo
         XfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jeIUpeh4Yswut4pRuWFrQhyeR8XRgwbORCyDxrSirrg=;
        b=NAY32eR7dEFeYiWChvjUxzd8Cg0RK987Tvl+JvYyrcQIhpDUDs/5XV14x8xRAL3jr3
         0t4iK+OEl0B7sluk0eQZjVu5JWbUZpE+tuMxeB0sPbjckC5M8zbOu48PoVG+5fRwBst/
         bgpqFqFWYwoidzcJYQE9XWbsaeRHeNty7Egk9T/Nb2IIvygw3PjK/okzMGsrSYBDJ62Y
         q5Ptr2LSUMfOYO4CZwlLW1jHO6IbiDxunvYmyGgknP8nnlADh9qSpXssWL+aBVjCmDRE
         Kp+s9bDJm8+7oX84cCvrqHtwNmEWFMp6Oys609iKVi80cPrhznrRavGT8FO3wcj0sa6h
         Iw/g==
X-Gm-Message-State: APjAAAUL8crR7PhzqHjVnwuFkaAj6A3XSHy6nuIaYPUJ7mhX6lqlk8Vs
        6kP29ESXr2Qr36vjDl6t+YaoLFYSxD/boV4m/51SObur
X-Google-Smtp-Source: APXvYqw7ABIomcTod01LEWiv36/B+eHKp6E58DE3Jyq2CkSUUGJl+Hodd9V6tK4HbI4brmheCQJUKcjUmPLs8Sgo0tM=
X-Received: by 2002:ae9:ef06:: with SMTP id d6mr18010698qkg.402.1580157368184;
 Mon, 27 Jan 2020 12:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20200125012105.59903-1-pmalani@chromium.org> <20200125012105.59903-2-pmalani@chromium.org>
 <feb0ef4d-0f03-9bbc-807e-c385c03ffa71@collabora.com> <CACeCKae4O+MKx3COh=u=28tk21rb4BrzFZgYpnc=tRkigqSP5Q@mail.gmail.com>
In-Reply-To: <CACeCKae4O+MKx3COh=u=28tk21rb4BrzFZgYpnc=tRkigqSP5Q@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 27 Jan 2020 21:35:56 +0100
Message-ID: <CAFqH_51agDMFV0xBU_63176TYq0Es0FkCBzBZFoyoCUjwHMSxg@mail.gmail.com>
Subject: Re: [PATCH 1/4] platform/chrome: Add EC command msg wrapper
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Missatge de Prashant Malani <pmalani@chromium.org> del dia dl., 27 de
gen. 2020 a les 18:13:
>
> Hi Enric,
>
> On Mon, Jan 27, 2020 at 7:29 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi Prashant,
> >
> > Many thanks for this patch.
> >
> > On 25/1/20 2:21, Prashant Malani wrote:
> > > Many callers of cros_ec_cmd_xfer_status() use a similar set up of
> > > allocating and filling a message buffer and then copying any received
> > > data to a target buffer.
> > >
> >
> > cros_ec_cmd_xfer_status is already a wrapper, I dislike the idea of having three
> > ways to do the same (cros_ec_cmd_xfer, cros_ec_cmd_xfer_status and this new
> > one). I like the idea of have a wrapper that embeds the message allocation but
> > we should not confuse users with different calls that does the same.
> Yes, my intention was to eventually replace all the xfer_status()
> call-sites to use the new wrapper, and then get rid of xfer_status
> completely.
> >
> > So, I am for a change like this but I'd like to have all the users calling the
> > same wrapper (unless there is a good reason to not use it). A proposed roadmap
> > (to be discussed) for this would be.
> >
> > 1. Replace all the remaining "cros_ec_cmd_xfer" calls with
> > "cros_ec_cmd_xfer_status".
> > 2. Modify cros_ec_cmd_xfer_status to embed the message allocation.
>
> How about the following alteration the the roadmap:
> - Introducing the new wrapper.
> - Replacing all remaining cros_ec_cmd_xfer/cros_ec_cmd_xfer_status to
> use the new wrapper.
> - Deleting cros_ec_cmd_xfer and cros_ec_cmd_xfer_status ?
> My thinking is that this would mean fewer changes at the call-sites
> compared to the original roadmap (in the original roadmap, one would
> first have to modify calls to use cros_ec_cmd_xfer_status(), and then
> modify them again when cros_ec_cmd_xfer_status() itself is modified to
> include message allocation).
>

Sounds like we have a plan, looks good to me.

Cheers,
 Enric

> That said I don't have any strong preference, so either would work.
>
> Best regards,
> >
> > Thanks,
> >  Enric
> >
> >
> > > Create a utility function that performs this setup so that callers can
> > > use this function instead.
> > >
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >  drivers/platform/chrome/cros_ec_proto.c     | 53 +++++++++++++++++++++
> > >  include/linux/platform_data/cros_ec_proto.h |  5 ++
> > >  2 files changed, 58 insertions(+)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > > index da1b1c4504333..8ef3b7d27d260 100644
> > > --- a/drivers/platform/chrome/cros_ec_proto.c
> > > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > > @@ -5,6 +5,7 @@
> > >
> > >  #include <linux/delay.h>
> > >  #include <linux/device.h>
> > > +#include <linux/mfd/cros_ec.h>
> > >  #include <linux/module.h>
> > >  #include <linux/platform_data/cros_ec_commands.h>
> > >  #include <linux/platform_data/cros_ec_proto.h>
> > > @@ -570,6 +571,58 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> > >  }
> > >  EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
> > >
> > > +/**
> > > + * cros_ec_send_cmd_msg() - Utility function to send commands to ChromeOS EC.
> > > + * @ec: EC device struct.
> > > + * @version: Command version number (often 0).
> > > + * @command: Command ID including offset.
> > > + * @outdata: Data to be sent to the EC.
> > > + * @outsize: Size of the &outdata buffer.
> > > + * @indata: Data to be received from the EC.
> > > + * @insize: Size of the &indata buffer.
> > > + *
> > > + * This function is a wrapper around &cros_ec_cmd_xfer_status, and performs
> > > + * some of the common work involved with sending a command to the EC. This
> > > + * includes allocating and filling up a &struct cros_ec_command message buffer,
> > > + * and copying the received data to another buffer.
> > > + *
> > > + * Return: The number of bytes transferred on success or negative error code.
> > > + */
> > > +int cros_ec_send_cmd_msg(struct cros_ec_device *ec, unsigned int version,
> > > +                      unsigned int command, void *outdata,
> > > +                      unsigned int outsize, void *indata,
> > > +                      unsigned int insize)
> > > +{
> > > +     struct cros_ec_command *msg;
> > > +     int ret;
> > > +
> > > +     msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> > > +     if (!msg)
> > > +             return -ENOMEM;
> > > +
> > > +     msg->version = version;
> > > +     msg->command = command;
> > > +     msg->outsize = outsize;
> > > +     msg->insize = insize;
> > > +
> > > +     if (outdata && outsize > 0)
> > > +             memcpy(msg->data, outdata, outsize);
> > > +
> > > +     ret = cros_ec_cmd_xfer_status(ec, msg);
> > > +     if (ret < 0) {
> > > +             dev_warn(ec->dev, "Command failed: %d\n", msg->result);
> > > +             goto cleanup;
> > > +     }
> > > +
> > > +     if (insize)
> > > +             memcpy(indata, msg->data, insize);
> > > +
> > > +cleanup:
> > > +     kfree(msg);
> > > +     return ret;
> > > +}
> > > +EXPORT_SYMBOL(cros_ec_send_cmd_msg);
> > > +
> > >  static int get_next_event_xfer(struct cros_ec_device *ec_dev,
> > >                              struct cros_ec_command *msg,
> > >                              struct ec_response_get_next_event_v1 *event,
> > > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > > index 30098a5515231..166ce26bdd79e 100644
> > > --- a/include/linux/platform_data/cros_ec_proto.h
> > > +++ b/include/linux/platform_data/cros_ec_proto.h
> > > @@ -201,6 +201,11 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> > >  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> > >                           struct cros_ec_command *msg);
> > >
> > > +int cros_ec_send_cmd_msg(struct cros_ec_device *ec_dev, unsigned int version,
> > > +                      unsigned int command, void *outdata,
> > > +                      unsigned int outsize, void *indata,
> > > +                      unsigned int insize);
> > > +
> > >  int cros_ec_register(struct cros_ec_device *ec_dev);
> > >
> > >  int cros_ec_unregister(struct cros_ec_device *ec_dev);
> > >
