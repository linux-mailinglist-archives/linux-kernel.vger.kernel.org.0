Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072B014A8BE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 18:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA0RLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 12:11:52 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46747 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0RLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:11:51 -0500
Received: by mail-qk1-f196.google.com with SMTP id g195so10300000qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1WlWU0/0mAGozdKMMszMQsPNvJD5JxxqRdPlFvg8YI=;
        b=HliaSyrTi1mEs7RJIOyREqc6GfovxcHJDRwdHVDsLt6M1BbPEGZS6me7xzIxoaIH6+
         LRhiSVFhh8DZeh/xECM51h6jpYf2k53TDdjlLlL2V4yFXM4O1BZVGsO55cyN8Cph7/pj
         ITj/iFDZiNtdo0SC+YNsTPtsj7qQlExirbsCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1WlWU0/0mAGozdKMMszMQsPNvJD5JxxqRdPlFvg8YI=;
        b=GJ195kdLp6cyzJOfJ4In/aE1HcVPuFlfkxPc1p5in3pPWTSEWCDmve80OmR1GLT3Cc
         c7IPauvnPtCf6KLq/+Oql+QFKSa9qKSl7mlsJkBp06iRSqfF0nNK4o1Fdt0RC52iahcD
         nwVH4PS6kcvF314WdM8xl5LTNIEIaco/0YBdj6gSsnlY3mcb1PVkYjw0fVeDhO0gDdlM
         frYkqc3XxTAqaUUCJcDe9iyEicq4fgEeRxPo3oqXBoR/Aq4GXYAJVVRFY6kPEkoOB/r8
         CLazyK2zXR/sx10TIsdhVs2xUqSkPXzAFzSvKjVjhPKxUFROU7glJ9JDP4ijZYaaCh95
         tThg==
X-Gm-Message-State: APjAAAXdV8RPElYWtXrRUn/MV8Sq4I5maMrHN9HnUdRI5QsHR4LPAkDq
        xNiqdcCg0+PnVyPNMhplx9tp1G9XHTka52NiZzpnBY0C
X-Google-Smtp-Source: APXvYqzmZBcDn+yybd09PYPu0USGydA5dOAJYTRhiyF2lqYF03Dy6NEXa81ASSZRQ7RKN7ezaLkO0A6CEn7L2jw9cCA=
X-Received: by 2002:a37:9186:: with SMTP id t128mr16882009qkd.180.1580145110288;
 Mon, 27 Jan 2020 09:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20200125012105.59903-1-pmalani@chromium.org> <20200125012105.59903-2-pmalani@chromium.org>
 <feb0ef4d-0f03-9bbc-807e-c385c03ffa71@collabora.com>
In-Reply-To: <feb0ef4d-0f03-9bbc-807e-c385c03ffa71@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 27 Jan 2020 09:11:39 -0800
Message-ID: <CACeCKae4O+MKx3COh=u=28tk21rb4BrzFZgYpnc=tRkigqSP5Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] platform/chrome: Add EC command msg wrapper
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Mon, Jan 27, 2020 at 7:29 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> Many thanks for this patch.
>
> On 25/1/20 2:21, Prashant Malani wrote:
> > Many callers of cros_ec_cmd_xfer_status() use a similar set up of
> > allocating and filling a message buffer and then copying any received
> > data to a target buffer.
> >
>
> cros_ec_cmd_xfer_status is already a wrapper, I dislike the idea of having three
> ways to do the same (cros_ec_cmd_xfer, cros_ec_cmd_xfer_status and this new
> one). I like the idea of have a wrapper that embeds the message allocation but
> we should not confuse users with different calls that does the same.
Yes, my intention was to eventually replace all the xfer_status()
call-sites to use the new wrapper, and then get rid of xfer_status
completely.
>
> So, I am for a change like this but I'd like to have all the users calling the
> same wrapper (unless there is a good reason to not use it). A proposed roadmap
> (to be discussed) for this would be.
>
> 1. Replace all the remaining "cros_ec_cmd_xfer" calls with
> "cros_ec_cmd_xfer_status".
> 2. Modify cros_ec_cmd_xfer_status to embed the message allocation.

