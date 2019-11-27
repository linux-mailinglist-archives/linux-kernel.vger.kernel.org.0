Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDF310B3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 17:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfK0QlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 11:41:19 -0500
Received: from foss.arm.com ([217.140.110.172]:50000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbfK0QlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:41:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B6B30E;
        Wed, 27 Nov 2019 08:41:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201213F68E;
        Wed, 27 Nov 2019 08:41:17 -0800 (PST)
Date:   Wed, 27 Nov 2019 16:41:16 +0000
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
Message-ID: <20191127164116.GE4879@sirena.org.uk>
References: <AM5PR1001MB0994720A0D615339A978E35C804E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <AM5PR1001MB0994E628439F021F97B872D480450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126170841.GC4205@sirena.org.uk>
 <AM5PR1001MB09949D557742E8817545637F80450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126175040.GD4205@sirena.org.uk>
 <AM5PR1001MB09940CF764711F1F13A6B37E80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191127123317.GA4879@sirena.org.uk>
 <AM5PR1001MB0994D842A2D7051F81A7765B80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191127154030.GD4879@sirena.org.uk>
 <AM5PR1001MB099467ACADA4F7B6DDA5087480440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB099467ACADA4F7B6DDA5087480440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: In the war of wits, he's unarmed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2019 at 04:33:12PM +0000, Adam Thomson wrote:
> On 27 November 2019 15:41, Mark Brown wrote:

> > Not sure I follow here - if we're configuring the PLL explicitly then
> > I'd expect the PLL to be configured first, then the SYSCLK, so I'd
> > expect that the automatic PLL configuration wouldn't kick in.

> The PLL in the codec relies on MCLK. The MCLK rate can be specified/configured
> by a machine driver using the relevant codec sysclk function, as is done in a
> number of drivers. Surely that has to happen first before we configure the PLL
> as the PLL functions needs to know what rate is coming in so the correct
> dividers can be applied for the required internal clocking to match up with the
> desired sample rates. I guess I'm still missing something regarding your
> discussion around SYSCLK?

The PLL configuration specifies both input and output clock rates (as
well as an input clock source) so if it's got to configure the MCLK I'd
expect the driver to figure that out without needing the caller to
separately set the MCLK rate.

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3epysACgkQJNaLcl1U
h9Ah8Af+Jkfk+6DCF4lg0qjlDTkm9J28Cp9C51qea8Lkj15D3QYxiCSIngIkcLDK
84eJfTaOnIjDYOj8bMovS/ZNY/JlsT46Vq8tJ2fPnyy/ihAM9CwKeGjprpv6voik
JZZ3pStVuiu3l7tVBLoaDLGCITJPuV1pqeq+bZtbHs8Axdx9xyG2MF1iAWo9lgDw
YpiNzRe6AESbGV8Pun6PTdBa8rktnOiTyixjLaiUC/WnUAxqXkHw/dHMWjOtYfwk
PMc6a5y4lCHqvEM+x4g3gE2Z0B+wCjpDd71c6qWIxyyzYLNL0geN6ogF91EVVyVO
xoBoNjYno2poQcDELx6VE77/8mFKWw==
=g6G7
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
