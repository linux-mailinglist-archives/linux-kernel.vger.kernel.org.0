Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 235FD9FD46
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfH1Iis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 04:38:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38731 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfH1Iis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:38:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id r20so1971932ota.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LA42bpg7TE1ErDc8e8NGiPSnjc3LkGHxDTQOiKqpb4U=;
        b=hfSMAmRpOdASqMo7kGDzwsaq1ugAqj8azpYiMW18Q4rIOyrsHZHB8eUQZRZWS6talu
         aq8wdMiWdJYogvypSrLVo8nEOyX7ETgHotBuqD2xXAnkpsCEQmqAtVnK76LnFuTHD0cD
         FS2jQLmBQtBHhcUeLjxcFGH23vM2ugltBi0mZl3AKifLrE4Dcfu82NYWTwduo8N9nF0o
         POzqNyeGFRSXYaDTcJlIMhmKWlHMqhp7vxvqHNr1pZebgghxEoaQWhymlcp/WAey8P85
         RlNvGjLrgQ2Vd4em5KUYRyhWldG9dH2oMv2LKV/t9kYF6I1+uP2ZwjPygwg7mHCxEuUe
         vTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LA42bpg7TE1ErDc8e8NGiPSnjc3LkGHxDTQOiKqpb4U=;
        b=XOrG2faJNLR67WxPVWAm4UNhXB3nBVSfwJc1faaQQjh7jZr/kd+NG58cUrHr5oMYDP
         YIVfPGGCuqJ6peODo+gEmxZ0ampsCDL7c8pg3a6MXfZluW1BvCq5byOTiq2FAHwrpJsV
         E+Di0zO593LeDDObvpQ12V+P81VONZkLpXquSC19qX9Z46jpOGv4L/Ljqu+NsigegjWi
         9KF53Ag9p9mQMXL9zpQAXslN4nWaQvqvBuHyaoSZr6nO1FXdzfIUIfbkwSlGrIBN/SPr
         JQvb23P3fV02fnfYeJBSJEaX4f8HcJs6DJ+sUCo7rqP1npnFZOAhYpqRXYW30MUN6VBH
         /1LA==
X-Gm-Message-State: APjAAAXidArwCiUA16CZAPU89sf72CxYysFsU1Y5BHg/3ZF1Ix6aG4HC
        4eXjado66b02YUXG4T5YBNlKZnp6eyT6ZjHAPViTbiM4
X-Google-Smtp-Source: APXvYqzr+/pBY3bba/FTj2fIGzqgeyy/JZsqIzuMeHwfBrHmod6PlFGij5uDPP1r6ct0mKAIXOz2O0gG2DETVBBY5pM=
X-Received: by 2002:a9d:5551:: with SMTP id h17mr2372248oti.194.1566981527387;
 Wed, 28 Aug 2019 01:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190827064629.90214-1-david@protonic.nl>
In-Reply-To: <20190827064629.90214-1-david@protonic.nl>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 28 Aug 2019 10:38:36 +0200
Message-ID: <CAMpxmJV2XC+CK1SfJnH2YuaD2Gh=fiBQY+WPbjnqkvxGW6ZH_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-pca953x.c: Correct type of reg_direction
To:     David Jander <david@protonic.nl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 27 sie 2019 o 08:46 David Jander <david@protonic.nl> napisa=C5=82(a):
>
> The type of reg_direction needs to match the type of the regmap, which is
> u8.
>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/gpio/gpio-pca953x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 378b206d2dc9..30072a570bc2 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -604,7 +604,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_da=
ta *d)
>         u8 new_irqs;
>         int level, i;
>         u8 invert_irq_mask[MAX_BANK];
> -       int reg_direction[MAX_BANK];
> +       u8 reg_direction[MAX_BANK];
>
>         regmap_bulk_read(chip->regmap, chip->regs->direction, reg_directi=
on,
>                          NBANK(chip));
> @@ -679,7 +679,7 @@ static bool pca953x_irq_pending(struct pca953x_chip *=
chip, u8 *pending)
>         bool pending_seen =3D false;
>         bool trigger_seen =3D false;
>         u8 trigger[MAX_BANK];
> -       int reg_direction[MAX_BANK];
> +       u8 reg_direction[MAX_BANK];
>         int ret, i;
>
>         if (chip->driver_data & PCA_PCAL) {
> @@ -768,7 +768,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chi=
p,
>  {
>         struct i2c_client *client =3D chip->client;
>         struct irq_chip *irq_chip =3D &chip->irq_chip;
> -       int reg_direction[MAX_BANK];
> +       u8 reg_direction[MAX_BANK];
>         int ret, i;
>
>         if (!client->irq)
> --
> 2.19.1
>

Applied for v5.4.

Thanks!
Bart
