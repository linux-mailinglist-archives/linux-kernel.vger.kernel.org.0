Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F327811896B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 14:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLJNVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 08:21:39 -0500
Received: from foss.arm.com ([217.140.110.172]:43912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfLJNVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:21:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 378ED328;
        Tue, 10 Dec 2019 05:21:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB59F3F52E;
        Tue, 10 Dec 2019 05:21:37 -0800 (PST)
Date:   Tue, 10 Dec 2019 13:21:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] regulator: max77650: add of_match table
Message-ID: <20191210132136.GG6110@sirena.org.uk>
References: <20191210100725.11005-1-brgl@bgdev.pl>
 <20191210121227.GB6110@sirena.org.uk>
 <CAMRc=MftOnQVAUjOz=UGV-S2HKPpiucQp98xYTdxgt7d8obCMg@mail.gmail.com>
 <20191210130244.GE6110@sirena.org.uk>
 <CAMRc=MenTgffszv4NsbCKRhH0TcRPSTLbeP3BttW9fmFBjLdCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Content-Disposition: inline
In-Reply-To: <CAMRc=MenTgffszv4NsbCKRhH0TcRPSTLbeP3BttW9fmFBjLdCA@mail.gmail.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 02:10:15PM +0100, Bartosz Golaszewski wrote:
> wt., 10 gru 2019 o 14:02 Mark Brown <broonie@kernel.org> napisa=C5=82(a):

> > This seems to work fine for other drivers and the platform bus has to be
> > usable on systems that don't use DT so that doesn't sound right.  Which
> > MODULE_ALIAS() are you using exactly?

> MODULE_ALIAS("platform:max77650-regulator");

Huh, that should work...  I wonder if adding a compatible to the DT has
messed it up, does it work without the compatible in the .dts (and with
the of_compatible removed from the MFD driver I guess)?

> > > Besides: the DT bindings define the compatible for sub-nodes already.
> > > We should probably conform to that.

> > I would say that's a mistake and should be fixed, this particular way of
> > loading the regulators is a Linux implementation detail.

> Fixed by removing this from the bindings?

Yeah.  Though it may be too late, shame I didn't catch this when it was
merged :(

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3vm98ACgkQJNaLcl1U
h9Cafwf/a3oxPbhu5Pta4vakVb1PxMAJdTKejo/JdqsYMWi/ZQTBNNH/FfInbp7T
D2zcDVZP/TNsmiEfpU2jPdKWjViPodD7lMFRqt+poeHmGDIqKBfO+MfQY8nZI5MH
N5WA+PCYhePQeF0imK/9MnPfFigZwIPNWmyrY+S4hzqdmO4sMl0aSJ2YrR/o64sa
Nu1qE8ALJ6S8anzLHm4X1iO3HGbpNHfEceZ4Ddr3UwWra4YpLNWLwoPGKX8XwN+V
QqU6wPmbBsXhtlVSWBzoNhy0m6/1ZXswhnTE36MGLER5OtZg4/XTngVn3CrAZyDi
MLjacZOLe5NREbuFhWuB0cgRlbFI+g==
=nIJk
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--
