Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24DA177CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 18:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgCCRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 12:10:52 -0500
Received: from foss.arm.com ([217.140.110.172]:50014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbgCCRKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:10:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 925202F;
        Tue,  3 Mar 2020 09:10:51 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 128593F534;
        Tue,  3 Mar 2020 09:10:50 -0800 (PST)
Date:   Tue, 3 Mar 2020 17:10:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] regulator: anatop: Drop min dropout for bypass mode
Message-ID: <20200303171049.GI3866@sirena.org.uk>
References: <1583245476-8009-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HkMjoL2LAeBLhbFV"
Content-Disposition: inline
In-Reply-To: <1583245476-8009-1-git-send-email-Anson.Huang@nxp.com>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HkMjoL2LAeBLhbFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2020 at 10:24:36PM +0800, Anson Huang wrote:
> Some of anatop regulators support bypass mode, and in bypass mode,
> minimum dropout is NOT required, the input voltage will be equal to
> the output voltage. The minimum dropout value is ONLY necessary for
> LDO enabled mode, so drop the minimum dropout for bypass mode to
> avoid unexpected high voltage output from PMIC supplies.

The goal makes sense but I don't think it makes sense to do this in the
driver - changing this without the core knowing is likely to lead to
confusion at some point and also I think this behaviour is likely to be
the same for every regulator that has a bypass mode (at least if it
isn't I'm kind of confused about how it's bypassing, usually the minimum
drop is a function of maintaining regulation).  Could you look into
doing something like this in the core instead please?

--HkMjoL2LAeBLhbFV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5ej5gACgkQJNaLcl1U
h9C23gf/bha+BF8TIeD6hPRVh2Doz2kjJKrak1meqLCpkFllt0K4GL9QHSddTmgb
vrjGFu5CFPdnY9nTE7cAI53PqzGkkl8jOICNxPmXFRmHnddTVkRVpYohC2DV2CIJ
Z0sSsrEfR7Y0lsddsLs/4zF8g5kZOhmp+3RyqJPdtu5dZsIaLRxcaoj0BDpYPFtK
QC8N1Ef3S5XZdnWioputBbLaEa/4Rq9WTjo6wCb87zRkFs1mIRpEXtXbnLfrPJ3V
nKjUmEZpsmxNyBJw6HIlHM8OibaLlzpzwA+6r5geDOiiXtODom3rcW0BmCOn4iQa
8Fkq/y5fKW3tq2xOWn49Uz006me3Mg==
=gqK6
-----END PGP SIGNATURE-----

--HkMjoL2LAeBLhbFV--
