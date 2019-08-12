Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F410689A00
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfHLJkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 05:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbfHLJkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:40:03 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C5CA20842;
        Mon, 12 Aug 2019 09:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565602803;
        bh=/plNdRQRHBEq6qvxvso4EuN5b9FnPD1xRMuPGqmRwTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLuOei9lChDsYwwW7g1GJU+7p3XrwM5Yxo08WjXwxfJgJJuhMLFNtTab71jhLTaa5
         JUgN0eOQ3JwQ6S8DjBLqiDQ9tq27o8mLarficjY5umbrndouUDLXFmm0lhaowZQxA+
         lkDZ37T2Kzzg73poMkUp8sZfqTlzPj/echbiV33g=
Date:   Mon, 12 Aug 2019 11:40:00 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM64: dts: allwinner: Add devicetree for pine H64
 modelA evaluation board
Message-ID: <20190812094000.ebdmhyxx7xzbevef@flea>
References: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qxku4lofbephj3it"
Content-Disposition: inline
In-Reply-To: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qxku4lofbephj3it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 10:42:53AM +0200, Corentin Labbe wrote:
> This patch adds the evaluation variant of the model A of the PineH64.
> The model A has the same size of the pine64 and has a PCIE slot.
>
> The only devicetree difference with current pineH64, is the PHY
> regulator.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>  .../sun50i-h6-pine-h64-modelA-eval.dts        | 26 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
>
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index f6db0611cb85..9a02166cbf72 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -25,3 +25,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-3.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-modelA-eval.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> new file mode 100644
> index 000000000000..d8ff02747efe
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2019 Corentin Labbe <clabbe.montjoie@gmail.com>
> + */
> +
> +#include "sun50i-h6-pine-h64.dts"
> +
> +/ {
> +	model = "Pine H64 model A evaluation board";
> +	compatible = "pine64,pine-h64-modelA-eval", "allwinner,sun50i-h6";
> +
> +	reg_gmac_3v3: gmac-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-gmac-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <100000>;
> +		gpio = <&pio 2 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +};
> +
> +&emac {
> +	phy-supply = <&reg_gmac_3v3>;
> +};

I might be missing some context here, but I'm pretty sure that the
initial intent of the pine h64 DTS was to support the model A all
along.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qxku4lofbephj3it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVEz8AAKCRDj7w1vZxhR
xVT5AQCmtGrOG8xFK95J8ZjmGV7HZxfxvNxV172wPtPegEHT2gEAtbdxFg5Ppsz/
TgtO+rT2XvcyllgsUSCaps9xmEidaAY=
=GlSZ
-----END PGP SIGNATURE-----

--qxku4lofbephj3it--
