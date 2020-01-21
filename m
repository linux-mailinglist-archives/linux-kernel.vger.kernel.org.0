Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F63C1442A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 17:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgAUQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 11:59:27 -0500
Received: from foss.arm.com ([217.140.110.172]:45946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgAUQ71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:59:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38E9230E;
        Tue, 21 Jan 2020 08:59:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABA9D3F6C4;
        Tue, 21 Jan 2020 08:59:26 -0800 (PST)
Date:   Tue, 21 Jan 2020 16:59:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: Fix for Subsequent Playback issue.
Message-ID: <20200121165925.GH4656@sirena.org.uk>
References: <1579603421-24571-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <1579603421-24571-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: You too can wear a nose mitten.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2020 at 04:13:35PM +0530, Ravulapati Vishnu vardhan rao wrote:

> If we play audio back to back, which kills one playback
> and immediately start another, we can hear clicks.
> This patch fixes the issue.

>  	/* Disable ACP irq, when the current stream is being closed and
>  	 * another stream is also not active.
>  	 */
> +	kfree(rtd);

This free looks like a separate change which seems good and useful but
should be in a separate patch?

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4nLewACgkQJNaLcl1U
h9B1+gf8CwB3aqHMAKHEgAHRutMujXPYif+JPjkD1gl9Cp8EFmrOkjwAO8ADVa3U
IhZonqAQvpX8nuRp2yq+GMTn0M3wKQHrZ8SZzFoY2az5dujgpV9shBrcSRAQa+vM
rnYexlnHXPlr/FFYHhcSlqPFgglHcZLJUIuioBk3OxoPrlXxnAcbhBP9zCpSZex3
mMwT3vlLmOTlhHkBhWNDGH7l3z5dd8N43iFMNCQP8zMEwggCkEPC4IYrLidXVORb
YE7fkOtRgRKJQhDjKN7QaH8XRSbbGdGK+9FthNOJXteCkp/VkU2ne7Mt0etqKDa/
ulqij1ZBM43yKQAhB8WIdYCQIw7oYw==
=m2Ma
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
