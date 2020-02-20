Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED8BD166682
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 19:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgBTSpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 13:45:10 -0500
Received: from foss.arm.com ([217.140.110.172]:49440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgBTSpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:45:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA4B130E;
        Thu, 20 Feb 2020 10:45:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7B63F6CF;
        Thu, 20 Feb 2020 10:45:08 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:45:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas2562: Add support for digital volume control
Message-ID: <20200220184507.GF3926@sirena.org.uk>
References: <20200220172721.10547-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline
In-Reply-To: <20200220172721.10547-1-dmurphy@ti.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 11:27:21AM -0600, Dan Murphy wrote:

> +	/* Set the Digital volume to -110dB */
> +	ret = snd_soc_component_write(component, TAS2562_DVC_CFG4, 0x00);
> +	if (ret)
> +		return ret;
> +	ret = snd_soc_component_write(component, TAS2562_DVC_CFG3, 0x00);
> +	if (ret)
> +		return ret;
> +	ret = snd_soc_component_write(component, TAS2562_DVC_CFG2, 0x0d);
> +	if (ret)
> +		return ret;
> +	ret = snd_soc_component_write(component, TAS2562_DVC_CFG1, 0x43);
> +	if (ret)
> +		return ret;

Is there a reason not to use the chip default here?  Otherwise this
looks good.

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O07IACgkQJNaLcl1U
h9DAjQf/cHDeWkaSRl4OHbk2bFU+NNUeICiEs7d2VmUuNe3pOWY4jw6w2tx/LGZ0
s0Ikm3/e6VYxuCqbUND6kIbzypru4df7TSoxV8nR5/5vM1mbVGKh1/zB2pURJ0M3
ZY1fEqA2gZLpdyJD1HwryukT7PnyhzbK1ACp+cnvdI8W6X2sV/7pIe/W33EvuHj7
BrxixQa7E3SGdOa0MM7014WUsOhcuh7KPjKswKH9j/hKNGYlLB0FI02qFFUR0fkT
1aFocXH34YKqP2NDRyDSY/0yijWTlf02Sa0kDgaIgTrOrwjBAtNkj1QwgSVbT477
s9fpTvqt7E5DAudi/+TK2YsORkI5JQ==
=Q0Wc
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--
