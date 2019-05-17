Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23298211F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 04:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfEQCLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 22:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfEQCLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:11:32 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068752082E;
        Fri, 17 May 2019 02:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558059092;
        bh=L9gJDk5SmlO1Bjp81hnl855ONnNEMGWCYhhypjgHXmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAz0fNHe5dnd4aoxP7ra/g7ObfoBZi3UgnTGjMsqpI0M0LkM+Xvra0hBSlbhPnmT1
         FcWJ/7iih/uZiogrwPeZOE2V0cr1ZYDgC1igYQ99sgmeG6hTJtmMb1rMjN7cts0lmm
         FE/4qhHUBZO/XJoqg4UfiOIaTb5BI+Vdmlc/1DQc=
Date:   Fri, 17 May 2019 10:10:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: ls1028a: Add USB dt nodes
Message-ID: <20190517021050.GW15856@dragon>
References: <20190508064814.14223-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508064814.14223-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 06:46:37AM +0000, Ran Wang wrote:
> This patch adds USB dt nodes for LS1028A.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v3:
>   - Add space between label and node name.
>   - Add spcae with properties and '='.
>   - Add SoC specific compatible.
> 
> Changes in v2:
>   - Rename node from usb3@... to usb@... to meet DTSpec
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 8dd3501..19519df 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -144,6 +144,26 @@
>  			clocks = <&sysclk>;
>  		};
>  
> +		usb0: usb@3100000 {

Please sort the nodes with unit-address in the address.  That said, it
should go after watchdog@23c0000.

> +			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
> +			reg = <0x0 0x3100000 0x0 0x10000>;
> +			interrupts = <0 80 0x4>;

interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;

Shawn

> +			dr_mode = "host";
> +			snps,dis_rxdet_inp3_quirk;
> +			snps,quirk-frame-length-adjustment = <0x20>;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> +		};
> +
> +		usb1: usb@3110000 {
> +			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
> +			reg = <0x0 0x3110000 0x0 0x10000>;
> +			interrupts = <0 81 0x4>;
> +			dr_mode = "host";
> +			snps,dis_rxdet_inp3_quirk;
> +			snps,quirk-frame-length-adjustment = <0x20>;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> +		};
> +
>  		i2c0: i2c@2000000 {
>  			compatible = "fsl,vf610-i2c";
>  			#address-cells = <1>;
> -- 
> 1.7.1
> 
