Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40440192902
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgCYMyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 08:54:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43989 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgCYMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:54:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id o10so2300377qki.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=povoSIiCw95ZWLQdoXVlSQBApcOXq2d8n4RLuzoEcos=;
        b=N6DjDOyXGLVrfhnKgSW6pYwhh4epm7TFTINbnybcohaJp7bpWPTjI0USi9+zwBuc4p
         hipSxYVV+rwwdBPFATtRmHNSbq9drmSshNOrWWnNWY4e35q5MzM11Qwz7JdPHTaEPVe7
         KkYzRWmWACEsjLgnLFgr8k6IP1yNHynfTX9ojxWfu4rsZgNWab1eqnE/+6qnVxxf5g/c
         cBRRQKv9l3QLeOKufr0zjvgqkc1Ko0Frl7n8tWovOAjazwloVRwnp/PhfIH09D16tqUK
         KSTdpsGNkSk9VT+y0FZinFzhBd5Z/SrfhzUcTbHOsaNuA4UkOCbYnnJRJdzjAVMQ2GpA
         Ljsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=povoSIiCw95ZWLQdoXVlSQBApcOXq2d8n4RLuzoEcos=;
        b=Pt3v1o7XnBhonpCmtpRJ8bLj549HuuYK6urk9A7UzLiO4KDbtzGDiOeaQqkXltaxcL
         IUzHceWCL7W3ts4JiYtZJkPR1IZyrOi2I9JYWSnzkAiPvMG3Lyh1xuvXNWaFPszAu50K
         2nMZUajW9CYicd4pAteRxSKtgYiMWzCyqYrDua6CFr7otgIw/aDkF4hu3zh81HfTPITS
         qpbt486FNd/Z/tAMcDfe4NP52bVi2cUwOGxBavcAEej2TNkWhiWZfRMrCGOULBRmkAkl
         ejP3FXyB28TVt6hGvi5AkKJ4NaPLgQb+Sag7H+S1ZJwRXwlp9nIfWORdNvzpGZdyMtRw
         sN+Q==
X-Gm-Message-State: ANhLgQ1Zjneo4x/aT5d7DutMttWN/fzK1kdRGIcWLanfSKUBSmdX1Lc9
        XmdelQeKna6UBwCHTozpk6hOAWTUl4Uac2ieh5lYCg==
X-Google-Smtp-Source: ADFU+vtYWyCKpiV6HL9KoZ/zSAsthjsfi5/+bVjB5sm9Hxel0UpTO8bItfwOZbQ3YQBl3fq9NQJ/tKrAmphnLe+CO8M=
X-Received: by 2002:a37:c444:: with SMTP id h4mr2801574qkm.120.1585140879852;
 Wed, 25 Mar 2020 05:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200325100439.14000-1-geert+renesas@glider.be>
In-Reply-To: <20200325100439.14000-1-geert+renesas@glider.be>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 25 Mar 2020 13:54:28 +0100
Message-ID: <CAMpxmJVduY65nnS_k+fa8h+5VXtwWjAfWvi5U8b4i99JD5NTxQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] gpiolib: gpio_set_config() cleanups
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 25 mar 2020 o 11:04 Geert Uytterhoeven <geert+renesas@glider.be>
napisa=C5=82(a):
>
>         Hi Linus, Bartosz,
>
> This patch sets reworks the parameters for gpio_set_config() and
> gpio_set_bias(), which simplifies callers, and slightly reduces the
> number of lines of code.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (2):
>   gpiolib: Pass gpio_desc to gpio_set_config()
>   gpiolib: Remove unused gpio_chip parameter from gpio_set_bias()
>
>  drivers/gpio/gpiolib.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> --
> 2.17.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                                             -- Linus Torv=
alds

Both look good to me.

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
