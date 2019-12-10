Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9024811892E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 14:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLJNIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 08:08:07 -0500
Received: from foss.arm.com ([217.140.110.172]:43582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfLJNIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:08:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68BFA328;
        Tue, 10 Dec 2019 05:08:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D28A73F52E;
        Tue, 10 Dec 2019 05:08:02 -0800 (PST)
Date:   Tue, 10 Dec 2019 13:08:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     Olivier Moysan <olivier.moysan@st.com>, mgalka@collabora.com,
        enric.balletbo@collabora.com, khilman@baylibre.com,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        Brian Austin <brian.austin@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>
Subject: Re: broonie-sound/for-next bisection: boot on rk3399-gru-kevin
Message-ID: <20191210130801.GF6110@sirena.org.uk>
References: <5def94e7.1c69fb81.2751f.190a@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Content-Disposition: inline
In-Reply-To: <5def94e7.1c69fb81.2751f.190a@mx.google.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 04:51:51AM -0800, kernelci.org bot wrote:
>     ASoC: cs42l51: add dac mux widget in codec routes
>    =20
>     Add "DAC mux" DAPM widget in CS42l51 audio codec routes,
>     to support DAC mux control and to remove error trace
>     "DAC Mux has no paths" at widget creation.
>     Note: ADC path of DAC mux is not routed in this patch.

This doesn't seem right, as far as I can see this device is not present
on that board (it uses some Realtek and Maxim devices AFAICT).  Is it
some sort of timing thing?

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3vmLAACgkQJNaLcl1U
h9DAzwf/Vl72koOz78QabTLK3qKjJ8J8uxgv87Zxb3NykzHxogKhBYdzFKfA0EpV
xqY1oCamb7cgAnfGFc8t2WAGC6jhqCZZxmHUQCh74Iy1rh7vJxg2NhuPhAzn6TZX
S6iprOJsY2QAFVpLJfHmC/Yl55EGihn22H/CO+PaspbCuyGPc2TwwTxnyLQeqFCx
r1PojQwIdk3VJSTZf4GOfd8ufsPM7K4psVJbtoKCQ3xXkre1j2CszTPv4jso1tGw
W9YR5uLNxS3rjueAJI56FBNYV48WK3rq9hVgyx9Z5Tc9cynx93aO5cu9n5Midy7W
lmaqK3rj9MbjHWjhIHmbteP634uwHA==
=okLz
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--
