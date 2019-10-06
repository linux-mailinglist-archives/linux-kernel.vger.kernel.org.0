Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19034CD185
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 13:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfJFLE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 07:04:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43634 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfJFLE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 07:04:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9D38780476; Sun,  6 Oct 2019 13:04:41 +0200 (CEST)
Date:   Sun, 6 Oct 2019 13:04:56 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Daniel Thompson <daniel.thompson@linaro.org>, alex@alexanderweb.de,
        andriy.shevchenko@linux.intel.com
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mat King <mathewk@google.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, Ross Zwisler <zwisler@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: New sysfs interface for privacy screens
Message-ID: <20191006110455.GC24605@amd>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <20191002094650.3fc06a85@lwn.net>
 <87muei9r7i.fsf@intel.com>
 <20191003102254.dmwl6qimdca3dbrv@holly.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <20191003102254.dmwl6qimdca3dbrv@holly.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >> I have been looking into adding Linux support for electronic privacy
> > >> screens which is a feature on some new laptops which is built into t=
he
> > >> display and allows users to turn it on instead of needing to use a
> > >> physical privacy filter. In discussions with my colleagues the idea =
of
> > >> using either /sys/class/backlight or /sys/class/leds but this new
> > >> feature does not seem to quite fit into either of those classes.
> > >
> > > FWIW, it seems that you're not alone in this; 5.4 got some support for
> > > such screens if I understand things correctly:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D110ea1d833ad
> >=20
> > Oh, I didn't realize it got merged already, I thought this was
> > related...
> >=20
> > So we've already replicated the backlight sysfs interface problem for
> > privacy screens. :(
>=20
> I guess... although the Thinkpad code hasn't added any standard
> interfaces (no other laptop should be placing controls for a privacy
> screen in /proc/acpi/ibm/... ). Maybe its not too late.

There's new interface for controlling privacyguard... but perhaps we
need better solution than what went in 5.4. Perhaps it should be
reconsidered?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2ZylcACgkQMOfwapXb+vIvLwCgv8pM8435FkksDHNB1TjTxnow
Zm8AoKrwhCDI1rdvOj6Y2H8UU21KaV9E
=xgty
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
