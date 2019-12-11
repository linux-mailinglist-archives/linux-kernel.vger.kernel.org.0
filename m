Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3543411A691
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfLKJPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:15:09 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43073 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfLKJPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:15:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id b3so1804817qti.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E6wMorO69DZEZ1sE/qWwk4Epgymi3NNrwm1o7yf8uZs=;
        b=gCWjoxJy7TelDBkwoiTu7kjNV9DFP+AVCBuAdLBIuCnDMDOJzEwZfy/Jbv/7wxZExs
         csgHekmcSVZURgTG1D5XLv/tBbnl3J6hyNhYMQeQBITooLkZMZuVZVROyZK3+IqKL5Bs
         3J6RE60DVjlutXxaqTPCRbi5/jx+BqHX3lzbQtkRgppMWUgau0tiuHiT0AbdfudBnV71
         WszMvwqEBhzu2BE2DA2zCAwXaMSzPqGTUYpCb0YcJRmQfNIH9utr0rXh+IxX4jsil0fk
         mvUsoJ8s2KrYqZwnbF4hM19sPd8dnxN3ZYGxnjDtnhR9McZ0mMuxBV692SW5UKj6NOth
         SRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E6wMorO69DZEZ1sE/qWwk4Epgymi3NNrwm1o7yf8uZs=;
        b=hQQr+aXmgiVHqCBkP07wL1esOFt6HwgOTAoEupFbq4/gpheEKsMM3EGXtuN417/fao
         eorOpPjaLdjEivxPmYnUZlVdhZzNy7t09gRZ7sngGCSkdzomAzubLaW5eqYjAXTuvPQx
         08v8oaf7pA8lv1zWVRAH7cbEhB5dXzG4hlISOQxMwdrE/qKjhGL8AVL3avs2HCqssRWP
         3W0cRUC04Qj9Gf5lLAprDxV6y9lOLE7PfW+B7i+e2c0c98qI6L72XNol1KfD+cvMFqjk
         4PR6z0ja/O+JVGSSKwIgzLtpJwYjk9qi9v0T4dn3IT9KgXu+kIMM+FOQNSVLP0xV0HEM
         VVMA==
X-Gm-Message-State: APjAAAVAyK7LdAmFoiZvPg6es6b4OTW4eq0BTDLEBqkxRNNn4Ed10xPh
        NoHiTpsDYkZjItLrmJx37GajaLQTrKCalFHMThkp4g==
X-Google-Smtp-Source: APXvYqxVk6H+v/SBU3kWiS7frnzyOo+1ST2qw1y44jpvjf3X1WWmv6bh0Fr3gtKPzYz3RXnVQ8imgQsqRxL9wvuwlyc=
X-Received: by 2002:ac8:704:: with SMTP id g4mr1818462qth.197.1576055708067;
 Wed, 11 Dec 2019 01:15:08 -0800 (PST)
MIME-Version: 1.0
References: <20191210195202.622734-1-arnd@arndb.de>
In-Reply-To: <20191210195202.622734-1-arnd@arndb.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Dec 2019 10:14:57 +0100
Message-ID: <CAMpxmJX0jAa4-52pT0rutPz9naRHb4nnZ=cDdvCMLxGh=3m_=A@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: select CONFIG_RESET_CONTROLLER
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        "Stable # 4 . 20+" <stable@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 gru 2019 o 20:52 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> Selecting RESET_CONTROLLER is actually required, otherwise we
> can get a link failure in the clock driver:
>
> drivers/clk/davinci/psc.o: In function `__davinci_psc_register_clocks':
> psc.c:(.text+0x9a0): undefined reference to `devm_reset_controller_regist=
er'
> drivers/clk/davinci/psc-da850.o: In function `da850_psc0_init':
> psc-da850.c:(.text+0x24): undefined reference to `reset_controller_add_lo=
okup'
>
> Fixes: f962396ce292 ("ARM: davinci: support multiplatform build for ARM v=
5")
> Cc: <stable@vger.kernel.org> # v5.4
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-davinci/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
