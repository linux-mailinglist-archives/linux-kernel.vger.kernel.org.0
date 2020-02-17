Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E4161598
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 16:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgBQPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 10:09:39 -0500
Received: from foss.arm.com ([217.140.110.172]:37066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbgBQPJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:09:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D841630E;
        Mon, 17 Feb 2020 07:09:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B7BA3F703;
        Mon, 17 Feb 2020 07:09:37 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:09:35 +0000
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
Subject: Re: [RFC PATCH 08/34] ASoC: sun8i-codec: Fix direction of AIF1
 outputs
Message-ID: <20200217150935.GJ9304@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-9-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4vpci17Ql0Nrbul2"
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-9-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4vpci17Ql0Nrbul2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 12:42:24AM -0600, Samuel Holland wrote:
> The naming convention for AIFs in this codec is to call the "DAC" the
> path from the AIF into the codec, and the ADC the path from the codec
> back to the AIF, regardless of if there is any analog path involved.

This renames widgets but does not update any DAPM routes from those
widgets which will break things if this patch is applied.

> Cc: stable@kernel.org

Why is this suitable for stable?  It's a random textual cleanup.

--4vpci17Ql0Nrbul2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KrK8ACgkQJNaLcl1U
h9Ab9Af/b8sQj3zwynBYYxusscd9/aduwhw7qF+DAdPBw6PYNIA/g/Ts6oULrx9/
F9O4MHo55RlwYbfi8iuyYJ8LpLv4y7txkM5x5y5oauIL+soV6TB8bszuwBvk5jHu
qMxAhPDo6mD2D1QYL7GJeWvid+lBr7MGrlzbxg+0uW1jEw3pEJjXL4WTXu0e2l4T
cTZ4Am744vhS15WDE0s/wJSvB2rxPn6xVVi93LtdEE9+YgE4lE9Y7ruezZibMFQb
hrTkWC0l92y8sbIkHpAzlo5gh5qNn6UahJRlr+wCILtXuEJMgPEEmx0DoTciwQUr
su1mRVq9kOQOtpw4mjBq3iDo8MiP3A==
=UkmS
-----END PGP SIGNATURE-----

--4vpci17Ql0Nrbul2--
