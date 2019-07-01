Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD50162AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfEGLRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 07:17:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34362 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEGLRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:17:14 -0400
Received: from we0048.dip.tu-dresden.de ([141.76.176.48] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hNy5v-00084m-35; Tue, 07 May 2019 13:17:11 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, tom@vamrs.com, dev@vamrs.com
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Enable SPI0 and SPI4 on Rock960
Date:   Tue, 07 May 2019 13:17:10 +0200
Message-ID: <3484838.jBNMtg6mRV@phil>
In-Reply-To: <20190506120458.25842-1-manivannan.sadhasivam@linaro.org>
References: <20190506120458.25842-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 6. Mai 2019, 14:04:57 CEST schrieb Manivannan Sadhasivam:
> Enable SPI0 and SPI4 exposed on the Low and High speed expansion
> connectors of Rock960.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> index 12285c51cceb..7498344d4a73 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> @@ -114,6 +114,18 @@
>  	};
>  };
>  
> +&spi0 {
> +	/* On Low speed expansion */
> +	label = "LS-SPI0";

where does the label property come from and what does it do?
It's not part of the rockchip-spi / general-spi binding.


Heiko

> +	status = "okay";
> +};
> +
> +&spi4 {
> +	/* On High speed expansion */
> +	label = "HS-SPI1";
> +	status = "okay";
> +};
> +
>  &usbdrd_dwc3_0 {
>  	dr_mode = "otg";
>  };
> 




