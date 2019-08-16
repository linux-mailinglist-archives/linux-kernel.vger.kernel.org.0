Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93BA90776
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfHPSGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 14:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfHPSGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:06:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 427BC20665;
        Fri, 16 Aug 2019 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565978761;
        bh=QASmlY4ON4/9px2oPd+HIdAz8Fff0k2LsKxJXsxM21Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oKyvzPF6SEO2Hyb1P31lHqJQ0RCDAW+ExZE524oWyY0eKm+1NEzXvsO+IJEtgKxKX
         WEcmUyALJDXuQ0z+TucDNe0xcEUxTtoeHBDp4YFE+GX+Jed3ElDBZrWaA2ID+Ha8vo
         MZSAC6QdFQSS5l8finFeul3EEp5TdM3Zawk10oxY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190809093158.7969-15-lkundrak@v3.sk>
References: <20190809093158.7969-1-lkundrak@v3.sk> <20190809093158.7969-15-lkundrak@v3.sk>
Subject: Re: [PATCH 14/19] ARM: mmp: add support for MMP3 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 11:06:00 -0700
Message-Id: <20190816180601.427BC20665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-08-09 02:31:53)
> diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
> index 7bc7ac69391e3..deb069a4e4215 100644
> --- a/drivers/clk/mmp/Makefile
> +++ b/drivers/clk/mmp/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_RESET_CONTROLLER) +=3D reset.o
> =20
>  obj-$(CONFIG_MACH_MMP_DT) +=3D clk-of-pxa168.o clk-of-pxa910.o
>  obj-$(CONFIG_MACH_MMP2_DT) +=3D clk-of-mmp2.o
> +obj-$(CONFIG_MACH_MMP3_DT) +=3D clk-of-mmp2.o
> =20

Maybe make a Kconfig variable in drivers/clk/mmp/Kconfig that builds
clk-of-mmp2.c and is selected by MACH_MMP*_DT?

>  obj-$(CONFIG_CPU_PXA168) +=3D clk-pxa168.o
>  obj-$(CONFIG_CPU_PXA910) +=3D clk-pxa910.o
