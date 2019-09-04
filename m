Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF9DA82C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfIDM1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 08:27:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35305 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfIDM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:27:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so3515831wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NZ96D9puEHxfzquVc6He7xf5nQpmZ8JSWavhp3HobU=;
        b=Yaru825MEoJOrDpdYOPMTkVcccBcPenEdQ38DAGjE1qc4fRskhwLtC4sJyTty778D5
         Uva/akBI4ltEngcEiL8vK8QLEMSP8DStf2kuaEYfuxb59YZzk6I+it15TzFgudqSIvm/
         JYpzqxdJcD9EL+6GNXO/cyWhsQ14m8hncM7bmi+RTx5+S797gfEX5t2+OzH4n+ct+r/z
         6FZ/weoORBRjeNqBDdaPoxQkdkoxGF8yahuvLAse5qJrS6lwTsTBOhtBCaZdOqn9veCO
         MQ+IroPD1KkuKJJH2ArS+/EAJfr5baX4eVXajylVTqGhD5eDTRm0JuGROl9JrnJVlMfb
         b0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NZ96D9puEHxfzquVc6He7xf5nQpmZ8JSWavhp3HobU=;
        b=ufS8nT3juIVFKFKUCJOy6gZQ1hhjPku+4vWB6GwUDe0dZpE5/3teAVhU7ixZOY14uC
         zxyaIlUC+lrxYL6NHGO6sJQUPmMfNbRwZWMoJKRN6gOPb9P0HJbw0CoJWR1BNi5pv3/z
         N4G3aLKWctOMKERRVOpaeydun00cPeEfO8hndvkvGr48niOpEbbzEz8LaS7K/vKJvTM3
         iPPDneGLsFOUfpz07T5Lyi/1p3fNKTXqyYPWo6iZRLy66cCiUvjipzSIlxiU3PrbxdJN
         AqUL/Gcp8C+SG6lSOYFm3UzzG0Nv0vtGldVFR9GFOM62ixg+pCfDVvv4kqr40usrAsHV
         k/eQ==
X-Gm-Message-State: APjAAAUD/r9FNuaP//c6wOz+YOKCeVKOdnmPqu5ZhNOKh3Clu8Iuif8O
        zifAdRsSfDiAIq0N7cp5aINzoF3JJkiBV/LEOktj3A==
X-Google-Smtp-Source: APXvYqzGSenGL1fOlhaP3eM0Wsxh9RQpnRMxJXsQ9c/jnvFT1eATCwySYBcKoufjBaezNjWYU7RdZ9CpNR/9m9WlHbc=
X-Received: by 2002:a1c:2546:: with SMTP id l67mr4370373wml.10.1567600051587;
 Wed, 04 Sep 2019 05:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190902141910.1080-1-yuehaibing@huawei.com> <20190903014518.20880-1-yuehaibing@huawei.com>
 <MN2PR20MB29732EEECB217DDDF822EDA5CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu8PVYyA-mzjrhR6r6upMc=xzpAhsbkuKRtb8T2noo_2XQ@mail.gmail.com> <MN2PR20MB297342698B98343D49FC2C82CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
In-Reply-To: <MN2PR20MB297342698B98343D49FC2C82CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Sep 2019 05:27:19 -0700
Message-ID: <CAKv+Gu_EA8-=Vc3aAdJSz7399Y5WBeKNjw_T3LEq7yOY2XQ+BA@mail.gmail.com>
Subject: Re: [PATCH v2 -next] crypto: inside-secure - Fix build error without CONFIG_PCI
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pvanleeuwen@insidesecure.com" <pvanleeuwen@insidesecure.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 at 05:25, Pascal Van Leeuwen
<pvanleeuwen@verimatrix.com> wrote:
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Sent: Wednesday, September 4, 2019 2:11 PM
> > To: Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
> > Cc: YueHaibing <yuehaibing@huawei.com>; antoine.tenart@bootlin.com;
> > herbert@gondor.apana.org.au; davem@davemloft.net; pvanleeuwen@insidesecure.com; linux-
> > crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 -next] crypto: inside-secure - Fix build error without CONFIG_PCI
> >
> > On Wed, 4 Sep 2019 at 04:57, Pascal Van Leeuwen
> > <pvanleeuwen@verimatrix.com> wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: linux-crypto-owner@vger.kernel.org <linux-crypto-owner@vger.kernel.org> On
> > Behalf Of
> > > > YueHaibing
> > > > Sent: Tuesday, September 3, 2019 3:45 AM
> > > > To: antoine.tenart@bootlin.com; herbert@gondor.apana.org.au; davem@davemloft.net;
> > > > pvanleeuwen@insidesecure.com
> > > > Cc: linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; YueHaibing
> > > > <yuehaibing@huawei.com>
> > > > Subject: [PATCH v2 -next] crypto: inside-secure - Fix build error without CONFIG_PCI
> > > >
> > > > If CONFIG_PCI is not set, building fails:
> > > >
> > > > rivers/crypto/inside-secure/safexcel.c: In function safexcel_request_ring_irq:
> > > > drivers/crypto/inside-secure/safexcel.c:944:9: error: implicit declaration of function
> > > > pci_irq_vector;
> > > >  did you mean rcu_irq_enter? [-Werror=implicit-function-declaration]
> > > >    irq = pci_irq_vector(pci_pdev, irqid);
> > > >          ^~~~~~~~~~~~~~
> > > >
> > > > Use #ifdef block to guard this.
> > > >
> > > Actually, this is interesting. My *original* implementation was using
> > > straight #ifdefs, but then I got review feedback stating that I should not
> > > do that, as it's not compile testable, suggesting to use regular C if's
> > > instead. Then there was quite some back-and-forth on the actual
> > > implementation and I ended up with this.
> > >
> > > So now it turns out that doesn't work and I'm suggested to go full-circle
> > > back to straight #ifdef's? Or is there some other way to make this work?
> > > Because I don't know where to go from here ...
> > >
> >
> >
> > C conditionals are preferred over preprocessor conditional, but if the
> > conditional code refers to symbols that are not declared when the
> > Kconfig symbol is not defined, preprocessor conditionals are the only
> > option.
> >
> Sure, I get that. But I *had* the #ifdef's and then other people told me
> to get rid of them. How is one supposed to know when which symbols are
> declared exactly? Moreover, I feel that if #ifdef's are sometimes the
> only way, then you should be careful providing feedback on the subject.
>

