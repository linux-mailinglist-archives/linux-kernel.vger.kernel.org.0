Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5EE0893
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfJVQTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:19:24 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44116 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730331AbfJVQTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:19:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 773C2FB03;
        Tue, 22 Oct 2019 18:19:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id asa4HXtqqs4k; Tue, 22 Oct 2019 18:19:20 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B351E49BFE; Tue, 22 Oct 2019 18:19:19 +0200 (CEST)
Date:   Tue, 22 Oct 2019 18:19:19 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     shawnguo@kernel.org, devicetree@vger.kernel.org, baruch@tkos.co.il,
        abel.vesa@nxp.com, Anson.Huang@nxp.com, ccaione@baylibre.com,
        andrew.smirnov@gmail.com, s.hauer@pengutronix.de, angus@akkea.ca,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        festevam@gmail.com, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
Subject: Re: [PATCH v4] arm64: dts: imx8mq: Init rates and parents configs
 for clocks
Message-ID: <20191022161919.GA3727@bogon.m.sigxcpu.org>
References: <20190728152040.15323-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728152040.15323-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, Jul 28, 2019 at 06:20:40PM +0300, Daniel Baluta wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> Add the initial configuration for clocks that need default parent and rate
> setting. This is based on the vendor tree clock provider parents and rates
> configuration except this is doing the setup in dts rather then using clock
> consumer API in a clock provider driver.
> 
> Note that by adding the initial rate setting for audio_pll1/audio_pll
> setting we need to remove it from imx8mq-librem5-devkit.dts

It seems this never made it into any tree, any particular reason for
that?
Cheers,
 -- Guido

> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Tested-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
> Changes since v3:
> 	- fix extra new lines
> 
>  .../dts/freescale/imx8mq-librem5-devkit.dts   |  5 -----
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 683a11035643..c702ccc82867 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -169,11 +169,6 @@
>  	};
>  };
>  
> -&clk {
> -	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL2>;
> -	assigned-clock-rates = <786432000>, <722534400>;
> -};
> -
>  &dphy {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 02fbd0625318..a55d72ba2e05 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -494,6 +494,25 @@
>  				clock-names = "ckil", "osc_25m", "osc_27m",
>  				              "clk_ext1", "clk_ext2",
>  				              "clk_ext3", "clk_ext4";
> +				assigned-clocks = <&clk IMX8MQ_VIDEO_PLL1>,
> +					<&clk IMX8MQ_AUDIO_PLL1>,
> +					<&clk IMX8MQ_AUDIO_PLL2>,
> +					<&clk IMX8MQ_CLK_AHB>,
> +					<&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
> +					<&clk IMX8MQ_CLK_AUDIO_AHB>,
> +					<&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
> +					<&clk IMX8MQ_CLK_NOC>;
> +				assigned-clock-parents = <0>,
> +						<0>,
> +						<0>,
> +						<&clk IMX8MQ_SYS1_PLL_133M>,
> +						<&clk IMX8MQ_SYS1_PLL_266M>,
> +						<&clk IMX8MQ_SYS2_PLL_500M>,
> +						<&clk IMX8MQ_CLK_27M>,
> +						<&clk IMX8MQ_SYS1_PLL_800M>;
> +				assigned-clock-rates = <593999999>,
> +						<786432000>,
> +						<722534400>;
>  			};
>  
>  			src: reset-controller@30390000 {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
