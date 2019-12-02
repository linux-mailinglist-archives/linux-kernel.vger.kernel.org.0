Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0040B10EB14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 14:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfLBNsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 08:48:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfLBNsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:48:13 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73332053B;
        Mon,  2 Dec 2019 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575294493;
        bh=68gVpj7OMA9BcFgcDkkN8ZgFocPqY7k3fD758PWkQZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TpzXSedQXEBTjAuBHm2WPPu+7DthlU4UXTfJNyoz8bG/sk0Di+Dl684WtoB9RsQ9o
         w9M0Lv9xK4Cif9eBB3qP7GqLn6Mgo8tSrwOb194G8+w6QHwEJ63x0YYgwX8FLvW1NE
         k5Zv8qqC8bsA6zQhMdkWxRGDf3U1L2DiLjt3QIYI=
Date:   Mon, 2 Dec 2019 21:47:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7ulp: Add cpu clock-frequency property
Message-ID: <20191202134748.GB21897@dragon>
References: <1572918578-13544-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572918578-13544-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 09:49:38AM +0800, Anson Huang wrote:
> Add "clock-frequency" property to avoid below warning on i.MX7ULP:
> 
> [    0.011762] /cpus/cpu@0 missing clock-frequency property
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx7ulp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
> index d37a192..87b2237 100644
> --- a/arch/arm/boot/dts/imx7ulp.dtsi
> +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> @@ -41,6 +41,7 @@
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <0>;
> +			clock-frequency = <500210526>;

I cannot find the binding doc for this property.  What is the
definition of it, the maximum frequency that the cpu could possibly run
at?

Shawn

>  		};
>  	};
>  
> -- 
> 2.7.4
> 
