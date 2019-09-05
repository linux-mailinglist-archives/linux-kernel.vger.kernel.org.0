Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27732AAA8B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 20:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbfIESGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 14:06:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47228 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388822AbfIESGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bjhBgn/hu4sBX3UF8vmjwc0zdzuNyTJ7pUGOwliYdOc=; b=p7jUDGlXDe3A/y79FGALT/xcU
        iN849LCtT7DwcUsiVXQT7PP9H7NoBfRhvNSCN5UbGsGNM4XCvgMMOU41EwbYBOsGZRUdXGW7Bbryh
        Tapwa2dMrSWw1IR+Pt5MVCXzZGfOp3/TQb5S6/d7p+jiMBN76391ukY6EV/uh8jDQQ0Ck=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5w9A-0005Tm-H8; Thu, 05 Sep 2019 18:06:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 90F1D2742D07; Thu,  5 Sep 2019 19:06:15 +0100 (BST)
Date:   Thu, 5 Sep 2019 19:06:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luka Pivk <luka.pivk@toradex.com>
Subject: Re: [PATCH 1/3] regulator: fixed: add possibility to enable by clock
Message-ID: <20190905180615.GG4053@sirena.co.uk>
References: <20190903080336.32288-1-philippe.schenker@toradex.com>
 <20190903080336.32288-2-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline
In-Reply-To: <20190903080336.32288-2-philippe.schenker@toradex.com>
X-Cookie: You humans are all alike.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 08:03:46AM +0000, Philippe Schenker wrote:
> This commit adds the possibility to choose the compatible
> "regulator-fixed-clock" in devicetree.
>=20
> This is a special regulator-fixed that has to have a clock, from which
> the regulator gets switched on and off.

This seems conceptually fine.  Minor issues though:

> +static int reg_clock_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct fixed_voltage_data *priv =3D rdev_get_drvdata(rdev);
> +
> +	if (priv->clk_enable_counter > 0)
> +		return 1;
> +
> +	return 0;
> +}

This could just be return priv->clk_enable_counter > 0 - ideally the
clock API would let us query if the clock is enabled but that might be a
bit confused anyway given that it's possibly shared.

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1xTpYACgkQJNaLcl1U
h9AsqAf/caqc82p8eTjLhI9qV1ov43qSU0Lx+x0l1/34fodrmhwX+985ieiCqPdK
YcQ+SBMd4NxLjLcIW7g6JNEhl7jK9Rf/JCdFqzTfLwH5PtuU9N7/NSkDVnHJT+Il
7vZxg1enEl9P7kopxqGJeWD9TIdwrLbLTrHeT+k65BfrXkYZqdCFwgRySuA2bJv1
ReQyGwWgKs9dHDKvFOcMUuFN8NII62VgdZ3v5nhNVtzsBqDjDpId9rk/2HhTUB6O
Cxandr5b4mTQ2E2XZ4zNY++IFnMACM+Jk82jFpbaBX6faVMdJnb2TobZt2C+pGOp
xTpfGM2727C2Yx2TU0BTn9qgDEHuNg==
=FHl0
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
