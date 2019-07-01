Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA41C59BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfF1MvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:51:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58069 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfF1MvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:51:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B13E38067C; Fri, 28 Jun 2019 14:51:09 +0200 (CEST)
Date:   Fri, 28 Jun 2019 14:51:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        linux-rt-users@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, mwhitehe@redhat.com
Subject: Re: PREEMPT_RT_FULL on x86-32 machine
Message-ID: <20190628125120.GB21311@amd>
References: <20190622081954.GA10751@amd>
 <2804bc5b-18c1-2793-171c-045c0725a6a7@siemens.com>
 <20190624105340.GA21414@amd>
 <20190624132748.n4lgg4swj4nzirdb@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <20190624132748.n4lgg4swj4nzirdb@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > >Is full preemption supposed to work on x86-32 machines?
> > > >
> > > >Because it does not work for me. It crashes early in boot, no messag=
es
> > > >make it to console. Similar configuration for x86-64 boots ok.
> > > >
> > >=20
> > > Maybe you can also tell which version(s) you tried, and in which
> > > configuration(s), and how the crash looked like.
> >=20
> > I wanted to know if the configuration is supposed to work at all
> > before starting heavy debugging. From your reply I assume that it
> > should work.
> >=20
> > I tried 4.19.13-rt1-cip1 among others. Crash is early in boot, I can
> > try some early printing...
>=20
> The latest is v4.19.50-rt22 I would suggest that one. There was a bug
> which was fixed either in 4.19.23-rt14 or in the following version.
>=20
> If the latest one does not work please let me know and I will have a
> look.

Ok, let me try again. It seems the kernel based on the latest one
works ok. Even suspend/resume works.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0WDUcACgkQMOfwapXb+vK5yQCeNKjG3rGjgsx9KqLkf32RYiJ9
6QMAnjOqSXA6Nqzzcac6pveqLSi0VimQ
=luiT
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
