Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34887711E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 08:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbfGWGaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 02:30:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44781 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730545AbfGWGaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:30:03 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so79350920iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j31K/zZs/r0C+pUWsqptIpZI42gK74CrCWxKrCU84XI=;
        b=N8Pla93TcEziqi3X9Xjj4jVFB6FXqFhyq+3mUxlpciUlrARDlvGyjeKc8SeQnuargV
         FN6ErDmNUCoDrH38zU3JHuoPpuMAZNLdPp31tlj7ewshoZqqtBcK4IcRQdbsI1CnMMnf
         5hA4bFDG/lArM1NQncuEu6rCSt6B3ndlw72yX0NSAbnaljYkk7CEAllPFu0SIId5I1sR
         U4Gz0rRgvvvgcQ0Z2hH1/E5sC3rwRaUiZNNJSe6iPAruMUZ1eoSTZcqyBloG9heNAprb
         mq31Yh74BQ+6PWAPc/rKE5g3B2XGRnySLEyQi2Wwan8kv19qIdLhvRoPKkKlTaKDka6Z
         z+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j31K/zZs/r0C+pUWsqptIpZI42gK74CrCWxKrCU84XI=;
        b=mC+L9rdehJDnnkCCSdIzDxmLGwusAEedKi1VjtXnzS4nqTNx1R83hcazmOwMBi6IhH
         QtwvhQ9cANAbqp6NJ17GdDiIqEIIQGNPgCQN2diiFcq3PT4c1N+uMOh4lgSHIiZ1fW9j
         CaKYYybJk+lAlD3Y+ZlxXn6XnbNKzjZj8xfLbSTi8P6k1iYQCQ3mTRR/FmIfvDiM6qmm
         hnW5XIaUV4lIYYXxg7KvXiy2Im8yb+U7uON0cuTc+AIAZTJLJxlJQCK6zcZyFTqfdGek
         mfBHWStbEsG5taq0orMlD6Fc6yLvvuZ4E02LDwyP9YDX1Etk52dm+XCNwKIYl2r3HNCK
         rUCA==
X-Gm-Message-State: APjAAAUK4SvBqF449bIwLfQzpirFby4F8jL50FnynoolpacU8l/l9MVS
        p+aq4RIOl7vafYCYrqYfHzLXx28SuFMbSQT8Zpc=
X-Google-Smtp-Source: APXvYqyvfBNIqjWIKreeMWxm6LxZ+e3NprufUy8Guv6wiY3P0Y5Y92XxFkqxlQycu+lO//vYesMKWVBa1nEhSzksv28=
X-Received: by 2002:a02:c916:: with SMTP id t22mr21391578jao.24.1563863403112;
 Mon, 22 Jul 2019 23:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190722150302.29526-1-brgl@bgdev.pl> <20190722150302.29526-8-brgl@bgdev.pl>
 <20190722160908.GZ9224@smile.fi.intel.com>
In-Reply-To: <20190722160908.GZ9224@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 23 Jul 2019 08:29:52 +0200
Message-ID: <CAMRc=McGTk+i0SzWN7AvGu3deYbXX_rJX=7+dKRpKFPKM_qxDA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] backlight: gpio: use a helper variable for &pdev->dev
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 22 lip 2019 o 18:09 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Jul 22, 2019 at 05:03:02PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Instead of dereferencing pdev each time, use a helper variable for
> > the associated device pointer.
>
> >  static int gpio_backlight_probe(struct platform_device *pdev)
> >  {
> > -     struct gpio_backlight_platform_data *pdata =3D
> > -             dev_get_platdata(&pdev->dev);
> > +     struct gpio_backlight_platform_data *pdata;
> >       struct backlight_properties props;
> >       struct backlight_device *bl;
> >       struct gpio_backlight *gbl;
> >       enum gpiod_flags flags;
> > +     struct device *dev;
>
> Can't we do
>
>         struct device dev =3D &pdev->dev;
>         struct gpio_backlight_platform_data *pdata =3D dev_get_platdata(d=
ev);
>
> ? It fits 80 nicely.
>

IMO it's more readable like that with the reverse christmas tree layout.

Bart
