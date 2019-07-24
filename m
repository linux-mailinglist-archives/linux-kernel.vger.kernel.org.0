Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1072BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfGXJ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 05:58:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49836 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfGXJ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:58:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 701EC802C3; Wed, 24 Jul 2019 11:58:30 +0200 (CEST)
Date:   Wed, 24 Jul 2019 11:58:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>
Subject: [PATCH] intel tracing: consistency and off-by-one fix
Message-ID: <20190724095841.GA6952@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Consistently use "< ... +1" in for loops.

Fix of-by-one in for_each_set_bit().

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/=
gth.c
index fa9d34a..11bc89c 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -543,7 +543,7 @@ static void intel_th_gth_disable(struct intel_th_device=
 *thdev,
 	output->active =3D false;
=20
 	for_each_set_bit(master, gth->output[output->port].master,
-			 TH_CONFIGURABLE_MASTERS) {
+			 TH_CONFIGURABLE_MASTERS + 1) {
 		gth_master_set(gth, master, -1);
 	}
 	spin_unlock(&gth->gth_lock);
@@ -694,7 +694,7 @@ static void intel_th_gth_unassign(struct intel_th_devic=
e *thdev,
 	othdev->output.port =3D -1;
 	othdev->output.active =3D false;
 	gth->output[port].output =3D NULL;
-	for (master =3D 0; master <=3D TH_CONFIGURABLE_MASTERS; master++)
+	for (master =3D 0; master < TH_CONFIGURABLE_MASTERS + 1; master++)
 		if (gth->master[master] =3D=3D port)
 			gth->master[master] =3D -1;
 	spin_unlock(&gth->gth_lock);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl04K9EACgkQMOfwapXb+vJBGwCdHwVEqX/QWWz7c5gL6F2AacBV
ly4An1YId3P21Ld19HtcMlDJcku6b1sL
=cXlX
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
