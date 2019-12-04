Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876A9112315
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 07:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfLDG6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 01:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfLDG6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 01:58:10 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76671206DB;
        Wed,  4 Dec 2019 06:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575442689;
        bh=7seXlS1sOOZzrxTvwmuY87kLA2KWFaeWkHCkND/6oSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qSIx10rTxmfaITCR9DxHpGeoYI5fkNuXBro6H2BESFMsiCASc1/AI8J6ylZJY3ODn
         xFsey2dXosB68ISVWrW/gzSm1l7SPZstwTqMcCeVS5H+755aiRLTqoXmWdWq6u4/xk
         N5aKsXoF4ZekmMH33dUoa6pcNgigi1oMiz3ovJOE=
Date:   Wed, 4 Dec 2019 14:58:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: lx2160a: add emdio1 node
Message-ID: <20191204065802.GB3365@dragon>
References: <1573055536-21786-1-git-send-email-ioana.ciornei@nxp.com>
 <1573055536-21786-2-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573055536-21786-2-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:52:15PM +0200, Ioana Ciornei wrote:
> Add the External MDIO1 device node found in the WRIOP global memory
> region. This is needed for management of external PHYs.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 80268c6ed5fb..8b87a0122b54 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -478,6 +478,17 @@
>  			little-endian;
>  		};
>  
> +		/* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
> +		emdio1: mdio@8b96000 {

Please find the place for the node in order of unit-address.

Shawn

> +			compatible = "fsl,fman-memac-mdio";
> +			reg = <0x0 0x8b96000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			little-endian;
> +			status = "disabled";
> +		};
> +
>  		i2c0: i2c@2000000 {
>  			compatible = "fsl,vf610-i2c";
>  			#address-cells = <1>;
> -- 
> 1.9.1
> 
