Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37936ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 10:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfFFIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 04:37:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43158 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfFFIhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:37:38 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 71E038024C; Thu,  6 Jun 2019 10:37:25 +0200 (CEST)
Date:   Thu, 6 Jun 2019 10:37:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 5.2: display corruption on X60, X220
Message-ID: <20190606083735.GA975@amd>
References: <20190603074004.GA15821@amd>
 <87v9xj15d9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <87v9xj15d9.fsf@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-06-06 11:32:18, Jani Nikula wrote:
> On Mon, 03 Jun 2019, Pavel Machek <pavel@ucw.cz> wrote:
> > In recent kernels (5.2.0-rc1-next-20190522, 5.2-rc2) I'm getting
> > display corruption in X. Usually in terminals, but also in title bars
> > etc. Black areas with white lines in them, usually...
> >
> > Same configuration worked properly in ... probably 4.19? Then I got
> > some graphics-crashes on X220 that prevented me from testing :-(.
>=20
> It's pretty hard to say anything based on the above.
>=20
> Anything in the logs with drm.debug=3D14 added?

I see. It looks like hard-to-debug issue.

Oh, interesting part is that corruption _is_ visible if I make a
screenshot.

Will try with drm.debug=3D...

Do you do some kind of testing that would catch similar issues?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlz40M4ACgkQMOfwapXb+vLZMACgm7iZSxYbdUCpTeiMLAPL7hEj
stEAn1R7/eD7ZCus4hp6dl3hhM0MIh4A
=DYR7
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
