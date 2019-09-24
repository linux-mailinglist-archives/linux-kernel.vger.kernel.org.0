Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8582BC37A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 09:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394728AbfIXHzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 03:55:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34540 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388712AbfIXHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:55:53 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4593480BB0; Tue, 24 Sep 2019 09:55:36 +0200 (CEST)
Date:   Tue, 24 Sep 2019 09:55:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org
Subject: Re: [PATCH v2 2/2] rtc: wilco-ec: Fix license to GPL from GPLv2
Message-ID: <20190924075549.GA20990@amd>
References: <20190916181215.501-1-ncrews@chromium.org>
 <20190916181215.501-2-ncrews@chromium.org>
 <20190922202947.GA4421@bug>
 <20190922204353.GD3185@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20190922204353.GD3185@piout.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-09-22 22:43:53, Alexandre Belloni wrote:
> On 22/09/2019 22:29:48+0200, Pavel Machek wrote:
> > On Mon 2019-09-16 12:12:17, Nick Crews wrote:
> > > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > > ---
> > >  drivers/rtc/rtc-wilco-ec.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > > index e84faa268caf..951268f5e690 100644
> > > --- a/drivers/rtc/rtc-wilco-ec.c
> > > +++ b/drivers/rtc/rtc-wilco-ec.c
> > > @@ -184,5 +184,5 @@ module_platform_driver(wilco_ec_rtc_driver);
> > > =20
> > >  MODULE_ALIAS("platform:rtc-wilco-ec");
> > >  MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> > > -MODULE_LICENSE("GPL v2");
> > > +MODULE_LICENSE("GPL");
> > >  MODULE_DESCRIPTION("Wilco EC RTC driver");
> >=20
> > File spdx header says GPL-2.0, this change would make it inconsistent w=
ith that...
>=20
> Commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
> bogosity") doesn't agree with you (but I was surprised too).

Still don't get it. bf7fbeeae6db makes MODULE_LICENSE less useful, and
declares "GPL" =3D=3D "GPL v2" in MODULE_LICENSE. So.. this change is no
longer wrong, it is just unneccessary...? Why do it? It is not a fix
as a subject line says...

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2JzAUACgkQMOfwapXb+vJcfQCePTpRui7YIrnE4Bvasd5Vc5uG
X8YAn0YwYBUBAc+4Em5e6pjWzVC05QPT
=y0hd
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
