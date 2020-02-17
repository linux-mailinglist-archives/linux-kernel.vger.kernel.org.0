Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B0B1614E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 15:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgBQOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 09:43:25 -0500
Received: from foss.arm.com ([217.140.110.172]:36560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgBQOnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:43:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A28BC30E;
        Mon, 17 Feb 2020 06:43:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 257A83F703;
        Mon, 17 Feb 2020 06:43:24 -0800 (PST)
Date:   Mon, 17 Feb 2020 14:43:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [RFC PATCH 02/34] ASoC: sun8i-codec: LRCK is not inverted on A64
Message-ID: <20200217144322.GE9304@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-3-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 12:42:18AM -0600, Samuel Holland wrote:

> +	scodec->inverted_lrck = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +

This is going to break the moment someone finds another quirk for some
variant of this device, it's not scalable.

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KpokACgkQJNaLcl1U
h9ALhQf+KpZMG6XlWXOf5M+RQbrrlJ7G6eHlAz9WNWS6pBlAdaLNxekgK+nHQJos
xgRQQ+WfRPwkVwkQqQ78pknN7GNtJA47rvXZskBUGBiYErsA8awxR7NQ0MdVgHt7
IER95dS+HOIU9qzfu/qXPJzL7FYmNiBgxG2766bd5rboIqr3GXhAsYa7phl3XPZo
HBwmnZ8DP2xN4op0fRBwZ/L855fSoATnNyoSPMabDa530WwUYyiUk+2BXYk8TaRB
Ck+OXm50qHCp8JHXoQox+uQzIyqVjtjp4czaGJeMlHQ+7ocwLa8ltTMkCfDUlzU6
zdaJIgMVGilYkB59EaFQL0UQ8j1TmA==
=ggb0
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
