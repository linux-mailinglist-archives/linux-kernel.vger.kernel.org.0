Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF8B1618D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgBQRax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 12:30:53 -0500
Received: from foss.arm.com ([217.140.110.172]:39088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbgBQRax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:30:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC091FB;
        Mon, 17 Feb 2020 09:30:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DD893F68F;
        Mon, 17 Feb 2020 09:30:52 -0800 (PST)
Date:   Mon, 17 Feb 2020 17:30:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Sameer Pujar <spujar@nvidia.com>, tiwai@suse.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [RFC] ASoC: soc-pcm: crash in snd_soc_dapm_new_dai
Message-ID: <20200217173050.GT9304@sirena.org.uk>
References: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
 <20200217144120.GA243254@gerhold.net>
 <20200217154301.GN9304@sirena.org.uk>
 <20200217171245.GA881@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ceuyUbi+oA5bUa/n"
Content-Disposition: inline
In-Reply-To: <20200217171245.GA881@gerhold.net>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ceuyUbi+oA5bUa/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2020 at 06:12:45PM +0100, Stephan Gerhold wrote:

> This does the swapping you mentioned, so I guess rtd->dai_link->params
> is only set for the codec2codec case?

Yes, that's the idea.

> From my limited understanding, I would say that a much simpler way to
> implement this would be:
>=20
> But I'm really not familar with the codec2codec case and am unable to
> test it :) What do you think?

I think that looks reasonable from just looking at the e-mail without a
context diff and you should submit a patch so others can test!

--ceuyUbi+oA5bUa/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KzckACgkQJNaLcl1U
h9BziAf+Izx20KRsb99onN4hjg2gDkeh3TMcutoOsbRYWWFaMSJOZ9Fq+lHXbuIq
0Qx4gzYh6jMLzvOPDY4BDyzSmcmE/7nAsAhNguMyc936iDrxG/K66Mq7sDX8oL45
YRWofbhaO4GvVtlpz1hxcrLrVVR9B3a2XreUqqmZQM2jLZCwgPtU0xALL/IDEwyb
VL/OCGwh3GfX3DTmsarJCj3tUlwKcvN9QdS5p4KQvH1q18D9O9nd/I0ykSrkbjPt
6wN2fEAxsfbHRoEbfmGZ3kCXVe7pxLRGiCe13e3ea17uv/Z9u95bHgBRIJVNEcSV
MX62HJ6YUZFKc/aAcg2f6BBGnaYpXQ==
=BVkC
-----END PGP SIGNATURE-----

--ceuyUbi+oA5bUa/n--
