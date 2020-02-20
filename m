Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C617E166702
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgBTTSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:18:06 -0500
Received: from foss.arm.com ([217.140.110.172]:49920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbgBTTSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:18:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 474ED30E;
        Thu, 20 Feb 2020 11:18:05 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACD463F6CF;
        Thu, 20 Feb 2020 11:18:04 -0800 (PST)
Date:   Thu, 20 Feb 2020 19:18:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas2562: Add support for digital volume control
Message-ID: <20200220191803.GH3926@sirena.org.uk>
References: <20200220172721.10547-1-dmurphy@ti.com>
 <20200220184507.GF3926@sirena.org.uk>
 <de0e8a5b-8c2a-ee04-856f-f0d678a3c66b@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline
In-Reply-To: <de0e8a5b-8c2a-ee04-856f-f0d678a3c66b@ti.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 12:46:57PM -0600, Dan Murphy wrote:
> On 2/20/20 12:45 PM, Mark Brown wrote:

> > Is there a reason not to use the chip default here?  Otherwise this
> > looks good.

> Chip default is set to 0dB full blast+ 0x40400000.=A0 This sets the volum=
e to
> -110dB.

OK...  that's a policy decision the same as all other volume changes and
so shouldn't be done by the driver - as ever we don't know how the
system is set up and what values make sense and keeping things out of
the driver means we don't end up with competing system integration
decisions causing changes in the driver.  The system may have an
external amplifier they prefer to use for hardware volume control, may
prefer to do entirely soft volume control in their sound server or
something like that.

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O22oACgkQJNaLcl1U
h9BNnAf/STD8X1meBVMym8n0PChi4jx1nA4QyPkwc1x8USlqaoWsz3QHBi7Q6H37
OG5YcO02ATyyjTe0rCZVKgyQUQ7Bmtw2bWRhNS3KH3HL90f0/kgu4K84i0UJ6psr
wfnDq2dItRwnq/EEwburkJom8ZJac9dii3HfF7jsafA1PoWgEdCy2pCY6liTfUNS
GzbqXIuXTIG25A6oHG7HE8489gPuC57XRapoGUyQ3gIj+ems8EwEAUkqVIA3symp
+6ZO2qTqhA+ArEuOptlxpjVLoNcQfddeJ/jwBZZQtCa2h/cwSVmzcfOorbznBmp9
KshHMzn9Z/sa+dmi0twVgXHv9mtEJQ==
=YOPj
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
