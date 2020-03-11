Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFBC181E17
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgCKQj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:39:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgCKQj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:39:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8F6EEAD83;
        Wed, 11 Mar 2020 16:39:23 +0000 (UTC)
Message-ID: <27b291f807b6b07c41bf836dc5d543c8b710737e.camel@suse.de>
Subject: Re: [PATCH] ARM: bcm2835-rpi-zero-w: Add missing pinctrl name
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>, nick.hudson@gmx.co.uk
Cc:     Nick Hudson <skrll@netbsd.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 11 Mar 2020 17:39:21 +0100
In-Reply-To: <620c845c-afd1-a4a4-468a-acc24299f492@gmail.com>
References: <20200310182537.8156-1-nick.hudson@gmx.co.uk>
         <12f35cc38b87dfe27f0786c931d4434b0fecb3d8.camel@suse.de>
         <620c845c-afd1-a4a4-468a-acc24299f492@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tO8qGKgqcYZ4oHm3H9Yo"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tO8qGKgqcYZ4oHm3H9Yo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-03-11 at 09:37 -0700, Florian Fainelli wrote:
> On 3/11/20 4:28 AM, Nicolas Saenz Julienne wrote:
> > On Tue, 2020-03-10 at 18:25 +0000, nick.hudson@gmx.co.uk wrote:
> > > From: Nick Hudson <nick.hudson@gmx.co.uk>
> > >=20
> > > Define the sdhci pinctrl state as "default" so it gets applied
> > > correctly and to match all other RPis.
> > >=20
> > > Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")
> > >=20
> > > Signed-off-by: Nick Hudson <skrll@netbsd.org>
> >=20
> > I think this one has everything right. As a nitpick, there is no need t=
o add
> > a
> > space between the Fixes tag and the Signed-off-by tag, but it's OK as i=
s.
> >=20
> > Florian, can we channel this as a fix for v5.6 or are we too late?
>=20
> We can try, let me queue this today.

Cool, in that case you can add my:

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-tO8qGKgqcYZ4oHm3H9Yo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5pFDkACgkQlfZmHno8
x/7ZLgf/Y74eTK74Olpi4QBn5o859nxJLEbfvHY7QMCt7KTQtkZb+Np8YQwlb0G1
GN7zU/ftA0ugqZgz0/PbzvfIaLmYOPvylyg3T5gOKVaPuZsY/94xYIzFCP7LduAw
3eq8NEf1EQrXDhDcKGzigrXBm6FsDAXJjIN7RiqT1JqofstwznMsebBYas0mk7pN
83VbCcgNkUMDSIDT2eURsUL+U2FqMFbgX6Ie03w8OlJtx6DsSNXYDzblK290cUtY
YRJpTqq38S8C9j9DvCPO9TK/t0ez/MbmaCJ/4jQMWfy8EmMqHq2Z+dxt4QYDIm16
hNh6SUj4r1QqDnMJhwvzKpjZpCJdkA==
=91Kj
-----END PGP SIGNATURE-----

--=-tO8qGKgqcYZ4oHm3H9Yo--

