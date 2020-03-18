Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93FC01897B4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 10:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCRJPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 05:15:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36681 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgCRJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:15:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id u25so37511792qkk.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8+ePRCjp2COuxHOwe4fehGApC+vyauxE5AKc9JXm2Bc=;
        b=QJqSNg8Psy4iKtjCBvszKB2g2XSpz9hUQBtOUZRdQsBtrZF/T5Vkx30wbzKCtfTnMv
         HX9EgYZNdRvnkRyxansVwKdnvaIVQ69xRf5SHo6o9rr8nB2nq/r0TtpsaPkFnszstZD+
         YI5dw0bxrtOBN7cMH4nKiW1GrnGWMEPu4wB/rZ4cZJPGt/BiLvg97OBHd4gNwvf5e1HP
         LCI3txsnGbaQBmw5BTW4NaroF79V/WoRY6qzU8xMXhdNjuvqs9KjvjHNTRHJkNnob80I
         AXleCzpdbpi8fWr5pO4IBOFBFRmmtiG+p0HlCKaqs2Nm2RVxsCbOQedeixq8BvW7fsFe
         TY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8+ePRCjp2COuxHOwe4fehGApC+vyauxE5AKc9JXm2Bc=;
        b=e+dpIkLJcnmrmx7LIsfWqPCO9NQbblCaTTGwAA7KnYL0bvuKyLwzCKlFqJnEISawq/
         AXinC5g+2BpWr6wh23+cyLYBOhOwfEIg0f8Dx1yF38ltSveFpXkmWX8XfP/8RBc1lsI0
         16aO4zMS4tKj/GJZmk+Xs4ygFUq4CqLhvuWoKe9xyO3C9B0bmOg5XVsUy16+1pB/PXKx
         gpEXazmwj0XmP71LKQxIqWEHZ/VVNJuBKYtUoq31KNlpwlOeh24kAREmqf+qYODLOW4H
         9ifykjUtf/gUO/LJ5/TZFrXFigX9LnAtClK1f1ySEqst3ly78jCzK1O3k+HrNqGCNqcL
         xLVg==
X-Gm-Message-State: ANhLgQ0m6ukMaNe4rFAtC5E8+0dWBnzUPhrM+wUed5B9dduE42KMq/7c
        oHu6+kQrnf/ZXSFf50RaeEi5OQs6gW/7njg19nylMxwT
X-Google-Smtp-Source: ADFU+vucljXV9cDR4psrQ9kMHd8pH3XRVFw7ths8JrGC+4S1GOKCYJkhhHl0AMAeLANHqBbRNLg2ovvvEI52ejnn8IQ=
X-Received: by 2002:a37:3c9:: with SMTP id 192mr3031931qkd.330.1584522927690;
 Wed, 18 Mar 2020 02:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584456635.git.mchehab+huawei@kernel.org> <51197e3568f073e22c280f0584bfa20b44436708.1584456635.git.mchehab+huawei@kernel.org>
In-Reply-To: <51197e3568f073e22c280f0584bfa20b44436708.1584456635.git.mchehab+huawei@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 18 Mar 2020 10:15:16 +0100
Message-ID: <CAMpxmJXW51AhqL8EMch6myth9fLQ2XnO6nC8NztJL3=ZiH0kdA@mail.gmail.com>
Subject: Re: [PATCH 12/17] gpio: gpiolib.c: fix a doc warning
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 17 mar 2020 o 15:54 Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> napisa=C5=82(a):
>
> Use a different markup for the ERR_PTR, as %FOO doesn't work
> if there are parenthesis. So, use, instead:
>
>         ``ERR_PTR(-EINVAL)``
>
> This fixes the following warning:
>
>         ./drivers/gpio/gpiolib.c:139: WARNING: Inline literal start-strin=
g without end-string.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index f31b1d46599e..74d8973025da 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -136,7 +136,7 @@ EXPORT_SYMBOL_GPL(gpio_to_desc);
>   * @hwnum: hardware number of the GPIO for this chip
>   *
>   * Returns:
> - * A pointer to the GPIO descriptor or %ERR_PTR(-EINVAL) if no GPIO exis=
ts
> + * A pointer to the GPIO descriptor or ``ERR_PTR(-EINVAL)`` if no GPIO e=
xists
>   * in the given chip for the specified hardware number.
>   */
>  struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip,
> --
> 2.24.1
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
