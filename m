Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5B19E1C10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405193AbfJWNO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389590AbfJWNO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:14:56 -0400
Received: from earth.universe (monacowifi.monaco.mc [82.113.13.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D31E21906;
        Wed, 23 Oct 2019 13:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571836495;
        bh=E6T55uP3FrNoFRn1ScztDiriAouaJNVm+C23qSgGr54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRZo+1m99h+6klvOJNcfToHQwLue1EIjCd65zwAMbXCJmUecwaD6rTEZZMg9+kYGQ
         X5a4WwTr2/f7Tv+/O8EavXhqMgoo2QXEcQz50Xv0uqv9yVI1aI0ToD4bwbFdEjF4FY
         xMiNVRLd3aBYkcz5+MbbKBcELuqBmnzcS8WN5k6k=
Received: by earth.universe (Postfix, from userid 1000)
        id 6FA8C3C09B2; Wed, 23 Oct 2019 15:14:52 +0200 (CEST)
Date:   Wed, 23 Oct 2019 15:14:52 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Adam Ford <aford173@gmail.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: omap3-rom - Fix unused function warnings
Message-ID: <20191023131452.2rilepif7x5lpfma@earth.universe>
References: <20191022142741.1794378-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sf4hte6kcc3ifsee"
Content-Disposition: inline
In-Reply-To: <20191022142741.1794378-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sf4hte6kcc3ifsee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 22, 2019 at 04:27:31PM +0200, Arnd Bergmann wrote:
> When runtime-pm is disabled, we get a few harmless warnings:
>=20
> drivers/char/hw_random/omap3-rom-rng.c:65:12: error: unused function 'oma=
p_rom_rng_runtime_suspend' [-Werror,-Wunused-function]
> drivers/char/hw_random/omap3-rom-rng.c:81:12: error: unused function 'oma=
p_rom_rng_runtime_resume' [-Werror,-Wunused-function]
>=20
> Mark these functions as __maybe_unused so gcc can drop them
> silently.
>=20
> Fixes: 8d9d4bdc495f ("hwrng: omap3-rom - Use runtime PM instead of custom=
 functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/char/hw_random/omap3-rom-rng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/char/hw_random/omap3-rom-rng.c b/drivers/char/hw_ran=
dom/omap3-rom-rng.c
> index 0b90983c95c8..e08a8887e718 100644
> --- a/drivers/char/hw_random/omap3-rom-rng.c
> +++ b/drivers/char/hw_random/omap3-rom-rng.c
> @@ -62,7 +62,7 @@ static int omap3_rom_rng_read(struct hwrng *rng, void *=
data, size_t max, bool w)
>  	return r;
>  }
> =20
> -static int omap_rom_rng_runtime_suspend(struct device *dev)
> +static int __maybe_unused omap_rom_rng_runtime_suspend(struct device *de=
v)
>  {
>  	struct omap_rom_rng *ddata;
>  	int r;
> @@ -78,7 +78,7 @@ static int omap_rom_rng_runtime_suspend(struct device *=
dev)
>  	return 0;
>  }
> =20
> -static int omap_rom_rng_runtime_resume(struct device *dev)
> +static int __maybe_unused omap_rom_rng_runtime_resume(struct device *dev)
>  {
>  	struct omap_rom_rng *ddata;
>  	int r;
> --=20
> 2.20.0
>=20

--sf4hte6kcc3ifsee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2wUkQACgkQ2O7X88g7
+prkIQ//eDW6JCdb1BVZK+8ld4GNb5f9QiGBp78CEzw4Nt7b9sjiSkuODvtpwUEz
LUYeSj3XJErABjT9CEteFHYmXlS4Tge9a12s4596KR1sut3960u83ZSVMD2MaFd7
jnNp9oZsiJivbZPWMqCiFPxpaV8nmvYvnyX5yMgDFrAMFFS6qk2w6ZznJctahXzs
WyKmQQTOc7wFo0AsT3iomSxZsyPKjPWUcXF1fO49Anzka3+6aV5k6mmEVEhMep/r
txA1zr6Fw3OKwF72r1x1bg2VcLluU4K66cm8R636W1FzujvHUgkWYr3BcUwaCqwr
LlTzvVokm6Pq2L9hFVIo5WrCP2qnnlzKXu6M0BoFcSWq0sXi2slhE1J1jlg63NpG
nHn/cpu8DPDfvZ/SdvDfESCGaMubItcv4EhauN/Ar8x2buf3duK4OE4ApJGUWnOV
BzghZnt1iY6y1JC4Rbnl6NJYaZm54sYjMildCKza4OuoLYGeTZKEM/bqpbiVodtI
Rm4nUpxCkZ2vfI2XxyDYuxmzzF/lu+1oZOTHDpVlv0OlqAJhgXzvUiuikMxS+6xQ
LSAzY1uG14pfrwKAUtWoh1vG/ZVoK5UpRYyhBnAAPcXH3C4h6TKxBwGCJ0BrhLmI
PfZIF2uCFofMB8Q3A8/cGxx6WGVgKWU1xkQhGr51TMgxA13+vwk=
=uPzb
-----END PGP SIGNATURE-----

--sf4hte6kcc3ifsee--
