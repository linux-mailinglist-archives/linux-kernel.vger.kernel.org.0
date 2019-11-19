Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987C3102ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 18:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfKSRZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 12:25:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:58448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726985AbfKSRZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:25:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4EA7B20B;
        Tue, 19 Nov 2019 17:25:19 +0000 (UTC)
Message-ID: <e3e192e178fadddcd862c2c1f4644b5a1fe3a3d0.camel@suse.de>
Subject: Re: [PATCH v2 3/3] ARM: dts: bcm2711: Enable HWRNG support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stephen Brennan <stephen@brennan.io>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Scott Branden <sbranden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <wahrenst@gmx.net>,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-crypto@vger.kernel.org
Date:   Tue, 19 Nov 2019 18:25:16 +0100
In-Reply-To: <BYK1FVFPTH7J.159A75JOGITR1@pride>
References: <BYK1FVFPTH7J.159A75JOGITR1@pride>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Q1OudO4sDtl+ITj8Di/3"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q1OudO4sDtl+ITj8Di/3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-19 at 09:09 -0800, Stephen Brennan wrote:
> Hi Nicolas,
>=20
> On Tue Nov 19, 2019 at 11:07 AM, Nicolas Saenz Julienne wrote:
> > Hi Stephen, thanks for the follow-up.
> >=20
> >=20
> > On Mon, 2019-11-18 at 22:14 -0800, Stephen Brennan wrote:
> > > BCM2711 features a RNG200 hardware random number generator block, whi=
ch i=3D
> > s
> > > different from the BCM283x from which it inherits. Move the rng block=
 fro=3D
> > m
> > > BCM283x into a separate common file, and update the rng declaration o=
f
> > > BCM2711.
> > > =3D20
> > > Signed-off-by: Stephen Brennan <stephen@brennan.io>
> > > ---
> >=20
> > It's petty in this case but you should add a list of changes here too.
>=20
> To make sure I understand, you mean listing out the changes in each=20
> revision of the patch series?

What's generally expected is for the cover letter to contain an overview of=
 the
series changes. No need to go into specific detail. Then, every patch shoul=
d
list its local modifications.

Also remember to add the list of changes after the '---' line in your patch=
,
this way they won't show up in the final commit log.

If in doubt have a look at the kernel mailing lists, there are plenty of
examples.

Regards,
Nicolas


--=-Q1OudO4sDtl+ITj8Di/3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3UJXwACgkQlfZmHno8
x/5J8gf/Wg/IrKzrAi1fKuJaY4CfPJSLpKvLtmOfDqcchsMm6aq0nBODopwXGT0y
bcPiG7OOnwcDqlD8pxyBL8iBG48gsidg51JSizuSnJ6lgxPpSN6JHoD4HUi2hnS5
y0wXzThHmoZB00Vep0o6EmBsY2hHU/URLfH1uWnSwut9CRQfC/dVJ8UhxPVuCaqJ
HLYdPveYV3S6P1YUk0RgO95RqhjEegya1zsvT3W0pGwda042QbvweKzaUtzRERT2
GwN2eIcP2SJ+8S/P8edIPwd3T6uL7gMLLsw7WWCp9DOQPI/ORFPm7c2dUEkdXW1l
mAscggOyCMH1qNaOc7lVVZ7o92N1mA==
=d9p8
-----END PGP SIGNATURE-----

--=-Q1OudO4sDtl+ITj8Di/3--

