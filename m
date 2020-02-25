Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9670C16C271
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 14:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgBYNfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 08:35:30 -0500
Received: from foss.arm.com ([217.140.110.172]:50914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgBYNf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:35:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02919328;
        Tue, 25 Feb 2020 05:13:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A2713F703;
        Tue, 25 Feb 2020 05:13:53 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:13:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
Cc:     "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH] ASoC: fsl: Add generic CPU DAI driver
Message-ID: <20200225131351.GC4633@sirena.org.uk>
References: <20200128144707.21833-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20200128144707.21833-1-daniel.baluta@oss.nxp.com>
X-Cookie: Booths for two or more.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 02:47:30PM +0000, Daniel Baluta (OSS) wrote:

> 	* clocks
> 	* power domain management
> 	* pinctrl
>=20
> For this reason we introduce a generic FSL DAI driver which will take
> care of the resources above.
> ---
>  sound/soc/fsl/Kconfig   |   8 ++
>  sound/soc/fsl/Makefile  |   2 +

This lacks a signoff, see submitting-patches.rst for details on what
this is and why it's important.

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5VHY8ACgkQJNaLcl1U
h9Bkggf+NFc15zsjS4QIV2DaUxkaJIlR+ksXVdjPkbwv+8e8jUttvHfZb+6Nd8L+
OUWXDup5SA6MGYW8HPAswswWPX8N/6ghjq72h1QTter2dDZ+qXRBsqOwrmnddf8k
384jTkaXxpDzN/Nv5DJ2z6/Oh7rKqJy8LW15f4Affj8Qy/QqgpPFP5jIse0DrpoM
hh8XphYn54t0BLQD67koCMSbRp1BNlJZ9OPXaZGlqZMYmNcUT1D9jcOSV4YJ9JYJ
+aF4nMjYmtM/rrqKmAfNjoo2ZT7X9iKeH7KvkQ8fVAPRog8nOXvJ+rlCWj/uWI1X
Vl1lYz4ZZ9wC0WH/esPGP1vHyL7gYw==
=Fd6l
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
