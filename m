Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6315831E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 19:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBJS7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 13:59:09 -0500
Received: from foss.arm.com ([217.140.110.172]:37732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgBJS7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:59:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E06941FB;
        Mon, 10 Feb 2020 10:59:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64BA93F68F;
        Mon, 10 Feb 2020 10:59:07 -0800 (PST)
Date:   Mon, 10 Feb 2020 18:59:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>
Cc:     alsa-devel@alsa-project.org,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        cychiang@google.com, mac.chiang@intel.com
Subject: Re: [PATCH] ASoC: da7219: check SRM lock in trigger callback
Message-ID: <20200210185905.GD14166@sirena.org.uk>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
X-Cookie: No lifeguard on duty.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 04:16:51PM +0800, Brent Lu wrote:

> Intel sst firmware turns on BCLK/WCLK in START Ioctl call which timing is
> later than the DAPM SUPPLY event handler da7219_dai_event is called (in
> PREPARED state). Therefore, the SRM lock check always fail.
>=20
> Moving the check to trigger callback could ensure the SRM is locked before
> DSP starts to process data and avoid possisble noise.

Independently of any other discussion trigger is expected to run very
fast so doesn't feel like a good place to do this - given that we're
talking about doing this to avoid noise the mute operation seems like a
more idiomatic place to do this, it exists to avoid playing back
glitches from the digitial interface during startup.

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Bp/kACgkQJNaLcl1U
h9AW9ggAhE+Uf05vhaF0QzQQUHbDzslATig+bVtp+hnoVHtcvBpIiJfssALCeBlO
9ax23eqKKLc71AGPWz+0Q/SFXNKtQks8EcCVb3E7DtHCPuME2XweuKpUP3cChyIR
PGC0auE4jAhRQYfUCHr/0h1mllN5eVB+CPIkvdlomAXdKVIIHh+RDfcWNzchlBqu
iv7Z6JB30FDe21lVXVuVUsDCvRL/bGpq7Puo2gMlxbj/q0ZjHuUzzNxbbAb8qPQu
Ck4FI/mgE+qoxGr1LvEmRU8/X9Z0FGRoA8j99UeYftSt338wTsYrMw9Q3vrrAwOJ
vbWjkVfV4UqRZbk8c5Bm8D1weiYu/A==
=kh32
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
