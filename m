Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219C3100396
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 12:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKRLLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 06:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfKRLLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:11:47 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C790E2075E;
        Mon, 18 Nov 2019 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574075506;
        bh=8iL77Cbod2Ldiv/Kdt/qOxk6iOq/uRTCIjFxHr20nBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qq3QIkHDLBpbwRJOsBbMchPRtT1Ua8NRpKp1o1BQyYFmK0/Wxh9Vq0GZUOG6H8xxs
         r44ljL0TDHb4sJ1TjYcMvn3e3Gv13Vwx4bZo2OwJwjwDS0jOFxpyOb/fhIvk/H+c0p
         wurFPXM4pgNllY2K6gNcSo1iaEZpBsXU3edAjdTk=
Date:   Mon, 18 Nov 2019 12:11:43 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/3] ARM: dts: sun8i: a33: add the new SecuritySystem
 compatible
Message-ID: <20191118111143.GF4345@gilmour.lan>
References: <20191114144812.22747-1-clabbe.montjoie@gmail.com>
 <20191114144812.22747-3-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p76r+0aZ/vhNbw2t"
Content-Disposition: inline
In-Reply-To: <20191114144812.22747-3-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p76r+0aZ/vhNbw2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Nov 14, 2019 at 03:48:11PM +0100, Corentin Labbe wrote:
> Add the new A33 SecuritySystem compatible to the crypto node.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a33.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index 1532a0e59af4..5680fa1de102 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -215,7 +215,8 @@
>  		};
>
>  		crypto: crypto-engine@1c15000 {
> -			compatible = "allwinner,sun4i-a10-crypto";
> +			compatible = "allwinner,sun8i-a33-crypto",
> +				     "allwinner,sun4i-a10-crypto";

If some algorithms aren't working properly, we can't really fall back
to it, we should just use the a33 compatible.

Maxime

--p76r+0aZ/vhNbw2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXdJ8bwAKCRDj7w1vZxhR
xWSsAQDfuOb7pAGVgHQzg3LHHlN6b2U6D/Lbo36ifRgHXwR4yQEA0GMSVqz5xwZy
x+K+EU4sfN71BXTin4nzbE/XEZXdQgc=
=hnch
-----END PGP SIGNATURE-----

--p76r+0aZ/vhNbw2t--
