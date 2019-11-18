Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B66D1008D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 17:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfKRQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 11:01:15 -0500
Received: from foss.arm.com ([217.140.110.172]:36402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfKRQBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:01:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14A32DA7;
        Mon, 18 Nov 2019 08:01:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7802F3F703;
        Mon, 18 Nov 2019 08:01:13 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:01:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        kuninori.morimoto.gx@renesas.com, linus.walleij@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bindings: sound: pcm3168a: Document optional RST gpio
Message-ID: <20191118160111.GH9761@sirena.org.uk>
References: <20191113124734.27984-1-peter.ujfalusi@ti.com>
 <20191113124734.27984-2-peter.ujfalusi@ti.com>
 <20191118130855.GE9761@sirena.org.uk>
 <5f824119-9b5b-5ad2-6915-d174f9cca8af@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ecMC0kzqsE2ddMN"
Content-Disposition: inline
In-Reply-To: <5f824119-9b5b-5ad2-6915-d174f9cca8af@ti.com>
X-Cookie: no maintenance:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ecMC0kzqsE2ddMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 18, 2019 at 04:46:26PM +0200, Peter Ujfalusi wrote:
> On 18/11/2019 15.08, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.
> > Look at what existing commits in the area you're changing are doing and
> > make sure your subject lines visually resemble what they're doing.
> > There's no need to resubmit to fix this alone.

> What would be the appropriate subject line for
> Documentation/devicetree/bindings/sound

> Oops, I have missed the dt- prefix for the bindings for sure.

I prefer ASoC: but yeah, you missed dt-.

--3ecMC0kzqsE2ddMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3SwEYACgkQJNaLcl1U
h9CqAQf/TzsDc61IPhX0l9gJTpyxpHP8aQwigm4y1DNpSWUcdHEoR0vSssiPAnLw
Pt2g9bSvrdUGiSEn9IkUGt4yWiCT0RyGUWSTsQ7/k78PCzGyGLrThmRRWnNu7s2b
qE7hGNfTMk6oThsMz03ytkIaZl40PJSopNCJHs5h73hkYkBWTZfSDW0XORUPrgYt
g5hx0bZJtYgwziZi05dFEW3KCpdaVSbyTZgULXAlVSpOhUbfcJpBl2K1rNcp1Opk
2KeKaWTJ59RxiEf9s32kFVxsKv9jXky55sMk6DrW8+Uwu98sZG/78xNrqXPu0T0d
pN4DN87GEqlrihD347osS1BBopRKNQ==
=fktM
-----END PGP SIGNATURE-----

--3ecMC0kzqsE2ddMN--
