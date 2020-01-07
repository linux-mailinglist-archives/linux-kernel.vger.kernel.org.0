Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC78132526
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 12:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgAGLsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 06:48:06 -0500
Received: from foss.arm.com ([217.140.110.172]:56490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgAGLsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:48:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56BC7328;
        Tue,  7 Jan 2020 03:48:05 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7B983F534;
        Tue,  7 Jan 2020 03:48:04 -0800 (PST)
Date:   Tue, 7 Jan 2020 11:48:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] coccinnelle: Remove ptr_ret script
Message-ID: <20200107114801.GB4877@sirena.org.uk>
References: <20200107073629.325249-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20200107073629.325249-1-maxime@cerno.tech>
X-Cookie: Will Rogers never met you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2020 at 08:36:29AM +0100, Maxime Ripard wrote:
> The ptr_ret script script addresses a number of situations where we end up
> testing an error pointer, and if it's an error returning it, or return 0
> otherwise to transform it into a PTR_ERR_OR_ZERO call.

Reviewed-by: Mark Brown <broonie@kernel.org>

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4Ub/EACgkQJNaLcl1U
h9AFuwf/fsXO9OUgtdPDsnD/4fMNSl2/bkAK7o5sd+/TPgPzv/q/IGJ7FcFXwjs6
ONuvBPB+h2paciCSU9VsIfHswdcD96K5sqD/D3h5Ou1rJyccz1sYO16R7q6HSpAD
VpJYOq6vNuMZir1UaIDEnPHwfVZjkfwPWtv8pWA48VfKFvJ8J6GhsrYDmUed71FA
7XXhVWffVr6OJlCDyqdExS3nB8p/xQjymz+VoEA6pGAZhvfOIXdkEuNFP6et9LEa
lI5abF8+hX1e14JsznU08pAJ4PGpsLDpfIyR6pOxbv20Tb+KPIjHALPthTJUEtkh
kz42yOtNeEzHJp33SuP/egBXI6eVJw==
=kvo0
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
