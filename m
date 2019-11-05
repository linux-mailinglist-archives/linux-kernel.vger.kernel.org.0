Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC548EFFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 15:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbfKEOcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 09:32:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36818 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbfKEOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:32:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id a6so11895496lfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 06:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLFMRSJOoW+yEvqE/nAHqNvN0PVJDrTXShmTG7ns9As=;
        b=y9perWPcAH4j5mAUN7KY2NmEekUSQ+a30wlQ/BNkpsPELwH8TkoyNWnfNTa3lXV3DG
         BkFwl5e2C3KBAEq3KrADfJNW1Ypu1c/6VxByLiYBAbCXpJq19EQ4g+exGsZm5h5Xlspb
         +Iq9W9nVecCRfhhM+jooPvA76M2X0wekEJFrOpHNcoKkEubx67vn9D5P1VY90UD436Hk
         T1tZtH3MMuvo3yEaGGNwhUmdU9HpmW/8QBNjtT0SxqiVtwGseNLZgQXk5Un5QKIiCuW0
         f+AFNL5Hr9zZUf5RXDuhMfNZsepmrFclGE7uh8/yMAabPU5TAGPuMIR/DxA+lc+l5PkB
         CHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLFMRSJOoW+yEvqE/nAHqNvN0PVJDrTXShmTG7ns9As=;
        b=f/Wrf/Kidub7cmU05LifK//PsRlkuZARRPp7k/d+yMcKyjeo73NxCra6+2uyFOUl2d
         vgOxuKNLTtb2LZtKIH72O4yCPVmabUKl7GzKx3+Sm8kSce81cv6qfBm5psD9HF4HJOWr
         0Kvj/pvLQjAOLMR+564p2rYvVFDNB23FCmidLgDLm/u8XB9BdekfxKwHD7WMsEEj/3tG
         yFMeLSC9ptTBx9ZE6vtI4JKgCRdPU12WC3ROVWyWZh8BauYR/mnqeTorkbi0tgYET/WN
         xWxAJSg6dJ+Xhx+MWsm3MPra3wndFD2oXwFy+vzgKXu7iv7lz0eAfEHuuS9CVLLcU1bY
         nMIA==
X-Gm-Message-State: APjAAAXL68kZd+phI3BT8NigSwQiwU1GsANY20KsblyABQUny/+T9qqT
        K98V+S2UAI8R0+g56jTDXfqhJO/tlWX/URCrqrE2Eg==
X-Google-Smtp-Source: APXvYqyVnOresRhCD7/BA1YBuA6qLWnNQMWqlAcN2EojWeInmLqNK2B9nacejztyRPmOEA5D/NM+oKAP10yDAKivgGk=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr20732685lfp.5.1572964341873;
 Tue, 05 Nov 2019 06:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20191104100908.10880-1-amelie.delaunay@st.com>
In-Reply-To: <20191104100908.10880-1-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 15:32:10 +0100
Message-ID: <CACRpkdb1c-NHXDQXYS78VTcGPnJApmxjzZbF_cM8SUknhDiQ4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: stmfx: fix valid_mask init sequence
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 11:09 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> With stmfx_pinctrl_gpio_init_valid_mask callback, gpio_valid_mask was used
> to initialize gpiochip valid_mask for gpiolib. But gpio_valid_mask was not
> yet initialized. gpio_valid_mask required gpio-ranges to be registered,
> this is the case after gpiochip_add_data call. But init_valid_mask
> callback is also called under gpiochip_add_data. gpio_valid_mask
> initialization cannot be moved before gpiochip_add_data because
> gpio-ranges are not registered.

Sorry but this doesn't add up, look at this call graph:

gpiochip_add_data()
  gpiochip_add_data_with_key()
    gpiochip_alloc_valid_mask()
    of_gpiochip_add()
    of_gpiochip_add_pin_range()
    gpiochip_init_valid_mask()

So the .initi_valid_mask() is clearly called *after*
of_gpiochip_add_pin_range() so this cannot be the real reason,
provided that the ranges come from the device tree. AFAICT that
is the case with the stmfx.

Can you check and see if the problem is something else?

Yours,
Linus Walleij
