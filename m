Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6EDFC9E30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfJCMRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 08:17:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43742 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJCMRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:17:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so1635635lfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+qFJxfK/o+AUCkajflBNym7EUXhIlRQ/i280OxUzCc=;
        b=CUcO6IscTDo8mvm9qzgA3Zn8Zsn+LcZQRIH8ztPINFQqpOx8vpK4w9p35AH1jCVpSs
         9TNKjI+Vxf60N956ZTBNrmSx3+lVjwPLaYypCzrI3sjO72XDyyE7z72cizulMp0wNLlR
         j+WC38KpS8tf80f7hnrfhi/82b0jDtkk5hJ2RJoCOCoYtNjmZpOJp29MSnkdeJKJQ/Wk
         yO38vsFc+mdsC1NHGOUw46TLfA1Eh1Vfq4sMdzO7qtzXMIMgchtXAITjF6KKLq+wlyuP
         IRTmDcR67lfFcZsJKuIt3C+Vd9sihbU01+Ftbo/a5fv8b4VywpTjAt8vYudhaOrBWw3U
         ffXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+qFJxfK/o+AUCkajflBNym7EUXhIlRQ/i280OxUzCc=;
        b=EYu7OZgMhg9gR3OSHGKQGaO1dfsbJN4hfLhkk3czvaX7Ako+j2QPBZHUr1U5/YoObg
         dyQhcAK/SItL3JL9cNiah9RFAdW2D8ELdKNdNDIimJqsar9QGJ5aiKeXGsjAGsxn4Yl7
         M8zCAroiQTlTjRahauFRfhCFUxssXn4UJjygFifv2Abk/lrSWnznPaOXxLqpy+UAC6lw
         mIyTktWUN0i8bpDFj9pdi8f50Xk/o3mRMYLzjfRrURDP33j6Ej7amQqrYv4L/1G7/UUK
         ZMO5TN+bfqgXjT7aCOZTxsyhulN29yLUT6Aa9DJIpS3TZkzc7YFWzKLLVg0QyDGnKo15
         BYIQ==
X-Gm-Message-State: APjAAAXKLXwUosNCx/E3/nQV8AoajNtpogXaL3uYRR0TwD2lhXKiv51z
        +3uNzICgGkCdxq6/A5xYrSW/PQx3nnGW2BTB1BZNcQ==
X-Google-Smtp-Source: APXvYqwCxVfpUKYXkD9EXOOAiK4MScexSxj0b6juR5gZ5noEs2VxeVKYBDkbVEtGagMUTAQcdhZfMoK7nvhLyQWGUf4=
X-Received: by 2002:ac2:46ee:: with SMTP id q14mr5220819lfo.152.1570105070638;
 Thu, 03 Oct 2019 05:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <1568411962-1022-1-git-send-email-ilina@codeaurora.org> <1568411962-1022-11-git-send-email-ilina@codeaurora.org>
In-Reply-To: <1568411962-1022-11-git-send-email-ilina@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Oct 2019 14:17:39 +0200
Message-ID: <CACRpkdav_BFubQ4-RWAN+uxBoExi7qfgdFhDVKfgtbXEOB5uvA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 10/14] drivers: pinctrl: msm: setup GPIO chip in hierarchy
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        mkshah@codeaurora.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 11:59 PM Lina Iyer <ilina@codeaurora.org> wrote:

> Some GPIOs are marked as wakeup capable and are routed to another
> interrupt controller that is an always-domain and can detect interrupts
> even most of the SoC is powered off. The wakeup interrupt controller
> wakes up the GIC and replays the interrupt at the GIC.
>
> Setup the TLMM irqchip in hierarchy with the wakeup interrupt controller
> and ensure the wakeup GPIOs are handled correctly.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ----
> Changes in RFC v2:
>         - Define irq_domain_qcom_handle_wakeup()
>         - Rebase on top of GPIO hierarchy support in linux-next
>         - Set the chained irq handler for summary line

This is looking better every time I look at it, it's really complex
but alas the problem is hard to solve so it requires complex solutions.

> @@ -1006,6 +1091,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>         struct gpio_irq_chip *girq;
>         int ret;
>         unsigned ngpio = pctrl->soc->ngpios;
> +       struct device_node *dn;

I usually call the variable "np"

> @@ -1021,17 +1107,40 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>
>         pctrl->irq_chip.name = "msmgpio";
>         pctrl->irq_chip.irq_enable = msm_gpio_irq_enable;
> +       pctrl->irq_chip.irq_disable = msm_gpio_irq_disable;
>         pctrl->irq_chip.irq_mask = msm_gpio_irq_mask;
>         pctrl->irq_chip.irq_unmask = msm_gpio_irq_unmask;
>         pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
> +       pctrl->irq_chip.irq_eoi = irq_chip_eoi_parent;

This part and the functions called seem fine!

> +       dn = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
> +       if (dn) {
> +               int i;
> +               bool skip;
> +               unsigned int gpio;
> +
> +               chip->irq.parent_domain = irq_find_matching_host(dn,
> +                                                DOMAIN_BUS_WAKEUP);
> +               of_node_put(dn);
> +               if (!chip->irq.parent_domain)
> +                       return -EPROBE_DEFER;
> +               chip->irq.child_to_parent_hwirq = msm_gpio_wakeirq;
> +
> +               skip = irq_domain_qcom_handle_wakeup(chip->irq.parent_domain);
> +               for (i = 0; skip && i < pctrl->soc->nwakeirq_map; i++) {
> +                       gpio = pctrl->soc->wakeirq_map[i].gpio;
> +                       set_bit(gpio, pctrl->skip_wake_irqs);
> +               }
> +       }

OK I guess this is how we should do it, maybe add a comment to clarify
that we are checking the parent irqdomain of the chained IRQ to see
if we need to avoid disabling the irq as it is used for wakeup. (IIUC
what the code does!)

> +       /*
> +        * Since we are chained to the GIC using the TLMM summary line
> +        * and in hierarchy with the wakeup parent interrupt controller,
> +        * explicitly set the chained summary line. We need to do this because
> +        * the summary line is not routed to the wakeup parent but directly
> +        * to the GIC.
> +        */
> +       gpiochip_set_chained_irqchip(chip, &pctrl->irq_chip, pctrl->irq,
> +                                    msm_gpio_irq_handler);

I don't think this part is needed, we already have:

girq->parent_handler = msm_gpio_irq_handler;
girq->num_parents = 1;
girq->parents = devm_kcalloc(pctrl->dev, 1, sizeof(*girq->parents),
     GFP_KERNEL);
if (!girq->parents)
     return -ENOMEM;
girq->default_type = IRQ_TYPE_NONE;
girq->handler = handle_bad_irq;
girq->parents[0] = pctrl->irq;

This will make the irq chain when calling gpiochip_add_data(), so
just delete this and see if everything works as before.

Other than that it looks fine!

Yours,
Linus Walleij
