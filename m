Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E10A47D910
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 12:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfHAKKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 06:10:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38401 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfHAKKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:10:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F157E802DA; Thu,  1 Aug 2019 12:10:00 +0200 (CEST)
Date:   Thu, 1 Aug 2019 12:10:12 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, Jiri Slaby <jslaby@suse.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 7/7] n_tty: Provide an informational line on VSTATUS
 receipt
Message-ID: <20190801101012.GA4816@amd>
References: <20190625161153.29811-1-ar@cs.msu.ru>
 <20190625161153.29811-8-ar@cs.msu.ru>
 <20190730161940.GA15798@kroah.com>
 <20190731222359.GA20574@cello>
 <20190801092020.GB19329@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20190801092020.GB19329@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > The use-case for this is different: the ^T-line as proposed by this
> > patch is for the user that interacts with a system through a terminal, =
who
> > wants to be informed not about the whole system (sort of what SysRq-t
> > tells you), but about what they run on that particular tty.
>=20
> Ok, fair enough, although if you just add a new sysrq option for "what
> is running on this tty", would that help resolve this?

This is meant for unpriviledged users, unlike sysrq.

> > This is much less about "why does my system/kernel seem to hang?" or
> > exposing low-level internals (registers, hrtimers, locks, ...), and more
> > about "is my SSH terminal session unresponsive?" and "I ran a command,
> > it doesn't finish, how's it doing?".
> > e.g. A user might want to know if their SSH connection is alive without
> > interrupting anything, while having no access both to SysRq and console,
> > and no one in fg pgrp actually handles SIGINFO.
>=20
> If you have access to a tty, you should have access to sysrq, right?

No. This is supposed to work over ssh. SysRq is not supposed to work
over ssh; that would be a security hole.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1CuoQACgkQMOfwapXb+vK3gQCfcVYhklm354XQ/g8no7Y8CTU6
zdsAn0kzH5QdUuT6Ax/Vz6mumSrD+H+n
=xg6J
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
