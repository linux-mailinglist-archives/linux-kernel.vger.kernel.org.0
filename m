Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DE9388B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 13:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfFGLOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 07:14:23 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38168 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfFGLOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:14:23 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so2095758itk.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 04:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9U1m6mU0o53HGYsINghj1de9Jt3i01TslgdBoF3QrwI=;
        b=MacR0VqP+e/LNHHHQuou2MHyR6W6QxkTNEnDiK5lI8M7aHLncXKtaoTKYdFCsQX72L
         qu3tKnlTMSBlHkwbtZTgq5b0jT86j6z7YkfkrMLHw/LSeQj+Omf/ISmbDbNxkKY0MUXT
         Wd10yqhWQ4BwTiU3ZeJNWzMN52jGtaS7iIsV/kff/CHKc9ikFuiP5vykWc/KPFy/hkLz
         ptYNF+aGadrnxOU3q/6CK7i0cl+JuOpgYW+55gole9j3014kmyKS4tLPAZjqvFQIBvrA
         LYannl2TspRoHbjMbvP3/mqGIL2fg9bVimS5aw6V+VPR8huAlX3csYgQGznhDGBP3OS9
         cHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9U1m6mU0o53HGYsINghj1de9Jt3i01TslgdBoF3QrwI=;
        b=o9NeFZrD2tRC9m8ykpIBaQjlmSFNBRpeuf0IkW94KIyQRUDIz5ljUn+qvWVYJ83ayx
         XdXGk6l/ZafNN8nJm5XELSAN2Pieul9XMxRRjp05V67hHNDdXd2tDGEIPi4fQRCl8y/p
         sbynWbqsrCjce0LXEA/ABbw1wOgSb4uu7T349A1xI4VmFDAOJgMQ06tXNLFWFvEwadLC
         hZDP6CZL9zmUg7A5VkBAeQzUbyOkeAqEYl0QbSsY5hQy/vapEtjccmk/9SkkcGv0rX64
         DL7MbWz2M9o/xs1R69mCapnqJaFq2wCgT1RwBae9+/QAAmrOd5ANtVzEV9pMC44GfWTT
         nSsw==
X-Gm-Message-State: APjAAAXOykl1oM7brNfaePVci+l6Vnd4M0iqWDWHpnJpJlQLDZMezLw5
        fa/eXr4PTeHfZyxKbaCu2HsVBpkLyHyKZXD6VK/I/A==
X-Google-Smtp-Source: APXvYqzENbGZGC/Ro2itSzojufojUt2gHL5BHdEmWJb4hnH6XoyTXJ7GENrRhEovlhdSyuHemD+29fiW8fSjTNkqB7E=
X-Received: by 2002:a24:740f:: with SMTP id o15mr3989343itc.76.1559906062309;
 Fri, 07 Jun 2019 04:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190607082901.6491-1-lee.jones@linaro.org> <20190607082901.6491-5-lee.jones@linaro.org>
In-Reply-To: <20190607082901.6491-5-lee.jones@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Jun 2019 13:14:11 +0200
Message-ID: <CAKv+Gu9RB1HLjvcHg1pFWbYjWQS=KAHu14TY_5OhCoWxJnR_zw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] soc: qcom: geni: Add support for ACPI
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        wsa+renesas@sang-engineering.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, balbi@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jeffrey Hugo <jlhugo@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 at 10:30, Lee Jones <lee.jones@linaro.org> wrote:
>
> When booting with ACPI as the active set of configuration tables,
> all; clocks, regulators, pin functions ect are expected to be at
> their ideal values/levels/rates, thus the associated frameworks
> are unavailable.  Ensure calls to these APIs are shielded when
> ACPI is enabled.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 6b8ef01472e9..cff0a413e59a 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>
> +#include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
> @@ -450,6 +451,9 @@ int geni_se_resources_off(struct geni_se *se)
>  {
>         int ret;
>
> +       if (ACPI_HANDLE(se->dev))

Please use has_acpi_companion() here

> +               return 0;
> +
>         ret = pinctrl_pm_select_sleep_state(se->dev);
>         if (ret)
>                 return ret;
> @@ -487,6 +491,9 @@ int geni_se_resources_on(struct geni_se *se)
>  {
>         int ret;
>
> +       if (ACPI_HANDLE(se->dev))
> +               return 0;
> +

Same

>         ret = geni_se_clks_on(se);
>         if (ret)
>                 return ret;
> @@ -724,12 +731,14 @@ static int geni_se_probe(struct platform_device *pdev)
>         if (IS_ERR(wrapper->base))
>                 return PTR_ERR(wrapper->base);
>
> -       wrapper->ahb_clks[0].id = "m-ahb";
> -       wrapper->ahb_clks[1].id = "s-ahb";
> -       ret = devm_clk_bulk_get(dev, NUM_AHB_CLKS, wrapper->ahb_clks);
> -       if (ret) {
> -               dev_err(dev, "Err getting AHB clks %d\n", ret);
> -               return ret;
> +       if (!ACPI_HANDLE(&pdev->dev)) {

Same

> +               wrapper->ahb_clks[0].id = "m-ahb";
> +               wrapper->ahb_clks[1].id = "s-ahb";
> +               ret = devm_clk_bulk_get(dev, NUM_AHB_CLKS, wrapper->ahb_clks);
> +               if (ret) {
> +                       dev_err(dev, "Err getting AHB clks %d\n", ret);
> +                       return ret;
> +               }
>         }
>
>         dev_set_drvdata(dev, wrapper);
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
