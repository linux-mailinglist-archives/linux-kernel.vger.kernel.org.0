Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A3618611B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 02:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgCPBEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 21:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgCPBEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:04:25 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B491205ED;
        Mon, 16 Mar 2020 01:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584320664;
        bh=Hw0ZivXWa3VjmpcCVQHuCLJJ+hlMopS5Berc2mfx4uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgOXCiVWkTvI7m9jrLidmfr5ERKuToqTfbuzGQ2P3SWJdpeH1NkNAM05witSWzZiz
         q+CxWlK+sxeZqzq6J3mULRs4ZbP4jYVMVXhspD4iqG3QvjgWe5LF/5ZtGi8pT6ENF6
         cqPZG70OPM+hb9UYZRzJb/HWrWD/IxrIgfUSDvOw=
Date:   Mon, 16 Mar 2020 09:04:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8qxp-mek: Sort labels alphabetically
Message-ID: <20200316010416.GI17221@dragon>
References: <1583830337-23889-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583830337-23889-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 04:52:16PM +0800, Anson Huang wrote:
> Sort the labels alphabetically for consistency.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

It doesn't apply to my branch.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 60 +++++++++++++--------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index 13460a3..2ed7aba 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -30,29 +30,8 @@
>  	};
>  };
>  
> -&adma_lpuart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_lpuart0>;
> -	status = "okay";
> -};
> -
> -&fec1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_fec1>;
> -	phy-mode = "rgmii-id";
> -	phy-handle = <&ethphy0>;
> -	fsl,magic-packet;
> +&adma_dsp {
>  	status = "okay";
> -
> -	mdio {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		ethphy0: ethernet-phy@0 {
> -			compatible = "ethernet-phy-ieee802.3-c22";
> -			reg = <0>;
> -		};
> -	};
>  };
>  
>  &adma_i2c1 {
> @@ -131,6 +110,35 @@
>  	};
>  };
>  
> +&adma_lpuart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpuart0>;
> +	status = "okay";
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +		};
> +	};
> +};
> +
> +&scu_key {
> +	status = "okay";
> +};
> +
>  &usdhc1 {
>  	assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
>  	assigned-clock-rates = <200000000>;
> @@ -229,11 +237,3 @@
>  		>;
>  	};
>  };
> -
> -&adma_dsp {
> -	status = "okay";
> -};
> -
> -&scu_key {
> -	status = "okay";
> -};
> -- 
> 2.7.4
> 
