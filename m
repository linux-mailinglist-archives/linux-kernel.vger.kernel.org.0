Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79740DD849
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 13:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfJSLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Oct 2019 07:02:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41644 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfJSLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 07:02:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so4115820plr.8;
        Sat, 19 Oct 2019 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vfy+N0HJhkAd61mrrTJP7hxadvxbbC71f+cce+TmuA=;
        b=W7n+E/u3skiQ69pm1r7wfiQo/HU+SGSsoYnyphLGGuj6GbMoTchFaWcEpzR3XaUslW
         MQ/wldf9yirYieBFgywlacB++8Wj6XtB6uyxw2LlKlyimR18FN4wEAAb7ZoLnYzgKhL6
         ySdCN3KsUrxZxMTlKYyg3lF/XLb1eMyxb5qSOMofJ8rPVlIuEthqo+NOTdljo+lkyW18
         jlJjRgr8wU1caPZaZXulDnRJLkqZ9egUyYT93tfOQL/LH2VYcDO++R5QKAwC2zMNRhbE
         ew2orPElf9jVtnaWC3t50Q2A/K+m8NSMC2Eg6eagicT1HAtgOdKVP5VFwbkEe8T+oxkK
         g9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vfy+N0HJhkAd61mrrTJP7hxadvxbbC71f+cce+TmuA=;
        b=CO9Sn7BlDowB/uYCdEOyR+CkbuKkhfIxScpnmvRwzCmt2CZo5Kvz7sgDgSCUJGvP2i
         yGk0DafUoete86hsNUqa855RDTM/8L7zpxqQK2tJ5Bl5kEXo+xuqRq/dCvuBWzjnBmXy
         po0AO6uDEPqscw+NWF6ME0pwqrvQ4D92IyqZm6Nd9MnLi31R3NxCIEXh0i9Zf/40MIKK
         8eO+PvpO1IH6zbyN8TSEvc+fBdEu1g51dIelaiFSd4w5/1aM4FqlnZ0PwdJBaBK+mLq9
         EZD81xn6CqdFfIgtQqFeQSWIiMWfOAD8FzzDncALmATkmKQTC/uZvUngYW1JsD6RK7YT
         Pkqg==
X-Gm-Message-State: APjAAAUwy8QIUv9gAGrtQQkF4JWLJqT4TXoq0FdlZbT/SEFqtZDZbWsX
        eNSrpfV9xU5WyiNyHUUDT4MPYjXryEVSpw8JFRw=
X-Google-Smtp-Source: APXvYqy0jhNhM7VCGYDN6zC4fxv2N1BdCAnSObzuZ5kjaQlx8tPwUMTzmZr/2ccoou/lgJfv6KsGWPIZ4irbf5K8gIc=
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr14373482plr.262.1571482957267;
 Sat, 19 Oct 2019 04:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191019083556.19466-1-brgl@bgdev.pl> <20191019083556.19466-3-brgl@bgdev.pl>
In-Reply-To: <20191019083556.19466-3-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 19 Oct 2019 14:02:25 +0300
Message-ID: <CAHp75VcBWk6xiFKejuN7qq8yAcubxbfW6GfvL7hOdQWxfoDBzg@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] backlight: gpio: remove stray newline
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 12:58 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Remove a double newline from the driver.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/video/backlight/gpio_backlight.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
> index 7e1990199fae..3955b513f2f8 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -91,7 +91,6 @@ static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
>         return FB_BLANK_UNBLANK;
>  }
>
> -
>  static int gpio_backlight_probe(struct platform_device *pdev)
>  {
>         struct gpio_backlight_platform_data *pdata =
> --
> 2.23.0
>


-- 
With Best Regards,
Andy Shevchenko
