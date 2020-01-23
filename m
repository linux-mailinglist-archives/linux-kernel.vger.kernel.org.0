Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E494146CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 16:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAWP0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 10:26:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37164 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgAWP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:26:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id o13so3913278ljg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JixvNa3T/Sm8CzR3MAMKQQKV9fkYDtItlBYnPybWoa4=;
        b=Zc2zmdqVVcMyTbKJk/OfPLvHkbDHUuyhXy1GzDGIH+DWyi7nlu+TzXS047DhqM4iYL
         k6DlWXmVECAGHakWQb6g4YBiX/aDLjp7jzYVfdCBTpYIClBMko+/vU8CyzRnbvn/+CkD
         A9Din0hPMTKhHDbByOcZGCXnF/wWejyE7BPZoVm+ev0SZMMmc4krnSBxYkZOzuyKdqP2
         c3pRw/8my1rLDkUyZuNSPhXOi4Xp8B+Mglx0qvtoYt8850IMiDGtB1vUjirnqk99mFGW
         vT1hBGvsTrwOWGUixxHPnxQxw1ztDctwT5yflrguwXwwv8D6cMdSAqP1vsQ+hLQ1vk9K
         LCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JixvNa3T/Sm8CzR3MAMKQQKV9fkYDtItlBYnPybWoa4=;
        b=V1M3UEOma3M12adBcCn3rtfN/NMmgKY3LEAbFf+LWHm5mfcuf8iyuTj+QSvwNZzlli
         da3WE3k+wHAN3NJrXoWvQB93DDJzUewqPey4s/NAjWUuFmPC6oqjBuzYvj6be8IjZVl7
         DlyBmn3kWNPr7zz4SsClN0no4Jb8AsQeGujPbtxSZLAINF5mHoNJZeSzbxEoFypiySoR
         xopqfscYa2ySlHAO+RzXiaDe2vyy1T2LInzqQ25ZDDi/d/yQUqoqNFZyec9UxqL+ykq1
         dhh1jAjtWCIeR5yZgXtTn9hcFHpAHr7x6i8AV9EsDG3xLft+04A/xrtYT0aHEw0+HsA6
         IreQ==
X-Gm-Message-State: APjAAAVODik376Ks0q63JQbchlX7qD3UDC/uuPx2BY19jg9jj0ETFyXO
        gGMt4axuhbkXY4LcU0J5xjJASSZ5I/52A+lIZ+djZQ==
X-Google-Smtp-Source: APXvYqxCD/64PYoNS7bPDfDqCy95gkiLu2aKyXaqySoWYyeZZbHp2gAVXZpYdev9k0/srjWcnvPk0rqLcDqsBw9H4qs=
X-Received: by 2002:a2e:960f:: with SMTP id v15mr23760075ljh.265.1579793182804;
 Thu, 23 Jan 2020 07:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20200121001216.15964-1-dan.callaghan@opengear.com>
In-Reply-To: <20200121001216.15964-1-dan.callaghan@opengear.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 16:26:11 +0100
Message-ID: <CACRpkdYGED-YU8PGUFwK-Arrs0Vp1=Oc-Nx=MvjuygLJvzQPkg@mail.gmail.com>
Subject: Re: [PATCH RESEND] gpiolib: hold gpio devices lock until ->descs
 array is initialised
To:     Dan Callaghan <dan.callaghan@opengear.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 1:13 AM Dan Callaghan
<dan.callaghan@opengear.com> wrote:

> If a driver consuming the GPIO chip is being probed at the same time as
> the GPIO driver is registering the chip, it is possible for the
> consuming driver to see the ->descs array in an uninitialised state.
> For example, the gpio-keys-polled driver can fail like this:
>
>     kernel: gpiod_request: invalid GPIO (no device)
>     kernel: gpio-keys-polled PRP0001:07: failed to get gpio: -22
>     kernel: gpio-keys-polled: probe of PRP0001:07 failed with error -22
>
> This patch makes gpiochip_add() hold the lock protecting gpio_devices
> until it has finished setting desc->gdev on the newly inserted list
> entry.
>
> Signed-off-by: Dan Callaghan <dan.callaghan@opengear.com>
> ---
> Resending this one because I failed to cc the maintainers on the
> original posting, sorry about that.

This makes a lot of sense, I'm impressed that you managed to
provoke this error!

Patch applied.

Yours,
Linus Walleij
