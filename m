Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979BA143125
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 18:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgATRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 12:55:57 -0500
Received: from foss.arm.com ([217.140.110.172]:35258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbgATRz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:55:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F30031B;
        Mon, 20 Jan 2020 09:55:56 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E7343F68E;
        Mon, 20 Jan 2020 09:55:55 -0800 (PST)
Date:   Mon, 20 Jan 2020 17:55:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 9/9] ASoC: Intel: Switch DMI table match to a test of
 variable
Message-ID: <20200120175554.GK6852@sirena.org.uk>
References: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
 <20200120160801.53089-10-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ucgz5Oc/kKURWzXs"
Content-Disposition: inline
In-Reply-To: <20200120160801.53089-10-andriy.shevchenko@linux.intel.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ucgz5Oc/kKURWzXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2020 at 06:08:01PM +0200, Andy Shevchenko wrote:
> Since we have a common x86 quirk that provides an exported variable,
> use it instead of local DMI table match.

Acked-by: Mark Brown <broonie@kernel.org>

> -	if (cht_machine_id == CHT_SURFACE_MACH)
> -		return &cht_surface_mach;
> -	else
> -		return mach;
> +	return x86_microsoft_surface_3_machine ? &cht_surface_mach : arg;

but if you're respinning this please replace this with a normal
conditional statement to improve legibility.

--Ucgz5Oc/kKURWzXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4l6akACgkQJNaLcl1U
h9CSpgf+MMjb+D55JRRorEe3BQ4M1I3cFOs+Bj/gzwORglvmHGKTGAvV4lt9Qz3Y
7mOitkpYtKoUpXSAr9xlxfMdYQvEGex599+4KCS76A1gdAjcIOwejaJcq8N88Lnw
s2kogJgt5nteihn7spBaT2scBUCkhwF25jCTjfFDVVgk6vTANDjja0sLL13rg2Rl
0a6fXh5ZSVgmi9ckouFC8b1K2YLBJ0kwSBtONXBvWfttQG8taOfwdNk363e8simL
gR67f8gexPh7rjX3f77QMdlmKx9UPWoeh6IkFVL3LOwJNM8j42mwipTK29++JYaf
G2s1Eo7nbPCkXGnwWzwr5ANfbhqzog==
=KRvr
-----END PGP SIGNATURE-----

--Ucgz5Oc/kKURWzXs--
