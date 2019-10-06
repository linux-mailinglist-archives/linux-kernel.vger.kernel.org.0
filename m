Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857B8CCF72
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfJFIdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 04:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfJFIdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 04:33:02 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48FC220867;
        Sun,  6 Oct 2019 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570350781;
        bh=uI2z8kh80JJBsoGDCTpXgGoUlxoiXMzMMLH6/pjgph4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQ1mRK8Nn2V3RByDwL40J4iVe6wtSvOfgGM+mpzX1n1u3vY8AmNcM0y566Y9iRK/D
         H8sPOn6CgAXUfq2lUctn04EUH546sfhdvBSUnmFYJm9DNhtOsh/+f3pQb902XNFzUp
         3DXxOW6MoTALJyZoCrP8sMX1DVLJE7px0Xm666v0=
Date:   Sun, 6 Oct 2019 16:32:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7s: Correct GPT's ipg clock source
Message-ID: <20191006083233.GB7150@dragon>
References: <1568622549-15819-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568622549-15819-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 04:29:09PM +0800, Anson Huang wrote:
> i.MX7S/D's GPT ipg clock should be from GPT clock root and
> controlled by CCM's GPT CCGR, using correct clock source for
> GPT ipg clock instead of IMX7D_CLK_DUMMY.

So both 'ipg' and 'per' clock are coming from GPT root clock?

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

It looks like a fix, so do we need a Fixes tag here?

Shawn

> ---
>  arch/arm/boot/dts/imx7s.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 710f850..e2e604d 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -448,7 +448,7 @@
>  				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
>  				reg = <0x302d0000 0x10000>;
>  				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_GPT1_ROOT_CLK>,
>  					 <&clks IMX7D_GPT1_ROOT_CLK>;
>  				clock-names = "ipg", "per";
>  			};
> @@ -457,7 +457,7 @@
>  				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
>  				reg = <0x302e0000 0x10000>;
>  				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_GPT2_ROOT_CLK>,
>  					 <&clks IMX7D_GPT2_ROOT_CLK>;
>  				clock-names = "ipg", "per";
>  				status = "disabled";
> @@ -467,7 +467,7 @@
>  				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
>  				reg = <0x302f0000 0x10000>;
>  				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_GPT3_ROOT_CLK>,
>  					 <&clks IMX7D_GPT3_ROOT_CLK>;
>  				clock-names = "ipg", "per";
>  				status = "disabled";
> @@ -477,7 +477,7 @@
>  				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
>  				reg = <0x30300000 0x10000>;
>  				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&clks IMX7D_CLK_DUMMY>,
> +				clocks = <&clks IMX7D_GPT4_ROOT_CLK>,
>  					 <&clks IMX7D_GPT4_ROOT_CLK>;
>  				clock-names = "ipg", "per";
>  				status = "disabled";
> -- 
> 2.7.4
> 
