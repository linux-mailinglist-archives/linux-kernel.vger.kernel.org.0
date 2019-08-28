Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924A9A0174
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 14:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfH1MRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 08:17:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33953 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfH1MRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:17:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id c7so2539736otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ucg4PVvFDJuY7IrX1BzjsG7jDMsSrlHH0nllnqOy1w=;
        b=RaaIg11X9DM0RGWFrGEjc/ZFk/tHs7LC6sDd3cWu2S6dRraD/Y04AcW2iBpmNHrpfN
         ea31HYHK7zF6k9yOf19OidqCKxqkJGzqh8D7XfnSPAomPgR/oThBI/dqteVcfc3R9RhS
         N2Y62HIWCOLylC1GlCTTLLvMELu6Lp9qgGMrouRx9ZFaTb3d5D6zKoZ8zEpjts64ssve
         1y1gh7m35Uhwr37MsFo0eluINZ7NKD9drFPWIQJuYClyc6+CkPQY1/UfizJhnXp6PhBx
         yCYpcVgC4C6krmIsCHHQakFMfYNq2tJaM1VyjPWE31A2jr9Bo93dVG9vyFOY9I16GWJK
         TpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ucg4PVvFDJuY7IrX1BzjsG7jDMsSrlHH0nllnqOy1w=;
        b=S6KoY3LZ5Xl+wMBv2oDpkLoUIM7JoKq8gwilpzJWjc4wu1rlA+Gnf9Avbgy4K3ToRB
         +M1RY9OyZ7gefy8AqAiIZpC/QppWjTMNCCikzYgK2hHANs+/B17VIdLWq1pY00g6eGCK
         IGASP2mEqvriL4PDvR9WpKkl0vnsdxG/cFHIbodOIyTnQicF5hhUTOcIDtukEK58ixgl
         JfWrfs5lRXheHFiSnv5efWepdR8YxGwb+nkFLnvl9bYdgSEgPV4j+OTSUEBQFdZ7+LRE
         J41YHfZc5a2FHw7QXc6u0POrMKZKF1viQxxzjDOEu9mxXn10aecd3FOnHG7Qk3slYQ/+
         N6cg==
X-Gm-Message-State: APjAAAXAQQ95AK7pZlK8Qytz6uBxUWSvEy2OQ4FwsPGobnqf3SFJt3px
        jHNgHarz/KTM9LpXfVWn90iImtqmiLkqigg6TEbJCg==
X-Google-Smtp-Source: APXvYqxvaDhp/dkkcMw7DJJ3ub/Alcq2Wx3/cUgoCozs4WNtp8URsGvjmQq9zjow7okgb55DGZ/Unruq8ktrBx09lXw=
X-Received: by 2002:a05:6830:144d:: with SMTP id w13mr3040072otp.85.1566994629759;
 Wed, 28 Aug 2019 05:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190827064629.90214-1-david@protonic.nl> <CAMpxmJV2XC+CK1SfJnH2YuaD2Gh=fiBQY+WPbjnqkvxGW6ZH_w@mail.gmail.com>
 <CAMpxmJXQ=M9PeMFBf70aE5Jgg3c6P2=4QF5CxWpenh+2WXLhnA@mail.gmail.com> <20190828131330.6a28e5cc@erd988>
In-Reply-To: <20190828131330.6a28e5cc@erd988>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 28 Aug 2019 14:16:58 +0200
Message-ID: <CAMpxmJUrvu9f_+-3epZ4iafZ-t0YUAA8E3_Xangc_dBiiCc20A@mail.gmail.com>
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

=C5=9Br., 28 sie 2019 o 13:13 David Jander <david@protonic.nl> napisa=C5=82=
(a):
>
> On Wed, 28 Aug 2019 12:56:28 +0200
> Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:
>
> > =C5=9Br., 28 sie 2019 o 10:38 Bartosz Golaszewski
> > <bgolaszewski@baylibre.com> napisa=C5=82(a):
> > >
> > > wt., 27 sie 2019 o 08:46 David Jander <david@protonic.nl> napisa=C5=
=82(a):
> > > >
> > > > The type of reg_direction needs to match the type of the regmap, wh=
ich is
> > > > u8.
> > > >
> > > > Signed-off-by: David Jander <david@protonic.nl>
> > > > ---
> > > >  drivers/gpio/gpio-pca953x.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953=
x.c
> > > > index 378b206d2dc9..30072a570bc2 100644
> > > > --- a/drivers/gpio/gpio-pca953x.c
> > > > +++ b/drivers/gpio/gpio-pca953x.c
> > > > @@ -604,7 +604,7 @@ static void pca953x_irq_bus_sync_unlock(struct =
irq_data *d)
> > > >         u8 new_irqs;
> > > >         int level, i;
> > > >         u8 invert_irq_mask[MAX_BANK];
> > > > -       int reg_direction[MAX_BANK];
> > > > +       u8 reg_direction[MAX_BANK];
> > > >
> > > >         regmap_bulk_read(chip->regmap, chip->regs->direction, reg_d=
irection,
> > > >                          NBANK(chip));
> > > > @@ -679,7 +679,7 @@ static bool pca953x_irq_pending(struct pca953x_=
chip *chip, u8 *pending)
> > > >         bool pending_seen =3D false;
> > > >         bool trigger_seen =3D false;
> > > >         u8 trigger[MAX_BANK];
> > > > -       int reg_direction[MAX_BANK];
> > > > +       u8 reg_direction[MAX_BANK];
> > > >         int ret, i;
> > > >
> > > >         if (chip->driver_data & PCA_PCAL) {
> > > > @@ -768,7 +768,7 @@ static int pca953x_irq_setup(struct pca953x_chi=
p *chip,
> > > >  {
> > > >         struct i2c_client *client =3D chip->client;
> > > >         struct irq_chip *irq_chip =3D &chip->irq_chip;
> > > > -       int reg_direction[MAX_BANK];
> > > > +       u8 reg_direction[MAX_BANK];
> > > >         int ret, i;
> > > >
> > > >         if (!client->irq)
> > > > --
> > > > 2.19.1
> > > >
> > >
> > > Applied for v5.4.
> >
> > Actually the second patch depends on the first one, so moved it over to=
 fixes.
>
> Btw, they are both bugfixes, IMHO it would be valuable to have them in 5.=
3rc
> if possible... there is some severe breakage there right now.
>
> Best regards,
>
> --
> David Jander
>

Yes, that's why I said I moved it to fixes.

Bart
