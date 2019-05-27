Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3218F2BBCC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfE0Vq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 17:46:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41885 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfE0Vq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 17:46:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2352F8053C; Mon, 27 May 2019 23:46:45 +0200 (CEST)
Date:   Mon, 27 May 2019 23:46:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.1.0-next-20190520 -- emacs segfaults on 32-bit machine Re:
 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190527214655.GA15713@amd>
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
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20190527130848.lec6zp3ntyhemsbj@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
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

Ok, I updated to -rc2 and applied that patch. I'll let you know if I
see another emacs crash.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzsWs4ACgkQMOfwapXb+vLkQACgtosw4uNzk0GV0b9Vw4Vn3N4w
Uy0AmwSLYTxppV9dS3TiqSYiK9VF6mTi
=2Rmy
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
