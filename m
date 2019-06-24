Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD99350944
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfFXKxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 06:53:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45954 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfFXKxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:53:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 84BD580583; Mon, 24 Jun 2019 12:53:30 +0200 (CEST)
Date:   Mon, 24 Jun 2019 12:53:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     linux-rt-users@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, mwhitehe@redhat.com
Subject: Re: PREEMPT_RT_FULL on x86-32 machine
Message-ID: <20190624105340.GA21414@amd>
References: <20190622081954.GA10751@amd>
 <2804bc5b-18c1-2793-171c-045c0725a6a7@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <2804bc5b-18c1-2793-171c-045c0725a6a7@siemens.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Is full preemption supposed to work on x86-32 machines?
> >
> >Because it does not work for me. It crashes early in boot, no messages
> >make it to console. Similar configuration for x86-64 boots ok.
> >
>=20
> Maybe you can also tell which version(s) you tried, and in which
> configuration(s), and how the crash looked like.

I wanted to know if the configuration is supposed to work at all
before starting heavy debugging. From your reply I assume that it
should work.

I tried 4.19.13-rt1-cip1 among others. Crash is early in boot, I can
try some early printing...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0Qq7QACgkQMOfwapXb+vJyDACeP59RoR7aVylUsn23lBsPwPI+
qlcAoJKBq4fQiNWjs1QKL6ElJCSlVJGi
=oK2q
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
