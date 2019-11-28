Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F47B10C864
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 13:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfK1MLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 07:11:32 -0500
Received: from foss.arm.com ([217.140.110.172]:34504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfK1MLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:11:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D810C30E;
        Thu, 28 Nov 2019 04:11:30 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559613F6C4;
        Thu, 28 Nov 2019 04:11:30 -0800 (PST)
Date:   Thu, 28 Nov 2019 12:11:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Andrew F. Davis" <afd@ti.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add HP output driver pop reduction
 controls
Message-ID: <20191128121128.GA4210@sirena.org.uk>
References: <20191128093955.29567-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20191128093955.29567-1-nikita.yoush@cogentembedded.com>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2019 at 12:39:55PM +0300, Nikita Yushchenko wrote:

> +static const char * const hp_poweron_time_text[] = {
> +	"0us", "15.3us", "153us", "1.53ms", "15.3ms", "76.2ms",
> +	"153ms", "304ms", "610ms", "1.22s", "3.04s", "6.1s" };
> +
> +static SOC_ENUM_SINGLE_DECL(hp_poweron_time_enum, AIC31XX_HPPOP, 3,
> +	hp_poweron_time_text);
> +
> +static const char * const hp_rampup_step_text[] = {
> +	"0ms", "0.98ms", "1.95ms", "3.9ms" };
> +
> +static SOC_ENUM_SINGLE_DECL(hp_rampup_step_enum, AIC31XX_HPPOP, 1,
> +	hp_rampup_step_text);

I'm not seeing any integration with DAPM here, I'd expect to see that so
we don't cut off the start of audio especially with the longer times
available (which I'm frankly not sure are seriously usable).

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3fuW8ACgkQJNaLcl1U
h9D+5Qf/QFKjJasickPKQCEdE/PrbvW/Mm+6dtmuvmnV9hvdQeCMwT37eyE3TFlE
+hlqcPYoBxVuscGPCTbS+PgplsAB7++PcLBp1gQwcrU3FGg/kbOQiF0AeV/8456X
hJD1fdSlIMnzV5QXMbKz0iAO6G2uxLJUHreXOGybQS3PYvFFplPs/2Sog4GIcnWt
94QrFkgRVccIIjVDCbisZngy1WK919xWYrQDCdg/MGKJiCKENfqUuwKSck6Cy+Z6
GDMCaDw9PNCCfeYW27GIt1DKqrdcL97+J29WsXqTxqth8WOwEM/UmpuMtvhX2nip
/4l2Iu4vwMmdpgsGwcLLJs+pPbi4Lg==
=bIgM
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
