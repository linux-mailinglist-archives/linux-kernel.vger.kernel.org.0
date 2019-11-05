Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E6AEFBB4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 11:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbfKEKpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 05:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387905AbfKEKpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:45:10 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB6B206BA;
        Tue,  5 Nov 2019 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572950709;
        bh=onQoxY+60Ht/QpXXbe43yBiTlL8/TGR6VtklKa0Nv8Q=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=PFdcBBT7246rOR+L/TuwT/n4Vd90Yj6lLmFUd6G+BIkkG3DYYgUrl28UrcsC9529U
         olg2lNxLJF9D2p0XDByHBB98hvUEFu0ZsC21KV3sVINqTUsnXTw6s+vC9LOX2EvyEb
         CeG36tokQ2/KIRdx+YsA4oASez2fvTD8FLd+rPZs=
Date:   Tue, 5 Nov 2019 11:45:07 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] arm64: dts: allwinner: orange-pi-3: Enable USB 3.0
 host support
Message-ID: <20191105104507.GE3876@gilmour.lan>
References: <20191020134229.1216351-1-megous@megous.com>
 <20191020134229.1216351-5-megous@megous.com>
 <20191021110946.gxmib3to7n7v2vof@gilmour>
 <20191104121648.jxgs2eoj6loh2as2@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20191104121648.jxgs2eoj6loh2as2@core.my.home>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 04, 2019 at 01:16:48PM +0100, Ond=C5=99ej Jirman wrote:
> Hello Maxime,
>
> On Mon, Oct 21, 2019 at 01:09:46PM +0200, Maxime Ripard wrote:
> > On Sun, Oct 20, 2019 at 03:42:29PM +0200, megous@megous.com wrote:
> > > From: Ondrej Jirman <megous@megous.com>
> > >
> > > Enable Allwinner's USB 3.0 phy and the host controller. Orange Pi 3
> > > board has GL3510 USB 3.0 4-port hub connected to the SoC's USB 3.0
> > > port. All four ports are exposed via USB3-A connectors. VBUS is
> > > always on, since it's powered directly from DCIN (VCC-5V) and
> > > not switchable.
> > >
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> >
> > Those last two patches are fine with me, I'll merge them once the phy
> > driver will be merged.
>
> PHY driver has been merged. You can now pull these patches too, when
> you like.
>
> See here: https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-ph=
y.git/log/?h=3Dnext

Thanks for letting me know, I just applied it.

Maxime
--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcFSswAKCRDj7w1vZxhR
xYUhAQCgnMs/KfGma0n4q8UBRgykbOwd6sV62XQC9vYIV/XaCQEA95H1Cno4U6UO
7b+BJra9M7o+xz4P/Mv6itEuQHmycQM=
=lBwP
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
