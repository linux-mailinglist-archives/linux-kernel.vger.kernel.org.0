Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35C1AF615
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 08:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfIKGqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 02:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfIKGqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:46:14 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C39E21928;
        Wed, 11 Sep 2019 06:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568184372;
        bh=qIBVFBd3Uzn1ZDrcBL8VAS5pV0/6Y6gy5xboCpJ+3/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y714A/OZ45VZt+Bk1N9sfI0EdgWcR7HUGZ9LgvsRB4mLhZ0T6qhLi2kX+E7Til6gF
         pq2q/RPs2GxKEJXiXnSRX6X8xzZNNtZDW79t9kbutbowD1zlW70J8WhOFQinZBckzb
         S3BXq+PGPVQZkJQ3slRkMVX+7x18y6zvP/QslzsI=
Date:   Wed, 11 Sep 2019 14:45:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fancy Fang <chen.fang@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>, Jana Build <jana.build@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx7ulp: remove IMX7ULP_CLK_MIPI_PLL clock
Message-ID: <20190911064556.GD17142@dragon>
References: <20190823003600.8317-1-chen.fang@nxp.com>
 <20190823003600.8317-2-chen.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823003600.8317-2-chen.fang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 12:37:35AM +0000, Fancy Fang wrote:
> The mipi pll clock comes from the MIPI PHY PLL output, so
> it should not be a fixed clock.
> 
> MIPI PHY PLL is in the MIPI DSI space, and it is used as
> the bit clock for transferring the pixel data out and its
> output clock is configured according to the display mode.
> 
> So it should be used only for MIPI DSI and not be exported
> out for other usages.
> 
> Signed-off-by: Fancy Fang <chen.fang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx7ulp-clock.txt   |  1 -
>  drivers/clk/imx/clk-imx7ulp.c                     |  3 +--
>  include/dt-bindings/clock/imx7ulp-clock.h         | 15 +++++++--------
>  3 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> index a4f8cd478f92..93d89adb7afe 100644
> --- a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> @@ -82,7 +82,6 @@ pcc2: pcc2@403f0000 {
>  		 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
>  		 <&scg1 IMX7ULP_CLK_UPLL>,
>  		 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
> -		 <&scg1 IMX7ULP_CLK_MIPI_PLL>,
>  		 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
>  		 <&scg1 IMX7ULP_CLK_ROSC>,
>  		 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
> diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
> index 2022d9bead91..459b120b71d5 100644
> --- a/drivers/clk/imx/clk-imx7ulp.c
> +++ b/drivers/clk/imx/clk-imx7ulp.c
> @@ -28,7 +28,7 @@ static const char * const scs_sels[]		= { "dummy", "sosc", "sirc", "firc", "dumm
>  static const char * const ddr_sels[]		= { "apll_pfd_sel", "upll", };
>  static const char * const nic_sels[]		= { "firc", "ddr_clk", };
>  static const char * const periph_plat_sels[]	= { "dummy", "nic1_bus_clk", "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
> -static const char * const periph_bus_sels[]	= { "dummy", "sosc_bus_clk", "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk", };
> +static const char * const periph_bus_sels[]	= { "dummy", "sosc_bus_clk", "dummy", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk", };
>  static const char * const arm_sels[]		= { "divcore", "dummy", "dummy", "hsrun_divcore", };
>  
>  /* used by sosc/sirc/firc/ddr/spll/apll dividers */
> @@ -75,7 +75,6 @@ static void __init imx7ulp_clk_scg1_init(struct device_node *np)
>  	clks[IMX7ULP_CLK_SOSC]		= imx_obtain_fixed_clk_hw(np, "sosc");
>  	clks[IMX7ULP_CLK_SIRC]		= imx_obtain_fixed_clk_hw(np, "sirc");
>  	clks[IMX7ULP_CLK_FIRC]		= imx_obtain_fixed_clk_hw(np, "firc");
> -	clks[IMX7ULP_CLK_MIPI_PLL]	= imx_obtain_fixed_clk_hw(np, "mpll");
>  	clks[IMX7ULP_CLK_UPLL]		= imx_obtain_fixed_clk_hw(np, "upll");
>  
>  	/* SCG1 */
> diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindings/clock/imx7ulp-clock.h
> index 6f66f9005c81..f8d34fb4378f 100644
> --- a/include/dt-bindings/clock/imx7ulp-clock.h
> +++ b/include/dt-bindings/clock/imx7ulp-clock.h
> @@ -49,15 +49,14 @@
>  #define IMX7ULP_CLK_NIC1_DIV		36
>  #define IMX7ULP_CLK_NIC1_BUS_DIV	37
>  #define IMX7ULP_CLK_NIC1_EXT_DIV	38
> -#define IMX7ULP_CLK_MIPI_PLL		39
> -#define IMX7ULP_CLK_SIRC		40
> -#define IMX7ULP_CLK_SOSC_BUS_CLK	41
> -#define IMX7ULP_CLK_FIRC_BUS_CLK	42
> -#define IMX7ULP_CLK_SPLL_BUS_CLK	43
> -#define IMX7ULP_CLK_HSRUN_SYS_SEL	44
> -#define IMX7ULP_CLK_HSRUN_CORE_DIV	45
> +#define IMX7ULP_CLK_SIRC		39
> +#define IMX7ULP_CLK_SOSC_BUS_CLK	40
> +#define IMX7ULP_CLK_FIRC_BUS_CLK	41
> +#define IMX7ULP_CLK_SPLL_BUS_CLK	42
> +#define IMX7ULP_CLK_HSRUN_SYS_SEL	43
> +#define IMX7ULP_CLK_HSRUN_CORE_DIV	44

No.  These clock IDs need to be stable, as they are referred by DT.
If you want to remove an ID, just remove it, keep others unchanged.

Shawn

>  
> -#define IMX7ULP_CLK_SCG1_END		46
> +#define IMX7ULP_CLK_SCG1_END		45
>  
>  /* PCC2 */
>  #define IMX7ULP_CLK_DMA1		0
> -- 
> 2.17.1
> 
