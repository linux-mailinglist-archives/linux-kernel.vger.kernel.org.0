Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4435A42389
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 13:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408990AbfFLLJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 07:09:07 -0400
Received: from sauhun.de ([88.99.104.3]:58678 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407079AbfFLLJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:09:06 -0400
Received: from localhost (p5486CACA.dip0.t-ipconnect.de [84.134.202.202])
        by pokefinder.org (Postfix) with ESMTPSA id CC6262C54BC;
        Wed, 12 Jun 2019 13:09:04 +0200 (CEST)
Date:   Wed, 12 Jun 2019 13:09:04 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Babayev <ruslan@babayev.com>,
        Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: linux-next: build warning after merge of the i2c tree
Message-ID: <20190612110904.qhuoxyljgoo76yjj@ninjato>
References: <20190611102528.44ad5783@canb.auug.org.au>
 <20190612081929.GA1687@kunai>
 <20190612080226.45d2115a@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4qzl3vk74xit3c3g"
Content-Disposition: inline
In-Reply-To: <20190612080226.45d2115a@coco.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4qzl3vk74xit3c3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

> That entire use of _P, _R and _ri looks weird into my eyes. The code there

Yes.

> do things like:
>=20
> #define _P 32
>=20
> ...
>=20
>         if (_P =3D=3D 64)
>                 reg1[1] |=3D 0x40;

Yup, I saw this, too, but didn't feel like refactoring the driver.
Thanks for stepping up!

> I'll work on a patch to address it.

OK, so that means I should send my pull request after yours in the next
merge window? To avoid the build breakage?

Kind regards,

   Wolfram


--4qzl3vk74xit3c3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0A3VAACgkQFA3kzBSg
KbahRw//VIu/ktMa+Keb+6y/7oxnZL6dC7PnhcBzrYURkHhZyqa+/v1wDI1FzHWu
kraj7LBKSdILyt/AFDIsjXKEFfQiZZcvsAhJnpuHVLjNwrZXANAMFmNsxz80S1Sk
mCf11wIp++OZdFv/Ba6VZys3Pj/DzA3wxgoysrmn51zfuWPXAOWVZ4GmGXzRRHEe
WbkxfU/d2aqQlnZN5+w3wwVmEOywO0R30bnbISP170Gl9YFhZbBIbQWF4Ij6Qajl
/hBsYVhts8/An+bhW+zqDZD/RQ28XD2GQv50ZSsOSYQ7ALijIiZPeWjpdFdLRj74
qa7/7EZ+2PisMjsh9WcMN4t05VB6eKeNrIJpOezWEPirMZMf/Mwj9Ggzni/5U0ay
1hVkIBujgVnkFIW4xn6miByvculFN9tHcpR/0oIjgqUaSDAdUK8b4r2zPfqn7LFL
GX2vSq4ht396fuzGMSnMJQ5T4i4FHH2xfOLkZdBAhV6k83zt/sfMRXllpvjhz9Jc
GRLd2ql3cM/L9xwGZt2eAqwnAyK9FKOe6Bj8kjD4C8gZhJvMFggaqcmoNXcV2W6A
cpHbiMjzbDWB2qZOrMu03uxrZu0eUaVG0mMeeZJ1qIqB73fsnYwy2zB3n3PsDISi
l+cMrCuB5d92N82TE0JNKJkI0EXkURSR9xmeTO38s2N4+xMF7lY=
=nM45
-----END PGP SIGNATURE-----

--4qzl3vk74xit3c3g--
