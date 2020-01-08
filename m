Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF31343EF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 14:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgAHNgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 08:36:11 -0500
Received: from foss.arm.com ([217.140.110.172]:44654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgAHNgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:36:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AF3831B;
        Wed,  8 Jan 2020 05:36:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 253813F703;
        Wed,  8 Jan 2020 05:36:10 -0800 (PST)
Date:   Wed, 8 Jan 2020 13:36:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: Re: [PATCH] regmap: add iopoll-like atomic polling macro
Message-ID: <20200108133608.GB3817@sirena.org.uk>
References: <1578392889-16587-1-git-send-email-spujar@nvidia.com>
 <20200107120902.GC4877@sirena.org.uk>
 <ae119533-6966-157a-d14b-365306907554@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <ae119533-6966-157a-d14b-365306907554@nvidia.com>
X-Cookie: Trouble always comes at the wrong time.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2020 at 10:20:37AM +0530, Sameer Pujar wrote:

> While checking the documentation on snd_soc_dai_ops, it appears trigger() is
> in atomic context.
> This means I cannot use regmap interface (with default configuration) in
> trigger().
> The above issue went away with usage of regmap_read_poll_timeout_atomic()
> and now I think I just got lucky.

It's fine if your regmap is set up to support atomic use (using a flat
or no cache and MMIO) but not for regmaps in general, I'm asking you to
document the fact that it's only usable with some regmaps.

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4V2scACgkQJNaLcl1U
h9DyyQf+LRcDvu8nJIgo56AfloLDZvisdiVJj7IrHeWoTCRS9c1x+UZUP70TNT6z
U8jW6z/jfA0AjReMQygFjd6K+3qAlfl3A/7EdFIb2oIv8xhW89KOhEIG2gp0ai57
bID5m+17D34TDlaCbzVgR5jAapB34UzAK6Okv1VjbeTgAXvEhUbbPYPgNbF2WVB7
Sz8KTR4CVfHPNN3UVh/9PBkrbEx5ndgBhAyjf00iffGfisbtUJ2WoHWd06VuUAmW
MlUxoi4kSwbgx+yd9L1gq+TOcCYqrCiW/8b2UubQ/xEe4hOM6i8SvMKbtuViORIa
W9nhfZ/Ki+3VjeiMnh+n2/XUVY4ndw==
=8PIN
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
