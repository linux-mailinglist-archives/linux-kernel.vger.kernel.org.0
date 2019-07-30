Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4EA7B479
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 22:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfG3UoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 16:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfG3UoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:44:19 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B47206A2;
        Tue, 30 Jul 2019 20:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564519458;
        bh=P3UiamUUeG6LN1NfFcjZtH7ENsm+grTuRBggTQlXPNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJF0xAo6pygf6VzDSGmlJ5OP5GQGQP+tmdc6jEWdXIiaqfCygfqED2Rk/NN/e8FEc
         KY+1JQQZ/ANT3RO4dgIMTbWnUgfgH0kBGZ2vzt6P8PFVXenTYW0lCZo+r7h/zlgGce
         2QCWy8zn3YHCZV8FJKZLcvaosNByUrSpRJJEuj2o=
Received: by earth.universe (Postfix, from userid 1000)
        id 595B03C0943; Tue, 30 Jul 2019 22:44:15 +0200 (CEST)
Date:   Tue, 30 Jul 2019 22:44:15 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 16/57] HSI: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190730204415.qvqabstlv5r5m3qw@earth.universe>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-17-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ugynw7smm36mkkr4"
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-17-swboyd@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ugynw7smm36mkkr4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 30, 2019 at 11:15:16AM -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>=20
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>=20
> ret =3D
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>=20
> if ( \( ret < 0 \| ret <=3D 0 \) )
> {
> (
> -if (ret !=3D -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>=20
> While we're here, remove braces on if statements that only have one
> statement (manually).
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>=20
> Please apply directly to subsystem trees

Thanks, queued to hsi-next.

-- Sebastian

>=20
>  drivers/hsi/controllers/omap_ssi_core.c | 4 +---
>  drivers/hsi/controllers/omap_ssi_port.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/contro=
llers/omap_ssi_core.c
> index 0cba567ee2d7..4bc4a201f0f6 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -370,10 +370,8 @@ static int ssi_add_controller(struct hsi_controller =
*ssi,
>  	if (err < 0)
>  		goto out_err;
>  	err =3D platform_get_irq_byname(pd, "gdd_mpu");
> -	if (err < 0) {
> -		dev_err(&pd->dev, "GDD IRQ resource missing\n");
> +	if (err < 0)
>  		goto out_err;
> -	}
>  	omap_ssi->gdd_irq =3D err;
>  	tasklet_init(&omap_ssi->gdd_tasklet, ssi_gdd_tasklet,
>  							(unsigned long)ssi);
> diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/contro=
llers/omap_ssi_port.c
> index 2cd93119515f..a0cb5be246e1 100644
> --- a/drivers/hsi/controllers/omap_ssi_port.c
> +++ b/drivers/hsi/controllers/omap_ssi_port.c
> @@ -1038,10 +1038,8 @@ static int ssi_port_irq(struct hsi_port *port, str=
uct platform_device *pd)
>  	int err;
> =20
>  	err =3D platform_get_irq(pd, 0);
> -	if (err < 0) {
> -		dev_err(&port->device, "Port IRQ resource missing\n");
> +	if (err < 0)
>  		return err;
> -	}
>  	omap_port->irq =3D err;
>  	err =3D devm_request_threaded_irq(&port->device, omap_port->irq, NULL,
>  				ssi_pio_thread, IRQF_ONESHOT, "SSI PORT", port);
> --=20
> Sent by a computer through tubes
>=20

--ugynw7smm36mkkr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1ArBoACgkQ2O7X88g7
+ppedw/+Jc8kGpySHPFQ4goKZ5kTA5ajxzpkcQEaKh38ZnwVpsOHZ4ktk+vpuKbo
dwaCaaQfx9I1oPt8hkIh8Xu3Ur+hnK/MTj/dlSgBy54EjTrFA71S6Q5o+RHEcqSb
Hj+MbUX/xP5PbUD73PAJ+EBphIDHoPOzEo9OOO8nWmDDg1F1C3cG+bv6bFgKVSxN
dG5zbX0wdmsb8JZpm4wMidBdNx+XhRAVWpJFlqYOloummZUniI+D1SaDctJT9ad8
KWNgZYwBU7MdG31OheLJX5mHngcje+/taccdDmKcZABIRNJSPRGWzyMHAZpgG7YY
X6zkj4CAbXr2QjCdCOAL4iiAQr0wsp9WoWIEPWVqrMh6F2myckadf6IzfxWzpJVo
eltgW33ZhzGttTI9GPm93BVNDVjHsAayPn6RnSLv+aF/Zgch5IU2PM+veUhFzuby
qH7d149BzFqSX+1g8IGRsftqHqHXt+SMnHdDOV3SF42ZAxhzKF4yftfIM7UZzZFK
760zoMR+0OVgpy4AaoaQRSMqFNCgY5194e+4pesBUlH1x58H+C8P4UpIUsSD8lgt
mb2uNofUdr4ic+fYrRHs2oLM0U1MYjhpgNJoJGP/5wQBakVcmBaJ1zWsrooNYKmy
+L2EQ1HGKgq52gS80/YcSDSdffG1Pwka7WYjvv+CL2PkqNmriEQ=
=akOq
-----END PGP SIGNATURE-----

--ugynw7smm36mkkr4--
