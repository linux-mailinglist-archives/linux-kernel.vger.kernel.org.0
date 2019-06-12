Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4232D41E48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 09:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbfFLHzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 03:55:04 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:42557 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfFLHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:55:03 -0400
Received: by mail-lf1-f42.google.com with SMTP id y13so11283807lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PzIlTNIG9ZNiKS3hRUm3RewsbWBmwo6U2w2huv5deg=;
        b=Ikh3hhr86U05Rwd/ohMNVvV7u0ctcFy7sv/uEL+EuxN98f3uQ67oC/e0EYe1RhQy8P
         GJFuf3O1tXMHShRpTgs1L8ewX/PFmrqAppj5PDuaoH3wYMGxvrkub2lXMWDhtvhhHInF
         ARAMOP1P6S6rvNLYPYfqORNKO1XSgrKGhExGTZJLtohlRIq3Npv7paeV6ElrVG69IdHH
         LxJS0EsMtyX1pKMDDSRbrirELXHF5eqYTU4kvAAzk5tfUlvp4fdYCIKCCxKMbk6xgobY
         lhpxsi57qNqQJVRRei3ceZXe4P0MuV4wPp9R8Mu4xrPb3dZbVCKlfuKWnUJ7naD6LBXM
         m3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PzIlTNIG9ZNiKS3hRUm3RewsbWBmwo6U2w2huv5deg=;
        b=UfFHVCM1QkWQqZS7t+i2ltboDfWv7OnBuy0YDbx/LpRbCpE9GkRVLybNAY+GMVe3j/
         GD6UwPLDdJ63XdiZJl+kA03efRmHr83skRFOuMu5n6D43EhlQa25R5ioJefDlVyEEZaV
         a44w1EU/bGfuyyERxBHFk7VcaTxjbeaKv3nTTK1nf7mzYTdDjblKBwcVeJNaYuf9r5CA
         78zZALW7bcsrECjb6cJ/mAxlyETEplrD+9uw466XZh6XTgPJsPXGUOJ7bY+shmrphTgS
         EiRZRLPzZY9fk5EQuPNOQAAG2jNdat+ECTibPkOzUCn2PI2G1a+eWKz+pKREMHDSBXnX
         kbLQ==
X-Gm-Message-State: APjAAAWoZ1R5PSHFLQ99iuCZ68aMbS4B6VSGQHw7QBypZgc+Pvus+bQI
        C2MJB1uGMwDHywUTM3uUnQ4otMwcn2RM6xCIhUv1yw==
X-Google-Smtp-Source: APXvYqwr+IggkBTWnR7/O1aUrCDYKzqAI3QVMBZqKcDtkTqDwEoqgL77KBrEFS20MTecxS2RTiEs6OZy6RxBT1DXdYY=
X-Received: by 2002:a19:7616:: with SMTP id c22mr36632491lff.115.1560326101939;
 Wed, 12 Jun 2019 00:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-2-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-2-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 09:54:50 +0200
Message-ID: <CACRpkdZvd_pApYbDL+PTJ1LDuDuvcVc2OCA_anRoWvwka_xm6g@mail.gmail.com>
Subject: Re: [PATCH-next 01/20] gpio: gpio-omap: ensure irq is enabled before wakeup
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Documentation states:
>
>   NOTE: There must be a correlation between the wake-up enable and
>   interrupt-enable registers. If a GPIO pin has a wake-up configured
>   on it, it must also have the corresponding interrupt enabled (on
>   one of the two interrupt lines).
>
> Ensure that this condition is always satisfied by enabling the detection
> events after enabling the interrupt, and disabling the detection before
> disabling the interrupt.  This ensures interrupt/wakeup events can not
> happen until both the wakeup and interrupt enables correlate.
>
> If we do any clearing, clear between the interrupt enable/disable and
> trigger setting.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
