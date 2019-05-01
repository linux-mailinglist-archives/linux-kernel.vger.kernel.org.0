Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0831106B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEAXyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 19:54:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41286 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEAXyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 19:54:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id g8so476456otl.8;
        Wed, 01 May 2019 16:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tXDCdd92LBDtjOFs+J4ymG7qHEvoPQwEOfUzmA0UDOI=;
        b=sXQoyqYcyVA0ILa3tjXc/AOmBS87ozU0X6j6A4cABupoStrU+ZXFJcDQARFV8LtAAa
         6Fy3E7EWFDTnqpbuge17wFnGKLIjffALKKLRIyR6eYayCp2lGW7VZy1NubHSFgzgt8Zq
         bIQ8twIbDUIGPaM8dkbbul0i/jm7Ul4f8OF7h9ZdQGypWCJEbc1u0Uz31cbiRgrijbZF
         azOrMwoNXmG8JjWGzRcX2ltZD98kPjAXq/3uBKPPER7CgNSyCXiWU6v+kynXlXLXHP7F
         Ba9wekgZB1Lh1LgiKhD99ZzroebY+84F979hSKO+NuRgbF+JK2J/wwh0urLK1MHjgNN8
         zdrA==
X-Gm-Message-State: APjAAAXA1R9XeODJGrUelUqtFPmZcijsjaAXN/981nR+NMZ42sLv0sD1
        aX/5PjTxSqwtcMRoX9fPyQ==
X-Google-Smtp-Source: APXvYqzf/+u+ytGa+dH4EzbSSOPM/R0r52/cNtm0uZJL/klvn3nRkLc4+3PH34Fir0IUOaAoVXP1wQ==
X-Received: by 2002:a05:6830:144c:: with SMTP id w12mr508462otp.192.1556754851856;
        Wed, 01 May 2019 16:54:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 3sm12085412oti.45.2019.05.01.16.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 16:54:10 -0700 (PDT)
Date:   Wed, 1 May 2019 18:54:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ls1028a: Add USB dt nodes
Message-ID: <20190501235410.GA25492@bogus>
References: <20190426055558.44544-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426055558.44544-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 05:54:26AM +0000, Ran Wang wrote:
> This patch adds USB dt nodes for LS1028A.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v2:
>   - Rename node from usb3@... to usb@... to meet DTSpec
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 8dd3501..188cfb8 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -144,6 +144,26 @@
>  			clocks = <&sysclk>;
>  		};
>  
> +		usb0:usb@3100000 {
                     ^ space needed

> +			compatible= "snps,dwc3";

Needs an SoC specific compatible.

> +			reg= <0x0 0x3100000 0x0 0x10000>;
> +			interrupts= <0 80 0x4>;
> +			dr_mode= "host";
> +			snps,dis_rxdet_inp3_quirk;
> +			snps,quirk-frame-length-adjustment = <0x20>;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> +		};
> +
> +		usb1:usb@3110000 {
> +			compatible= "snps,dwc3";
> +			reg= <0x0 0x3110000 0x0 0x10000>;
> +			interrupts= <0 81 0x4>;
> +			dr_mode= "host";
> +			snps,dis_rxdet_inp3_quirk;
> +			snps,quirk-frame-length-adjustment = <0x20>;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> +		};
> +
>  		i2c0: i2c@2000000 {
>  			compatible = "fsl,vf610-i2c";
>  			#address-cells = <1>;
> -- 
> 1.7.1
> 
