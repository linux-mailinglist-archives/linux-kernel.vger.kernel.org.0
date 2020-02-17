Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA4160971
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 05:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBQEFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 23:05:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgBQEFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 23:05:33 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E83C120726;
        Mon, 17 Feb 2020 04:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581912333;
        bh=COHRYy09mHaqje5Vnj5MQFsJbA5qpkK8tfzGXCr5eog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fke/f2Phbi9bhv8nqVj8HuRjf/h3SzwMJW2UZUazCSRQIeEM+5jw9Pv4QE3VloeoH
         1gmbN/PrErT7/QozAM0WA2klfauYDW9v5i20xJS//TxMgtsBx+8UZdM8n5SBlYDgwk
         Fz2uK4i8LETUHP/xvbmQkRzyEoe7ZRC9+X5It3Kk=
Date:   Mon, 17 Feb 2020 12:05:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, devicetree@vger.kernel.org, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: Re: [PATCH v1 05/12] arm64: dts: librem5-devkit: add the sgtl5000
 i2c audio codec
Message-ID: <20200217040524.GE5395@dragon>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
 <20200205143003.28408-6-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205143003.28408-6-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 03:29:56PM +0100, Martin Kepplinger wrote:
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
> 
> Describe the sgtl5000 of the librem 5 devkit in devicetree.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../boot/dts/freescale/imx8mq-librem5-devkit.dts    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index e7e3766198c6..56b4ac286801 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -480,6 +480,19 @@
>  		vddio-supply = <&reg_3v3_p>;
>  	};
>  
> +	sgtl5000: sgtl5000@a {

audio-codec for the node name.

> +		compatible = "fsl,sgtl5000";
> +		clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
> +		assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
> +		assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
> +		assigned-clock-rates = <24576000>;
> +		#sound-dai-cells = <0>;
> +		reg = <0x0a>;
> +		VDDD-supply = <&reg_1v8_p>;
> +		VDDIO-supply = <&reg_3v3_p>;
> +		VDDA-supply = <&reg_3v3_p>;
> +	};
> +

Add a device only when there is a user for it.

Shawn

>  	touchscreen@5d {
>  		compatible = "goodix,gt5688";
>  		reg = <0x5d>;
> -- 
> 2.20.1
> 
