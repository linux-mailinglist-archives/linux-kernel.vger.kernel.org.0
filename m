Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3626B15BDCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 12:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgBMLit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 06:38:49 -0500
Received: from foss.arm.com ([217.140.110.172]:45430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbgBMLit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:38:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EC491FB;
        Thu, 13 Feb 2020 03:38:48 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D795B3F6CF;
        Thu, 13 Feb 2020 03:38:47 -0800 (PST)
Date:   Thu, 13 Feb 2020 11:38:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/4] ASoC: simple-card: Add support for codec-to-codec
 dai_links
Message-ID: <20200213113846.GB4333@sirena.org.uk>
References: <20200213061147.29386-1-samuel@sholland.org>
 <20200213061147.29386-5-samuel@sholland.org>
 <1jpneialqa.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <1jpneialqa.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Academicians care, that's who.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 10:18:53AM +0100, Jerome Brunet wrote:
> On Thu 13 Feb 2020 at 07:11, Samuel Holland <samuel@sholland.org> wrote:

> > +- codec-to-codec			: Indicates a codec-to-codec
> > dai-link.

> I wonder if such property could be viewed as a Linux implementation
> detail ?

Yes, it is.

> Should the card figure out the codec-to-codec links on its own or is it
> something generic enough to put in DT ?

We should be able to figure it out by ourselves, we already have a link
between two CODECs - we should be able to infer that it is in fact a
link between two CODECs with the information we already have, probably
by looking at the two devices that are referenced.

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5FNUUACgkQJNaLcl1U
h9AQ3Af/XaLbts6WjJP/3bk73GDv0QmGgaskQL8b6m1D39K+JlBEpJFtRFU8dbwI
lRAtiipudev/YrYxB1zTgCbspo7bZ+p9X+lKGs3duT/Mbu/S19AJXn1oczaI9bSr
ry8cckwgoWfaT5KEgf32ZKhLPL2RYOGUfxK8YD3V2SVj74QapjdY3S4cOWFYCGSy
G9RP0+ReSirSQ9p4MFiA3zxj5lLgNHnCoMkVrIUktLtLfbE9T6vyW0eZhc0+9wXC
td2NQln5v755wOwxzGvfZ0hmO1Zil4FZEoCCdGT/izv7joqZaB18lG/XVlBCHQbn
Sm25vTaxFqSe2wL3vQlqmRW5BEYsTQ==
=eGwg
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
