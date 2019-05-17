Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D280521447
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 09:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfEQHax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 03:30:53 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:32899 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfEQHax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:30:53 -0400
X-Originating-IP: 80.215.154.25
Received: from localhost (unknown [80.215.154.25])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3C582E0006;
        Fri, 17 May 2019 07:30:48 +0000 (UTC)
Date:   Fri, 17 May 2019 09:30:48 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i-h3: Fix wifi in Beelink X2 DT
Message-ID: <20190517073048.y6mzgbhhryfmuckl@flea>
References: <20190516161039.18534-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jkbi65rx3dzh424y"
Content-Disposition: inline
In-Reply-To: <20190516161039.18534-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jkbi65rx3dzh424y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, May 16, 2019 at 06:10:39PM +0200, Jernej Skrabec wrote:
> mmc1 node where wifi module is connected doesn't have properly defined
> power supplies so wifi module is never powered up. Fix that by
> specifying additional power supplies.
>
> Additionally, this STB may have either Realtek or Broadcom based wifi
> module. One based on Broadcom module also needs external clock to work
> properly. Fix that by adding clock property to wifi_pwrseq node.
>
> Fixes: e582b47a9252 ("ARM: dts: sun8i-h3: Add dts for the Beelink X2 STB")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> index 6277f13f3eb3..6a0ac85b4616 100644
> --- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> @@ -89,7 +89,10 @@
>
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";

pinctrl-names only make sense with another pinctrl-[0-255]
property. Did you forgot something here?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jkbi65rx3dzh424y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN5jKAAKCRDj7w1vZxhR
xUr9AP97UzodMbd7XRkMSWOZH5h4GuNferFgLYoAMM0yGXZWrwD6AwhGz1w7cehv
pfHluFzjaOLCt4LLQWUiDAMaW2+Y0wU=
=ocrv
-----END PGP SIGNATURE-----

--jkbi65rx3dzh424y--
