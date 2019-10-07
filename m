Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88DCCE03C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 13:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfJGLY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 07:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfJGLYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:24:55 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A61D21655;
        Mon,  7 Oct 2019 11:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570447495;
        bh=hjXcVcJK0NpbQJa+f7TFWSRlvZy1ZIrFfr/Rfc4aJi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIMmA4Vnd/pzFe9G3L79Di5PxkxuNkTcFK3yqVQ0wttpfkZqZsqcg8VSnUBVD7xCt
         EcYK5jbHsg+pTfwnyNFSkjjbTAWlMgzD0CEmTngraSU8Rj0mn0nMBscnOp+VrFEei2
         53Xf7WGQ2exUbFIaylOjOrVcmCWjpoC5nzEjxYeM=
Date:   Mon, 7 Oct 2019 19:24:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
Cc:     devicetree@vger.kernel.org, rennes@savoirfairelinux.com,
        jerome.oufella@savoirfairelinux.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: imx6qdl-rex: add gpio expander pca9535
Message-ID: <20191007112430.GD7150@dragon>
References: <20190916104353.7278-1-gilles.doffe@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916104353.7278-1-gilles.doffe@savoirfairelinux.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 12:43:53PM +0200, Gilles DOFFE wrote:
> The pca9535 gpio expander is present on the Rex baseboard, but missing
> from the dtsi.
> The pca9535 is on i2c2 bus which is common to the three SOM
> variants (Basic/Pro/Ultra), thus it is activated by default.
> 
> Add also the new gpio controller and the associated interrupt line
> MX6QDL_PAD_NANDF_CS3__GPIO6_IO16.
> 
> Signed-off-by: Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
> ---
>  arch/arm/boot/dts/imx6qdl-rex.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
> index 97f1659144ea..8a748ca1b108 100644
> --- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
> @@ -132,6 +132,19 @@
>  	pinctrl-0 = <&pinctrl_i2c2>;
>  	status = "okay";
>  
> +	pca9535: gpio8@27 {

gpio-expander might be a better node name?

Shawn

> +		compatible = "nxp,pca9535";
> +		reg = <0x27>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pca9535>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
>  	eeprom@57 {
>  		compatible = "atmel,24c02";
>  		reg = <0x57>;
> @@ -237,6 +250,12 @@
>  			>;
>  		};
>  
> +		pinctrl_pca9535: pca9535 {
> +			fsl,pins = <
> +				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x17059
> +		   >;
> +		};
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
> -- 
> 2.20.1
> 
