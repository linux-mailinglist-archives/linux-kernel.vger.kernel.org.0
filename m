Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7741D11E2D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 12:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLMLco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 06:32:44 -0500
Received: from foss.arm.com ([217.140.110.172]:55758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfLMLco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:32:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4EA11045;
        Fri, 13 Dec 2019 03:32:43 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30B113F718;
        Fri, 13 Dec 2019 03:32:43 -0800 (PST)
Date:   Fri, 13 Dec 2019 11:32:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?amVmZl9jaGFuZyjlvLXkuJbkvbMp?= <jeff_chang@richtek.com>
Cc:     Jeff Chang <richtek.jeff.chang@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Message-ID: <20191213113241.GA4644@sirena.org.uk>
References: <1576152740-11979-1-git-send-email-richtek.jeff.chang@gmail.com>
 <20191212145330.GC4310@sirena.org.uk>
 <b0f4c1afd1d341b49b87b7b5cda5ea4d@ex1.rt.l>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <b0f4c1afd1d341b49b87b7b5cda5ea4d@ex1.rt.l>
X-Cookie: Life exists for no known purpose.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 07:36:15AM +0000, jeff_chang(=E5=BC=B5=E4=B8=96=E4=
=BD=B3) wrote:
> Dear Mark:
>=20
>=20
>=20
>         Thanks for your replying. I consider that there was only one item=
 I should modify. So I kept resending.
>=20
>=20
>=20
>         Please refer my red comment after your comment.

I can't tell what's in red or not, kernel development gets done with
plain text e-mail.  Please fix your mail configuration, it is extremely
difficult to read your messages for this and other reasons.

> The writes to reserved registers should be fine but things like this whic=
h looks like it's configuring the input path should just be left at the chi=
p default, we don't want to be configuring for particular boards since the =
same driver will be used for every board with the chip.
>=20
>=20
>=20
>         The chip default cannot be modified anymore. How can I do if I re=
ally need write these setting in our drivers?

Settings should be done through some combination of userspace
configuration at runtime and device tree or ACPI properties.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3zdtYACgkQJNaLcl1U
h9B8kwf+IpjaEaGa2G/sBNA8Uba5iLxJH77tx+EkitOF1sumwNDj1XNcuYqb9lDl
ak4VjrPpISMuFyn2bA1jcGMDT9Kt7Iu9Ho2H/trihujQasAESaDskolv4ePg0XVV
azTK7X98WsarZRy6EpuWWSCmF1ePPpA60fHtM3rjQbKDhAb+6VVIl6kDEeWvhwtt
aPl5Twi1fjMqgPtqSdCe/aREpmiREG19zoTy/M/INreV7T5KY4ndfV/m6YNnBVss
T0ambE+xjV94LIULzEsa5fno9DKIgGOmrKxunAXswLk8B4Za0Auhv7E3XBvc/CpR
7kTt0mjLMsVXjv75mbnn2BKi7Zdovw==
=PyY0
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
