Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B404C141090
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 19:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgAQSOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 13:14:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbgAQSOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:14:30 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2981620748;
        Fri, 17 Jan 2020 18:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579284869;
        bh=1r92zzD8XWpIGYHwCR61Uj+YCjejOaMCX1TbdsNW94c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o90IHGwWDzmgjs2UOwYCFlu/eT5jmUkchRD2VpUdmHw05PF5YZZXaUIrkVSDm6ZIL
         jgO15hnCyLC3L1DKQZAXSgt2Hsve/p3+/Oms6nRlG/5fFXq/sBTQ3uXOuL81hBTWVV
         +MtoTJVakZT8hdU7GLMvaaD9Rwxx8So843ysjPow=
Date:   Fri, 17 Jan 2020 19:14:27 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: allwinner: h6: tanix-tx6: enable emmc
Message-ID: <20200117181427.hy7qsyxwomsl3v2q@gilmour.lan>
References: <20200115193441.172902-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3cltcqsa3lajhg5"
Content-Disposition: inline
In-Reply-To: <20200115193441.172902-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f3cltcqsa3lajhg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2020 at 08:34:41PM +0100, Jernej Skrabec wrote:
> Tanix TX6 has 32 GiB eMMC. Add a node for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../dts/allwinner/sun50i-h6-tanix-tx6.dts     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> index 83e6cb0e59ce..8cbf4e4a761e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> @@ -31,6 +31,13 @@ hdmi_con_in: endpoint {
>  		};
>  	};
>
> +	reg_vcc1v8: vcc1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
>  	reg_vcc3v3: vcc3v3 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc3v3";
> @@ -78,6 +85,15 @@ &mmc0 {
>  	status = "okay";
>  };
>
> +&mmc2 {
> +	vmmc-supply = <&reg_vcc3v3>;
> +	vqmmc-supply = <&reg_vcc1v8>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	bus-width = <8>;
> +	status = "okay";
> +};
> +
>  &ohci0 {
>  	status = "okay";
>  };
> @@ -86,6 +102,10 @@ &ohci3 {
>  	status = "okay";
>  };
>
> +&pio {
> +	vcc-pc-supply = <&reg_vcc1v8>;
> +};
> +

Can you list all of the regulators for the H6 while you're at it (in a
preliminary patch, ideally)?

Thanks!
Maxime

--f3cltcqsa3lajhg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiH5gwAKCRDj7w1vZxhR
xSStAP9vFRUXKGi1EuMs8pb4/YHRNScqQrchGDt874B7pjrD1AD+PUlqtp134Y+C
7bsxe4hKGX8rhUf/fZ/H9oGhJ6/YJQM=
=gOtr
-----END PGP SIGNATURE-----

--f3cltcqsa3lajhg5--
