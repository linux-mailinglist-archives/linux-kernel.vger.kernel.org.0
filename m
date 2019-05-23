Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFCE27759
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfEWHoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 03:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfEWHoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:44:00 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 467A020856;
        Thu, 23 May 2019 07:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558597439;
        bh=hwfjC0bXWxh5lwODucXR9POcCE97XxGPfx1uJr9D5yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9onpqNwODufrI8uriW0tYeYRv+0mlHpJc++3atbbEighhn/1SpHQpYJWkxUeeJAe
         V9YnYpsQfUDuuvh68tB23LMxH806pLBp+uwFdJ87PJZnTEigJT4LK2jRID4t/0VoAr
         SRBPYBsBm0cH6dtEqbFP15rfsZia3Af4BmFosvoU=
Date:   Thu, 23 May 2019 15:43:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] arm64: dts: lx2160a: Enable usb3-lpm-capable for
 usb3 node
Message-ID: <20190523074300.GH9261@dragon>
References: <20190515060434.33581-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515060434.33581-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 02:04:34PM +0800, Ran Wang wrote:
> Enable USB3 HW LPM feature for lx2160a and active patch for
> snps erratum A-010131. It will disable U1/U2 temperary when
> initiate U3 request.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Depend on: https://lore.kernel.org/patchwork/patch/870134/

Is the dependency accepted?

Shawn

> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 125a8cc..0073df3 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -696,6 +696,8 @@
>  			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
> +			usb3-lpm-capable;
> +			snps,dis-u1u2-when-u3-quirk;
>  			snps,dis_rxdet_inp3_quirk;
>  			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  			status = "disabled";
> @@ -707,6 +709,8 @@
>  			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
> +			usb3-lpm-capable;
> +			snps,dis-u1u2-when-u3-quirk;
>  			snps,dis_rxdet_inp3_quirk;
>  			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  			status = "disabled";
> -- 
> 1.7.1
> 
