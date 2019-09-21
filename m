Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670BBB9FB4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 22:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfIUUrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Sep 2019 16:47:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33921 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfIUUrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 16:47:02 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1936A80EA6; Sat, 21 Sep 2019 22:46:46 +0200 (CEST)
Date:   Sat, 21 Sep 2019 22:46:59 +0200
From:   Pavel Machek <pavel@denx.de>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Phil Reid <preid@electromag.com.au>,
        Moritz Fischer <mdf@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 32/79] fpga: altera-ps-spi: Fix getting of optional
 confd gpio
Message-ID: <20190921204659.GC14868@amd>
References: <20190919214807.612593061@linuxfoundation.org>
 <20190919214810.609051121@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <20190919214810.609051121@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Currently the driver does not handle EPROBE_DEFER for the confd gpio.
> Use devm_gpiod_get_optional() instead of devm_gpiod_get() and return
> error codes from altera_ps_probe().

> @@ -265,10 +265,13 @@ static int altera_ps_probe(struct spi_device *spi)
>  		return PTR_ERR(conf->status);
>  	}
> =20
> -	conf->confd =3D devm_gpiod_get(&spi->dev, "confd", GPIOD_IN);
> +	conf->confd =3D devm_gpiod_get_optional(&spi->dev, "confd", GPIOD_IN);
>  	if (IS_ERR(conf->confd)) {
> -		dev_warn(&spi->dev, "Not using confd gpio: %ld\n",
> -			 PTR_ERR(conf->confd));
> +		dev_err(&spi->dev, "Failed to get confd gpio: %ld\n",
> +			PTR_ERR(conf->confd));
> +		return PTR_ERR(conf->confd);

Will this result in repeated errors in dmesg in case of EPROBE_DEFER?
We often avoid printing such messages in EPROBE_DEFER case.

> +	} else if (!conf->confd) {
> +		dev_warn(&spi->dev, "Not using confd gpio");
>  	}
> =20
>  	/* Register manager with unique name */

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2GjEMACgkQMOfwapXb+vLWngCeLWHCxTo8mcUYpW0aCCTkNY/Q
q4QAn2ad1B60c82dx/CY4tBk65tVVhjr
=+b4E
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
