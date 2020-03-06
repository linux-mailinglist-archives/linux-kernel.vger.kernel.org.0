Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48BCD17BA5E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 11:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 05:38:50 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48247 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgCFKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:38:50 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jAANM-00031M-8Q; Fri, 06 Mar 2020 11:38:40 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jAANJ-0002Qa-AC; Fri, 06 Mar 2020 11:38:37 +0100
Date:   Fri, 6 Mar 2020 11:38:37 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Message-ID: <20200306103837.4b2qfrsnqf2ebqqa@pengutronix.de>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
 <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
 <240b86a0aa76ac1f1d3948fc3089e3d13266f4b1.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctfe6omlsgsb22re"
Content-Disposition: inline
In-Reply-To: <240b86a0aa76ac1f1d3948fc3089e3d13266f4b1.camel@toradex.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:17:37 up 112 days,  1:36, 141 users,  load average: 0.00, 0.01,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctfe6omlsgsb22re
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Fri, Mar 06, 2020 at 09:55:06AM +0000, Philippe Schenker wrote:
> On Thu, 2020-03-05 at 15:38 +0100, Oleksij Rempel wrote:
> > Hi Philippe,
> >=20
> > On Thu, Mar 05, 2020 at 02:49:28PM +0100, Philippe Schenker wrote:
> > > The MAC of the i.MX6 SoC is compliant with RGMII v1.3. The KSZ9131
> > > PHY
> > > is like KSZ9031 adhering to RGMII v2.0 specification. This means the
> > > MAC should provide a delay to the TXC line. Because the i.MX6 MAC
> > > does
> > > not provide this delay this has to be done in the PHY.
> > >=20
> > > This patch adds by default ~1.6ns delay to the TXC line. This should
> > > be good for all boards that have the RGMII signals routed with the
> > > same length.
> > >=20
> > > The KSZ9131 has relatively high tolerances on skew registers from
> > > MMD 2.4 to MMD 2.8. Therefore the new DLL-based delay of 2ns is used
> > > and then as little as possibly subtracted from that so we get more
> > > accurate delay. This is actually needed because the i.MX6 SoC has
> > > an asynchron skew on TXC from -100ps to 900ps, to get all RGMII
> > > values within spec.
>=20
> Hi Oleksij! Thanks for your comments and review.
> >=20
> > This configuration has nothing to do in mach-imx/* It belongs to the
> > board devicetree. Please see DT binding documentation for needed
> > properties:
> > Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
>=20
> I know that nowadays this stuff only belongs in the devicetree. I fully
> agree with you. I am also aware of the devicetree bindings.
> >=20
> > All of this mach-imx fixups are evil and should be removed or disabled
> > by Kconfig
> > option. Since they will run on all i.MX based boards even if this PHY
> > are
> > connected to some switch and not connected to the FEC directly.
> > And.. If driver didn't made this configuration all this changes will
> > be lost on
> > suspend/resume cycle or on PHY reset.
>=20
> I am also aware of this behaviour.

=2E.. =C3=B2_=C3=B4 ...

> But the i.MX6 is a SoC used in
> embedded applications and I guess no one comes and plugs in a PCIe MAC
> card in an embedded device.

=2E.. hm ...

> But yes you're right you never know.

well, it is not theoretical discussion. This devices do exist.. With
this patch you will break other existing systems.

> Because the i.MX6 is an embedded processor I still think we should place
> that fixup in mach-imx. There is already a fixup for the predecessor
> KSZ9031 in that code. The KSZ9131 is pin-compatible with KSZ9031 and
> also software compatible, just not with the skew settings.

This fixups will be removed or disabled with Kconfig option:
https://lore.kernel.org/patchwork/patch/1164172/

> I really dislike reinventing the weel here for an old SoC.

Well, you are doing it not for a SoC (old or new), you are doing it for
PHY. PHY fixes belong to PHY driver.

> Philippe
> >=20
> > Regards,
> > Oleksij
> >=20
> > > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > >=20
> > > ---
> > >=20
> > >  arch/arm/mach-imx/mach-imx6q.c | 37
> > > ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >=20
> > > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-
> > > imx/mach-imx6q.c
> > > index edd26e0ffeec..8ae5f2fa33e2 100644
> > > --- a/arch/arm/mach-imx/mach-imx6q.c
> > > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > > @@ -61,6 +61,14 @@ static void mmd_write_reg(struct phy_device *dev,
> > > int device, int reg, int val)
> > >  	phy_write(dev, 0x0e, val);
> > >  }
> > > =20
> > > +static int mmd_read_reg(struct phy_device *dev, int device, int
> > > reg)
> > > +{
> > > +	phy_write(dev, 0x0d, device);
> > > +	phy_write(dev, 0x0e, reg);
> > > +	phy_write(dev, 0x0d, (1 << 14) | device);
> > > +	return phy_read(dev, 0x0e);
> > > +}
> > > +
> > >  static int ksz9031rn_phy_fixup(struct phy_device *dev)
> > >  {
> > >  	/*
> > > @@ -74,6 +82,33 @@ static int ksz9031rn_phy_fixup(struct phy_device
> > > *dev)
> > >  	return 0;
> > >  }
> > > =20
> > > +#define KSZ9131_RXTXDLL_BYPASS	12
> > > +
> > > +static int ksz9131rn_phy_fixup(struct phy_device *dev)
> > > +{
> > > +	int tmp;
> > > +
> > > +	tmp =3D mmd_read_reg(dev, 2, 0x4c);
> > > +	/* disable rxdll bypass (enable 2ns skew delay on RXC) */
> > > +	tmp &=3D ~(1 << KSZ9131_RXTXDLL_BYPASS);
> > > +	mmd_write_reg(dev, 2, 0x4c, tmp);
> > > +
> > > +	tmp =3D mmd_read_reg(dev, 2, 0x4d);
> > > +	/* disable txdll bypass (enable 2ns skew delay on TXC) */
> > > +	tmp &=3D ~(1 << KSZ9131_RXTXDLL_BYPASS);
> > > +	mmd_write_reg(dev, 2, 0x4d, tmp);
> > > +
> > > +	/*
> > > +	 * Subtract ~0.6ns from txdll =3D ~1.4ns delay.
> > > +	 * leave RXC path untouched
> > > +	 */
> > > +	mmd_write_reg(dev, 2, 4, 0x007d);
> > > +	mmd_write_reg(dev, 2, 6, 0xdddd);
> > > +	mmd_write_reg(dev, 2, 8, 0x0007);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /*
> > >   * fixup for PLX PEX8909 bridge to configure GPIO1-7 as output High
> > >   * as they are used for slots1-7 PERST#
> > > @@ -167,6 +202,8 @@ static void __init imx6q_enet_phy_init(void)
> > >  				ksz9021rn_phy_fixup);
> > >  		phy_register_fixup_for_uid(PHY_ID_KSZ9031,
> > > MICREL_PHY_ID_MASK,
> > >  				ksz9031rn_phy_fixup);
> > > +		phy_register_fixup_for_uid(PHY_ID_KSZ9131,
> > > MICREL_PHY_ID_MASK,
> > > +				ksz9131rn_phy_fixup);
> > >  		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffef,
> > >  				ar8031_phy_fixup);
> > >  		phy_register_fixup_for_uid(PHY_ID_AR8035, 0xffffffef,
> > > --=20
> > > 2.25.1
> > >=20
> > >=20
> > >=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ctfe6omlsgsb22re
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl5iKCcACgkQ4omh9DUa
UbMdoxAApaNnKMpkRYngo5clBs9/blpB/yrFdBsqF4OR7883X+stDApm9dk+ZBvr
oJzuj2m+FJ5GdazPWF3J4Ynt2vaZRQIip/R51/KSPp/b9DbUGpXbMZD0GXFnqmVk
1sErMn3ZV0QdIOdq8X+0HKg0Sl3zxSti+6TQolLlRvmZ0+LRqkM1TT40VQ2SdpK+
YxB6lginMrBz74vX7JBkgyQOBT9ECuWBvFodBHGhjGLXzkwgit+/c5Fxd7SLQc6o
kTiRmZEezVvBYh4t+JQCkm8ZWbelUv2KGjaO5SHLVBCGuVZ0fyoT7UqNYVNIINag
Skrv4H5t+2zMwn8ixXlFN1uRlKgUPxrhP7ehXn3rMyIwwG6rICWZT7XsTmT7+S/m
zn4Az0DGpECCIVIX/l2bx1xYJFu+eWy3PyYgL32g/EpV1nkAxYwJv/j7eWHZ5en7
RCSOLWoNqRW817h625OSS/NZVg8vcBnmXpV04JwumvJoBM3x6lsYNyd2sILIimmH
+T6qKZqaJ6o5vMw5PqDoZ1qqhTGr/l2xUu8a39oJToTQ0RtvnRZLzBeSmangprLH
2TeW3IGm61D8RNiF8BgxV42+NWwjatfbD+IwFARodwbM25ncg0PABeExdyLVKM8l
XmVKStnZ0taO/dk2DCRwGgEPXmTi66E9b8P4Ji1GJP3cJSKwgv0=
=Juw9
-----END PGP SIGNATURE-----

--ctfe6omlsgsb22re--
