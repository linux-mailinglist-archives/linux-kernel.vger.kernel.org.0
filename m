Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A2C31C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 12:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbfJAKvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 06:51:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51774 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731030AbfJAKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:51:05 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7EA5280498; Tue,  1 Oct 2019 12:50:48 +0200 (CEST)
Date:   Tue, 1 Oct 2019 12:51:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, rodrigo.vivi@intel.com,
        joonas.lahtinen@linux.intel.com
Subject: 5.4-rc1 on Thinkpad x220: graphics regression, it "snows" on digital
 output
Message-ID: <20191001105102.GA4442@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

When 5.4-rc1 is booted on thinkpad X220 I get "snow" and other
artefacts on digital output.

00:02.0 VGA compatible controller: Intel Corporation 2nd Generation
Core Processor Family Integrated Graphics Controller (rev 09)

It already snows when kernel is booting, snow continues in X.

HDMI1 connected primary 1920x1080+0+0 (normal left inverted right x
axis y axis) 478mm x 268mm
   1920x1080     60.00*+


Snow continues in other video modes:

pavel@duo:~$  xrandr --output HDMI1 --mode 1024x768
pavel@duo:~$

VGA output appears normal.

Any ideas?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2TL5YACgkQMOfwapXb+vIcUACdEniC2D2dL2MVXRONfTE+X3NS
NscAn12L+nQU3Q3mdoa61oyqu0Z7AluS
=cSp1
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
