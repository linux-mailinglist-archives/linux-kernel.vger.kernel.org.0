Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4C102B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 18:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKSRz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 12:55:29 -0500
Received: from foss.arm.com ([217.140.110.172]:56300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfKSRz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:55:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B41AFEC;
        Tue, 19 Nov 2019 09:55:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FD833F703;
        Tue, 19 Nov 2019 09:55:27 -0800 (PST)
Date:   Tue, 19 Nov 2019 17:55:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     vishnu <vravulap@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, Alexander.Deucher@amd.com,
        djkurtz@google.com, Akshu.Agrawal@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v9 6/6] ASoC: amd: Added ACP3x system resume and
 runtime pm
Message-ID: <20191119175525.GC3634@sirena.org.uk>
References: <1574165476-24987-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1574165476-24987-7-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191119123531.GA30789@kadam>
 <3321478e-de8f-2eb6-6e6f-6eb621b8434b@amd.com>
 <20191119133416.GB30789@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20191119133416.GB30789@kadam>
X-Cookie: Beam me up, Scotty!  It ate my phaser!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2019 at 04:34:16PM +0300, Dan Carpenter wrote:

> There is only one real bug in my review but there is just a lot of clean
> up left.  Can you have a co-worker review your patch before resending?
> The patch 1/6 looks pretty good now but I haven't seen patches 2-5 so
> I'm worried there is a lot of cleanup left to do.

Please, yes - there's a *lot* of fairly minor problems that are coming
up in review each time before I've even had a chance to glance at it.
You might also want to consider looking to make smaller, more
incremental changes towards the goal (eg, refactoring the drivers in
ways that will allow multiple instances more easily) which will be
easier for both you and reviewers to check thoroughly.

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3ULI0ACgkQJNaLcl1U
h9Ag7gf/U42vZmCsRiImxDyr6Xnk82fk8zre1u5yI8CR3chacv0eLrQrkkkO234e
zHI36xZrvJA4M94bSt5XcDni7/TTra84LizttZLTMdOqUpJdnG3L9OPEOREJvsw7
xwsKRDpvkmnQ6pLJrlIMMEDzPzw/IRbqLMKXJ3hXh/3Ze/aPFtOg72SnhdbM7vRq
XNkbwLwP5C3WZ3vvdtKk/7c+n3vK1yM3MwnsXFLUffuraa087YSEsWXUJ/VF4wsf
BAdlxj8K8mxsfabL0PsK1WV5OLdma2vcEE5mUaQGFqloxegWt87yacqTYCzr9XA1
yr4D+He8PBmAyyOSjynCbUsUD4CLmw==
=7Kmu
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
