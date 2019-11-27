Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73F510AF97
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 13:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfK0MdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 07:33:21 -0500
Received: from foss.arm.com ([217.140.110.172]:47118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfK0MdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:33:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3B9C30E;
        Wed, 27 Nov 2019 04:33:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70AFC3F6C4;
        Wed, 27 Nov 2019 04:33:19 -0800 (PST)
Date:   Wed, 27 Nov 2019 12:33:17 +0000
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
Message-ID: <20191127123317.GA4879@sirena.org.uk>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
 <20191120152406.2744-7-sebastian.reichel@collabora.com>
 <AM5PR1001MB0994720A0D615339A978E35C804E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <AM5PR1001MB0994E628439F021F97B872D480450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126170841.GC4205@sirena.org.uk>
 <AM5PR1001MB09949D557742E8817545637F80450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126175040.GD4205@sirena.org.uk>
 <AM5PR1001MB09940CF764711F1F13A6B37E80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB09940CF764711F1F13A6B37E80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: In the war of wits, he's unarmed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2019 at 11:32:54AM +0000, Adam Thomson wrote:

> As I said it's a small thing and requires a specific use-case to occur, but
> having the PLL configured twice for the very first stream in that scenario
> seems messy. Regarding the SYSCLK approach you mention, I'm not clear how that
> would work so I'm obviously missing something. If we had some init stage
> indication though that auto PLL was required then we're golden.

There's a bunch of other drivers using the SYSCLK thing, when you call
set_sysclk() they provide a different SYSCLK number if they want to use
manual mode.  If there's a concern about drivers doing stuff on init you
could always ask them to set the PLL during init, even if only briefly.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3ebQoACgkQJNaLcl1U
h9BDaQf/ZAlgmS17icedamvRKebKOojZ+VtpiJMgMsOiLs1eMu10rJm/6XiCT5sh
dvPRA9mGno4nal5L/s8UHj3CFPkHSYqPGI/uwY4Gf4Ek2B9cyMHiW3ht1MozjcDH
I2QMxZxMhqHCf1p5a8fh+2jlyFfwC8lpluRg57rLT5PTdb27MBbrshYHlPuuxKtk
p7U1irpsbnO6iW3CAp9N8kIc996SItJ7230JQCHXdLJ0X773ekOLQTSb5Ypn0Y/f
kD+NRNoggRWJ70XZqm3DwMQRdGIW33IWR/nS+W0ncP93hfneMjYpp4byZ+BGWOwy
CozlfXK15fWw/kq+9Gw1LGWv9CKSxw==
=thrJ
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
