Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A138E547
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 09:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfHOHNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 03:13:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53277 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbfHOHNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:13:53 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ACFB180BCE; Thu, 15 Aug 2019 09:13:38 +0200 (CEST)
Date:   Thu, 15 Aug 2019 09:13:50 +0200
From:   Pavel Machek <pavel@denx.de>
To:     gregkh@linuxfoundation.org,
        kernel list <linux-kernel@vger.kernel.org>, stable@kernel.org,
        matthias.bgg@gmail.com, neil@brown.name,
        thirtythreeforty@gmail.com, christian@lkamp.de,
        nishadkamdar@gmail.com, ser.perschin@gmail.com, blogic@openwrt.org,
        jan.kiszka@siemens.com
Subject: [stable] Deleting "mt7621-mmc" with "interesting" license?
Message-ID: <20190815071350.GB3906@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I realize that "interesting" license is not on a list of bugs suitable
for -stable, but on the other hand, this tends to scare corporate
lawyers... so perhaps we should remove the driver in -stable, too?

Upstream commit id is 441bf7332d55c4d34afae9ffc3bbec621093f4d1.

4.19 has the problematic driver, 4.4 does not.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1VBi4ACgkQMOfwapXb+vKxkACfbdhmGEXzpOJ8zHpHBAwXCghh
6n8An1gwThbe9Frol8AN7iQD3KPEtZ1M
=v2Dj
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
