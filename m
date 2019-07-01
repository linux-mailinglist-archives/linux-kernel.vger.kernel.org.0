Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA4D2C727
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 14:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfE1M7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 08:59:05 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34037 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfE1M7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:59:04 -0400
Received: from aptenodytes (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7D3D2240011;
        Tue, 28 May 2019 12:58:58 +0000 (UTC)
Message-ID: <2b671c1f0734177a6283407f753403473b70f5bc.camel@bootlin.com>
Subject: Re: [linux-sunxi] [RESEND PATCH] ARM: dts: sun7i: olimex-lime2:
 Enable ac and power supplies
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     plaes@plaes.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com
Date:   Tue, 28 May 2019 14:58:57 +0200
In-Reply-To: <20190528063544.17408-1-plaes@plaes.org>
References: <20190528063544.17408-1-plaes@plaes.org>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2019-05-28 at 09:35 +0300, Priit Laes wrote:
> Lime2 has battery connector so enable these supplies.

Out of curiosity, what is reported to userspace when no battery is
attached?

Looks good otherwise:
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> index 9c8eecf4337a..9001b5527615 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -206,6 +206,14 @@
>  
>  #include "axp209.dtsi"
>  
> +&ac_power_supply {
> +	status = "okay";
> +};
> +
> +&battery_power_supply {
> +	status = "okay";
> +};
> +
>  &reg_dcdc2 {
>  	regulator-always-on;
>  	regulator-min-microvolt = <1000000>;
> -- 
> 2.11.0
> 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

