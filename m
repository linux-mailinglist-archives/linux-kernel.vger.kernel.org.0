Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9B80576
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbfHCI7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 04:59:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45284 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbfHCI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 04:59:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F3EE68031B; Sat,  3 Aug 2019 10:59:18 +0200 (CEST)
Date:   Sat, 3 Aug 2019 10:59:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] ARM: dts: mmp2: devicetree updates
Message-ID: <20190803085930.GC8224@amd>
References: <20190802103326.531250-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <20190802103326.531250-1-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-08-02 12:33:20, Lubomir Rintel wrote:
> Hi,
>=20
> Here's a couple of updates for the MMP2 SoC devicetree files.
>=20
> The only change from the last submission is the addition of the
> OLPC XO 1.75 dts file. Apart from that one, the patches are
> independent of each other, can be applied in any order.
>=20
> Hopefully I'm sending the patch set in the correct direction.

For the series:

Acked-by: Pavel Machek <pavel@ucw.cz>

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

iEYEARECAAYFAl1FTPIACgkQMOfwapXb+vJSEgCeP8R8/yqqOx9NWsQBypBVhpTv
A4sAmQGoqEsj1khqUsIR0sjkyEqGdQfG
=LO3O
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
