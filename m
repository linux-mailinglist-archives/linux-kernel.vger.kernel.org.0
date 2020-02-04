Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4B151821
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 10:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgBDJrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 04:47:11 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42734 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgBDJrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:47:11 -0500
Received: by mail-io1-f68.google.com with SMTP id s6so9775917iol.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DWB0fGs6D7ucbUTFnrtpqXtN60QWiVsKTSoTpOV+cwQ=;
        b=XxT3YHCdjUeV5vaM9x2BVAz/ipXOX9X2gkgzuN5lR69WqotmvgDPxkKRusp86NCvLT
         dgUArE8KvG37XY+rkm8XKJJRhKkXxxriRnFPXMjaDgonyEbcF8tb8NVNo1bEiC2UwpNv
         hzYCORrrcRkAsi15WzajfZU7DIkuqxrqQFmB0tUiQDH49BJ8aimRdfzPKcVClNwOF1gQ
         rdfBiMYLew5Ps145UHkfySJBjuKiVfYs7vVquH632OoC4frSXWRUGooWjLUxnpLIixlY
         sfSL2FCMuh0vr02kit4yuMkH0kXDf6PdmyLfnnyBmePpBjYTXFdrJAR8fWTn4CKgpG2z
         ra0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DWB0fGs6D7ucbUTFnrtpqXtN60QWiVsKTSoTpOV+cwQ=;
        b=CZ8XEbnRGiOBj5oKiyezO6yygb73karKIogwXtuDtMpTibtvJH7qUxnPTzFDdRDtZW
         DHzG35vC5p7kg8JGYpqAfiFy5U8JTZ3QkeQmXpTOrOU4h2KtZ/lqfHhK9aGva7tNCPB1
         aZeutQYDNC0iem5mjr8Ndn8IAWd9zdhlWvwrHkIwECJrg1NRSuV/4gCTiJT5aemMyCO8
         xw6e3ORcatP4Tl3bCzxW/JS/h1FEcoo8iu8rgSgQL23Mvo/NCvulEQm5v4TsjZpn2KFl
         wYzz/HfKzBKeVYLb+zIoLW7168mK9vWcHwuDdT+k9l7XpDCGiL72kuN15K6Zh6581zYX
         NwEQ==
X-Gm-Message-State: APjAAAWnao0HWilFqom+YogJkMwXNOazZkxomFxxTnI1DKUhjxCt7RJN
        J/YSKPdZIFAvOj29hvjlWjWSqiCakIJsAp1gXWwUW7TD
X-Google-Smtp-Source: APXvYqyDTCKV1001Mtg+D0euI9fs/vBcJls8wPjmIXSoroJPOS7q+Flq1f6VsazCkXXWHcCrfHdrncKW81QHHYS0ZC8=
X-Received: by 2002:a05:6602:2352:: with SMTP id r18mr21945815iot.220.1580809630802;
 Tue, 04 Feb 2020 01:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20200203133026.22930-1-brgl@bgdev.pl> <20200203191451.GA19076@roeck-us.net>
In-Reply-To: <20200203191451.GA19076@roeck-us.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 4 Feb 2020 10:46:59 +0100
Message-ID: <CAMRc=McoG=uRJi0W+KV89bORNbGHOw7F=+hdbbEimANJGAYd7w@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpiolib: fix a regression introduced by gpio_do_set_config()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 3 lut 2020 o 20:14 Guenter Roeck <linux@roeck-us.net> napisa=C5=82(a)=
:
>
> On Mon, Feb 03, 2020 at 02:30:23PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > These three patches fix a regression introduced by commit d90f36851d65
> > ("gpiolib: have a single place of calling set_config()"). We first need
> > to revert patches that came on top of it, then apply the actual fix.
> >
> > Bartosz Golaszewski (3):
> >   Revert "gpiolib: Remove duplicated function gpio_do_set_config()"
> >   Revert "gpiolib: remove set but not used variable 'config'"
> >   gpiolib: fix gpio_do_set_config()
> >
>
> For the series:
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>

Applied the patches. I'll send them to Linus W shortly.

Bartosz
