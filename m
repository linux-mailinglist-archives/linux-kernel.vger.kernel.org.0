Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3DC16EBAB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbgBYQpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 11:45:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:39358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbgBYQpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:45:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9897AAAC2;
        Tue, 25 Feb 2020 16:45:28 +0000 (UTC)
Message-ID: <47f6f9f63a25820b9c9fb10d281f4824862a234b.camel@suse.de>
Subject: Re: [PATCH 18/89] clk: bcm: rpi: Rename is_prepared function
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>, Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Date:   Tue, 25 Feb 2020 17:45:26 +0100
In-Reply-To: <cdeaa4152ac84aecc362e09153d1427777e3d933.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <cdeaa4152ac84aecc362e09153d1427777e3d933.1582533919.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RIXUZuAJcUivUhgI0C4B"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RIXUZuAJcUivUhgI0C4B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-24 at 10:06 +0100, Maxime Ripard wrote:
> The raspberrypi_fw_pll_is_on function doesn't only apply to PLL
> registered in the driver, but any clock exposed by the firmware.
>=20
> Since we also implement the is_prepared hook, make the function
> consistent with the other function names, and drop the fw from the
> function name.

It seems you didn't :)

As it does use the fw interface I'd say keep it in the name, with that:

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!
Nicolas

>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---


--=-RIXUZuAJcUivUhgI0C4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5VTyYACgkQlfZmHno8
x/5rAgf7BxTTPBRye7XRqwBPhoICcffv/Ii4T91MNAtumCd4F0s+hsYk44Ttsbrb
tr9ZiFNFnOkV/rVNLG3cg/QhMaKotcAg59qVcw/g/ZDPc6xodEilj19jaf2WDIi1
echfeq0yvG8cPb8ljFCPiKisneTp/ascqFR//M9Ap8zpfpQUCswisjsqzhSY1Y1k
f5Dtc3fY+2szMYu08XhKojT0UUBt4gtxh5pAXk7RSG1moPrP/NGJpS/8XQ0w5EyT
fs8hWtU4De7Ja4NH8Xb2haFk0kZgoJyqxGjhMOyeYtBUS8mpKbE0iWMg0fx2vW+/
KtTtxwpzcWfrZ+Ox/njAdAXkd+CUOA==
=pqBd
-----END PGP SIGNATURE-----

--=-RIXUZuAJcUivUhgI0C4B--

