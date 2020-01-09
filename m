Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9CD135A0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 14:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgAIN2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 08:28:38 -0500
Received: from foss.arm.com ([217.140.110.172]:59016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgAIN2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:28:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7206E31B;
        Thu,  9 Jan 2020 05:28:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEEEF3F534;
        Thu,  9 Jan 2020 05:28:36 -0800 (PST)
Date:   Thu, 9 Jan 2020 13:28:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] regulator: mpq7920: add mpq7920 regulator driver
Message-ID: <20200109132835.GA7768@sirena.org.uk>
References: <20200109112548.23914-1-sravanhome@gmail.com>
 <20200109112548.23914-4-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20200109112548.23914-4-sravanhome@gmail.com>
X-Cookie: Necessity is a mother.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2020 at 12:25:47PM +0100, Saravanan Sekar wrote:
> Adding regulator driver for the device mpq7920.
> The MPQ7920 PMIC device contains four DC-DC buck converters and
> five regulators, is designed for automotive and accessed over I2C.

This doesn't apply against current code, please check and resend.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4XKoIACgkQJNaLcl1U
h9CDdgf/bTjR+dsJEfEA7ydjVkffsHZoIdhND0nuXgydleN4eH2kE05CNTaafAOU
FCs/pTjuZaG6lG4fDc7FglR4NOZxmI32wOpYwwqYjz9NF2EV0pm49tFPYAfvPo3/
i+StQaOspnLdkvEymxxzxISY5Dc6n57pIThIa+R0+HHoKjmOJnpIHvShAM/lD0Lz
TAi0mCwUZWBzkZwG6IpJj7i3PcjshNeDiIzgum/QKyP8405l4PlzqLH0CHNNLoWv
AYn9+xrpViRU1P6RK5b6TBm8UvBTHXNgSfX7JpEKVoAcg8K6fXcjzTUuaA0ZFKt8
PGlX0xcbeeM3FDK35H6wCQrQD8tcng==
=afwH
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
