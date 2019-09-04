Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A677DA7910
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 04:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfIDCzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 22:55:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36687 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfIDCzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:55:54 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so16748839iof.3;
        Tue, 03 Sep 2019 19:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7KAHv1e63QK9hCRccVZugLye8tI2fhDiGMo9YSU17+k=;
        b=NJoNsQJFq84KLUFHY7UF2Gj+5i1DC2QrkkF3c2BI/l+/qelsHvd9IPqek+VF0v6pPH
         a+Ftiz0FoLR3DtdpAUhM3w7unJ9XkpR25N7C+ICbsrvwwA6IATHtu8OMHizph2d446rH
         I9N2zQgWCeHLsZ+T3GHmZwG1BzCSOqvxPGEDPCaxTZfXhZrX+CL0nAFVBZEpDtMX42ao
         t8GztDVo3ciyEUIsv/Jz5ZAhpkhOj1Exwj0GOhi1tySoOjIL9nZelQNS1dwcTBc1fzkK
         uW+XZ9N5gpT8Yry8dRcfiueZPc0Fqi4P1pCaJpqahIOqLSj1PtjSFRtS3ZV2oOhdHnk1
         XBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7KAHv1e63QK9hCRccVZugLye8tI2fhDiGMo9YSU17+k=;
        b=ZfvSP2PYu4dYEfIZDxPZWUGsi47NiJNYuHkLB4kuzKYZqAqvh5xYagAc+QMOpfWM6G
         tCKqsw+N1zHxeHW1gxabzstTsvLwEotN9DntxLzdSDWOR92h4aCrPRx6uo3ALxkMvTG/
         BFvQPM25q+DHM3s8TpVaNEK8q6XpMq3a5y6eDzUgziZHshQD1N6oP0kKxRjxXX3QOoXR
         r11EaVMfhfP8u+gNt1whZCBW9Sd+UoX+f++fpCJ5pG/0l+r0MmrDPymBxVKx/tmNse/6
         Gt8yM98DjzDVBDbEe3kRdNr0Uazo9txWLeyNWCSQxXOz5b6ahZpKHmlGow81nY3lTsfp
         8cJQ==
X-Gm-Message-State: APjAAAXDhRtPrJKdnx4Hwh1tHToUASXYIp/PstnTvlprjQrOnTM4usH5
        tVUeQroCTH6tIOazxC+pJuPe4Rx1Prnwiy2lR7c=
X-Google-Smtp-Source: APXvYqy6DIeTsmKuzWXHD8W0nCChr0Alz2XaxQY19OH+kuUIfOdhhVc9KFZZeaXvRXwFufqw05eVIm+j3dVI5LKa8Ow=
X-Received: by 2002:a5d:8502:: with SMTP id q2mr23512677ion.287.1567565753605;
 Tue, 03 Sep 2019 19:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190904023515.7107-1-andrew.smirnov@gmail.com>
 <20190904023515.7107-3-andrew.smirnov@gmail.com> <CAOMZO5DoaLkycXOfzYQv2CHKSRA9sri5igaVSNhQvxR06Gzv+g@mail.gmail.com>
In-Reply-To: <CAOMZO5DoaLkycXOfzYQv2CHKSRA9sri5igaVSNhQvxR06Gzv+g@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 3 Sep 2019 19:55:42 -0700
Message-ID: <CAHQ1cqH+aoXVdfhDBmRNr=+NO6y82dXU2YRHWquJwPnunJH9gQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] crypto: caam - use devres to unmap JR's registers
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 7:43 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Tue, Sep 3, 2019 at 11:37 PM Andrey Smirnov <andrew.smirnov@gmail.com>=
 wrote:
> >
> > Use devres to unmap memory and drop explicit de-initialization
> > code.
> >
> > NOTE: There's no corresponding unmapping code in caam_jr_remove which
> > seems like a resource leak.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Horia Geant=C4=83 <horia.geanta@nxp.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
> > Cc: linux-crypto@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/crypto/caam/jr.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
> > index 417ad52615c6..7947d61a25cf 100644
> > --- a/drivers/crypto/caam/jr.c
> > +++ b/drivers/crypto/caam/jr.c
> > @@ -498,6 +498,7 @@ static int caam_jr_probe(struct platform_device *pd=
ev)
> >         struct caam_job_ring __iomem *ctrl;
> >         struct caam_drv_private_jr *jrpriv;
> >         static int total_jobrs;
> > +       struct resource *r;
> >         int error;
> >
> >         jrdev =3D &pdev->dev;
> > @@ -513,9 +514,15 @@ static int caam_jr_probe(struct platform_device *p=
dev)
> >         nprop =3D pdev->dev.of_node;
> >         /* Get configuration properties from device tree */
> >         /* First, get register page */
> > -       ctrl =3D of_iomap(nprop, 0);
> > +       r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!r) {
> > +               dev_err(jrdev, "platform_get_resource() failed\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       ctrl =3D devm_ioremap(jrdev, r->start, resource_size(r));
>
> It seems that using devm_platform_ioremap_resource() could make the
> code even smaller.

Unfortunately that function would do devm_ioremap_resource() under the
hood and claim the ownership of the corresponding memory region.
That's going to create a conflict with devm_of_iomap() used in
"crypto: caam - use devres to unmap memory".

Thanks,
Andrey Smirnov
