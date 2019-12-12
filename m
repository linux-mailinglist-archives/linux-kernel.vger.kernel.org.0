Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4AA11CCC2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 13:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfLLMGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 07:06:08 -0500
Received: from foss.arm.com ([217.140.110.172]:44422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfLLMGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:06:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A3F81FB;
        Thu, 12 Dec 2019 04:06:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0726D3F718;
        Thu, 12 Dec 2019 04:06:06 -0800 (PST)
Date:   Thu, 12 Dec 2019 12:06:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeff_chang@richtek.com
Subject: Re: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Message-ID: <20191212120605.GA4310@sirena.org.uk>
References: <1576148934-27701-1-git-send-email-richtek.jeff.chang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <1576148934-27701-1-git-send-email-richtek.jeff.chang@gmail.com>
X-Cookie: We have DIFFERENT amounts of HAIR --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2019 at 07:08:54PM +0800, Jeff Chang wrote:
>     The MT6660 is a boosted BTL class-D amplifier with V/I sensing.
>     A built-in DC-DC step-up converter is used to provide efficient
>     power for class-D amplifier with multi-level class-G operation.
>     The digital audio interface supports I2S, left-justified,
>     right-justified, TDM and DSP A/B format for audio in with a data
>     out used for chip information like voltage sense and current
>     sense, which are able to be monitored via DATAO through proper
> ---
>  sound/soc/codecs/Kconfig  |   14 +

You've not provided a Signed-off-by so I can't do anything with this,
please see submitting-patches.rst for an explanation of what that is or
why it's important.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3yLSoACgkQJNaLcl1U
h9CfvQf+OwqaS6opHAx708EXSW3weHgQ0koD3aM3Ti2vyAWlAztKo1uyctXylitF
tyVzUCsBptcVFwwkhCYncnk/VzS3vz0NvWg9D7yNrfCE8Vc9IIhuqk9g4V10PmyU
KALFmhFVlK+J68pBpdln63KeqmBcuAO9EkNq7B3D28SVXZkb1Q35nIQFRmCOXsd2
zmmlFzZzSBV8L6RLLPcXHmfFfiOhsebyzgz/eE4e+l2diJAH1khhnko9JX5EaDq9
WGdnsm4QUiEOk1Vgg6c7PLRheaeupPapijBxIRualBZSNewoaKveKxcPoGZrZaC0
i4WjYS7UJY6DqBHdh5yG31iOcgvjJw==
=KCrs
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
