Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E822952
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 00:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfESWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 18:17:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60858 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfESWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 18:17:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9C5A4802EE; Mon, 20 May 2019 00:16:51 +0200 (CEST)
Date:   Mon, 20 May 2019 00:17:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190519221700.GA7154@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

emacs segfaults... when I attempt to exit it. And that did not use to
be the case. Nothing suspect in the dmesg. Rest of the machine seems
to work ok.

I'm using "l1tf=3Dfull" on kernel command line.

During one crash, I got some kind of debug output (from glibc?), but
it scrolled away when I asked for dmesg :-(.

Ideas welcome...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzh1dwACgkQMOfwapXb+vLx8wCfR8A7RIJwo6KDHY/dAKuFerdQ
IEgAnRtr988aB8dQbyKs57xaKsnV0097
=rlYq
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
