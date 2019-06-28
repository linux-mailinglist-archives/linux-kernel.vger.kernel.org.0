Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D52E59835
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 12:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfF1KKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 06:10:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52176 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfF1KKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:10:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B325380683; Fri, 28 Jun 2019 12:10:38 +0200 (CEST)
Date:   Fri, 28 Jun 2019 12:10:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jaegeuk@kernel.org,
        yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        Qiuyang Sun <sunqiuyang@huawei.com>
Subject: Re: Next 20190621: fails to link f2fs in x86-32
Message-ID: <20190628101050.GA7745@amd>
References: <20190621110311.GF24145@amd>
 <20190621214657.1624e5a4@canb.auug.org.au>
 <20190622174945.GA30317@amd>
 <20190624101844.50e4c4ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20190624101844.50e4c4ff@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-06-24 10:20:52, Stephen Rothwell wrote:
> Hi all,
>=20
> On Sat, 22 Jun 2019 19:49:45 +0200 Pavel Machek <pavel@ucw.cz> wrote:
> >
> > ld: fs/f2fs/gc.o: in function `f2fs_resize_fs':
> > gc.c:(.text+0x3a91): undefined reference to `__umoddi3'
> > ld: gc.c:(.text+0x3b70): undefined reference to `__udivdi3'
> > make: *** [Makefile:1052: vmlinux] Error 1
>=20
> This should be fixed in today's linux-next.

Thanks, I tested 5.2.0-rc6-next-20190627+ and that seems to work here.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0V56kACgkQMOfwapXb+vJ32ACcCv+1kImpwXc0zptPPZyuFcmp
4pYAoLpPKrNoRcAK1WsX9uQ+gudk09zk
=MTJn
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
