Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2991361E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 21:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgAIUiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 15:38:22 -0500
Received: from foss.arm.com ([217.140.110.172]:36560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbgAIUiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:38:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9236331B;
        Thu,  9 Jan 2020 12:38:21 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 188F03F534;
        Thu,  9 Jan 2020 12:38:20 -0800 (PST)
Date:   Thu, 9 Jan 2020 20:38:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Annaliese McDermond <nh6z@nh6z.net>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1] ASoC: tlv320aic32x4: handle regmap_read error
 gracefully
Message-ID: <20200109203819.GG3702@sirena.org.uk>
References: <20191227152056.9903-1-ps.report@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <20191227152056.9903-1-ps.report@gmx.net>
X-Cookie: Killing turkeys causes winter.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 27, 2019 at 04:20:56PM +0100, Peter Seiderer wrote:
> @@ -338,7 +338,8 @@ static unsigned long clk_aic32x4_div_recalc_rate(struct clk_hw *hw,

>  	unsigned int val;

> -	regmap_read(div->regmap, div->reg, &val);
> +	if (regmap_read(div->regmap, div->reg, &val))
> +		return 0;

Is this the best fix - shouldn't we be returning an error here?  We
don't know what the value programmed into the device actually is so zero
might be wrong, and we still have the risk that the value we read from
the device may be zero if the device is misprogrammed.

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4XjzoACgkQJNaLcl1U
h9BsYwf9FFgKoSbL5lC50mSEVqCPZLbUHO3dBKRJnmTHcEUvNS5eWPVNpH+cT04y
JmhyR9UvkDd0uD8uGILu33O7WQB2p+0vL++3ZNHxmiuPahdDQIsU4LSOd1KxECjK
0CUOK7TRBEhrsDtzGRJASf+1DO8GRqs5abAjTRAkFPBG4mVUtDmPrIaaqxdrS8IG
QX2WU53Ee3PidUrDbmVFC7LOxN93YlujLBKhuWwVuD2IvIfzYGmDPIsmUAvKX8wD
/+cVC0PrjVec5we3himey5e5o1BwfO8IUK6Fshea6548M90d/oQCioPjxKvLjvNc
B/udO2IZjDYCm1uIFshxEGTtGtQlQw==
=A/xb
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
