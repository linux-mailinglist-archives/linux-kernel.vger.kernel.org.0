Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93042136
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437567AbfFLJlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 05:41:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37762 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFLJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:41:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 09883802E0; Wed, 12 Jun 2019 11:40:58 +0200 (CEST)
Date:   Wed, 12 Jun 2019 11:41:08 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir D . Seleznev" <vseleznv@altlinux.org>
Subject: Re: [PATCH 0/7] TTY Keyboard Status Request
Message-ID: <20190612094108.GA11439@amd>
References: <20190605081906.28938-1-ar@cs.msu.ru>
 <20190609174139.GA11944@xo-6d-61-c0.localdomain>
 <20190609194013.GA3736@cello>
 <20190609195132.GA1430@amd>
 <20190609205610.GB3736@cello>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20190609205610.GB3736@cello>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > If any of isig, icanon and iexten is disabled on the tty, the signal =
is
> > > not sent.
> >=20
> > As expected.
> >=20
> > > Any application that wants to handle raw terminal input events itself,
> > > e.g. vim, mutt, libreadline, anything ncurses-based, etc., has to turn
> > > off the tty's cooked mode, i.e. at least icanon. This means those
> > > applications are unaffected.
> >=20
> > Agreed, those are unaffected.
> >=20
> > But if I have an application doing read() from console (without
> > manipulating tty), am I going to get surprise signal when user types
> > ^T?
> >=20
> > 	     	      	      	     	      	     	       	     Pavel
>=20
> As of now, that application will indeed receive a signal that is
> guaranteed to be ignored by default.
>=20
> This is similar to SIGWINCH, which is default-ignored as well: if the
> terminal width/height changes (like when a terminal emulator window is
> resized), its foreground pgrp gets a surprise signal as well, and the
> processes that don't care about WINCH (and thus have default
> disposition) do not get confused.
> E.g. 'strace cat' demonstrates this quite clearly.

Ok, so this should be safe as long as noone listens for SIGPWR. So
=2E.. I guess we are ok :-).
								Pavel


--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0AyLQACgkQMOfwapXb+vJFlQCguETfJ+hTMGE/wltRVEKeEcrm
q1YAmwfrv5HKtICh2anxucyqQHW3eFNN
=TVS/
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
