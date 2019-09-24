Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6DDBC423
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 10:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395067AbfIXIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 04:32:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37269 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390364AbfIXIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:32:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ACC5580BB1; Tue, 24 Sep 2019 10:32:30 +0200 (CEST)
Date:   Tue, 24 Sep 2019 10:32:44 +0200
From:   Pavel Machek <pavel@denx.de>
To:     kernel list <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH] tty_ldisc: simplify tty_ldisc_autoload initialization
Message-ID: <20190924083244.GA4344@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have got existing macro to check for CONFIG option, use it.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 4c49f53..ec1f6a4 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -156,12 +156,7 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
  *		takes tty_ldiscs_lock to guard against ldisc races
  */
=20
-#if defined(CONFIG_LDISC_AUTOLOAD)
-	#define INITIAL_AUTOLOAD_STATE	1
-#else
-	#define INITIAL_AUTOLOAD_STATE	0
-#endif
-static int tty_ldisc_autoload =3D INITIAL_AUTOLOAD_STATE;
+static int tty_ldisc_autoload =3D IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
=20
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2J1KwACgkQMOfwapXb+vI0YACfXoK9Yjl7GDLMW2dlzhVvZMIT
C/4AoIVRYIUCLsDo1GbsrGh2oRPNvlEI
=qaxy
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
