Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30C5127B65
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 13:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfLTM7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 07:59:10 -0500
Received: from foss.arm.com ([217.140.110.172]:50578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfLTM7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:59:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B29330E;
        Fri, 20 Dec 2019 04:59:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC6383F719;
        Fri, 20 Dec 2019 04:59:08 -0800 (PST)
Date:   Fri, 20 Dec 2019 12:59:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ASoC: gtm601: add Broadmobi bm818 sound profile
Message-ID: <20191220125907.GD4790@sirena.org.uk>
References: <20191219210944.18256-1-angus@akkea.ca>
 <20191219210944.18256-2-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20191219210944.18256-2-angus@akkea.ca>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2019 at 01:09:43PM -0800, Angus Ainslie (Purism) wrote:

> @@ -37,7 +37,7 @@ static struct snd_soc_dai_driver gtm601_dai = {
>  		.channels_max = 1,
>  		.rates = SNDRV_PCM_RATE_8000,
>  		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> -		},
> +	},
>  	.capture = {

This is an unrelated indentation change.

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl38xZoACgkQJNaLcl1U
h9C4ZAf8CQJRsBBKW1r/HN9qrSPlWJ/8y2yShT5u/Q46IsjSr2ENsv3ljkkC9BIv
ioX2h5Y/ikx7RJy5rVYwrp2anG97WNnfXu8I9OfIlvjBfDKoxg99HwmJQWL7niqh
VS/rxHQyEPIyvaDaDT6wKF+gYZpvlCQaYLi6DRhYQxZzhLo72tWrDvvr8604bOn4
aJqd0Enqf716cNuRGkYQLNkQd4565oA50kxybbJoRaiYedLR+lnvcAPQvGfpV9CL
g/owmDglgQj3oDOSgw4F4iSRNVohxf0CncQMoCGmWPLpuzw5Z0n1OU+Idfwqv08j
E/Na+edk3JFuBsoEQ+zqRmhqyaDACw==
=ximh
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
