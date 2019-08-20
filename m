Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B029F95C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 12:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfHTK1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 06:27:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34556 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbfHTK1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:27:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id x18so4612940ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/WL7mt//GAgzwpdMZbthxuFg+kLsllf6TCIqq5cm4k=;
        b=WRmbYOSuUZTNI+VHX1CcRM/fsEMSBDx0RvKKzmF0CBEnfGFQy4jwdRNLy7jlnI71Jx
         vpVfv1RUwcWCx6BY0Ww4yUiLIZW59Ks6mcyBJ/34UhiYcaCJMg0H2VxEQ4C77ZKH7OwI
         e1SvT7JJBct7l227/+DWqKgkSjG2K/bPFJGXSqOqyc5Z/GHZs7xizq/yrtYTa6vdpiBw
         vA3CPiGHNyD/M6Mx1CZtmQUaQ76xIgOYo2G5FmdW5bYPaMkF86DVU+QXZY26Hjj5yoKb
         077WUHbNXzbP2drPoIpP83IgyXznGU7ZNCatF/K1XShzcm8Cfj2hr5QISGBqHSCZt91P
         xkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/WL7mt//GAgzwpdMZbthxuFg+kLsllf6TCIqq5cm4k=;
        b=Px3StGE4tCr/ITQ1S4u46cOdW3QZy/wVg3CvtP/0mXEfTcMCQJTSYa0+nZIC45sBNo
         EpRNTY41UsR8mkS/MkrHrPSQnnonea2hkRZKlsgBruD0E9e78xd+dbUUVkxJD45RtDRL
         Rit8U/N9t/4NzuSgA8CtEqOIjdvC+ArV0Gd2JYtE2ccTgwd5cZqscNzmSF6eah7iFGl5
         zS7yoQcl0/5cx7LsWYCBeNVDHP2ig3fkFphuPHmQtN+yOLlN2cuaWAGUXp33JQCZPbcy
         Z8UFrcONqXZlh2YXBi9COr9V0QMbynlhXW/PoRe9lEuwf7GIPzUkcgDSVJF1hFTfOUHb
         7rWg==
X-Gm-Message-State: APjAAAX97Gzd/zsG9Oy1Cd+OJtLTPF1I7E6RuegEw410F7vnvEy8ykuz
        QtVOScB9Hw8xm8zoZwrCeEQYI78oszVzO8v7y4z8Pg==
X-Google-Smtp-Source: APXvYqy9d7CgQvy0ZM0/DSmtHyrZ+R2wFU3tRkdCwr+9kjsIgtuwE4FW7X7VWI/cj5Incxd0Z4l1OHqEHETZ6NI0BN8=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr10426093ljc.28.1566296822942;
 Tue, 20 Aug 2019 03:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <1566221225-5170-1-git-send-email-xuwei5@hisilicon.com>
 <CAHp75Vct3qtR5bDF6iALmduKEEq+gNL-btmzQVuWq_hYsmxKhw@mail.gmail.com>
 <CACRpkdbRZ=88+ooW5jb5vu4Dwsaj7Ce+V5Ked2-bGn0JWpTHfQ@mail.gmail.com> <CAHp75VcwDZdOwFsT4Gf-1a4tNGQdowK-RKRvSif2m7oTsVQNbw@mail.gmail.com>
In-Reply-To: <CAHp75VcwDZdOwFsT4Gf-1a4tNGQdowK-RKRvSif2m7oTsVQNbw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Aug 2019 12:26:51 +0200
Message-ID: <CACRpkdZMHqppyzVQCLSR8yv1owZ71eDAduL9JGkCawjFvZ2U+A@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: pl061: Fix the issue failed to register the ACPI interrtupion
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>, Wei Xu <xuwei5@hisilicon.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>, jinying@hisilicon.com,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        huangdaode <huangdaode@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:51 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Aug 20, 2019 at 10:12 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Aug 19, 2019 at 5:07 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:

> > Exactly what do you refer to when you want me to
> > "re-do the approach for IRQ handling"? Do you mean
> > this driver or are you referring to:
> >
> > commit e0d89728981393b7d694bd3419b7794b9882c92d
> > Author: Thierry Reding <treding@nvidia.com>
> > Date:   Tue Nov 7 19:15:54 2017 +0100
> >
> >     gpio: Implement tighter IRQ chip integration
> >
> >     Currently GPIO drivers are required to add the GPIO chip and its
> >     corresponding IRQ chip separately, which can result in a lot of
> >     boilerplate. Use the newly introduced struct gpio_irq_chip, embedded in
> >     struct gpio_chip, that drivers can fill in if they want the GPIO core
> >     to automatically register the IRQ chip associated with a GPIO chip.
> >
> >     Signed-off-by: Thierry Reding <treding@nvidia.com>
> >     Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yes.

OK let's fix this mess, it shouldn't be too hard, I've sent a first
few patches.

> > The problem comes from the problem/mess I am trying to
> > clean up in the first place. So if the new way of registering GPIO
> > irqchips is not working for ACPI, then we have to fix that instead
> > of reverting all attempts to use the new API IMO.
>
> Sorry for me being impatient and asking for a groundless requests.
> I'll help you with cleaning this.

Sorry if I sounded harsh :( I just have a bit of panic.

I am sure we can fix this, I only recently realized what a headache
the new API is going to be if I can't straighten it out and have to
keep the old stuff around forever in parallel.

Yours,
Linus Walleij
