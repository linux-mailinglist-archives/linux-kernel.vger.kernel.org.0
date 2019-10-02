Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF54C492C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 10:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfJBIIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 04:08:31 -0400
Received: from plaes.org ([188.166.43.21]:33392 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfJBIIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:08:31 -0400
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id ECE53403D6;
        Wed,  2 Oct 2019 08:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1570003709; bh=r7FM+ChyBVkd7WScYrRkPVi3YYirvvd/P+0kYWXf3zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAgy6LI7VH5imQ5NWv+1B9z1JsIT4BpA66mpgfglyXxY030499lSUVR3wRdUOKGze
         3VXmnDPv3yXb7uvEkS7H3AZ8hoKC2vxS9KAdLo/DY+ZI/9pZIPMbW42IPmxP+W38gq
         YJ3I+f9rJ2k1NkgPvxksz5dbTzXEq1PpOHF7Tb2kqzA2NcZ7Is/v6kvku4FDcypDgj
         z9SD3W320tPP6KuUJl2N0Ops9mwp/SpWBQxi1xojJMDQIcYmLEM9yNbcpWRNSRt2iu
         XCHV0r/EYZfVnXbgwWge+ucQmKlhe0I1aSin6ngB1rUsh7uQKQvLZCM7LuWz38w/6O
         YY3jwmY1fUb8A==
Date:   Wed, 2 Oct 2019 08:08:27 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux@armlinux.org.uk,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, will@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v2 04/11] ARM: dts: sun8i: R40: add crypto
 engine node
Message-ID: <20191002080827.GB6347@plaes.org>
References: <20191001184141.27956-1-clabbe.montjoie@gmail.com>
 <20191001184141.27956-5-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001184141.27956-5-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 08:41:34PM +0200, Corentin Labbe wrote:
> The Crypto Engine is a hardware cryptographic offloader that supports
> many algorithms.
> It could be found on most Allwinner SoCs.
> 
> This patch enables the Crypto Engine on the Allwinner R40 SoC Device-tree.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> index bde068111b85..1fc3297a55ec 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -266,6 +266,16 @@
>  			#phy-cells = <1>;
>  		};
>  
> +		crypto: crypto-engine@1c15000 {

All the other .dtsi files have `crypto: crypto@...` instead of crypto-engine.

> +			compatible = "allwinner,sun8i-r40-crypto";
> +			reg = <0x01c15000 0x1000>;
> +			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
> +			clock-names = "bus", "mod";
> +			resets = <&ccu RST_BUS_CE>;
> +			reset-names = "bus";
> +		};
> +
>  		ehci1: usb@1c19000 {
>  			compatible = "allwinner,sun8i-r40-ehci", "generic-ehci";
>  			reg = <0x01c19000 0x100>;
> -- 
> 2.21.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20191001184141.27956-5-clabbe.montjoie%40gmail.com.
