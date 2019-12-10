Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8180F1187E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 13:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLJMRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 07:17:13 -0500
Received: from foss.arm.com ([217.140.110.172]:42144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfLJMRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:17:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0051FB;
        Tue, 10 Dec 2019 04:17:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578DD3F6CF;
        Tue, 10 Dec 2019 04:17:11 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:17:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs42l42: add missed regulator_bulk_disable in
 remove and fix probe failure
Message-ID: <20191210121709.GC6110@sirena.org.uk>
References: <20191206075209.18068-1-hslester96@gmail.com>
 <20191209162417.GD5483@sirena.org.uk>
 <CANhBUQ0zwQG-=C12v02cf5kfvJba=5_=0JkZA45DDhxOzTBY6A@mail.gmail.com>
 <20191209170030.GH5483@sirena.org.uk>
 <CANhBUQ0-jEG2W=sby1SyPphxK3CSPinFF5zkLq9jsKCZM5hYjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <CANhBUQ0-jEG2W=sby1SyPphxK3CSPinFF5zkLq9jsKCZM5hYjw@mail.gmail.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 09:32:12AM +0800, Chuhong Yuan wrote:
> On Tue, Dec 10, 2019 at 1:00 AM Mark Brown <broonie@kernel.org> wrote:

> > There's also the case where runtime PM is there and the device is active
> > at suspend - it's not that there isn't a problem, it's that we can't
> > unconditionally do a disable because we don't know if there was a
> > matching enable.  It'll need to be conditional on the runtime PM state.

> How about adding a check like #ifndef CONFIG_PM?
> I use this in an old version of the mentioned patch.

That won't handle the runtime PM problem, the state will vary depending
on what the system is doing at the time.

> However, that is not accepted since it seems not symmetric with enable
> in the probe.
> But I don't find an explicit runtime PM call in the probe here so the
> revision pattern of

It's got runtime PM ops though so that's clearly a bug that needs to be
fixed itself.

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3vjMUACgkQJNaLcl1U
h9AAoAf+K6J1r4btG9IR3em9HyPA3E/jMnx1YBRDo2CJwTZfUe8rMyqJPl98cYs8
OJMbc+4U2Q2aJjjYNvLzFWwGJAA48tf4BitK3hxGRwQDK3rolg1Xb+eVEqVToLOi
CQyZj5j5lvH3ZS6fSJitXTZYcgSN4jbVCoPRiG4aK7IKUMeXgcLEOb6WJIN3RDvz
oJzATwyxtvjIIHiM9DpKVkAuoltOtdM1ofmMpRTbqyN/s42Oa1BgFf3tgXp/l5GY
zqOLaz+1BsiADE2Yhs2q5PbzgBpeG5QfWWXykKAtByqTgau9StyQHGBG8eYt1YW1
E4y4Eguf5CGRV+9Kwxl6KsgFnycxTQ==
=EXTv
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
