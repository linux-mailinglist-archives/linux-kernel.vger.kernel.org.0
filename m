Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56215DDF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 09:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfEGHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 03:06:32 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57519 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfEGHGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:06:32 -0400
X-Originating-IP: 90.88.149.145
Received: from localhost (aaubervilliers-681-1-29-145.w90-88.abo.wanadoo.fr [90.88.149.145])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0696C240010;
        Tue,  7 May 2019 07:06:18 +0000 (UTC)
Date:   Tue, 7 May 2019 09:06:17 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v2] arm64: allwinner: h6: orangepi-one-plus: Add Ethernet
 support
Message-ID: <20190507070617.h7loqiqvznqvvprq@flea>
References: <20190503115928.27662-1-jagan@amarulasolutions.com>
 <20190503144651.ttqfha656dykqjzo@flea>
 <CAMty3ZCQTiX5OvCG_uMRS02vFu0c1-bkcyauLD6oaFcd=y3RNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7mpr5huweraqfrmv"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCQTiX5OvCG_uMRS02vFu0c1-bkcyauLD6oaFcd=y3RNA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7mpr5huweraqfrmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2019 at 03:03:15PM +0530, Jagan Teki wrote:
> On Fri, May 3, 2019 at 8:16 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, May 03, 2019 at 05:29:28PM +0530, Jagan Teki wrote:
> > > Add Ethernet support for orangepi-one-plus board,
> > >
> > > - Ethernet port connected via RTL8211E PHY
> > > - PHY suppiled with
> > >   GMAC-2V5, fixed regulator with GMAC_EN pin via PD6
> > >   GMAC-3V, which is supplied by VCC3V3-MAC via aldo2
> > > - RGMII-RESET pin connected via PD14
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Your commit log should be improved. We can get those informations from
> > the patch itself...
>
> Thought it was a clear commit log :)  will update anyway.

Well, yes and no. The commit log is clear indeed, but it doesn't
provide what it's supposed to provide.

You shouldn't put *what* is being done by the patch. That's pretty
easy to figure out by reading the patch itself. You have to explain
why and how you did it, which is lacking in that case.

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7mpr5huweraqfrmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXNEuaQAKCRDj7w1vZxhR
xd1dAQCZ8mdMU1ntN71QprlJOvmZ6QM+Lac9lUEn0g7MW9XFtQEApmogSNh+xobJ
9r8QAM1TQtC15u9UPFQcjEOQBoc1iww=
=Vt2l
-----END PGP SIGNATURE-----

--7mpr5huweraqfrmv--
