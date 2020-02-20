Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB81516674F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgBTTkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:40:51 -0500
Received: from foss.arm.com ([217.140.110.172]:50256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgBTTkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:40:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C38530E;
        Thu, 20 Feb 2020 11:40:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5DB73F6CF;
        Thu, 20 Feb 2020 11:40:49 -0800 (PST)
Date:   Thu, 20 Feb 2020 19:40:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas2562: Add support for digital volume control
Message-ID: <20200220194048.GI3926@sirena.org.uk>
References: <20200220172721.10547-1-dmurphy@ti.com>
 <20200220184507.GF3926@sirena.org.uk>
 <de0e8a5b-8c2a-ee04-856f-f0d678a3c66b@ti.com>
 <20200220191803.GH3926@sirena.org.uk>
 <6f3ff810-5e75-cb33-10d6-198a7c5cd202@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Content-Disposition: inline
In-Reply-To: <6f3ff810-5e75-cb33-10d6-198a7c5cd202@ti.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 01:22:34PM -0600, Dan Murphy wrote:
> On 2/20/20 1:18 PM, Mark Brown wrote:

> > decisions causing changes in the driver.  The system may have an
> > external amplifier they prefer to use for hardware volume control, may
> > prefer to do entirely soft volume control in their sound server or
> > something like that.

> But this is an amplifier.=A0 Not sure why the system designer would design
> cascading amplifiers.

> And if that was the case wouldn't you want the output to be low so you do=
n't
> overdrive the ext amplifier front end?

The point is that we don't know what people are doing and should try to
keep the kernel out of policy decisions unless there's something that's
clearly just unconditionaly right for all systems.  It's a lot easier to
just have a clear rule that we defer to the wisdom of the silicon vendor
than try to get into defaults, and it's a lot easier to just do this as
consistently as we can rather than debating individual configuration
changes.

> I was considering safety in that the device is on at full blast (not sure
> why the HW is defaulted that way but it is).

I bet there's been issues with people turning things on and not
realising they need register writes to hear anything, and the volume
control here is a bit complex as well.

> But if volume is adjusted prior to playback then this is not an issue.=A0=
 But
> if volume is not adjusted then it plays full blast.

Wouldn't be the first time.  See all the dual purpose headphone/line
outputs that people build, sensible defaults for headphones and line
outputs are rather different.

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O4L8ACgkQJNaLcl1U
h9A7ywf/a70pEqcaoFyz44HUYWAA/C7/HptVOyj9BF7YOHzPCROQheZtAOnK/irB
NQ/wVoUly0UK4lakCGKSiAOvpqJIQ0XTEWP8KYt/SnA8jTsehWTlJaOlDuotsnOw
e3hQkhBz03kXfyuNO0VdGEbmIivWqb5rgzVykCYo0wS1qSYKFITdIKyK6uvLfDnX
g0l/AQmep2hERqDbM0g+zi8vOtgabdblq2/q93zTwEJidA2C7dpJBs/BpelKxzT1
I3sDvPo3XXCCKdLjiMi6Bp6e9tlZ4qcly412+bMUfCJjCKOYOgH3jsGdG4M87UR+
wvOv3ovPVjWTsSaVrlzJjFPabYYauQ==
=NqJ2
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--
