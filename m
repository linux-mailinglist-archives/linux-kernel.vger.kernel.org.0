Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1006416162C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 16:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgBQPa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 10:30:26 -0500
Received: from foss.arm.com ([217.140.110.172]:37370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgBQPa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:30:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCCDE30E;
        Mon, 17 Feb 2020 07:30:25 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E50E3F703;
        Mon, 17 Feb 2020 07:30:25 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:30:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [RFC PATCH 10/34] ASoC: sun8i-codec: Advertise only
 hardware-supported rates
Message-ID: <20200217153023.GL9304@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-11-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-11-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2020 at 12:42:26AM -0600, Samuel Holland wrote:
> The hardware does not support 64kHz, 88.2kHz, or 176.4kHz sample rates,
> so the driver should not advertise them. The hardware can handle two
> additional non-standard sample rates: 12kHz and 24kHz, so declare
> support for them via SNDRV_PCM_RATE_KNOT.
>=20
> Cc: stable@kernel.org
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

The new sample rates are new functionality, they are definitely not
stable material.   For the sample rates you are removing do we
understand why they were added - do they work for people, are they
perhaps supported for some users and not others for example?

--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KsY8ACgkQJNaLcl1U
h9DgKwf/RkeIHeM2sJ2RgbLTXWX8YZmWkvlMjMbuWBeFxHTz/Hdo+gM34z7glK5D
vTsYnMg6wYSVtkRJzw6JOjJE/YqT+KFTmpqMHlhJkHhh+0Ce33hnN5vhPWAOyDLX
ajN4NNYMR/RvlHVhAD8YVCjWKy65hpslCTajh+74Pn5GNtXao1z2mH6vDaVOntZj
KsuP3g6wxqKicdi4lrAYDS80cpUVlOD4OkMk49MT5h1U78w3hblZkKULqFjOt3BL
jgdv2os2/zg+/7OxQCcAlJfrfd4m4kBHbI9HF+0IMV9CIt+pR7Kmy7H+zcliwi9L
1zUYINK1EWJvcb+4lIeZcMRp0sH7aQ==
=ZBtq
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--
