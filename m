Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB8E10A391
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 18:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKZRuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 12:50:44 -0500
Received: from foss.arm.com ([217.140.110.172]:37558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfKZRun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:50:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E74AB30E;
        Tue, 26 Nov 2019 09:50:42 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CC813F52E;
        Tue, 26 Nov 2019 09:50:42 -0800 (PST)
Date:   Tue, 26 Nov 2019 17:50:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCHv2 6/6] ASoC: da7213: Add default clock handling
Message-ID: <20191126175040.GD4205@sirena.org.uk>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
 <20191120152406.2744-7-sebastian.reichel@collabora.com>
 <AM5PR1001MB0994720A0D615339A978E35C804E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <AM5PR1001MB0994E628439F021F97B872D480450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126170841.GC4205@sirena.org.uk>
 <AM5PR1001MB09949D557742E8817545637F80450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB09949D557742E8817545637F80450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: Where's SANDY DUNCAN?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2019 at 05:39:45PM +0000, Adam Thomson wrote:
> On 26 November 2019 17:09, Mark Brown wrote:

> > If we're special casing simple-card we're doing it wrong - there's
> > nothing stopping any other machine driver behaving in the same way.

> Ok, what's being proposed here is for the codec to automatically control =
the PLL
> rather than leaving it to the machine driver as is the case right now. In=
 the
> possible scenario where this is done using a card level widget to enable/=
disable

Wasn't the proposal to add a new mode where the machine driver *could*
choose to delgate PLL selection to the CODEC driver rather than do so
unconditionally? =20

> the PLL we will conflict with that using the current suggested approach f=
or the
> da7213 driver, albeit with no real consequence other than configuring the=
 PLL
> twice the first time a stream is started. It's a case of how to determine=
 who's
> in control of the PLL here; machine driver or codec?

The patch looked like the idea was that as soon as the machine driver
configures the PLL the CODEC driver will stop touching it which looked
like a reasonable way of doing it, you could also do it with an explicit
SYSCLK value (which would have to be 0 for generic machine drivers to
pick it up) but this works just as well and may even be better.  Perhaps
I misread it though.

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3dZfAACgkQJNaLcl1U
h9CwfAf/YV/EIozE9EzDMFY5bhh24HCl54wOPeRj11gAdUc9Dgos5WcUBUp1OKGF
fMWwffNUQQ6pttjnObQRNpgbEYALQbgmriiDqKa6l7m/jBgm0vaXtF+rdbyHEt7Z
VGEZcUDDUYjL3lYLHpmCMIxuON1NceLHNn6UjNWc3ukHuKOZTDVKANSoAiskfvuH
dpcZX/A6I71lUtLq54+uVGh28k7/5cOL2sE/syHjQyA25LcH71hjFVhaByUcx8EC
AjV8phIVnDYDzwAQhrz0MfXCySpsaq0oPNWHkr9S4d4RZvVaqI5DFVVRGxUivZOM
auolGphSGFR7UvpNFLu9qItUxlTZxA==
=SdHM
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
