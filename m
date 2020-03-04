Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0791D179382
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 16:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbgCDPfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 10:35:14 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41622 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbgCDPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:35:10 -0500
Received: by mail-vs1-f68.google.com with SMTP id k188so1400611vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=607USbInCPhErOqAR+rQmRLg2cAUXpDH/Wdrk48PRkY=;
        b=HxwjdvIrAhxRWqM0xoHcPCla2sl36KuJ2jfiMJ4/Ah98SMgRhr4WEl8ksuR5VLDptC
         fekPB8aYp1FPKfQZaZ19NssPoj0U9CWqGeYSvdeEJF0wk5VPzSg7WlWwRKFWYXnhA6OT
         fGS6nq2edty0YK3E3OBbXC1O7qYGqLayb89IhfVZbMNZABON1WZxBihJedyu1uwFA3ob
         xMTAxMHv/RHXnzD5tPwiyyEajIJnCWeyD2ElqfRcSxhP0OU2Wew2xwNyZEDDWuT6etL9
         ER2rY1apFQsBvkjQLH6ABUU60hxzwjYD5wFjqLWW6xikxZuahnF3R5ilNiVbdP3BzDcx
         P/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=607USbInCPhErOqAR+rQmRLg2cAUXpDH/Wdrk48PRkY=;
        b=ISp9CYnrKJBpIfNyfOvbr5FxsASIexbxn1OmKMfBb+Fy0LZElGxyL9nifzVk8TblvR
         tCp9dhHXOZLavMXH9kFWsGVfSzVRq6NtWdhCdkNUfSSPHSGBGjbw6/26hjXZfpcyJjpP
         YOFOII6AAMiQS+MA+g/8w+Mg7CYN/anLtGPnQnCx4M2lWvHW9fj+nc/9Ifxg+Sx0UhS3
         UQXRu71nQldzFiSdcszA6RGVJGyMSqw6EnmNh60i2ed0k65MQ5B5n8hm8AgEWvn98/m2
         bJPjQlF/jPQglMohDFL/I0vmNF3w0DL+2+TeJDao81GtITEzI4aIjxCIcQInoLTFKm+s
         xwEQ==
X-Gm-Message-State: ANhLgQ1v278b0zLbmq212Clk4cSQGTqWgWtKcTgMMcCAzuRY7VJIRouw
        KUdSh/tLw4reyyQ4n6vlDxnIhhSU44aHn7E+mY9/dg==
X-Google-Smtp-Source: ADFU+vt5YUaBm2Cv5bwdr+N4lTy0pvVPOqWx1UDOgb8Ufrbuyzw2mN4dBUdswksoPqVVqU33mp1Xm3MVwiAFdqAWsO4=
X-Received: by 2002:a67:f4cf:: with SMTP id s15mr2024303vsn.165.1583336109225;
 Wed, 04 Mar 2020 07:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20200221163147.608677-1-Jerome.Pouiller@silabs.com>
In-Reply-To: <20200221163147.608677-1-Jerome.Pouiller@silabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 16:34:33 +0100
Message-ID: <CAPDyKFq4aNohO6p+Bn=_z11+sEjnZUP6Ny0TWLNALSoTdCcbSA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Fix indentation
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 at 17:32, Jerome Pouiller
<Jerome.Pouiller@silabs.com> wrote:
>
> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> sdio_single_irq_set() was indented with a mix of tabs and spaces.
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
>   - Also add braces arounf for loop (suggested by Joe)
>
>  drivers/mmc/core/sdio_irq.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 900871073bd7..3ffe4ff49aa7 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -276,14 +276,15 @@ static void sdio_single_irq_set(struct mmc_card *ca=
rd)
>
>         card->sdio_single_irq =3D NULL;
>         if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
> -           card->host->sdio_irqs =3D=3D 1)
> +           card->host->sdio_irqs =3D=3D 1) {
>                 for (i =3D 0; i < card->sdio_funcs; i++) {
> -                      func =3D card->sdio_func[i];
> -                      if (func && func->irq_handler) {
> -                              card->sdio_single_irq =3D func;
> -                              break;
> -                      }
> -              }
> +                       func =3D card->sdio_func[i];
> +                       if (func && func->irq_handler) {
> +                               card->sdio_single_irq =3D func;
> +                               break;
> +                       }
> +               }
> +       }
>  }
>
>  /**
> --
> 2.25.1
>
