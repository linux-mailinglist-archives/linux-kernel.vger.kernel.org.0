Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3849C31D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfJAK4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 06:56:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51920 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJAK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:56:10 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DE85280498; Tue,  1 Oct 2019 12:55:53 +0200 (CEST)
Date:   Tue, 1 Oct 2019 12:56:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, rodrigo.vivi@intel.com,
        joonas.lahtinen@linux.intel.com
Subject: Re: 5.4-rc1 on Thinkpad x220: graphics regression, it "snows" on
 digital output
Message-ID: <20191001105607.GA4339@amd>
References: <20191001105102.GA4442@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20191001105102.GA4442@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> When 5.4-rc1 is booted on thinkpad X220 I get "snow" and other
> artefacts on digital output.
>=20
> 00:02.0 VGA compatible controller: Intel Corporation 2nd Generation
> Core Processor Family Integrated Graphics Controller (rev 09)
>=20
> It already snows when kernel is booting, snow continues in X.

Sorry, false alarm. I seem to have a hardware problem, it persisted
reboot to older kernel, and went away after I wiggled cables.

Best regards,
									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2TMMcACgkQMOfwapXb+vIHYACdEwgjSZrQx2RQQ5tJu1JrD4Ny
/noAoIfW65BKZQ42HcUBKDDdNQM+C4UY
=ZGYS
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
