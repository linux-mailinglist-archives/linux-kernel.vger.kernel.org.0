Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5623B15F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 10:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbfFJIzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 04:55:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45152 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388777AbfFJIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:55:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so8279719wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GpySo1g8LDVz9k5a5vKZQ7sUTfsxzgZnBVStPDXVsTE=;
        b=TLJxZMAGuxy/AarP67BjcpuFCdXmgR43IKr0+QKdb6Ol6EwjkgW464DzS62DwAo+dO
         4l3D0glt/AANh00dpOKeX5lgOGgnaHX5MLKI65hRHi1lyXRAlxo+62OuFKkD2ZaRQmV/
         rI8WIiHsmp51LUX4YV67upchYnpEWrPy/SORxZ7qXCtZ2qHX3OSg2GFqUgV0Qmye4QRn
         vHth3Dz6FslHlbL0Hr2s3SDTPwXw4Rw1HdBy85K9V5tOqQ5Vt0wKY5E3wp4wLIRhsXug
         FNL3oCKSL/XBHtVjEY+6D6WgGpP7i050rJ6/+HHW2jGvqbrA7bIIrN60uwfYlIt2VUPj
         LJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GpySo1g8LDVz9k5a5vKZQ7sUTfsxzgZnBVStPDXVsTE=;
        b=QOnVsTHuGbhI/RY3rtIK2liXLb0bYC4+LOSnsihoDKhYzB+rTkKIAJDp5R4ZgZWUNj
         O67eTgYA+yGmZJ33vyJ9M7aw9wLq3muhMO1MgjkYKAjFv/UcpZJvPWr9x7VV9TkK+t91
         LqlUaC3M+qZ5v3LVnaAHowyOELS+3jEhIkhI7fDW4Ky/+zsOcxVjlohKhmIiqOsPImdm
         87i7NELJLjP1SZiZrCz1IToEQrHwYxQsUbUe7mwf7A48Pr3Wi8vWkHR0PQSNv89Qr0gB
         8P7Zw4TjrfHXDuegIJWo+8ZKGADBU+dYRWRrnaN+03WMBCOSM7UxlEx1NN6eGjAcdNWg
         vT+A==
X-Gm-Message-State: APjAAAX/UXTSsQKQDoXMx65WA65pvdZdkw1zy927VodFHwvwst15YmaB
        pe99GeZR3ZEigEbWWQNmmOzdkw==
X-Google-Smtp-Source: APXvYqyjQYjI9vIrm/FNhIBXPO/+5VtKCSvydqLfAPGAnBQLd3gOIGqGaZYrgEZEfWBncvk0AvMC2A==
X-Received: by 2002:adf:aa09:: with SMTP id p9mr23598944wrd.59.1560156944579;
        Mon, 10 Jun 2019 01:55:44 -0700 (PDT)
Received: from dell ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id x129sm13809283wmg.44.2019.06.10.01.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 01:55:44 -0700 (PDT)
Date:   Mon, 10 Jun 2019 09:55:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        wsa+renesas@sang-engineering.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, balbi@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jlhugo@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/8] pinctrl: qcom: sdm845: Provide ACPI support
Message-ID: <20190610085542.GL4797@dell>
References: <20190610084213.1052-1-lee.jones@linaro.org>
 <20190610084213.1052-4-lee.jones@linaro.org>
 <CAKv+Gu_s7i8JC4cv-dJMvm1_0cGzzhzf+Dxu0rxcF7iugF=vHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKv+Gu_s7i8JC4cv-dJMvm1_0cGzzhzf+Dxu0rxcF7iugF=vHg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019, Ard Biesheuvel wrote:

> On Mon, 10 Jun 2019 at 10:42, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > This patch provides basic support for booting with ACPI instead
> > of the currently supported Device Tree.  When doing so there are a
> > couple of differences which we need to taken into consideration.
> >
> > Firstly, the SDM850 ACPI tables omit information pertaining to the
> > 4 reserved GPIOs on the platform.  If Linux attempts to touch/
> > initialise any of these lines, the firmware will restart the
> > platform.
> >
> > Secondly, when booting with ACPI, it is expected that the firmware
> > will set-up things like; Regulators, Clocks, Pin Functions, etc in
> > their ideal configuration.  Thus, the possible Pin Functions
> > available to this platform are not advertised when providing the
> > higher GPIOD/Pinctrl APIs with pin information.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> For the ACPI probing boilerplate:
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> *However*, I really don't like hardcoding reserved GPIOs like this.
> What guarantee do we have that each and every ACPI system
> incorporating the QCOM0217 device has the exact same list of reserved
> GPIOs?

