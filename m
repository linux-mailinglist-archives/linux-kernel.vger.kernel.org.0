Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396AF2D73E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 10:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfE2IFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 04:05:16 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50867 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfE2IFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:05:15 -0400
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1F3AA240018;
        Wed, 29 May 2019 08:05:05 +0000 (UTC)
Date:   Wed, 29 May 2019 10:05:05 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     emilio@elopez.com.ar, mturquette@baylibre.com, sboyd@kernel.org,
        wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk-sunxi: fix a missing-check bug in
 sunxi_divs_clk_setup()
Message-ID: <20190529080505.acyiha3uebg6wski@flea>
References: <20190528021851.GA14526@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o35lrbyzjlkcjtqy"
Content-Disposition: inline
In-Reply-To: <20190528021851.GA14526@zhanggen-UX430UQ>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o35lrbyzjlkcjtqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2019 at 10:18:51AM +0800, Gen Zhang wrote:
> In sunxi_divs_clk_setup(), 'derived_name' is allocated by kstrndup().
> It returns NULL when fails. 'derived_name' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

Applied, thanks
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--o35lrbyzjlkcjtqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXO49MQAKCRDj7w1vZxhR
xWfrAP46HVqEHdmnfc8KYLclIPZP/0pUCzi5RAIq6DVjbMwmUgD9GOGKEB363FSF
iYDV78aJJGnCdjGQ7JRUoIR+3s7Q3wA=
=m78v
-----END PGP SIGNATURE-----

--o35lrbyzjlkcjtqy--
