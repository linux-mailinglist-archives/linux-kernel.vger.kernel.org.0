Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF317EC20
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 23:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCIWde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 18:33:34 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36784 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCIWde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:33:34 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A331D1C0317; Mon,  9 Mar 2020 23:33:32 +0100 (CET)
Date:   Mon, 9 Mar 2020 23:33:32 +0100
From:   Pavel Machek <pavel@denx.de>
To:     corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] devices.txt: document minor for rfkill
Message-ID: <20200309223332.GB1634@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rfkill is using	minor 242, document that.

Signed-off-by: Pavel Machek <pavel@denx.de>
Fixes: 8670b2b8b029a6650d133486be9d2ace146fd29a

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-gu=
ide/devices.txt
index 2a97aaec8b12..763fedd94d7d 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -375,8 +375,9 @@
 		239 =3D /dev/uhid		User-space I/O driver support for HID subsystem
 		240 =3D /dev/userio	Serio driver testing device
 		241 =3D /dev/vhost-vsock	Host kernel driver for virtio vsock
+		242 =3D /dev/rfkill	Turning off radio transmissions (rfkill)
=20
-		242-254			Reserved for local use
+		243-254			Reserved for local use
 		255			Reserved for MISC_DYNAMIC_MINOR
=20
   11 char	Raw keyboard device	(Linux/SPARC only)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXmbEPAAKCRAw5/Bqldv6
8iODAJ0cDBIMIY4P9rxntVrVJoo5oGDgLACgmrqACb8bNq5HOe5cFdn4GoiZIX4=
=OEcN
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
