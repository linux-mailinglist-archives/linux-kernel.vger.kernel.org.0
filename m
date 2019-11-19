Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69718102818
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 16:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfKSP23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 10:28:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52597 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfKSP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:28:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id l1so3637005wme.2;
        Tue, 19 Nov 2019 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1HYHJw8McTZ7N/6ctuIe19JHAWc7EsnLv1+FsoeRwIM=;
        b=u9qIYAUd8t1Si1NGOg3iOzUILb8Sj+heMp9IGdkjCh+UY7kNRpR9G9p6hfjhMVjLoO
         lgqL+iWLbCdMNDD98LutY35l7e+i0z0aW1GN4Tg/zs7QDADuBYkOWfUZNbEiwROTvC2l
         IF8cfgQ+l2mcX9lsjGWprjfbJLYR58R0DEPhQfeE/9xMapTb+tR1DiCIBe88G5p1VZ3j
         p9j7wgdbbClKeX9P/RyjfGM5kJvyNYcJWs5iT46psKlJb1xnipnyh6pbTkdQJt6T85mI
         3foU2bYtcRXd2lTglnYdevNqKgbGAMtEg1JghxusgQ9xUNE0c+TWCFpfEiCkY8PRf2lq
         /M2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1HYHJw8McTZ7N/6ctuIe19JHAWc7EsnLv1+FsoeRwIM=;
        b=DJl9PCQN8CghbqgIhzcFC6b6Kc/GF7Do7sR86oOqIJMGNX5/R+54sifRGIiqZ2MJdN
         joPOpo1srpNUwXRty/spM1mhFOwSqco80F0fowkOwsUPL0FPMn5TH+txqnsVbL1orPb/
         fdCTjar1JSRNgePt1m/McibMaHzUueh+QQ/B5/U5c36mo1RrQ8Llht0lzSCcN5Y011U0
         xxLdTFZ6vzTvAjlEAE/8kdVr+2GpawjZfqhI9qYpcCGHHNyuGDaz61fhOPKmtrN3KoTZ
         iul09RG6bH5Tc0ziWkEvYzraAsr2svO9YF6szM8xkJ9mLjTsNY7ODdDwYp9gB34lGv7v
         27aA==
X-Gm-Message-State: APjAAAVdJu/S5iCr6iZySttR2KHhLY2vl+sQE5aV4UTotyGc04LP3LTC
        5xKcxsxmciuWSEl2UyIum66zTVtEhUhTI7L0MR6urla3
X-Google-Smtp-Source: APXvYqxak6WQm7Y4UFKZotBN9GM8x9c4GjEhTUCJ18zzE2ijWISRp4Xk0WbiEHim7BXDKJfmXHILgbrVVQ4jAJ2ennQ=
X-Received: by 2002:a1c:e308:: with SMTP id a8mr6362852wmh.55.1574177306046;
 Tue, 19 Nov 2019 07:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20191118153843.28136-1-andrew.smirnov@gmail.com>
 <20191118153843.28136-6-andrew.smirnov@gmail.com> <19429ab6840292cc9b3003face918a2bff4f8b55.camel@pengutronix.de>
In-Reply-To: <19429ab6840292cc9b3003face918a2bff4f8b55.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 19 Nov 2019 07:28:14 -0800
Message-ID: <CAHQ1cqHJAS1+fNDapu9QuSs_qp6ka9zykD-VihiHyQ4m1hD_Vg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] crypto: caam - replace DRNG with TRNG for use with hw_random
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Chris Healy <cphealy@gmail.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 7:50 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> On Mo, 2019-11-18 at 07:38 -0800, Andrey Smirnov wrote:
> > In order to give CAAM-generated random data highest quarlity
> > raiting (999), replace current code that uses DRNG with code that
> > fetches data straight out of TRNG used to seed aforementioned DRNG.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Horia Geant=C4=83 <horia.geanta@nxp.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-crypto@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> [...]
> > diff --git a/drivers/crypto/caam/trng.c b/drivers/crypto/caam/trng.c
> > new file mode 100644
> > index 000000000000..ab2af786543e
> > --- /dev/null
> > +++ b/drivers/crypto/caam/trng.c
> > @@ -0,0 +1,85 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * hw_random interface for TRNG generator in CAAM RNG block
> > + *
> > + * Copyright 2019 Zoidac Inflight Innovations
>                      ^ Zodiac
>

Ugh, thanks for catching this, will fix in v3

> > + *
> > + */
> > +
> > +#include <linux/hw_random.h>
> > +
> > +#include "compat.h"
> > +#include "regs.h"
> > +#include "intern.h"
> > +
> > +struct caam_trng_ctx {
> > +     struct rng4tst __iomem *r4tst;
> > +     struct hwrng rng;
> > +};
> > +
> > +static bool caam_trng_busy(struct caam_trng_ctx *ctx)
> > +{
> > +     return !(rd_reg32(&ctx->r4tst->rtmctl) & RTMCTL_ENT_VAL);
> > +}
> > +
> > +static int caam_trng_read(struct hwrng *rng, void *data, size_t max, b=
ool wait)
> > +{
> > +     struct caam_trng_ctx *ctx =3D (void *)rng->priv;
> > +     u32 rtent[ARRAY_SIZE(ctx->r4tst->rtent)];
> > +     size_t residue =3D max;
> > +
> > +     clrsetbits_32(&ctx->r4tst->rtmctl, 0, RTMCTL_ACC);
> > +
> > +     do {
> > +             const size_t chunk =3D min(residue, sizeof(rtent));
> > +             unsigned int i;
> > +
> > +             while (caam_trng_busy(ctx)) {
>
> The CAAM needs quite a bit of time to gather the 384bits of raw
> entropy, in my testing it was almost 60ms. A busy loop (even with a
> cpu_relax) for such an extended amount of time is probably not
> appropriate, better sleep for some time here.
>

Good point, will fix in v3.

> Also in the !wait case we are almost guaranteed to leave this function
> without any entropy gathered. Maybe we should just bail out on !wait
> without even trying to enable the TRNG access?
>

Yeah, I think you're right. Will change in v3.

Thanks,
Andrey Smirnov
