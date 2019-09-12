Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23119B08D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 08:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfILGcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 02:32:33 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43976 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfILGcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 02:32:33 -0400
Received: by mail-vs1-f65.google.com with SMTP id u21so15428867vsl.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 23:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anandra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3n6GltZO+OtJoQdKROJI96T9MrzZAMOjs1puX9Kbpvo=;
        b=eeSmJ5xcN10sZAnGEHc7gqbVzHCrYTdEovfohCNylc4pLZtuIYAhzjMUD3M1DGIymd
         m/N74veb7vmeZ2JP9x/KxBQ9rh35PjFTIayrjQWOy+QP5+m3DYoZLu2ZGjuJtQ6wBne5
         mRP0tP+WH20jlTsBlohSb3dPGPbmr46j5isRGh0lSSF8CrRu6NXcobR3Mw66kFrZtLyU
         uckshBb+hoPb1NMv0VjL6AO/dxRxtAggeAQ7ky1bDMigvhROajTJXxorAbheefsX0neG
         ShZUGlk46y9t/YxtaI4a1i7M3fFaZpTRpFYDH/13n+uFEOeCsLWk+E+zkBZ8+XgcPx5+
         O6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3n6GltZO+OtJoQdKROJI96T9MrzZAMOjs1puX9Kbpvo=;
        b=AJtg7O0HbsSVJrfNuRYzdq1RycxxlXZZEF/avoIJCs6f8jiTJlHHLAp69uUwZcnHcn
         Cvn113lxAp1EAS+V1iUHxEzHRyFnNfeIk18oFc+WHB6Kd2gbWJ5T8ZaiFvNX1N8+2lmS
         qpjLb9LkwiD1x58pRQmat/kqvtULs1Kq4bdxzBmAvk0C3TKBorRtpE2izlOU+GXNj7Ns
         lzL1EXrplLApTtky2gq4hR6LtJJP6+KWCiW+0C/Pw1YvrZGH3KicK6qlpBxNP9k44Aux
         GH43Gbw8jHPRK53AQof6d2wILTTd2mYbap9x8FyJx9vQt1Q4u79+0W2ndkgvll6pYEZp
         0kRw==
X-Gm-Message-State: APjAAAVdGA09H7ycCjvvd+kg+/aWNWqFKB282llt1U7foa4yC1VR835R
        wVCUohqvX7K4roUi5Xw4c/8CJSR7VO/W9gxnKS+bog==
X-Google-Smtp-Source: APXvYqxvw33app8ehwtG/HmDhiiAhumgM1IZ5mmnHdjYx87w8KSdlbyLbdfva5l2gg3rQlcCuertnre8gSf8mdOAf/4=
X-Received: by 2002:a67:e886:: with SMTP id x6mr22255618vsn.117.1568269950234;
 Wed, 11 Sep 2019 23:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190911114650.20567-1-clabbe.montjoie@gmail.com> <20190911114650.20567-2-clabbe.montjoie@gmail.com>
In-Reply-To: <20190911114650.20567-2-clabbe.montjoie@gmail.com>
From:   Maxime Ripard <maxime.ripard@anandra.org>
Date:   Thu, 12 Sep 2019 08:32:19 +0200
Message-ID: <CAO4ZVTPAX8FsSWHNAbCV3XSEe5BjDM+s9cB_TbF-2t8g-u4TKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] crypto: sun4i-ss: simplify enable/disable of the device
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer. 11 sept. 2019 =C3=A0 13:46, Corentin Labbe
<clabbe.montjoie@gmail.com> a =C3=A9crit :
>
> This patch regroups resource enabling/disabling in dedicated function.
> This simplify error handling and will permit to support power
> management.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/crypto/sunxi-ss/sun4i-ss-core.c | 73 ++++++++++++++-----------
>  1 file changed, 42 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto/sun=
xi-ss/sun4i-ss-core.c
> index 9aa6fe081a27..2c9ff01dddfc 100644
> --- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> +++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> @@ -223,6 +223,41 @@ static struct sun4i_ss_alg_template ss_algs[] =3D {
>  #endif
>  };
>
> +static void sun4i_ss_disable(struct sun4i_ss_ctx *ss)
> +{
> +       if (ss->reset)
> +               reset_control_assert(ss->reset);
> +       clk_disable_unprepare(ss->ssclk);
> +       clk_disable_unprepare(ss->busclk);
> +}

While you're at it, can you add a new line after the reset_control_assert h=
ere?

> +static int sun4i_ss_enable(struct sun4i_ss_ctx *ss)
> +{
> +       int err;
> +
> +       err =3D clk_prepare_enable(ss->busclk);
> +       if (err) {
> +               dev_err(ss->dev, "Cannot prepare_enable busclk\n");
> +               goto err_enable;
> +       }
> +       err =3D clk_prepare_enable(ss->ssclk);
> +       if (err) {
> +               dev_err(ss->dev, "Cannot prepare_enable ssclk\n");
> +               goto err_enable;
> +       }
> +       if (ss->reset) {
> +               err =3D reset_control_deassert(ss->reset);
> +               if (err) {
> +                       dev_err(ss->dev, "Cannot deassert reset control\n=
");
> +                       goto err_enable;
> +               }
> +       }
> +       return err;

And after each block here?

With that fixed:
Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
