Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE9A18E875
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 12:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCVLpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 07:45:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33943 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgCVLpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:45:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id s13so11395471ljm.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvkwniGOgLV8mB9CWYJP/ZbTdJL82BLIEY1BcTY1Qto=;
        b=YEBV9C++ndScMxatDthA+7c/f8KKuvfqHltiGzT/Jc2ZHPU1tE227G0/kAb2z60WP+
         tCkZtG0LYyh89fSCUGOCOuSHrushC6Kuo1nBUPKiHVbwgog5bDAnMkK1DDXTzqLbbkao
         uC2xZTER+EwG7GN0qOrBq9pX2sFNst9ayS+K9GtKWWY4BSlZ8srH1+HnmajSF0ikQDG8
         xJKMCr/0rDN486nzu53ft/63SkVj4DkAKkblD88kmaUoP/BofYCVVgREFD13eXHBH9jf
         iILEc0VBhXKw8zus2J2RFO+uZi8GDlj2bZHAHqbeDCEuJKQi0Qu1qkIHkQZqZRFoN9UK
         TRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvkwniGOgLV8mB9CWYJP/ZbTdJL82BLIEY1BcTY1Qto=;
        b=eg9luKN+DqoOi23o/srZfY9jvq1dFpnqYvboV16BO3xUj2Ws0DMJFXsgRiSNhQapC2
         VEnGUopr33Jd6nLxDEId4bARXviYi/LaAujnyA9/2QfMeNpc4jAsSKoaXLhZXvt0EZLa
         8qMqQtIC6Dz3O0YDTrhOi+i5CBufAF4cM17o2PpcQS5+sUWbUmfpRosCeYDrpB5fFs8H
         qsiDkktbgCrIykSIskREPBsfL7cY95xe/FGubCk8C8YSImH2tB3tS39IGXAvN1czy4k+
         cpmmAfBkgOayjnkqxFH33CHiZnCC15vLMI/tnWZE44rP1NMLn6DIbSnFVz5XZjeOWUYA
         aqdg==
X-Gm-Message-State: ANhLgQ1owCw95FQiIEGcvAspr1LXqrkQmOquUjoUMlJaEYY+9VyPT1iq
        omDRo1HsUZ+A0PhCLK512bkDG9L7HpzBQgVrTat+wQ==
X-Google-Smtp-Source: ADFU+vtz8JnRQjucKNvAZ8vvh9L8MfwrXSOVPk5erRyANVzjEGlUnxBNNGaucWacBWN8eUzf6lDDsJ8zv+51Z7tWzlw=
X-Received: by 2002:a2e:8ecf:: with SMTP id e15mr11158856ljl.223.1584877540117;
 Sun, 22 Mar 2020 04:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200321133842.2408823-1-mans0n@gorani.run>
In-Reply-To: <20200321133842.2408823-1-mans0n@gorani.run>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 22 Mar 2020 12:45:29 +0100
Message-ID: <CACRpkdYvoVF_q1Re_v_sJCYVDOhte0NpdU91UtYB2SpHH60-jg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/versatile-fpga: Apply clear-mask earlier
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     linux-oxnas@groups.io, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 2:40 PM Sungbo Eo <mans0n@gorani.run> wrote:

> Clear its own IRQs before the parent IRQ get enabled, so that the
> remaining IRQs do not accidentally interrupt the parent IRQ controller.
>
> This patch also fixes a reboot bug on OX820 SoC, where the remaining
> rps-timer IRQ raises a GIC interrupt that is left pending. After that,
> the rps-timer IRQ is cleared during driver initialization, and there's
> no IRQ left in rps-irq when local_irq_enable() is called, which evokes
> an error message "unexpected IRQ trap".
>
> Fixes: bdd272cbb97a ("irqchip: versatile FPGA: support cascaded interrupts from DT")
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Daniel Golle <daniel@makrotopia.org>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Marc: Cc stable?

Yours,
Linus Walleij
