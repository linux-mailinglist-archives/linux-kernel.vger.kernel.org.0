Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC0E15AD48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 17:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgBLQXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 11:23:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33940 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgBLQXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:23:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so1152008plt.1;
        Wed, 12 Feb 2020 08:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuS3UA1IgBJUj+Wpff0h1v7oXXukTf3YUcZ7+4lm5Pc=;
        b=ZBz6nbVg0BvKO4Kpp4xvT89r/oVFpqbGIv6DR+w3SZFiDgfpiCsa6srQmCI7ILhPsg
         ftsBjyXrlU+BY6jaNV2yB9qcscoalG03jvehW6GwpDD7HLsYyyPpMnkh9zMVvo8bT9OV
         WY7wem6cbcoBfg1yjGFvHS+IbXfECEzMnhhsTxFINGSMv+utJY7AyzknnwDbd/gzNGjh
         7yWTVzwMm78qnN7L7BeNToUPFxxslox45BOqW3slHHfw1nIyKT/Wl+WvOE3oXoQnKHb+
         Do/jOgYPgDl55OtppFGbDAmiQ+TnOUerZWMq/6crZdwYG6W+rF1Q3FCiXMfFtNqdNEtp
         ODgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuS3UA1IgBJUj+Wpff0h1v7oXXukTf3YUcZ7+4lm5Pc=;
        b=Git5yNlMuwbZhJmZKkCQyphCFxle8rkhieJlvvNQfj0ACx79U1j47S1fSfAhe8VfpJ
         jwANpOrig2bCBa6QgdXVmmf5jMN/nE8MHo7LKwXMGf+WIbinT6v2GE9+s0hI6vwAjJaY
         s86DhuC4+aeUoSyMfD7PmLgfy68mE8q/8+dya+VKZABgkmYzNiYvwhnhVDgGmHxLMurP
         dTZnHEOJF/Pd3gnjmK43Ab+NwfglRxIetiKlGjUtactG7BekRWbq7W9dJtRV+ThJZnaH
         s4HazdbSDca+eVXXKYsixDZ91tXuGE7KMsbytG6GonIfxSldYwwNy27gjE4UxucV8ZJ2
         6Npw==
X-Gm-Message-State: APjAAAVd+ICO1NrqGNhU4tws5aWcmYGWczAOMZ4k8f2AB+QxIdvjTb8w
        sTHp92Ga6kbfdFUKnxyy2zI9xPRyktstOHNSQvc=
X-Google-Smtp-Source: APXvYqyQ68Kti3qwh42kkGAhB0AUJ6hfRU+pu7Wom3J96ut79md2/f+Fd78hgzJvaOGt2BLMWtLQct6myw5vSBS/bc8=
X-Received: by 2002:a17:902:9342:: with SMTP id g2mr8825074plp.339.1581524600442;
 Wed, 12 Feb 2020 08:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20200128110102.11522-1-martin@kaiser.cx> <20200128110102.11522-6-martin@kaiser.cx>
In-Reply-To: <20200128110102.11522-6-martin@kaiser.cx>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 12 Feb 2020 21:53:09 +0530
Message-ID: <CANc+2y6oasMLCzDJAebFca4yoWWTL4r3Esyws-K5EuMLwbuAqA@mail.gmail.com>
Subject: Re: [PATCH 5/6] hwrng: imx-rngc - check the rng type
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 at 16:31, Martin Kaiser <martin@kaiser.cx> wrote:
>
> Read the rng type and hardware revision during probe. Fail the probe
> operation if the type is not one of rngc or rngb.
> (There's also an rnga type, which needs a different driver.)
>
> Display the type and revision in a debug print if probe was successful.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/char/hw_random/imx-rngc.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
> index 8222055b9e9b..27d85fced30b 100644
> --- a/drivers/char/hw_random/imx-rngc.c
> +++ b/drivers/char/hw_random/imx-rngc.c
> @@ -18,12 +18,22 @@
>  #include <linux/completion.h>
>  #include <linux/io.h>
>
> +#define RNGC_VER_ID                    0x0000
>  #define RNGC_COMMAND                   0x0004
>  #define RNGC_CONTROL                   0x0008
>  #define RNGC_STATUS                    0x000C
>  #define RNGC_ERROR                     0x0010
>  #define RNGC_FIFO                      0x0014
>
> +/* the fields in the ver id register */
> +#define RNGC_TYPE_SHIFT                28
> +#define RNGC_VER_MAJ_SHIFT             8
> +
> +/* the rng_type field */
> +#define RNGC_TYPE_RNGB                 0x1
> +#define RNGC_TYPE_RNGC                 0x2
> +
> +
>  #define RNGC_CMD_CLR_ERR               0x00000020
>  #define RNGC_CMD_CLR_INT               0x00000010
>  #define RNGC_CMD_SEED                  0x00000002
> @@ -212,6 +222,8 @@ static int imx_rngc_probe(struct platform_device *pdev)
>         struct imx_rngc *rngc;
>         int ret;
>         int irq;
> +       u32 ver_id;
> +       u8  rng_type;
>
>         rngc = devm_kzalloc(&pdev->dev, sizeof(*rngc), GFP_KERNEL);
>         if (!rngc)
> @@ -237,6 +249,17 @@ static int imx_rngc_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> +       ver_id = readl(rngc->base + RNGC_VER_ID);
> +       rng_type = ver_id >> RNGC_TYPE_SHIFT;
> +       /*
> +        * This driver supports only RNGC and RNGB. (There's a different
> +        * driver for RNGA.)
> +        */
> +       if (rng_type != RNGC_TYPE_RNGC && rng_type != RNGC_TYPE_RNGB) {
> +               ret = -ENODEV;
> +               goto err;
> +       }
> +
>         ret = devm_request_irq(&pdev->dev,
>                         irq, imx_rngc_irq, 0, pdev->name, (void *)rngc);
>         if (ret) {
> @@ -269,7 +292,10 @@ static int imx_rngc_probe(struct platform_device *pdev)
>                 goto err;
>         }
>
> -       dev_info(&pdev->dev, "Freescale RNGC registered.\n");
> +       dev_info(&pdev->dev,
> +               "Freescale RNG%c registered (HW revision %d.%02d)\n",
> +               rng_type == RNGC_TYPE_RNGB ? 'B' : 'C',
> +               (ver_id >> RNGC_VER_MAJ_SHIFT) & 0xff, ver_id & 0xff);
>         return 0;
>
>  err:
> --
> 2.20.1
>

Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
