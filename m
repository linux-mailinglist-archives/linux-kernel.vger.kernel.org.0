Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37A277A49
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 17:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfG0Pdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 11:33:46 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52692 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbfG0Pdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 11:33:44 -0400
Received: from d57e23da.static.ziggozakelijk.nl ([213.126.35.218] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hrOhX-0002VP-9k; Sat, 27 Jul 2019 17:33:39 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Add missing unit address to memory node on rk3288-veyron
Date:   Sat, 27 Jul 2019 17:33:38 +0200
Message-ID: <86910491.m50tbimVMv@phil>
In-Reply-To: <20190727142736.23188-2-krzk@kernel.org>
References: <20190727142736.23188-1-krzk@kernel.org> <20190727142736.23188-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Am Samstag, 27. Juli 2019, 16:27:36 CEST schrieb Krzysztof Kozlowski:
> Fix DTC warning:
> 
>     arch/arm/boot/dts/rk3288-veyron.dtsi:21.9-24.4:
>     Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name

please see the comment directly above the memory node on why that needs
to stay that way. So no, we'll keep the veyron memory node as is.


Heiko

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index 8fc8eac699bf..02243ff46a65 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -18,7 +18,7 @@
>  	 * The default coreboot on veyron devices ignores memory@0 nodes
>  	 * and would instead create another memory node.
>  	 */
> -	memory {
> +	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
> 




