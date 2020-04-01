Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B80F19B686
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbgDATqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 15:46:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:59588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbgDATqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:46:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1EAB9ADC1;
        Wed,  1 Apr 2020 19:46:21 +0000 (UTC)
Message-ID: <b0a1c1c34539cc84a3c5c62f627422f7aa2bd411.camel@suse.de>
Subject: Re: [GIT PULL 1/3] bcm2835-dt-fixes-2020-03-27
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 01 Apr 2020 21:46:19 +0200
In-Reply-To: <0db69929-ba6f-555f-7ed4-8a03dd398507@gmail.com>
References: <20200327211632.32346-1-nsaenzjulienne@suse.de>
         <0db69929-ba6f-555f-7ed4-8a03dd398507@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-y8RSrHcqIVOj8ZCcIb+g"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y8RSrHcqIVOj8ZCcIb+g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Wed, 2020-04-01 at 12:38 -0700, Florian Fainelli wrote:
>=20
> On 3/27/2020 2:16 PM, Nicolas Saenz Julienne wrote:
> > Hi Florian,
> >=20
> > The following changes since commit 55c7c0621078bd73e9d4d2a11eb36e61bc6f=
e998:
> >=20
> >   ARM: dts: bcm283x: Fix vc4's firmware bus DMA limitations (2020-03-22
> > 14:45:24 -0700)
> >=20
> > are available in the Git repository at:
> >=20
> >  =20
> > ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi=
.git
> > tags/bcm2835-dt-fixes-2020-03-27
>=20
> You would want to provide a public fetch URL for next pull requests, I
> fetched your tree so this is fine, but in case someone processes those
> messages in a semi automated way, they would not be able to pull from
> your tree here.

Noted.

>=20
> > for you to fetch changes up to be08d278eb09210fefbad4c9b27d7843f1c096b2=
:
> >=20
> >   ARM: dts: bcm283x: Add cells encoding format to firmware bus (2020-03=
-27
> > 21:36:17 +0100)
> >=20
> > ----------------------------------------------------------------
> > This patch is to be squashed into 55c7c0621078 ("ARM: dts: bcm283x: Fix
> > vc4's firmware bus DMA limitations") as it turned out to be faulty
> >=20
> > ----------------------------------------------------------------
>=20
> Merged into devicetree/fixes, thanks Nicolas, looks like the offending
> commit has already been applied, though I had not gotten an email about
> it, so the fixup in place is no longer an option.

Ok, no worries, as long as it gets applied at some point we're good, it's j=
ust
a dtc warning.

Regards,
Nicolas


--=-y8RSrHcqIVOj8ZCcIb+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6E74sACgkQlfZmHno8
x/4iOAf+JI6FgsTZ9uymMqt8mJKCK/Fix7acS4hO5RCTAr9N5IsTURngjJam6UZX
8gexD/zBLwFT1a6yzCe2cbkP8y7k2/+Jre85qGl38pXKKeWiA5HxE6r5xyQdXGXW
bQXGdacIaeJWozgGqw+f7Mf94CMbvtACJYpHWk/v8HCetESipZWMs2MtN+OOKkZp
xh5Zlh/yjl+XjWHb+hUsVajbnBdLufNAnKhmvXtqg0FhdorM9dNNlGcoyke/O/aW
T0JKMcHKA/VNgWgNLtcb62tbFe85OKRkUtW72YdPGe7X4d+h92V+i2lARV55GQC2
5qLzU4NK8h3sNnNYzVnDwVV1FAOA3g==
=CULh
-----END PGP SIGNATURE-----

--=-y8RSrHcqIVOj8ZCcIb+g--

