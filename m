Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D8D161546
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgBQO4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 09:56:52 -0500
Received: from foss.arm.com ([217.140.110.172]:36802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgBQO4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:56:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E63430E;
        Mon, 17 Feb 2020 06:56:51 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E733B3F703;
        Mon, 17 Feb 2020 06:56:50 -0800 (PST)
Date:   Mon, 17 Feb 2020 14:56:49 +0000
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
Subject: Re: [RFC PATCH 03/34] arm64: dts: allwinner: a64: Fix the audio
 codec compatible
Message-ID: <20200217145649.GF9304@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-4-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 12:42:19AM -0600, Samuel Holland wrote:

> Cc: stable@kernel.org
> Fixes: ec4a95409d5c ("arm64: dts: allwinner: a64: add nodes necessary for analog sound support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

>  		codec: codec@1c22e00 {
>  			#sound-dai-cells = <0>;
> -			compatible = "allwinner,sun8i-a33-codec";
> +			compatible = "allwinner,sun50i-a64-codec";

This is an incompatible change in the ABI, it's going to break unless
it's applied at exactly the same time as the matching kernel update
adding the new compatible string.  That's not suitable for stable, you
need to keep the old compatible as a fallback.

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KqbAACgkQJNaLcl1U
h9CYUAf/ZCOyWpSkn3x5uej3JtTUW/4RmXdnFa/ZOH/PjJuGXBCc7m4ZbP2jo5t2
2XdicNuPW5JUz9kmdxNzfeyUOYprNoheZyy/5i1u8EM9Br/zyszZFkMoApsLKSdF
qPUhK51OvntU8eb4DFQAswJFw6HmKfGImygfRHvHSax37e5srjBSosR5ZeJv7lQO
ZyP3iUjWXb9b8P/akkgxhQRpGkugDsrqx4oXSzKCzsj3kMpw6rE7yWXS9rQSVoaw
amPYSjsE4prqOnOlHfR0/y+dU6HJGHfWIWZqeNIEXK+gf1flqLmqxlpwCNnFCtn0
8rreEBr8qPilxVdhA7LpTMvLOCE8Jw==
=uWDR
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
