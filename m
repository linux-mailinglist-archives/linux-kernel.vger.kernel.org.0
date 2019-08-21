Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E76697CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 16:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfHUO0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 10:26:10 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60788 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHUO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:26:10 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i0RYv-0004aN-BG; Wed, 21 Aug 2019 10:26:09 -0400
Message-ID: <7d3d50666ced8fb27d0964fa51e78fcbd0aec82e.camel@surriel.com>
Subject: Re: Pointer magic in mm_init_cpumask()
From:   Rik van Riel <riel@surriel.com>
To:     Siarhei Liakh <sliakh.lkml@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 21 Aug 2019 10:26:08 -0400
In-Reply-To: <CALBuU529+=+Xmsccc3AU2R0tSOCJtMQx=yMGDHopc3=tO3uM3Q@mail.gmail.com>
References: <CALBuU529+=+Xmsccc3AU2R0tSOCJtMQx=yMGDHopc3=tO3uM3Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-k3HbeHCDITjKCpsf2FRY"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k3HbeHCDITjKCpsf2FRY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-21 at 09:13 -0400, Siarhei Liakh wrote:

> If mm_cpumask() is not safe, then at the very least the following has
> to be fixed:
> $ grep -rIn 'cpumask_clear(mm_cpumask(' *
> arch/powerpc/include/asm/tlb.h:69:    cpumask_clear(mm_cpumask(mm));
> arch/sparc/mm/init_64.c:857:        cpumask_clear(mm_cpumask(mm));
> arch/ia64/include/asm/mmu_context.h:92:        cpumask_clear(mm_cpuma
> sk(mm));
> arch/csky/mm/asid.c:126:    cpumask_clear(mm_cpumask(mm));
> arch/arm/mm/context.c:233:    cpumask_clear(mm_cpumask(mm));
>=20
> Otherwise, mm_init_cpumask() can be simplified down to
> cpumask_clear(mm_cpumask(mm)).
> What do you think?

That looks like a nice cleanup.

I do not see why it would not work, but I suppose
that should be tested :)

--=20
All Rights Reversed.

--=-k3HbeHCDITjKCpsf2FRY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1dVIEACgkQznnekoTE
3oNGSQf/Xbkuz6NK2iPNQsSsPRCz2ie4Qkxq6sQYeD+pD4f6YHog0GOGWTFFrAIT
FShUqfjcu5OgYAAuhifsZn9k9WjYeME+HSQON8we3IjyeAP05r5yE25TrvQgVc6l
5CrEle71a7go8l+f5ZcCB/gUJHZdRjaD+aJ3RIEPPwZ/O2YYofcGpHb4kHeFOABX
sxI8y9waEIQJlUBzOdIHuUajxyCh6W2zr0s7aM590iqGsFBbvvrKxQMK5F8HUbhP
ahi8PNbsO9bz3vLvVpKN9jzkJd5CviMCLO1oFN8cYvOjLfdKDo8BAQ2ddMJhQXej
4+pdaB4mVtUuTReDC/hMDQaiBcqbxg==
=sAMJ
-----END PGP SIGNATURE-----

--=-k3HbeHCDITjKCpsf2FRY--