If you compile your code with and without the Kconfig symbol defined,
the compiler will tell you if there is a problem or not.

> > This is the reason we have so many empty static inline functions in
> > header files - it ensures that the symbols are declared even if the
> > only invocations are from dead code.
> >
> This ties back into my previous question: how am I supposed to know whether
> stuff is nicely covered by these empty static inlines or not? If this
> happens to be a hit-and-miss affair.
>

Indeed.

> Note that I tested the code with the 2 platforms at my disposal - actually
> the only 2 relevant platforms for this driver, if you ask me - and they
> both compiled just fine, so I had no way of finding this "problem" myself.
>

Did you try disabling CONFIG_PCI?

> >
> > > > Fixes: 625f269a5a7a ("crypto: inside-secure - add support for PCI based FPGA
> > development
> > > > board")
> > > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > > ---
> > > > v2: use 'ifdef' instead of 'IS_ENABLED'
> > > > ---
> > > >  drivers/crypto/inside-secure/safexcel.c | 13 ++++++++++---
> > > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-
> > > > secure/safexcel.c
> > > > index e12a2a3..5253900 100644
> > > > --- a/drivers/crypto/inside-secure/safexcel.c
> > > > +++ b/drivers/crypto/inside-secure/safexcel.c
> > > > @@ -937,7 +937,8 @@ static int safexcel_request_ring_irq(void *pdev, int irqid,
> > > >       int ret, irq;
> > > >       struct device *dev;
> > > >
> > > > -     if (IS_ENABLED(CONFIG_PCI) && is_pci_dev) {
> > > > +#ifdef CONFIG_PCI
> > > > +     if (is_pci_dev) {
> > > >               struct pci_dev *pci_pdev = pdev;
> > > >
> > > >               dev = &pci_pdev->dev;
> > > > @@ -947,7 +948,10 @@ static int safexcel_request_ring_irq(void *pdev, int irqid,
> > > >                               irqid, irq);
> > > >                       return irq;
> > > >               }
> > > > -     } else if (IS_ENABLED(CONFIG_OF)) {
> > > > +     } else
> > > > +#endif
> > > > +     {
> > > > +#ifdef CONFIG_OF
> > > >               struct platform_device *plf_pdev = pdev;
> > > >               char irq_name[6] = {0}; /* "ringX\0" */
> > > >
> > > > @@ -960,6 +964,7 @@ static int safexcel_request_ring_irq(void *pdev, int irqid,
> > > >                               irq_name, irq);
> > > >                       return irq;
> > > >               }
> > > > +#endif
> > > >       }
> > > >
> > > >       ret = devm_request_threaded_irq(dev, irq, handler,
> > > > @@ -1137,7 +1142,8 @@ static int safexcel_probe_generic(void *pdev,
> > > >
> > > >       safexcel_configure(priv);
> > > >
> > > > -     if (IS_ENABLED(CONFIG_PCI) && priv->version == EIP197_DEVBRD) {
> > > > +#ifdef CONFIG_PCI
> > > > +     if (priv->version == EIP197_DEVBRD) {
> > > >               /*
> > > >                * Request MSI vectors for global + 1 per ring -
> > > >                * or just 1 for older dev images
> > > > @@ -1153,6 +1159,7 @@ static int safexcel_probe_generic(void *pdev,
> > > >                       return ret;
> > > >               }
> > > >       }
> > > > +#endif
> > > >
> > > >       /* Register the ring IRQ handlers and configure the rings */
> > > >       priv->ring = devm_kcalloc(dev, priv->config.rings,
> > > > --
> > > > 2.7.4
> > > >
> > >
> > > Regards,
> > > Pascal van Leeuwen
> > > Silicon IP Architect, Multi-Protocol Engines @ Verimatrix
> > > www.insidesecure.com
>
> Regards,
> Pascal van Leeuwen
> Silicon IP Architect, Multi-Protocol Engines @ Verimatrix
> www.insidesecure.com
>
