Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39517183228
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 14:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCLNze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 09:55:34 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39085 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgCLNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:55:34 -0400
Received: by mail-vk1-f195.google.com with SMTP id t129so1585547vkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3uuC3dwn0tC5WDh43z+Qz3cNZTanvUjHY5K/ioZRrE=;
        b=KVkVoA2k473yz0FJ1dnZvdkbqNXVgnmOKYeMLASFd+4bSsxq5NXs1+7o8r3p9WtTjE
         dkXtgcZAcltgvd/hSXf0jyAfcWOy4O+uFY79LpGpQSK2nqebK3t+BwbvklghCJutN99P
         6yO7hRXTMpLRdUJkZn+ZahduFDqpulDoa0xLbWnv67CuJk4DY5WfjjnA5zeDuRcrIUIe
         iLUC1jmVqd0X3FMCG9O9mIAzG/HvJsm4zjcDumzRlBmQvfodAky3Pn/LEKNXs8yZRg9l
         jC0lZMI+kCP/Vc3flcV3ewrQXXxRtcrWQy9zY7bV/OZTmsXn0q+se6I2okHonk1GL4Vi
         DWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3uuC3dwn0tC5WDh43z+Qz3cNZTanvUjHY5K/ioZRrE=;
        b=l3StCGn69BUtse1NqlPT6/xgu6mgdyOdvfbkEGJbE8NWV8oLKvioOgA1L6XWXA7yu7
         BrXTYj0zSBpjPKQW/7OlEmGUerWNG8FuKJ8yPuONsVbUltu1gHRMoPO7nnVWoD96RfEj
         0bjj3R6jceC+NmWWpSOVsPLxvLrZK6LtE5CAHE1pPQZtGqJSHFio0K/ZEB3LQJpqDjyA
         sOiuXOFWLGar6ijLL2BUAeAHZUr6tBRhg4fWtpKaNPdTDLbEt/8gm5SV3ksVtTzzGTZz
         bdo0S98Ak3yRyPO088mN6GCxBpH4Uxjvx3pvyT4hB+6XqpG7rb1dYFVyz+PPGrqVMpbb
         vFQQ==
X-Gm-Message-State: ANhLgQ1rNEURWf4HWsLZn7kPmNw8Vu+ja1c6C94QCh+Susq2ufg4Hlb/
        dhsUpoYk6oPVQGIRYmafY6pXA7eW99ZUDew53NCKHQ==
X-Google-Smtp-Source: ADFU+vtnsiNcMca52ukoHC3qr+zfMoqmRF6BTsGwzWrnwAJ6XL1pJpX6SsAHKanNqeMSKOOjxyqGYzIy0bSZmwnEFSI=
X-Received: by 2002:a05:6122:1065:: with SMTP id k5mr5346841vko.14.1584021332168;
 Thu, 12 Mar 2020 06:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200306132448.13917-1-Sergey.Semin@baikalelectronics.ru> <20200306132519.2AC268030797@mail.baikalelectronics.ru>
In-Reply-To: <20200306132519.2AC268030797@mail.baikalelectronics.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 14:55:20 +0100
Message-ID: <CACRpkdaU1f_RM8GDPxj_2qaiBsJ5JLnKp=ryZxAYMp2YhTDKWA@mail.gmail.com>
Subject: Re: [PATCH 4/4] gpio: dwapb: Add debounce reference clock support
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

thanks for your patch!

On Fri, Mar 6, 2020 at 2:25 PM <Sergey.Semin@baikalelectronics.ru> wrote:

> +       err = devm_clk_bulk_get_optional(&pdev->dev, DWAPB_NR_CLOCKS,
> +                                        gpio->clks);
> +       if (err) {
> +               dev_info(&pdev->dev, "Cannot get APB/Debounce clocks\n");

dev_err() again.

> +       err = clk_bulk_prepare_enable(DWAPB_NR_CLOCKS, gpio->clks);
>         if (err) {
> -               dev_info(&pdev->dev, "Cannot enable APB clock\n");
> +               dev_info(&pdev->dev, "Cannot enable APB/Debounce clocks\n");

dev_err() again.

Yours,
Linus Walleij
