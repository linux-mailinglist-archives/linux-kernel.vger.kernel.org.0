Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53ED1346C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgAHP6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:58:23 -0500
Received: from foss.arm.com ([217.140.110.172]:46506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbgAHP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:58:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C863131B;
        Wed,  8 Jan 2020 07:58:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51A6D3F534;
        Wed,  8 Jan 2020 07:58:22 -0800 (PST)
Date:   Wed, 8 Jan 2020 15:58:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: Add an entry for Monolithic Power
 System, MPS
Message-ID: <20200108155820.GB4036@sirena.org.uk>
References: <20200108131234.24128-1-sravanhome@gmail.com>
 <20200108131234.24128-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20200108131234.24128-2-sravanhome@gmail.com>
X-Cookie: My vaseline is RUNNING...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2020 at 02:12:31PM +0100, Saravanan Sekar wrote:

>    "^mitsubishi,.*":
>      description: Mitsubishi Electric Corporation
> +  "^mps,.*":
> +    description: Monolithic Power Systems, Inc.
>    "^mosaixtech,.*":

This isn't sorted properly, since someone else already added MPS in the
correct place I'll just drop this.

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4V/BwACgkQJNaLcl1U
h9By3wf/YYMc9sjiEySnW17B8F3RVOkg5bgEkSuVhF/8h0kW0tIn0tOEezWbrj7f
sfbwrQS1Wi8tAMhDcSzCTXWUHImnaFZ++X46xm0K818/GBS0Dj3lt5LGUBfS3XVS
wYB6TH0g75fcqlnAPIu8QVgaN7NZeyjpCpwkQ+qCuPGKTyCUjrazLIbrUVZVwPqu
nrOwtiqEtU1qhQcshzXavIa+XlqkdGkR3iW0TzLYvxdzpZtHNTMGnZL2vAt8lIXg
355T7ykJ7DzvQwpSg6CrOTuFEAeiCAMWBxm4rnkMoEHabc+fHYdIP5E4yTDLf364
3l9KPT6h6uWNcXsdAISI2JtCqR4BkQ==
=4QhW
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
