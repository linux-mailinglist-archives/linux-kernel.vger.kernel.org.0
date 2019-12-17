Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5078122611
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 09:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLQIA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 03:00:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43460 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLQIA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:00:56 -0500
Received: by mail-io1-f66.google.com with SMTP id s2so9958230iog.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 00:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fjfBTXD/0Rg93fYPAe9SEo+I0qrNg9n7YS5lPldbMxg=;
        b=Kw1586Eb7ayc/Uevj8kSs/jgbYJZ5RYqw6C/4PkUaMTeDr28DglPtZD1DpVyn1eGW3
         gdH8K+XvoTplIyxy5dARmY3R34o7vUJ7Vekk7cA71Z/jc21kJsq1tPVO0q3Vrpd/4nVf
         nem3oX3/rwi1QWu+HC4paVuGsbly6AzhY414oydHkwRHfygrV9dAovK/YbW4QSOZiucx
         vycrxUBnDwLIO0sUyaIwB9gGUNB1aJmu/4TZf3sYpeXu+lsEQnGfvJ6bvIqLFEseV7H3
         pkoJcKkz0EaZzEODKNX5LjiNY67fjwLigUHtMjkcLluVjeg/Q/oBqpu17LrvkDoh/87L
         K2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fjfBTXD/0Rg93fYPAe9SEo+I0qrNg9n7YS5lPldbMxg=;
        b=fFehi2NSzEOdPzcsuGWAJVAWg3me9jEh/3FXjaN1xGnjzs4F0OSU6UFWH45KDnMTch
         RIBtvb17gLKq+d6k/BRai6YIY7Z9k+VfHTUEGKFkbme+Y07hBQhQRmc9VJWlXDjl4BS6
         avH/GkQutwdM/ySF6u95hiksir3dJHvAFaVdVqJ29bqeVS06KxUCzX9tkE2+uMMYg0hS
         E5Fxem53Nipua8UGOXSYM+DxpwwDoTFKGi1tscD+5ZlDNf5i7onnR0BYTtSdQu5l1S4Z
         ezKBDFx0vaGwJ3rCjuZKxBYFo7GNyM7QEkzQorstkBdzNBLQUFoE0hdCocbm3kMdbt0j
         MG3A==
X-Gm-Message-State: APjAAAUOYyfuZKy1mrP5WmBhBlpNBWAwZeqQfdlqZ3qlTILdqnoNxZpk
        xo+4dTgGVpiPAk0uLjJpsQP0TkY5bUq4qK2izSlRLQ==
X-Google-Smtp-Source: APXvYqz32eReTALarnf1P0DDPtaS3epoXURcAZnKU7rDx0beSWVeeDK4EoJbvrSnuhkreRg5/vzJ1Z7KVBqugRXabrU=
X-Received: by 2002:a02:c85b:: with SMTP id r27mr7986096jao.57.1576569655617;
 Tue, 17 Dec 2019 00:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20191213162453.15691-1-brgl@bgdev.pl> <20191213162453.15691-2-brgl@bgdev.pl>
 <b9a28314-4fce-ebbd-be20-b0ffa2f1f15f@lechnology.com>
In-Reply-To: <b9a28314-4fce-ebbd-be20-b0ffa2f1f15f@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 17 Dec 2019 09:00:44 +0100
Message-ID: <CAMRc=McRKwYkUcY9J8cEkwoMnGYxs7SkTnOnFsVMDZD2DkJ1Zw@mail.gmail.com>
Subject: Re: [PATCH 1/3] clocksource: davinci: work around a clocksource
 problem on dm365 SoC
To:     David Lechner <david@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 16 gru 2019 o 18:58 David Lechner <david@lechnology.com> napisa=C5=82=
(a):
>
> >
> > +static unsigned int davinci_clocksource_tim32_mode;
>
> static unsigned bool davinci_clocksource_initialized;
>
> > +
> >   static struct davinci_clockevent *
> >   to_davinci_clockevent(struct clock_event_device *clockevent)
> >   {
> > @@ -94,7 +96,7 @@ static void davinci_tim12_shutdown(void __iomem *base=
)
> >        * halves. In this case TIM34 runs in periodic mode and we must
> >        * not modify it.
> >        */
> > -     tcr |=3D DAVINCI_TIMER_ENAMODE_PERIODIC <<
> > +     tcr |=3D davinci_clocksource_tim32_mode <<
> >               DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
>
>         if (davinci_clocksource_initialized)
>                 tcr |=3D DAVINCI_TIMER_ENAMODE_PERIODIC <<
>                         DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;

I thought about doing this initially, but then figured this code would
be called a lot, so why not avoid branching and just store the right
value? Alternatively we can do:

    if (likely(davinci_clocksource_initialized)
        ....

Bart
