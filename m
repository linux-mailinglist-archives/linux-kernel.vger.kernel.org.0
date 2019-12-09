Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D75116596
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 04:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfLIDrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 22:47:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfLIDrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 22:47:49 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95FED20663;
        Mon,  9 Dec 2019 03:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575863268;
        bh=gbAWx/Homjwlessv9WNcGCDHpl4sgHhFZoIC+r7vDcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlNlN4TWyP5wDGVKe73e/6cQSpb2q/kPc4D5fq2mAm9UT2d5hPIWLC4A7o1nZabPE
         tfpS4ZtDxsUJiRICfA4Z13QMIFFITt7IEh2nxauYhlshF6huY/xTrKNX1ODyBA1QAc
         HpTLG/LW/JoQ5+zQMkOIiNvvMcydfzljfYa+GcC4=
Date:   Mon, 9 Dec 2019 11:47:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix reboot node
Message-ID: <20191209034722.GZ3365@dragon>
References: <20191123000709.13162-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123000709.13162-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 01:07:09AM +0100, Michael Walle wrote:
> The reboot register isn't located inside the DCFG controller, but in its
> own RST controller. Fix it.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 72b9a75976a1..dc75534a4754 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -102,7 +102,7 @@
>  
>  	reboot {
>  		compatible ="syscon-reboot";
> -		regmap = <&dcfg>;
> +		regmap = <&rst>;
>  		offset = <0xb0>;
>  		mask = <0x02>;
>  	};
> @@ -161,6 +161,12 @@
>  			big-endian;
>  		};
>  
> +		rst: syscon@1e60000 {
> +			compatible = "fsl,ls1028a-rst", "syscon";

Compatible "fsl,ls1028a-rst" seems undocumented?

Shawn

> +			reg = <0x0 0x1e60000 0x0 0x10000>;
> +			little-endian;
> +		};
> +
>  		scfg: syscon@1fc0000 {
>  			compatible = "fsl,ls1028a-scfg", "syscon";
>  			reg = <0x0 0x1fc0000 0x0 0x10000>;
> -- 
> 2.20.1
> 
