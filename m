Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B901CA007
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfJCOFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 10:05:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45617 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfJCOFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:05:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id 41so2345768oti.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CjkcCbQk4BfKYjIfcsA27jNMdWtxDDNMFITjeJ5N6Yo=;
        b=YOXOx+TpchFlAH//++YWGEZLm1lokUcPLph2RU/Nu9ijloryGxTZofWrIGe7Ku03q1
         Tzs93SvjWVnXX4Ix9pEmfQIydneey+OnWoUywuxD3xJQPit7fR4RUkv3aCY0Kc+nZUxm
         74IRyYDFNglOCzz0yKXO9ne/egBQUOI6ITzGRMC12TIdQSjjilUgUphdDgCgCpck92wN
         r2cHZIFAaEc1uAzwLfz4edoSRcU/EkpLCUMNfxMbwb1NTL3TEaklMlhG+jHSbZ0c5eHH
         9NjN3q0urk1H//CSeEOj3BexelnRhpkPQ8G+WhdF02b5vB5+lmVLGU4A1NMUd2nN6D4Q
         Q0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CjkcCbQk4BfKYjIfcsA27jNMdWtxDDNMFITjeJ5N6Yo=;
        b=s8XgFyP+R/2Lev1tp0uV2wtyH3xWV9yqgy78oNG1pAzPcG14JT+gM9KHaB+Ghj4c0r
         BeFxa8V5rg2nO10dk1gg0YQWng9OIOH2MC/Vbvl7aQ1eyD+pp3YDlqa3ooygcIewbML+
         VqlhJZD9qZKmp4yFNWKspPcBd/jOCTBMYc2hqSlaGYc0breSTfmPmXq2WztcgLydibks
         78Y6vd49bH8obSq3P+Sd1zm7oR7ME7En2sSEvB47AYkoFY1C2kKVPOG3+zV2rERI4Dww
         POoaBsyprq/aBzwW0QJP2gFxxaAd7d0WqF4/jTWWGYr1Bk1PP2HnPf5V8rb1E5PuLODo
         /oDA==
X-Gm-Message-State: APjAAAWcc1Xy4wM+RtSQkpjLaUHu0pF/834eHAOt9HWBDN5htBG+I9mo
        On14ddMBjDnnNNzuWpO9POe88Z7vXZfsxkPKrpVteA==
X-Google-Smtp-Source: APXvYqzJLEJexAn72R2rPNacy6O7n9DNnITIY6sTbrSg2g0w3x+cqeu7psGfMmvb0/+z5UR1x9WrNfk4Bm8i08YwGxo=
X-Received: by 2002:a05:6830:609:: with SMTP id w9mr6937958oti.292.1570111533275;
 Thu, 03 Oct 2019 07:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190927100407.1863293-1-paul.kocialkowski@bootlin.com>
 <20190927100407.1863293-4-paul.kocialkowski@bootlin.com> <CAMpxmJUHPuGPPPFSctyhtfj0oAk6oJ+=mvgN4=7jmLxAfHs45Q@mail.gmail.com>
 <20191003112610.GA28856@aptenodytes>
In-Reply-To: <20191003112610.GA28856@aptenodytes>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 3 Oct 2019 16:05:22 +0200
Message-ID: <CAMpxmJVfgDTNcwk6qmCwfwQkp_tw+8CVbO1mSeHQkBzJgoWLXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] gpio: syscon: Add support for a custom get operation
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 3 pa=C5=BA 2019 o 13:26 Paul Kocialkowski
<paul.kocialkowski@bootlin.com> napisa=C5=82(a):
>
> Hi,
>
> On Thu 03 Oct 19, 10:24, Bartosz Golaszewski wrote:
> > pt., 27 wrz 2019 o 12:04 Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> napisa=C5=82(a):
> > >
> > > Some drivers might need a custom get operation to match custom
> > > behavior implemented in the set operation.
> > >
> > > Add plumbing for supporting that.
> > >
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/gpio/gpio-syscon.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
> > > index 31f332074d7d..05c537ed73f1 100644
> > > --- a/drivers/gpio/gpio-syscon.c
> > > +++ b/drivers/gpio/gpio-syscon.c
> > > @@ -43,8 +43,9 @@ struct syscon_gpio_data {
> > >         unsigned int    bit_count;
> > >         unsigned int    dat_bit_offset;
> > >         unsigned int    dir_bit_offset;
> > > -       void            (*set)(struct gpio_chip *chip,
> > > -                              unsigned offset, int value);
> > > +       int             (*get)(struct gpio_chip *chip, unsigned offse=
t);
> > > +       void            (*set)(struct gpio_chip *chip, unsigned offse=
t,
> > > +                              int value);
> >
> > Why did you change this line? Doesn't seem necessary and pollutes the h=
istory.
>
> This is for consistency since both the "chip" and "offset" arguments can =
fit
> in a single line. Since I want the "get" addition to fit in a single line=
,
> bringing back "offset" on the previous line of "set" makes things consist=
ent.
> There's probably no particular reason for the split in the first place.
>
> Do you think it needs a separate cosmetic commit only for that?
> I'd rather add a note in the commit message and keep the change as-is.
>

The line is still broken - just in a different place. I'd prefer to
leave it as it is frankly, there's nothing wrong with it.

Bart

> Cheers,
>
> Paul
>
> > Bart
> >
> > >  };
> > >
> > >  struct syscon_gpio_priv {
> > > @@ -252,7 +253,7 @@ static int syscon_gpio_probe(struct platform_devi=
ce *pdev)
> > >         priv->chip.label =3D dev_name(dev);
> > >         priv->chip.base =3D -1;
> > >         priv->chip.ngpio =3D priv->data->bit_count;
> > > -       priv->chip.get =3D syscon_gpio_get;
> > > +       priv->chip.get =3D priv->data->get ? : syscon_gpio_get;
> > >         if (priv->data->flags & GPIO_SYSCON_FEAT_IN)
> > >                 priv->chip.direction_input =3D syscon_gpio_dir_in;
> > >         if (priv->data->flags & GPIO_SYSCON_FEAT_OUT) {
> > > --
> > > 2.23.0
> > >
>
> --
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
