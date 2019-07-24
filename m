Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4772BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGXJw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 05:52:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49701 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGXJw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:52:57 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AADEF802C3; Wed, 24 Jul 2019 11:52:43 +0200 (CEST)
Date:   Wed, 24 Jul 2019 11:52:54 +0200
From:   Pavel Machek <pavel@denx.de>
To:     perex@perex.cz, tiwai@suse.com, gregkh@linuxfoundation.org,
        allison@lohutok.net, tglx@linutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: line6: sizeof (byte) is always 1, use that fact.
Message-ID: <20190724095254.GA6727@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


sizeof (byte) is always 1, use that fact and make interesting code explicit.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index ab2ec89..387c5c2 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -342,7 +342,7 @@ int line6_read_data(struct usb_line6 *line6, unsigned a=
ddress, void *data,
 	if (address > 0xffff || datalen > 0xff)
 		return -EINVAL;
=20
-	len =3D kmalloc(sizeof(*len), GFP_KERNEL);
+	len =3D kmalloc(1, GFP_KERNEL);
 	if (!len)
 		return -ENOMEM;
=20
@@ -418,7 +421,7 @@ int line6_write_data(struct usb_line6 *line6, unsigned =
address, void *data,
 	if (address > 0xffff || datalen > 0xffff)
 		return -EINVAL;
=20
-	status =3D kmalloc(sizeof(*status), GFP_KERNEL);
+	status =3D kmalloc(1, GFP_KERNEL);
 	if (!status)
 		return -ENOMEM;
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl04KnYACgkQMOfwapXb+vIvPgCdEcgRySTDEvncHuH1EgY1sF2N
rwMAoMGO7UVMzt/J19H3d1Huf9YsVeSF
=2Y4Y
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
