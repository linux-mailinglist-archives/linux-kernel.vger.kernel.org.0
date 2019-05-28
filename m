Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2602C2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 11:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfE1JNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 05:13:23 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54957 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1JNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:13:23 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 80A60C0034;
        Tue, 28 May 2019 09:13:16 +0000 (UTC)
Date:   Tue, 28 May 2019 11:13:15 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 4/7] ASoC: sun4i-spdif: Add support for H6 SoC
Message-ID: <20190528091315.ysfieiebn5gk53f5@flea>
References: <20190527200627.8635-1-peron.clem@gmail.com>
 <20190527200627.8635-5-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="chyxdzlab5sysxo6"
Content-Disposition: inline
In-Reply-To: <20190527200627.8635-5-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--chyxdzlab5sysxo6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2019 at 10:06:24PM +0200, Cl=E9ment P=E9ron wrote:
> Allwinner H6 has a different mapping for the fifo register controller.
>
> Actually only the fifo TX bit is used in the drivers.
>
> Use the freshly introduced quirks to make this drivers compatible with
> the Allwinner H6.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--chyxdzlab5sysxo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOz7qwAKCRDj7w1vZxhR
xSIiAP9nmxuaqkOOSRfudhUw4zPITHUHtndI2JThUfrXTighbwEAyJjIFkev8yqr
i6HikA6T6bWimgGAMVM9UxUwiD1Rdgc=
=iAGv
-----END PGP SIGNATURE-----

--chyxdzlab5sysxo6--
