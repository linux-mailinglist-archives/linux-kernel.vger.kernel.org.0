Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37977E1F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392484AbfJWPhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 11:37:11 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35491 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390400AbfJWPhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:37:11 -0400
Received: by mail-il1-f195.google.com with SMTP id p8so9613246ilp.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sR2SNSnWNwKPR9DRMKnUHE6gMbz4VxB5+FQlRjQHbYk=;
        b=if0Y/K+bq2VP0SUiEtC6YdtsHM9dyP5JmWUT3AyFj22AYtLxOkIBx9KqKRXORfJk5o
         pwaRf3waYJBB2f6wxn5KEKEI7y2ghA7jS9NW5D8sxdxwlWLZ7nBBonDzPCSxxuKHqngp
         IK4mH/JwTsTmfM2bciFwJtoge+ejdYHZdgOchIpDgMOGf1B0zKG2MFcwn+jtbB6OVDM+
         JmHr6FVZzvh5RjIcRcnrySRiWRFpkdxSl5aJTBZZDLL9WNal832HP9TcNzFzjZ5s61RI
         9+mWUu0N4g/tK96XhQGYtRcazQOuyln0l87gX3sgsPXOfI4srezH4tRoxxSpY12Bw8pU
         p9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sR2SNSnWNwKPR9DRMKnUHE6gMbz4VxB5+FQlRjQHbYk=;
        b=lanDJEd9TjUFe5ADNL8WFUw6iIXNjAAlJ2UUkSxygTEL/3ZqwKU3apy86R3arxmWPX
         vGmVZDZb/yemBij8DT1j4MNhPr4oz+39zUjCco3z7f3h34h83STDUDhgwCRZXgdLp6tr
         8hFMME9TLYn/TX8SYlLjw+9TiVi3/6V76DKrvYDmUdUIG59ibqQ0NS5TNsN+WUMONa5B
         Bg+AhuCJ0yKBs+oC1Wvi6doXnDHQpC6VnXJyjRsRgo/HnZS3imi9i6inY7mSviXVvWRy
         5z9XJJb5Gra8mDnmYH4VX0QKUJngZAmr8RY281GPpeLsJZiN8R8FExMy/n1lHN4eiwI5
         mKgA==
X-Gm-Message-State: APjAAAU62keaARrccCApmwDrzDIRjd2KmWU6ChtKHDzPAYu9Ba/LXvc4
        l34XXBZJr6/k9ceD7icqSL9EyCiivzFne9WimcCAmQ==
X-Google-Smtp-Source: APXvYqwcyEef1k3eSIVQftJdMb4J6dmUUsBH64WugGGW0Hv+ml6s21TuA/xxpNc0Hz4rvsRY/Y30rpHOQs/Ie6/vbv0=
X-Received: by 2002:a92:d285:: with SMTP id p5mr36879409ilp.278.1571845028660;
 Wed, 23 Oct 2019 08:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <2e3d8287d05ce2d642c0445fbef6f1960124c557.1571828539.git.baolin.wang@linaro.org>
 <CAK8P3a0i_xvSzeRxfT-5LLpaAfGx3USsuXX1dv1x6Bg87jeopg@mail.gmail.com>
In-Reply-To: <CAK8P3a0i_xvSzeRxfT-5LLpaAfGx3USsuXX1dv1x6Bg87jeopg@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 23 Oct 2019 08:36:57 -0700
Message-ID: <CAOesGMg5MH3Dq8yBLhHZCJJwMqVaiqqJyhs-tNE_nWDzUaTPCw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update the Spreadtrum SoC maintainer
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Baolin Wang <baolin.wang@linaro.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>, baolin.wang7@gmail.com,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 5:17 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Oct 23, 2019 at 1:06 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> > +F:     drivers/power/reset/sc27xx-poweroff.c
> > +F:     drivers/leds/leds-sc27xx-bltc.c
> > +F:     drivers/input/misc/sc27xx-vibra.c
> > +F:     drivers/power/supply/sc27xx_fuel_gauge.c
> > +F:     drivers/power/supply/sc2731_charger.c
> > +F:     drivers/rtc/rtc-sc27xx.c
> > +F:     drivers/regulator/sc2731-regulator.c
> > +F:     drivers/nvmem/sc27xx-efuse.c
> > +F:     drivers/iio/adc/sc27xx_adc.c
> >  N:     sprd
>
> Maybe add a regex pattern for "sc27xx" instead of listing each file
> individually?
> That would simplify it when files move around or you add more drivers that
> follow the same naming.

Agreed.

In addition to that: Baolin, when you resend this, feel free to send
it to soc@kernel.org so we get it into our patchwork tracker (if you
want us to apply it directly).


Thanks!

-Olof
