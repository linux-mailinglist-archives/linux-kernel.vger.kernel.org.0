Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6948422B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 12:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437020AbfFLKkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 06:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389150AbfFLKkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:40:06 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0327E2082C;
        Wed, 12 Jun 2019 10:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560336005;
        bh=olJE88EuGPDle+9Tm9CK1rEMk80N8UpsGxLJZzTv3x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqSGJ26WhA1epEd5iGa6+JzbWjQ8AyZF8ksDozVUYo1vXzZ1K7aEeze82ZJa1JjQB
         BNZU7J5vrqlC3YpGiTfgCyhGB+NnChrdzCZupgVC2hVkdmJy+fipdid2cOkE1tvqt0
         P40EJtFCyc0BT0Au2KyU+1wmtXHN0JS9rs7oBZWY=
Date:   Wed, 12 Jun 2019 18:39:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        linux-crypto@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx7ulp: add crypto support
Message-ID: <20190612103926.GE11086@dragon>
References: <20190606080255.25504-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606080255.25504-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:02:55AM +0300, Horia Geantă wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> Add crypto node in device tree for CAAM support.
> 
> Noteworthy is that on 7ulp the interrupt line is shared
> between the two job rings.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
> 
> I've just realized that this patch should be merged through the crypto tree,
> else bisectability could be affected due to cryptodev-2.6
> commit 385cfc84a5a8 ("crypto: caam - disable some clock checks for iMX7ULP")
> ( https://patchwork.kernel.org/patch/10970017/ )
> which should come first.

I'm not sure I follow it.  This is a new device added to imx7ulp DT.
It's never worked before on imx7ulp.  How would it affect git bisect?

Shawn

> 
>  arch/arm/boot/dts/imx7ulp.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
> index d6b711011cba..e20483714be5 100644
> --- a/arch/arm/boot/dts/imx7ulp.dtsi
> +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> @@ -100,6 +100,29 @@
>  		reg = <0x40000000 0x800000>;
>  		ranges;
>  
> +		crypto: crypto@40240000 {
> +			compatible = "fsl,sec-v4.0";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x40240000 0x10000>;
> +			ranges = <0 0x40240000 0x10000>;
> +			clocks = <&pcc2 IMX7ULP_CLK_CAAM>,
> +				 <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>;
> +			clock-names = "aclk", "ipg";
> +
> +			sec_jr0: jr0@1000 {
> +				compatible = "fsl,sec-v4.0-job-ring";
> +				reg = <0x1000 0x1000>;
> +				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			sec_jr1: jr1@2000 {
> +				compatible = "fsl,sec-v4.0-job-ring";
> +				reg = <0x2000 0x1000>;
> +				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
>  		lpuart4: serial@402d0000 {
>  			compatible = "fsl,imx7ulp-lpuart";
>  			reg = <0x402d0000 0x1000>;
> -- 
> 2.17.1
> 
