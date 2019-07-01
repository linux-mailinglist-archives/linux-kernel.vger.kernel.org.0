Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADAB4F786
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 19:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFVRtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 13:49:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55190 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:49:53 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 16F10805FB; Sat, 22 Jun 2019 19:49:39 +0200 (CEST)
Date:   Sat, 22 Jun 2019 19:49:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jaegeuk@kernel.org,
        yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: Next 20190621: fails to link f2fs in x86-32
Message-ID: <20190622174945.GA30317@amd>
References: <20190621110311.GF24145@amd>
 <20190621214657.1624e5a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20190621214657.1624e5a4@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

> On Fri, 21 Jun 2019 13:03:11 +0200 Pavel Machek <pavel@ucw.cz> wrote:
> >
> > I get this during compilation:
> >=20
> >   CC      net/netfilter/core.o
> >   In file included from net/netfilter/core.c:19:0:
> >   ./include/linux/netfilter_ipv6.h: In function
> >   =E2=80=98nf_ipv6_cookie_init_sequence=E2=80=99:
> >   ./include/linux/netfilter_ipv6.h:174:2: error: implicit declaration
> >   of function =E2=80=98__cookie_v6_init_sequence=E2=80=99
> >   [-Werror=3Dimplicit-function-declaration]
> >     return __cookie_v6_init_sequence(iph, th, mssp);
> >       ^
> >       ./include/linux/netfilter_ipv6.h: In function
> >   =E2=80=98nf_cookie_v6_check=E2=80=99:
> >   ./include/linux/netfilter_ipv6.h:189:2: error: implicit declaration
> >   of function =E2=80=98__cookie_v6_check=E2=80=99
> >   [-Werror=3Dimplicit-function-declaration]
> >     return __cookie_v6_check(iph, th, cookie);
> >       ^
> >       cc1: some warnings being treated as errors
> >       scripts/Makefile.build:278: recipe for target
> >   'net/netfilter/core.o' failed
> >   make[2]: *** [net/netfilter/core.o] Error 1
> >   scripts/Makefile.build:498: recipe for target 'net/netfilter' failed
> >   make[1]: *** [net/netfilter] Error 2
> >=20
> > Is it known?
>=20
> Yes, and should be fixed in next-20190621.

Ok, that one is indeed gone. Now I'm getting failure in f2fs:

ld: fs/f2fs/gc.o: in function `f2fs_resize_fs':
gc.c:(.text+0x3a91): undefined reference to `__umoddi3'
ld: gc.c:(.text+0x3b70): undefined reference to `__udivdi3'
make: *** [Makefile:1052: vmlinux] Error 1

I'll try compiling on on older gcc.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0OajgACgkQMOfwapXb+vLbtwCcDGYXh5MYvY2toY7j7D23RLBx
aBsAoMKz0fwdn/ss8jNnIQl93ShJosm5
=3Kbp
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
