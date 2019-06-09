Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFEEC3ABB1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 21:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfFITve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 15:51:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38908 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfFITve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 15:51:34 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9BD2A802A4; Sun,  9 Jun 2019 21:51:22 +0200 (CEST)
Date:   Sun, 9 Jun 2019 21:51:32 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir D . Seleznev" <vseleznv@altlinux.org>
Subject: Re: [PATCH 0/7] TTY Keyboard Status Request
Message-ID: <20190609195132.GA1430@amd>
References: <20190605081906.28938-1-ar@cs.msu.ru>
 <20190609174139.GA11944@xo-6d-61-c0.localdomain>
 <20190609194013.GA3736@cello>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20190609194013.GA3736@cello>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series introduces TTY keyboard status request, a feature of
> > > the n_tty line discipline that reserves a character in struct termios
> > > (^T by default) and reacts to it by printing a short informational li=
ne
> > > to the terminal and sending a Unix signal to the tty's foreground
> > > process group. The processes may, in response to the signal, output a
> > > textual description of what they're doing.
> > >=20
> > > The feature has been present in a similar form at least in
> > > Free/Open/NetBSD; it would be nice to have something like this in Lin=
ux
> > > as well. There is an LKML thread[1] where users have previously
> > > expressed the rationale for this.
> > >=20
> > > The current implementation does not break existing kernel API in any
> > > way, since, fortunately, all the architectures supported by the kernel
> > > happen to have at least 1 free byte in the termios control character
> > > array.
> >=20
> > I like the idea... I was often wondering "how long will this dd take". =
(And in
> > case of dd, SIGUSR1 does the job).
> >=20
> > I assume this will off by default, so that applications using ^T today =
will not
> > get surprise signals?
>=20
> If any of isig, icanon and iexten is disabled on the tty, the signal is
> not sent.

As expected.

> Any application that wants to handle raw terminal input events itself,
> e.g. vim, mutt, libreadline, anything ncurses-based, etc., has to turn
> off the tty's cooked mode, i.e. at least icanon. This means those
> applications are unaffected.

Agreed, those are unaffected.

But if I have an application doing read() from console (without
manipulating tty), am I going to get surprise signal when user types
^T?

	     	      	      	     	      	     	       	     Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz9Y0QACgkQMOfwapXb+vIU7ACfRSaiBYXbA7R8lFC9dxbQPTtK
ZogAoIVPIcphBVNpKz5QKwmuob12pU1i
=/RPY
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
