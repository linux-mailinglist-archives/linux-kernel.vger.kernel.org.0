Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1F117252
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfLIRAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 12:00:33 -0500
Received: from foss.arm.com ([217.140.110.172]:38564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfLIRAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:00:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 418FA1FB;
        Mon,  9 Dec 2019 09:00:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B39F33F6CF;
        Mon,  9 Dec 2019 09:00:31 -0800 (PST)
Date:   Mon, 9 Dec 2019 17:00:30 +0000
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
Message-ID: <20191209170030.GH5483@sirena.org.uk>
References: <20191206075209.18068-1-hslester96@gmail.com>
 <20191209162417.GD5483@sirena.org.uk>
 <CANhBUQ0zwQG-=C12v02cf5kfvJba=5_=0JkZA45DDhxOzTBY6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Content-Disposition: inline
In-Reply-To: <CANhBUQ0zwQG-=C12v02cf5kfvJba=5_=0JkZA45DDhxOzTBY6A@mail.gmail.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 12:52:30AM +0800, Chuhong Yuan wrote:

> I have a question that what if CONFIG_PM is not defined?
> Since I have met runtime PM before in the patch
> a31eda65ba21 ("net: fec: fix clock count mis-match").
> I learned there that in some cases CONFIG_PM is not defined so runtime PM
> cannot take effect.
> Therefore, undo operations should still exist in remove functions.

There's also the case where runtime PM is there and the device is active
at suspend - it's not that there isn't a problem, it's that we can't
unconditionally do a disable because we don't know if there was a
matching enable.  It'll need to be conditional on the runtime PM state.

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3ufa0ACgkQJNaLcl1U
h9BFrgf+KMBI9l2Ruzln5WCg+/ELdsLj2dDgAlFZSOigICoPdgNnXzqk8gYIZxsb
5y5Q4mUcWncbjNq7PuWG/ddIonFPKyPhKb/h/xrdgbTPfqqEekryLHW93SS+sAiG
mLktyFWuPyvZOifDWfaFwYc1jzwsslgOweJOEoOw+fofsPlxe/3R8oom4zfpwdDV
KUUxIC5hEKjUfPTpOVdw+7Ud7JpFm7uR1qtd6LptcIOb+UO7FPm6EQhrkl0thiGd
fKGcPx/t3f/Xjn23+Nw3WmV+gSUX9t6wqsouwWB83Capsb4N3SMw7HFOPcy0S5vV
rB45x3AzVSeKCCSIKs1IywlYcsUO7w==
=feWL
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
