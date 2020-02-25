Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3C16EB24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 17:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgBYQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 11:17:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:49060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbgBYQRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:17:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 290E6B1AE;
        Tue, 25 Feb 2020 16:17:51 +0000 (UTC)
Message-ID: <343bf33c29e640241d1ca64f67b05af6d0a0bb43.camel@suse.de>
Subject: Re: [PATCH 13/89] clk: bcm: rpi: Switch to clk_hw_register_clkdev
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
Date:   Tue, 25 Feb 2020 17:17:48 +0100
In-Reply-To: <75dd8f658a253649c176509f0d8d3dd10354ce51.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <75dd8f658a253649c176509f0d8d3dd10354ce51.1582533919.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-AEsyYIEmDz/ZPvq2SNJG"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AEsyYIEmDz/ZPvq2SNJG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-24 at 10:06 +0100, Maxime Ripard wrote:
> Since we don't care about retrieving the clk_lookup structure pointer
> returned by clkdev_hw_create, we can just use the clk_hw_register_clkdev
> function.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!
Nicolas


--=-AEsyYIEmDz/ZPvq2SNJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5VSKwACgkQlfZmHno8
x/6pGAf/RhH46fsKWEbXOnAY4VW48kY55Oo5HIdgFz30Cf1FEHGSIbvJ5ybQk47Y
T2YNRaoxvcqqYAmOT6nB4LVHUE3HDBt4qWC/yNF7R0vfpVMCCAymZ63hDODXmn7R
kdfhBPmuUsEkJr6hxW3KzqjRjBoEt1KwRdj+Y7UMF/ufb6nt8rSiRtwX6oa7yomn
L+gIpiZY/Cz6Z3ALHkbyfIwrAeXNsoXCle8bFAVa5MENX0hlUc+NdbfYOn40Zm5f
SVl46yPakAdj0LUVEyUDzsaWESwRJfT8NHgz/4OWSnzqsrJ9zsfWvjyfqgJn1LrD
vtIuk4MlrJ50e8tCyoFLOTrEqWUgEA==
=uZJp
-----END PGP SIGNATURE-----

--=-AEsyYIEmDz/ZPvq2SNJG--

