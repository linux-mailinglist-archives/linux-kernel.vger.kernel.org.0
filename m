Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E0F59EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfF1Pbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 11:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfF1Pbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:31:50 -0400
Received: from earth.universe (dyndsl-091-096-035-018.ewe-ip-backbone.de [91.96.35.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09342064A;
        Fri, 28 Jun 2019 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561735909;
        bh=8iUoGaLQnM0v2OSv7ts6RP76zfN/sNZi3PrtkS407jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBpC3RcrKHQz5hNkpi0n5n0TZhRt6u7Ijak6wxpwSvKGIAHelHud0EaAjBjDUNsTI
         HiXkUyFw2/g2puFyUpWSi4cRIJreLq3BZmEPqMvmyRh+yGttLILmNUxYRLg1BHYUYv
         LE1Xw92j5mjCmEmbcqbC/BBuck5X13uI1G81OC3k=
Received: by earth.universe (Postfix, from userid 1000)
        id 0313B3C08D5; Fri, 28 Jun 2019 17:31:46 +0200 (CEST)
Date:   Fri, 28 Jun 2019 17:31:46 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: linux-next: build failure after merge of the battery tree
Message-ID: <20190628153146.c2lh4y55qvcmqhry@earth.universe>
References: <20190628140304.76caf572@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jpayq2oy4ickphis"
Content-Disposition: inline
In-Reply-To: <20190628140304.76caf572@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jpayq2oy4ickphis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 28, 2019 at 02:03:04PM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the battery tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/power/supply/wilco-charger.c: In function 'wilco_charge_get_prope=
rty':
> drivers/power/supply/wilco-charger.c:104:8: error: implicit declaration o=
f function 'wilco_ec_get_byte_property'; did you mean 'wilco_charge_get_pro=
perty'? [-Werror=3Dimplicit-function-declaration]
>   ret =3D wilco_ec_get_byte_property(ec, property_id, &raw);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>         wilco_charge_get_property
> drivers/power/supply/wilco-charger.c: In function 'wilco_charge_set_prope=
rty':
> drivers/power/supply/wilco-charger.c:130:10: error: implicit declaration =
of function 'wilco_ec_set_byte_property'; did you mean 'wilco_charge_set_pr=
operty'? [-Werror=3Dimplicit-function-declaration]
>    return wilco_ec_set_byte_property(ec, PID_CHARGE_MODE, mode);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>           wilco_charge_set_property
>=20
> Caused by commit
>=20
>   0736343e4c56 ("power_supply: wilco_ec: Add charging config driver")
>=20
> I have reverted that commit for today.

Oops, thanks for the hint. I did not notice this with ARM
allmodconfig. I dropped the patch for this cycle.

-- Sebastian

--jpayq2oy4ickphis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0WMt8ACgkQ2O7X88g7
+pr2ZxAAqlndUv8spBY4poNijfH2UHCQDuCzIF9qUSZKLUwyno/nC/hnlCCKv/hK
/bEK18Yboat6lgTTv6P8i7pY86GGWEt2CxHFstuz0/05Io+9D+gXcXknJTgge6L3
yl2y30/nsG3rfHHbxHXFl4grEuAmeLIYG3i44hYiuNh+wD0YMLljC9BJrIUAe+1Z
h6SZN0aXy7qtoI4gQ/qN8DGudsuplwF7zb4YE+V8iMGI3zZd9Z9JDbcZRF75ZNsB
O7KHG8bdS5a8HQN7kAfMAQjPgbYfE0yQk4B5bOeTGf5O9tev7j0y9G14zAO0tck8
eRtuWioq68ddclVuq54ZShq+Zj2XpxeelKj/h1dqM4sjeFjFKkpyDVZwKtFXJlwZ
FJ1RxsSOfH7BzD2h25fXBp5QyYGyQ2Oqf4XCpyXkWHDvfzb8IwANhczGp+QuSqVq
5d1BTVSm2KOL5usbaUL/cUi/LAu2xABeapoGErqhaIivTR12zdE4oLaMi671Pkwb
O28j7X74yNaGjceS/PdCNCQ5XVKvNNKz+9mqabE4c6uDuGkQMPgNi5ESOm2zcCfL
yKWJvnuMDqapkH+3OqDCDW732HElTNkr4lg6jvyuxcr6J2LDkbF/B7gXiADQtNjI
hJDIs+Ok/QqdcrKXuojZ1l132w/lWG17cgBN6w9/0Q8Vhiw582w=
=dBPC
-----END PGP SIGNATURE-----

--jpayq2oy4ickphis--
