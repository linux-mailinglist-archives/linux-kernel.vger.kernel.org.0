Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66FBE320C7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 23:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfFAVaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 17:30:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41701 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFAVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 17:30:11 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D8B5D803AC; Sat,  1 Jun 2019 23:29:59 +0200 (CEST)
Date:   Sat, 1 Jun 2019 23:30:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.1.0-next-20190520 -- emacs segfaults on 32-bit machine Re:
 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190601213009.GC13060@amd>
References: <20190519221700.GA7154@amd>
 <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
 <20190520231342.GA20835@amd>
 <20190521073240.mikv2ufwyriy4q7r@linutronix.de>
 <20190522183329.GB10003@amd>
 <20190523083724.GA21185@amd>
 <20190523145035.wncfmwem57z2oxb7@linutronix.de>
 <20190527130317.GB19795@amd>
 <20190527130848.lec6zp3ntyhemsbj@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20190527130848.lec6zp3ntyhemsbj@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-05-27 15:08:48, Sebastian Andrzej Siewior wrote:
> On 2019-05-27 15:03:17 [+0200], Pavel Machek wrote:
> > > could you please send me (offlist) your .config? Also, what kind of
> > > userland do you run? Something like Debian stable?
> >=20
> > Yep, debian stable.
>=20
> Since we had a little bit of development recently, could you please
> check if
> 	http://lkml.kernel.org/r/20190526173325.lpt5qtg7c6rnbql5@linutronix.de
>=20
> makes any difference?

X version of emacs keeps crashing, but I guess that's something
unrelated. Looks like this one is solved.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzy7mEACgkQMOfwapXb+vLfsACdHvEPAgNcEoPeM8ezplpRKItk
iQsAnihbNYHGpqsP8UkuSqtqDBYANZ5/
=ZWnl
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
