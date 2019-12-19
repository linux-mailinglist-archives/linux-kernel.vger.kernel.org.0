Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B6E12633A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 14:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLSNP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 08:15:58 -0500
Received: from foss.arm.com ([217.140.110.172]:38664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfLSNP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:15:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9FC5328;
        Thu, 19 Dec 2019 05:15:57 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D56373F67D;
        Thu, 19 Dec 2019 05:15:56 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:15:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     vishnu <vravulap@amd.com>
Cc:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, Alexander.Deucher@amd.com,
        djkurtz@google.com, pierre-louis.bossart@linux.intel.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Tabian, Reza" <Reza.Tabian@amd.com>
Subject: Re: [PATCH v14 7/7] ASoC: amd MMAP_INTERLEAVED Support
Message-ID: <20191219131554.GF5047@sirena.org.uk>
References: <1575553053-18344-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1575553053-18344-8-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <3688990f-0ac3-08bf-20b8-93a4ab17441e@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <3688990f-0ac3-08bf-20b8-93a4ab17441e@amd.com>
X-Cookie: I smell a RANCID CORN DOG!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 11:59:56AM +0530, vishnu wrote:
> Hi Mark,
>=20
> Patches have been reviewed by Dan and pierre-louis.bossart@linux.intel.com

I see no reviewed-by tags on most of this.

> Please can you upstream these please.

No, I will review them first.  Given the problems that have been seen on
previous reviews I don't intend to rush that.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl37eAkACgkQJNaLcl1U
h9CVpAf+K32nHGUcXJWEpJjWpcGVQiWjEjbsF9z+jhCBspPCGKsl08RI1cXbo87P
/OjYMebtkwJqflBz5c947lIF2SA9ofMD6uu4y+C5/JfaSDkz2XtRElnRNQq568rz
CsuEikfk3MDeZ8atNXGeh/U/qT5QnJT/9pjUSTiQv0E1dn/fnke715mrjuMLuGGa
WSfl5qgHp7mOF5rGb63PcI4pWK0vo+fs8X+pbOOrR1+IluSE6qSU1aqdggo/4mTA
rzGDIb2FyaMSmhL5muM4atXu02VHkosSZ4Ae9nqY8rWQta9a2tkKyzF+rqJmJTjd
CfpApBIsMtlhkNb4gQ/rAPtXJBkrAQ==
=XtBZ
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
