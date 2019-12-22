Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C40128EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Dec 2019 16:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLVPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 10:49:19 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:42566 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfLVPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 10:49:19 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E1C4E1C2461; Sun, 22 Dec 2019 16:49:17 +0100 (CET)
Date:   Sun, 22 Dec 2019 16:49:17 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        kernel list <linux-kernel@vger.kernel.org>,
        sfr@canb.auug.org.au
Subject: f2fs compile problem in next-20191220 on x86-32
Message-ID: <20191222154917.GA22964@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm getting this:

  LD      .tmp_vmlinux1
  ld: fs/f2fs/file.o: in function `f2fs_truncate_blocks':
  file.c:(.text+0x2968): undefined reference to `__udivdi3'
  make: *** [Makefile:1079: vmlinux] Error 1

when attempting to compile kernel for x86-32.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3/kHwACgkQMOfwapXb+vLa4wCgimod+RHLfKgfWf5luFTBhNad
yhsAnjHq4RGS/OfqHn75OENnR9nXvmiY
=p0yC
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
