Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF46F8A08D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 16:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfHLORe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 10:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfHLORe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:17:34 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AAFE20679;
        Mon, 12 Aug 2019 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565619453;
        bh=29VUEDM2dmCIL10kGZLjVx43mBJDQtDwf0Ic1S1sTGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPo9emimkCnzzzAxb2H8E560aYiHwJHh7Psl/fziDqjGoLkHs3vb6blwqkwcN46JF
         b598yTAgaD/nRH7UskzS1p9KKlDV3iu8DQFYZcnUWXeBfEQC9MYMyAIR7vO3xjjOrB
         eyhELkzHxw5Q82A/CMvAK9eCWpNLgKGgZfhpChH0=
Date:   Mon, 12 Aug 2019 16:17:24 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: ls1088a: Fix incorrect I2C clock divider
Message-ID: <20190812141722.GJ27041@X250>
References: <20190806084223.23543-1-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806084223.23543-1-chuanhua.han@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 04:42:20PM +0800, Chuanhua Han wrote:
> Ls1088a platform, the i2c input clock is actually platform pll CLK / 8
> (this is the hardware connection), other clock divider can not get the
> correct i2c clock, resulting in the output of SCL pin clock is not
> accurate.
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>

@Leo, looks good?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 20f5ebd..30b760e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -324,7 +324,7 @@
>  			#size-cells = <0>;
>  			reg = <0x0 0x2000000 0x0 0x10000>;
>  			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&clockgen 4 3>;
> +			clocks = <&clockgen 4 7>;
>  			status = "disabled";
>  		};
>  
> @@ -334,7 +334,7 @@
>  			#size-cells = <0>;
>  			reg = <0x0 0x2010000 0x0 0x10000>;
>  			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&clockgen 4 3>;
> +			clocks = <&clockgen 4 7>;
>  			status = "disabled";
>  		};
>  
> @@ -344,7 +344,7 @@
>  			#size-cells = <0>;
>  			reg = <0x0 0x2020000 0x0 0x10000>;
>  			interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&clockgen 4 3>;
> +			clocks = <&clockgen 4 7>;
>  			status = "disabled";
>  		};
>  
> @@ -354,7 +354,7 @@
>  			#size-cells = <0>;
>  			reg = <0x0 0x2030000 0x0 0x10000>;
>  			interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&clockgen 4 3>;
> +			clocks = <&clockgen 4 7>;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.9.5
> 
