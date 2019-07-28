Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C812B78215
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 00:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfG1WaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 18:30:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32864 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfG1WaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:30:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so56655389ljg.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdX9YrMQVaxUpfOTBX1O7pLAKJ90DiMSNYDDgK4w6MY=;
        b=uzHn7y7a0Y0/qlrn0YKzbEZHsMJUT2XOGNwHEDmiall7D/hRi7/Pa0PXDWsMKK8M/x
         +T5Ufs0bPMV5NZn4UKxhRQJRiV7HioFeyz42N5YxMlqpe0otIap7wBnrRHIXRlabL6F+
         tIw+FW06ASnNiOMxsazFNARFAoQxhXCx8mVUKVQUiwc6s8eKSGDQ+wV6xvlP+RKVCx69
         AthGteqAMcNz4kes7DpXDFFTXyZdf1plXIwdX4VvK4RzT+DjLMcAtCpSZs6JrLBP3hiD
         AjyFEwNvD7QVeh3gFADQG7mUdVU4Krzz3Mz+hC8ImhnfZx9OK6NL+asd76M5rif4Ggir
         TO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdX9YrMQVaxUpfOTBX1O7pLAKJ90DiMSNYDDgK4w6MY=;
        b=Q27GFw7T1a6+hN87KVvIdToQhK/U9Fvko7Ki6hkXufAzYm8zMIShFRDrY95r1qezoC
         5u7SSKxGJvTTKz19Nr6H8yWmCxR/nNWpOV5HzmHeS0ZPk2zm72wPJHFsn3g/l3zJ6ofW
         st/Y8BMd2JnFG9uAfRNzKVCRxbLJzaLyDPQ/d4vLcM9A1Xk/Tr3piHzK6OXSL57YWt4h
         6T9e68iQizxqhl/Eojcnz7r7Ld78bnvaeNjM1hdHelrHwbP41wBgPZTUDXosF2wvWibU
         vcPtvk48ZdQinrez/CnYs3pU/vyrhb9AW8VJbVHvnhQ6Hh/EnNf1hlXYDBbaXheMr54I
         IxJA==
X-Gm-Message-State: APjAAAVBpXChP1Tglvu7f+uWYUNsnGbvE115kPTjdNtj7LO1fenM9Eh0
        9Aes5w0hTHSWA8o4UY6EnT+naiw+l62vYiBEajxKiw==
X-Google-Smtp-Source: APXvYqyNNR8/uF69NmdXmI2Xz8NIUyywV1VbobmDCsvJZxej/NwUjEoBbVcZtYq2KHv7AytYbnmLcq/B2nAMEoUr/1A=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr8075769ljs.54.1564353021137;
 Sun, 28 Jul 2019 15:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190707023037.21496-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190707023037.21496-1-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:30:09 +0200
Message-ID: <CACRpkdYSDT3pQzNTiHoDdtwMQn32jZ83Q71G=soQ1ycdg+F1ag@mail.gmail.com>
Subject: Re: [PATCH] gpio: remove less important #ifdef around declarations
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 7, 2019 at 4:31 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The whole struct/function declarations in this header are surrounded
> by #ifdef.
>
> As far as I understood, the motivation of doing so is probably to break
> the build earlier if a driver misses to select or depend on correct
> CONFIG options in Kconfig.
>
> Since commit 94bed2a9c4ae ("Add -Werror-implicit-function-declaration")
> no one cannot call functions that have not been declared.
>
> So, I see some benefit in doing this in the cost of uglier headers.
>
> In reality, it would not be so easy to catch missed 'select' or
> 'depends on' because GPIOLIB, GPIOLIB_IRQCHIP etc. are already selected
> by someone else eventually. So, this kind of error, if any, will be
> caught by randconfig bots.
>
> In summary, I am not a big fan of cluttered #ifdef nesting, and this
> does not matter for normal developers. The code readability wins.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Hm I guess you're right.

This patch does not apply cleanly on v5.3-rc1, could you rebase it
and resend?

Yours,
Linus Walleij
