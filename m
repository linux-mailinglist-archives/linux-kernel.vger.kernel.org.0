Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1ECD180
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 12:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfJFK6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 06:58:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43470 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfJFK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:58:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CF2FC80471; Sun,  6 Oct 2019 12:58:35 +0200 (CEST)
Date:   Sun, 6 Oct 2019 12:58:50 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Mat King <mathewk@google.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Ross Zwisler <zwisler@google.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: New sysfs interface for privacy screens
Message-ID: <20191006105850.GA24605@amd>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-10-01 10:09:46, Mat King wrote:
> Resending in plain text mode
>=20
> I have been looking into adding Linux support for electronic privacy
> screens which is a feature on some new laptops which is built into the
> display and allows users to turn it on instead of needing to use a
> physical privacy filter. In discussions with my colleagues the idea of
> using either /sys/class/backlight or /sys/class/leds but this new
> feature does not seem to quite fit into either of those classes.

Thank you for not trying to push it as a LED ;-).

> I am proposing adding a class called "privacy_screen" to interface
> with these devices. The initial API would be simple just a single
> property called "privacy_state" which when set to 1 would mean that
> privacy is enabled and 0 when privacy is disabled.
>=20
> Current known use cases will use ACPI _DSM in order to interface with
> the privacy screens, but this class would allow device driver authors
> to use other interfaces as well.
>=20
> Example:
>=20
> # get privacy screen state
> cat /sys/class/privacy_screen/cros_privacy/privacy_state # 1: privacy
> enabled 0: privacy disabled
>=20
> # set privacy enabled
> echo 1 > /sys/class/privacy_screen/cros_privacy/privacy_state
>=20
>  Does this approach seem to be reasonable?

Not really. How does the userland know which displays this will
affect?

This sounds like something that should go through drm drivers,
probably to be selected by xrandr, rather than separate file somewhere
in sysfs.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2ZyOoACgkQMOfwapXb+vIIUACeJ2pN1CHDcsdh0BG2KltFUGBJ
sOEAn1IE5e0NufSQ0G4RhwqmtYb04UbY
=Loez
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
