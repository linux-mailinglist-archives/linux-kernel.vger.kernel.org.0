Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E8F163D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 14:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEGMlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 08:41:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47674 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfEGMlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:41:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9672480237; Tue,  7 May 2019 14:41:01 +0200 (CEST)
Date:   Tue, 7 May 2019 14:41:13 +0200
From:   Pavel Machek <pavel@denx.de>
To:     alexander.shishkin@linux.intel.com, security@kernel.org,
        sasha.levin@oracle.com, gregkh@linuxfoundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, trivial@kernel.org
Subject: stm class: Prevent user-controllable allocations
Message-ID: <20190507124113.GA659@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


It seems to me that we still allow overflow if count =3D=3D ~0. We'll then
allocate 0 bytes but copy ~0 bytes. That does not sound healthy.

Fixes: f08b18266c7116e2ec6885dd53a928f580060a71

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index c7ba8ac..8846fca 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -631,7 +631,7 @@ static ssize_t stm_char_write(struct file *file, const =
char __user *buf,
 	char *kbuf;
 	int err;
=20
-	if (count + 1 > PAGE_SIZE)
+	if (count > PAGE_SIZE - 1)
 		count =3D PAGE_SIZE - 1;
=20
 	/*

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzRfOgACgkQMOfwapXb+vIg6ACcCUYSmergmRoYlj8yv4lhG3Rt
eV0AnjHAZKnKZkbG2MYYaSIxgt2+B3+b
=hRpN
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