This is SDM845 specific, so the chances are reduced.

However, if another SDM845 variant does crop up, also lacking the
"gpios" property, we will have to find another differentiating factor
between them and conduct some matching.  What else can you do with
platforms supporting non-complete/non-forthcoming ACPI tables?

> > ---
> >  drivers/pinctrl/qcom/Kconfig          |  2 +-
> >  drivers/pinctrl/qcom/pinctrl-sdm845.c | 36 ++++++++++++++++++++++++++-
> >  2 files changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> > index 2e66ab72c10b..aafbe932424f 100644
> > --- a/drivers/pinctrl/qcom/Kconfig
> > +++ b/drivers/pinctrl/qcom/Kconfig
> > @@ -168,7 +168,7 @@ config PINCTRL_SDM660
> >
> >  config PINCTRL_SDM845
> >         tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
> > -       depends on GPIOLIB && OF
> > +       depends on GPIOLIB && (OF || ACPI)
> >         select PINCTRL_MSM
> >         help
> >           This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> > diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > index c97f20fca5fd..98a438dba711 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > @@ -3,6 +3,7 @@
> >   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> >   */
> >
> > +#include <linux/acpi.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> > @@ -1277,6 +1278,10 @@ static const struct msm_pingroup sdm845_groups[] = {
> >         UFS_RESET(ufs_reset, 0x99f000),
> >  };
> >
> > +static const int sdm845_acpi_reserved_gpios[] = {
> > +       0, 1, 2, 3, 81, 82, 83, 84, -1
> > +};
> > +
> >  static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
> >         .pins = sdm845_pins,
> >         .npins = ARRAY_SIZE(sdm845_pins),
> > @@ -1287,11 +1292,39 @@ static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
> >         .ngpios = 150,
> >  };
> >
> > +static const struct msm_pinctrl_soc_data sdm845_acpi_pinctrl = {
> > +       .pins = sdm845_pins,
> > +       .npins = ARRAY_SIZE(sdm845_pins),
> > +       .groups = sdm845_groups,
> > +       .ngroups = ARRAY_SIZE(sdm845_groups),
> > +       .reserved_gpios = sdm845_acpi_reserved_gpios,
> > +       .ngpios = 150,
> > +};
> > +
> >  static int sdm845_pinctrl_probe(struct platform_device *pdev)
> >  {
> > -       return msm_pinctrl_probe(pdev, &sdm845_pinctrl);
> > +       int ret;
> > +
> > +       if (pdev->dev.of_node) {
> > +               ret = msm_pinctrl_probe(pdev, &sdm845_pinctrl);
> > +       } else if (has_acpi_companion(&pdev->dev)) {
> > +               ret = msm_pinctrl_probe(pdev, &sdm845_acpi_pinctrl);
> > +       } else {
> > +               dev_err(&pdev->dev, "DT and ACPI disabled\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       return ret;
> >  }
> >
> > +#if CONFIG_ACPI
> > +static const struct acpi_device_id sdm845_pinctrl_acpi_match[] = {
> > +       { "QCOM0217"},
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, sdm845_pinctrl_acpi_match);
> > +#endif
> > +
> >  static const struct of_device_id sdm845_pinctrl_of_match[] = {
> >         { .compatible = "qcom,sdm845-pinctrl", },
> >         { },
> > @@ -1302,6 +1335,7 @@ static struct platform_driver sdm845_pinctrl_driver = {
> >                 .name = "sdm845-pinctrl",
> >                 .pm = &msm_pinctrl_dev_pm_ops,
> >                 .of_match_table = sdm845_pinctrl_of_match,
> > +               .acpi_match_table = ACPI_PTR(sdm845_pinctrl_acpi_match),
> >         },
> >         .probe = sdm845_pinctrl_probe,
> >         .remove = msm_pinctrl_remove,
> >

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
