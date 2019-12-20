Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B77E128178
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLTRdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 12:33:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45179 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:33:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so8232008qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4GRO/tWiHbtugNhV7RJoylU3LHor0URi+UMEUF74qE=;
        b=d1sfmHOoN92uPuLuu8fgnRwjyA5F1JWhhVFF57FV7A2DSxKQqRF4LGQa69tbTalwUh
         1zL8yEdkg72wO0woe+DVlrUMKZ8uS9dQaa+SmFcwb+JeUY4UPw64tQXdrq93FETmgWDo
         Qse0URFDLMNwpusPCyMWsdhUpgpPL0BfRXU6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4GRO/tWiHbtugNhV7RJoylU3LHor0URi+UMEUF74qE=;
        b=Rst9A2SmE/tAKyhU2njizjPXbqc4/2MUA/ZnOFitVpVCxEfVRzfwLE1UWuXV57ASXi
         C033o4aQO4p1xBlxfCyPHN/VmOv8sWzFrrQ4vnQprEjQgNPfqmYpp/YYtliLRq0ygudJ
         oPSczvL4MPvd+S6qepnS+imyLLZTCthTo7EjI4i9tDNMEGS/Wq01TDK//hKvGHHirJwS
         Rx9DFhcW9Ponm9CLMZkXiO8GfBQgI25mpN255EuirI92CLKN3ZbnHkcIycHsdhS7zw81
         rgsUXT/kmn87JZX9gSaekNsqpOiBZ2HD2B8wiyhQoQPAjJ5n+Mm/7yy6Ai1WMLbthneY
         UBkg==
X-Gm-Message-State: APjAAAUqaDUrXcBjlLfEl+xt1n53tV+TgcJa9issfoHdD8weZ2bcYtvX
        b0kJCG3+dOIDFoYbXo0AYAEoUVv4oxHdxiIOQc31cQ==
X-Google-Smtp-Source: APXvYqyECW5ukaLyBjYrwaRekIeLNwYlDah24gVYQkCKTiWSXa2ygEc+b0DkuTHIrCff61ddxAEKw1t+6msgwF6EG38=
X-Received: by 2002:a37:5b41:: with SMTP id p62mr14388232qkb.442.1576863182554;
 Fri, 20 Dec 2019 09:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20191219201340.196259-1-pmalani@chromium.org> <20191219201340.196259-2-pmalani@chromium.org>
 <f3d6267e-2429-e5a0-2a0e-60cab5bb1bb9@collabora.com>
In-Reply-To: <f3d6267e-2429-e5a0-2a0e-60cab5bb1bb9@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 20 Dec 2019 09:32:51 -0800
Message-ID: <CACeCKafK+XpHnQzjXePMLiv7F7dVDVcNJNO4nOF3VvSqCR-+fA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: cros_ec: Add usbpd-notify to usbpd_charger
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 12:55 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> This should be [PATCH v3 2/2]. All the patches in the series should have the
> same version otherwise makes difficult to follow.
>
Noted. I was under the impression that  new patches would have
individual version numbers. I will correct this in the next version.
Thanks!

> Thanks,
>  Enric
>
> On 19/12/19 21:13, Prashant Malani wrote:
> > Add the cros-usbpd-notify driver as a cell for the cros_usbpd_charger
> > subdevice on non-ACPI platforms.
> >
> > This driver allows other cros-ec devices to receive PD event
> > notifications from the Chrome OS Embedded Controller (EC) via a
> > notification chain.
> >
> > Change-Id: I4c062d261fa1a504b43b0a0c0a98a661829593b9
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/mfd/cros_ec_dev.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index c4b977a5dd966..1dde480f35b93 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
> >  static const struct mfd_cell cros_usbpd_charger_cells[] = {
> >       { .name = "cros-usbpd-charger", },
> >       { .name = "cros-usbpd-logger", },
> > +#ifndef CONFIG_ACPI
> > +     { .name = "cros-usbpd-notify", },
> > +#endif
> >  };
> >
> >  static const struct cros_feature_to_cells cros_subdevices[] = {
> >
