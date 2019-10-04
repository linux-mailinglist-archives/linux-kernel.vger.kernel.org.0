Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E1ECC594
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 00:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbfJDWDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 18:03:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35467 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbfJDWDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:03:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so7968548lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7VFtrYB8LeEaQkJ1DeJb6d8IbIcJQwakcs9Nbpjdm8=;
        b=B/IeFnkkWS3RpKsuLqD1d1bPI4D7V/8A7MG4m7yUC2cY+9s4Q75dqxAlyR8PcF79z/
         UOJkyDyxtiS0NZpzhMffx6CmSGqYLlNm95JLYvaJrnl3f7q7zgi1K2jKCpJ4lHuZapvG
         FbRAvMqIY8ZnzyPbAFLiM4zCQ31RpsgNx1BnXNjeVewFxVt7PIG8MEhV3et2lSf3CFpe
         JcFsTc0AQVR1XcX2PqPUuPNmV1BsFDqAWozTFETRpyVmxzBB0Ca3gUajWcYyScSthkkZ
         miMnbbhj4c2ECvLJCbVJkfJCbUYJn1boYB2dtLSPhubRtu0uHVcvcWMZXJO5i7lOnday
         Y6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7VFtrYB8LeEaQkJ1DeJb6d8IbIcJQwakcs9Nbpjdm8=;
        b=b9ZpN9T2H/jK9uXFi7BhT+DTBXm58IKrxDHJXvBL+wZa8Y+sYcSMZ1k65WIgFtdrxQ
         N0m1njpokDhP1h9dg+Fi8vIzw4D/fZv5qbGXIPB2YRcBd34uome67wRJfA6w+amtG9zw
         mnbpG+3/TYnakWy2UExDQp+vg9fmDkaQ5Kx/Fx/OH5ush7+Q+0kebEPWgI/5yTiJ8mfv
         WftMRW3sqE+zUVclqLLqJbNgNICGTpLUKIPjCDyPGOFd+yp3ut48CKuIM1n0np/pqH+7
         atbMyQcEDry75RiT0dduXhPlUR9HAxn0ieD1FPES0uJH89BzmdYHFbWVOkNzGsQnTPIK
         ISNg==
X-Gm-Message-State: APjAAAXoibwgccU554gogJBQzfgMLesPooNu77a0JW0m9a+c2WdMi13a
        +8RpV/tA7vmDlriHX8Rz3CGaiQpbkXaCbCmcEfYTmw==
X-Google-Smtp-Source: APXvYqyayLEeP5GtY+NODuGBcU+zsbAld/JABRRGHZCAz4et/eo3y8m/dSZIPA8S70tZ6ZYfJ0ig358jv/pC+9AXJKE=
X-Received: by 2002:a2e:9094:: with SMTP id l20mr11194298ljg.35.1570226629592;
 Fri, 04 Oct 2019 15:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191002122825.3948322-1-thierry.reding@gmail.com> <20191002122825.3948322-3-thierry.reding@gmail.com>
In-Reply-To: <20191002122825.3948322-3-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Oct 2019 00:03:37 +0200
Message-ID: <CACRpkdYhSu9feBKqFA4wGdWP81fgjNYPHCdC7zaZ+eqO+caw5Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: max77620: Fix interrupt handling
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Timo Alho <talho@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 2:28 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Timo Alho <talho@nvidia.com>
>
> The interrupt-related register fields on the MAX77620 GPIO controller
> share registers with GPIO related fields. If the IRQ chip is implemented
> with regmap-irq, this causes the IRQ controller code to overwrite fields
> previously configured by the GPIO controller code.
>
> Two examples where this causes problems are the NVIDIA Jetson TX1 and
> Jetson TX2 boards, where some of the GPIOs are used to enable vital
> power regulators. The MAX77620 GPIO controller also provides the USB OTG
> ID pin. If configured as an interrupt, this causes some of the
> regulators to be powered off.
>
> Signed-off-by: Timo Alho <talho@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied.

I am looking for ways to pass also nested irqchips along when registering
the gpio_chip but I guess I need to clean up all the chained chips
first (getting there...)

Yours,
Linus Walleij
