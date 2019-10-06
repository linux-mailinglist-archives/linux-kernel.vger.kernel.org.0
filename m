Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41B1CCD97
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 03:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfJFBBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 21:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfJFBBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 21:01:36 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41778222C5;
        Sun,  6 Oct 2019 01:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570323695;
        bh=u9QvhR9lqJ6StmNv8NAJZHc+hhhHyZb4CxaNHiDBHbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTlXc+UR6+Nug1PPV4pT6l8dVEOguUDilWaamNP4vKos9Hm1wt/z8pvA1g2xjY8Ru
         b0evmTcy66sQg1h8ni8+cntfTbYTg6cluAVCQiXBX5l6HrKbSc2ee2MjpDuHZcmk3W
         KHyhcAn43L3AaJSR4iIVgIIwmwvJWbqsWvipz2JU=
Date:   Sun, 6 Oct 2019 09:01:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: arm64: ls1028a-qds: correct bus of rtc
Message-ID: <20191006010123.GF7150@dragon>
References: <20190904085104.44709-1-biwen.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904085104.44709-1-biwen.li@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 04:51:04PM +0800, Biwen Li wrote:
> The rtc is on i2c2 bus(hardware), not on i2c1 channel 3,
> so correct it
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

This looks a like a fix.  Do we need a Fixes tag for it?

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index de6ef39f3118..6c0540ad9c59 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -133,11 +133,6 @@
>  				vcc-supply = <&sb_3v3>;
>  			};
>  
> -			rtc@51 {
> -				compatible = "nxp,pcf2129";
> -				reg = <0x51>;
> -			};
> -
>  			eeprom@56 {
>  				compatible = "atmel,24c512";
>  				reg = <0x56>;
> @@ -166,6 +161,14 @@
>  	};
>  };
>  
> +&i2c1 {
> +	status = "okay";

Please have a newline between properties and child node.

Shawn

> +	rtc@51 {
> +		compatible = "nxp,pcf2129";
> +		reg = <0x51>;
> +	};
> +};
> +
>  &sai1 {
>  	status = "okay";
>  };
> -- 
> 2.17.1
> 
