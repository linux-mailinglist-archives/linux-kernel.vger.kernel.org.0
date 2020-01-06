Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B3A130FA7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 10:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAFJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 04:39:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34320 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFJjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:39:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so39287175qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 01:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0IMrJL31KOKRhcpikoW9p4q5BiNsVCEDs6+PkVchk4A=;
        b=zDoGTfDZ7XzgIAthgq84UNg7kChkVHrVGfOH6NDLEcxLGdjVwtnx+WMxNJ8Us6eKt/
         n2BtOTZMfLesf81vo9eBoNyJIe+5sXdyOjjeQqylWzPYO+n3O0yxB4NXAAkZdyA0IKyu
         zv6ekCgxVf6FQhRd4d0uDlYKbdQYVij7K4HAOhK4zj2Nq4PZLZFaSU99SKh5xuuzh1/o
         GB9N6ad/sL6xNHL2ddLi+Al9b7dXBYxeH6FYrWAs7NKk6ZpcDJLeq1eNeoqNpFnnj3PK
         ck+mUibdBpoGGNL1slT/0h/WLpWAHuQ6GmDPivQE4fzADhoupSULHHpZKKh3KSFwoc43
         I/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0IMrJL31KOKRhcpikoW9p4q5BiNsVCEDs6+PkVchk4A=;
        b=b0F7TENRnlKppferCBfOf+PrzVr1VtHu9+hRbQQ1xWktEEvb9jNGMR17fFI+8oPVlE
         a6s0hNz1JfPqLm35lMuoS6l+V+o0DSsMtHWYYwFsu/utqCFnEf9bsJ/nB05HaCW4UmG6
         PahFKHdtoBu2uQRrDGlrIc6PmxGoka4oEkA7szh3Nq6UvSpWaHuCbC1gfVWiOAJTo4mx
         Z5CUYXFZfBZf6SJEKiCTyJqofPO3D+NG2mJJ0uPI1bkXSBh94jcSJoEb4byEEI7xpQgS
         s9p8ox+EkBxONsBvE0ElkkitnIE1qxTzmTCy0ibFcu14D0QY4+4AnyiEf7oly2oMcTSm
         LJEw==
X-Gm-Message-State: APjAAAXVTMKukXlKQvEcKtZfRAxsmnRx0SnHBfiDTyNEsPfzS6oy+PY6
        P3/5E9pKYuBhnxEbBO4rRnbfS/amakLoJgZ+gVNg6g==
X-Google-Smtp-Source: APXvYqya1aUi/UEsgS/VKm7A15ONk5Amnry1GpUD58kY7ihGHkOTtlyichZgXhPln8+W/xva2fcjeozl6/S+aDUIF7k=
X-Received: by 2002:a37:6255:: with SMTP id w82mr83028232qkb.330.1578303590820;
 Mon, 06 Jan 2020 01:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20200104194334.12237-1-info@metux.net>
In-Reply-To: <20200104194334.12237-1-info@metux.net>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 6 Jan 2020 10:39:39 +0100
Message-ID: <CAMpxmJXSrF6sDQgCGy+j0NiFVN7NTcxNC9Et4KZxvNbOXRd01w@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpiolib: fix confusing indention
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 4 sty 2020 o 20:49 Enrico Weigelt, metux IT consult
<info@metux.net> napisa=C5=82(a):
>
> There's a confusing indention in gpiochip_add_data_with_key(), which
> could be misinterpreted on a quick walkthrough. Fixing this in order
> to improve code readability a bit.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 3fa2f4d3cdce..d77695cc82ef 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1447,7 +1447,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *ch=
ip, void *data,
>
>         if (chip->ngpio > FASTPATH_NGPIO)
>                 chip_warn(chip, "line cnt %u is greater than fast path cn=
t %u\n",
> -               chip->ngpio, FASTPATH_NGPIO);
> +                         chip->ngpio, FASTPATH_NGPIO);
>
>         gdev->label =3D kstrdup_const(chip->label ?: "unknown", GFP_KERNE=
L);
>         if (!gdev->label) {
> --
> 2.11.0
>

Patch applied, thanks!

Bart
