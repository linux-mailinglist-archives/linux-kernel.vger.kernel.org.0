Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D93408E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfFDHnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:43:05 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51141 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFDHnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:43:05 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5D1EF20007;
        Tue,  4 Jun 2019 07:43:02 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:43:01 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v4 3/9] ASoC: sun4i-i2s: Add regmap field to sign extend
 sample
Message-ID: <20190604074301.p27e5towgehmraoy@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <20190603174735.21002-4-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4iu232naw3x4dexg"
Content-Disposition: inline
In-Reply-To: <20190603174735.21002-4-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4iu232naw3x4dexg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 07:47:29PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs this is set by default to transfer a 0 after

Which SoCs?

> each sample in each slot. However the platform that this driver

Which platform?

> was developed on had the default setting where it padded the audio
> gain with zeros. This isn't a problem whilst we have only support
> for 16bit audio but with larger sample resolution rates in the
> pipeline then it should be fixed to also pad. Without this the audio
> gets distorted.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Once the commit log fixed,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4iu232naw3x4dexg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPYhBQAKCRDj7w1vZxhR
xcVmAQDSGaycvO/U1wpX1Ai6mvSxxamMb37KG7EScFKOC3oa5gEAzJ68Gg6XPP/O
EBu14S2afGHTqLHHKTGeLzVHp5ZKHwU=
=1Yj6
-----END PGP SIGNATURE-----

--4iu232naw3x4dexg--
