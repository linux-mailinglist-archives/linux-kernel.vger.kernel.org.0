Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7E3484C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfFQOBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:01:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47396 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQOBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:01:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A54F580265; Mon, 17 Jun 2019 16:01:04 +0200 (CEST)
Date:   Mon, 17 Jun 2019 16:01:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 1/3] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
Message-ID: <20190617140114.GA26140@amd>
References: <20190617135215.550-1-angus@akkea.ca>
 <20190617135215.550-2-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20190617135215.550-2-angus@akkea.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-06-17 07:52:13, Angus Ainslie (Purism) wrote:
> This is for the development kit board for the Librem 5. The current level
> of support yields a working console and is able to boot userspace from
> the network or eMMC.
>=20
> Additional subsystems that are active :
>=20
> - Both USB ports
> - SD card socket
> - WiFi usdhc
> - WWAN modem
> - GNSS
> - GPIO keys
> - LEDs
> - gyro
> - magnetometer
> - touchscreen
> - pwm
> - backlight
> - haptic motor
>=20
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0HnSoACgkQMOfwapXb+vJOGgCgi4UVHEckeZdZZeAkOxWfWI5z
EcgAn2c/wl0vMJH3MIZWhH8So2axxskQ
=DbDK
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
