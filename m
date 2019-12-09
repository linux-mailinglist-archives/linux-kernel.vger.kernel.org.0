Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258F0117709
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 21:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLIUKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 15:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIUKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:10:06 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B75E214D8;
        Mon,  9 Dec 2019 20:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575922205;
        bh=Diy0RAMb2nmCr+FApInTdUlXJLEjOPXITAFoPxtK6Lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZFLl1YErRFnSKRSMXOxm4n5/u2qhnNLjtgxyrohyoLZ+o8nhFndXIBnXQsAU+MM2
         /0gsZJcFQhNPp305wZejd1Lh83xdrq+035ePlZU9W2siegqsB+I00VwRzR+OyCEFWq
         FERNlByejYl2Jd5EifpsZNDR2TjecUkM4vsyRe9g=
Date:   Mon, 9 Dec 2019 20:37:29 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wens@csie.org,
        alistair23@gmail.com
Subject: Re: [PATCH] arm64: allwinner: Enable Bluetooth and WiFi on sopine
 baseboard
Message-ID: <20191209193729.jfw2z4iqlhrzohse@hendrix.lan>
References: <20191207192249.8346-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207192249.8346-1-alistair@alistair23.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2019 at 11:22:49AM -0800, Alistair Francis wrote:
> The sopine board has an optional RTL8723BS WiFi + BT module that can be
> connected to UART1. Add this to the device tree so that it will work for
> users if connected.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index 920103ec0046..0a91f9d8ed47 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -214,6 +214,20 @@ &uart0 {
>  	status = "okay";
>  };
>
> +&uart1 {
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +        status = "okay";
> +
> +        bluetooth {
> +                compatible = "realtek,rtl8723bs-bt";
> +                reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
> +                device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
> +                host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> +                firmware-postfix = "pine64";
> +        };
> +};
> +

Output from checkpatch:
total: 10 errors, 11 warnings, 0 checks, 20 lines checked

More importantly, that binding isn't documented, and doesn't have a
driver either.

I guess you want to have a look at:
https://www.spinics.net/lists/arm-kernel/msg771488.html

Maxime
