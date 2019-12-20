Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1E127B72
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 14:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLTNBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 08:01:46 -0500
Received: from foss.arm.com ([217.140.110.172]:50616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfLTNBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 08:01:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8912130E;
        Fri, 20 Dec 2019 05:01:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068FD3F719;
        Fri, 20 Dec 2019 05:01:44 -0800 (PST)
Date:   Fri, 20 Dec 2019 13:01:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ASoC: gtm601: add Broadmobi bm818 sound profile
Message-ID: <20191220130143.GF4790@sirena.org.uk>
References: <20191219210944.18256-1-angus@akkea.ca>
 <20191219210944.18256-2-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <20191219210944.18256-2-angus@akkea.ca>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 01:09:43PM -0800, Angus Ainslie (Purism) wrote:

>  static int gtm601_platform_probe(struct platform_device *pdev)
>  {
> +	struct snd_soc_dai_driver *dai_driver;
> +
> +	dai_driver =3D of_device_get_match_data(&pdev->dev);
> +

I was going to apply this but it causes build warnings:

sound/soc/codecs/gtm601.c: In function =E2=80=98gtm601_platform_probe=E2=80=
=99:
sound/soc/codecs/gtm601.c:83:13: warning: assignment discards =E2=80=98cons=
t=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
  dai_driver =3D of_device_get_match_data(&pdev->dev);
             ^

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl38xjYACgkQJNaLcl1U
h9Df9gf/RXeLC/iEcTjvaaWh2UqB0phzyy+OHv9wXcopbWJ0trlsSZ9OfjI4keLj
/SQlaeT4FyfDcNOaRH2npIrvNnjrnN5WAIQps3EZHDIaFzaPXeQt3bgOmrLQIVIt
sQCsJEiC7U6ZKf4R6KBux/PX7rfO2q0Wd5RSuCEoFHBOECd0L3imZhCTaLhw34I0
b3woQI/+BCbnNXMQiwmiXqYWT6Ak4LpCfIRevMPbvVli2lp98fc9M+ldCGjnrQ5K
AU2h1gS326XiacrjDGiqO5II8eD3cQWm7RPF+c4Nqm+dj8PgwHhcMnYluwKPNIcn
FOGmQ5BDpr2lt82gvh2NFTcNAUBlxQ==
=gbI3
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
