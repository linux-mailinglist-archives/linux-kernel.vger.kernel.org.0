Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98174CD1D1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 14:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfJFMHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 08:07:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45490 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfJFMHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 08:07:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E7B8980486; Sun,  6 Oct 2019 14:07:27 +0200 (CEST)
Date:   Sun, 6 Oct 2019 14:07:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, a.darwish@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20191006120742.GE24605@amd>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191001161448.GA1918@darwi-home-pc>
 <CAHk-=wjPTVJNtynBMUbcnChUu=11f=VK=ASkw+4TUU7MEpiugA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjPTVJNtynBMUbcnChUu=11f=VK=ASkw+4TUU7MEpiugA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Entropy really is hard. It's hard to generate, and it's hard to measure.

It is not hard to generate... not on PC, not on most machines. "find
/" can generate plenty of entropy... certainly on any PC.

But it does not work everywhere, and we may need other methods of
generating entropy on some very embedded systems... So IMO we shold
have generic driver for PC-like machines and specific drivers for the
embedded stuff that needs it.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2Z2Q4ACgkQMOfwapXb+vLJmwCgsFCfHfVV/UV8/H1RKW3Bb2qW
tgcAoIHZHNpLto8l4KAkxCjjogABil9Q
=6JAW
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
