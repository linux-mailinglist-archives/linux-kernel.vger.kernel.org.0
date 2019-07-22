Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAAB6F9A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 08:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfGVGtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 02:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfGVGtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:49:13 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C92121F26;
        Mon, 22 Jul 2019 06:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563778152;
        bh=sIc+AwBn2K9+LHNS4raXYSMczgBUvlPESoR4NJQLQxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okhk/niS8KhKuHHKL9IU8Gl3191MGVibZd7mm7eo0Vq9iYQhosqPniyuCL8YGVUsX
         zGQg5zDJ/00d4RE56HbBnxkBqX0bZYzC82zsDqM+li1lZmz5IQ4WTNIVpPMBIsUjZ/
         SiKdrlcGJ7iUfw/RL7mxYzWEoqVXyoL1eTFNulvs=
Date:   Mon, 22 Jul 2019 14:48:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mq: Default parents for PCIE1 clocks
Message-ID: <20190722064840.GB3738@dragon>
References: <1562235864-12953-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562235864-12953-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 01:24:24PM +0300, Abel Vesa wrote:
> Set default parents for PCIE1_CTRL and PCIE1_PHY clocks.

Can you add a few words about why this change is necessary?

Shawn

> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index e3df9b8..23bf85f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -235,6 +235,10 @@
>  		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
>  		 <&pcie0_refclk>;
>  	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +	assigned-clocks = <&clk IMX8MQ_CLK_PCIE1_CTRL>,
> +			  <&clk IMX8MQ_CLK_PCIE1_PHY>;
> +	assigned-clock-parents = <&clk IMX8MQ_SYS2_PLL_250M>,
> +				 <&clk IMX8MQ_SYS2_PLL_100M>;
>  	status = "okay";
>  };
>  
> -- 
> 2.7.4
> 
