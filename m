Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E948EAC949
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 22:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406333AbfIGUsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Sep 2019 16:48:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58511 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfIGUsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:48:00 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5D3F9802B9; Sat,  7 Sep 2019 22:47:39 +0200 (CEST)
Date:   Sat, 7 Sep 2019 22:47:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] ARM: dts: mmp2: devicetree updates
Message-ID: <20190907204752.GA7919@amd>
References: <20190828072629.285760-1-lkundrak@v3.sk>
 <20190907194040.GB25459@amd>
 <CAK8P3a0nNEoy31oxFL11Y2VHw-O=m8e8JuuQk+FjiPh94GikoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0nNEoy31oxFL11Y2VHw-O=m8e8JuuQk+FjiPh94GikoA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2019-09-07 21:57:42, Arnd Bergmann wrote:
> On Sat, Sep 7, 2019 at 9:40 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> >
> > > Here's a couple of updates for the MMP2 SoC devicetree files.
> > > I'm wondering if they could be applied to the armsoc tree?
> > >
> > > Compared to previous submission, the only change is the addition of
> > > Acks from Pavel.
> >
> > Any news here? Having up-to-date dts is kind-of useful....
>=20
> Thanks for adding me to Cc on your reply. I'm doing the merged for 5.4
> and had not noticed this series earlier (I found the mmp3 series by
> accident, but that one looked like it was not meant as a submission
> for inclusion yet).
>=20
> I've added the six patches to the arm/late branch in the soc tree
> now, they will be in 5.4.

That was quick, thank you!
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl10F3gACgkQMOfwapXb+vL0iwCeKnLVYDl45xCxTQmr6GfIec3S
/nMAoLneu6hLNmE6/QadQfhQkaNlwULX
=8gHX
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
