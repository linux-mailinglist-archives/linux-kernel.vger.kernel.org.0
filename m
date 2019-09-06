Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27115AC35E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 01:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406219AbfIFXsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 19:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405441AbfIFXsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:48:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC0DA20842;
        Fri,  6 Sep 2019 23:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567813699;
        bh=NSLywlCOcgcWPM52MbfyuhWTAOW2/4du9FX0KFp7RSI=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=KwtHGJhGEM4BfLeqXjbsZT07sFB7biEeHKuQ9ohRGYNIP+wMSmwfyp48kbdV4SUug
         9M91UWABZNoGL2ftCmjs/VA0iuLyajB//EFiauZlmyBqMSnWqUAU5XYGAqo9yY+2fj
         yelyGsFZ9lWHC9sKK4riqUF9SI/AwZEQtDSQvrHU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830220743.439670-12-lkundrak@v3.sk>
References: <20190830220743.439670-1-lkundrak@v3.sk> <20190830220743.439670-12-lkundrak@v3.sk>
Cc:     "Cc : Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     "To : Olof Johansson" <olof@lixom.net>,
        Lubomir Rintel <lkundrak@v3.sk>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 11/16] ARM: mmp: add support for MMP3 SoC
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 16:48:18 -0700
Message-Id: <20190906234818.EC0DA20842@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-08-30 15:07:38)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 801fa1cd03217..8bb2ac83a1fcc 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -301,6 +301,11 @@ config COMMON_CLK_STM32H7
>         ---help---
>           Support for stm32h7 SoC family clocks
> =20
> +config COMMON_CLK_MMP2
> +       def_bool COMMON_CLK && (MACH_MMP2_DT || MACH_MMP3_DT)

Does it need to depend on COMMON_CLK? I thought that by being part of
the menuconfig (even if it's a hidden symbol) mean that it wouldn't be
evaulated unless the COMMON_CLK define is =3DY.

> +       help
> +         Support for Marvell MMP2 and MMP3 SoC clocks
> +
>  config COMMON_CLK_BD718XX
>         tristate "Clock driver for ROHM BD718x7 PMIC"
>         depends on MFD_ROHM_BD718XX || MFD_ROHM_BD70528