How about the following alteration the the roadmap:
- Introducing the new wrapper.
- Replacing all remaining cros_ec_cmd_xfer/cros_ec_cmd_xfer_status to
use the new wrapper.
- Deleting cros_ec_cmd_xfer and cros_ec_cmd_xfer_status ?
My thinking is that this would mean fewer changes at the call-sites
compared to the original roadmap (in the original roadmap, one would
first have to modify calls to use cros_ec_cmd_xfer_status(), and then
modify them again when cros_ec_cmd_xfer_status() itself is modified to
include message allocation).

That said I don't have any strong preference, so either would work.

Best regards,
>
> Thanks,
>  Enric
>
>
> > Create a utility function that performs this setup so that callers can
> > use this function instead.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_proto.c     | 53 +++++++++++++++++++++
> >  include/linux/platform_data/cros_ec_proto.h |  5 ++
> >  2 files changed, 58 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index da1b1c4504333..8ef3b7d27d260 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -5,6 +5,7 @@
> >
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > +#include <linux/mfd/cros_ec.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_data/cros_ec_commands.h>
> >  #include <linux/platform_data/cros_ec_proto.h>
> > @@ -570,6 +571,58 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >  }
> >  EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
> >
> > +/**
> > + * cros_ec_send_cmd_msg() - Utility function to send commands to ChromeOS EC.
> > + * @ec: EC device struct.
> > + * @version: Command version number (often 0).
> > + * @command: Command ID including offset.
> > + * @outdata: Data to be sent to the EC.
> > + * @outsize: Size of the &outdata buffer.
> > + * @indata: Data to be received from the EC.
> > + * @insize: Size of the &indata buffer.
> > + *
> > + * This function is a wrapper around &cros_ec_cmd_xfer_status, and performs
> > + * some of the common work involved with sending a command to the EC. This
> > + * includes allocating and filling up a &struct cros_ec_command message buffer,
> > + * and copying the received data to another buffer.
> > + *
> > + * Return: The number of bytes transferred on success or negative error code.
> > + */
> > +int cros_ec_send_cmd_msg(struct cros_ec_device *ec, unsigned int version,
> > +                      unsigned int command, void *outdata,
> > +                      unsigned int outsize, void *indata,
> > +                      unsigned int insize)
> > +{
> > +     struct cros_ec_command *msg;
> > +     int ret;
> > +
> > +     msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> > +     if (!msg)
> > +             return -ENOMEM;
> > +
> > +     msg->version = version;
> > +     msg->command = command;
> > +     msg->outsize = outsize;
> > +     msg->insize = insize;
> > +
> > +     if (outdata && outsize > 0)
> > +             memcpy(msg->data, outdata, outsize);
> > +
> > +     ret = cros_ec_cmd_xfer_status(ec, msg);
> > +     if (ret < 0) {
> > +             dev_warn(ec->dev, "Command failed: %d\n", msg->result);
> > +             goto cleanup;
> > +     }
> > +
> > +     if (insize)
> > +             memcpy(indata, msg->data, insize);
> > +
> > +cleanup:
> > +     kfree(msg);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(cros_ec_send_cmd_msg);
> > +
> >  static int get_next_event_xfer(struct cros_ec_device *ec_dev,
> >                              struct cros_ec_command *msg,
> >                              struct ec_response_get_next_event_v1 *event,
> > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > index 30098a5515231..166ce26bdd79e 100644
> > --- a/include/linux/platform_data/cros_ec_proto.h
> > +++ b/include/linux/platform_data/cros_ec_proto.h
> > @@ -201,6 +201,11 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> >  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >                           struct cros_ec_command *msg);
> >
> > +int cros_ec_send_cmd_msg(struct cros_ec_device *ec_dev, unsigned int version,
> > +                      unsigned int command, void *outdata,
> > +                      unsigned int outsize, void *indata,
> > +                      unsigned int insize);
> > +
> >  int cros_ec_register(struct cros_ec_device *ec_dev);
> >
> >  int cros_ec_unregister(struct cros_ec_device *ec_dev);
> >
