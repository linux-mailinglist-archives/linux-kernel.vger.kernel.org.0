Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D55136DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 14:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgAJNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 08:25:04 -0500
Received: from foss.arm.com ([217.140.110.172]:44350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgAJNZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:25:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECBB71FB;
        Fri, 10 Jan 2020 05:25:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B233F534;
        Fri, 10 Jan 2020 05:25:02 -0800 (PST)
Date:   Fri, 10 Jan 2020 13:25:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     alsa-devel@alsa-project.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dylan Reid <dgreid@google.com>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: Applied "ASoC: max98090: fix incorrect helper in
 max98090_dapm_put_enum_double()" to the asoc tree
Message-ID: <20200110132501.GA5889@sirena.org.uk>
References: <CGME20200109212932eucas1p17a0066e1b426db3d4fdbd89632ea5130@eucas1p1.samsung.com>
 <applied-20200108115007.31095-1-m.szyprowski@samsung.com>
 <77e524c5-f0a4-1996-2bf5-cbb7395f7c25@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <77e524c5-f0a4-1996-2bf5-cbb7395f7c25@samsung.com>
X-Cookie: A little pain never hurt anyone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2020 at 10:02:05AM +0100, Marek Szyprowski wrote:

> This patch has been applied twice. First time for the=20
> max98090_dapm_put_enum_double() function (as it has been designed),=20
> second time for max98090_put_enum_double(), what is completely wrong=20
> thing (it does exactly the opposite thing).

> Mark, please revert/drop 4e93c1294f4b051d574d6bc59755d2863286990e commit.

OK.  For things like this it's generally easiest to just send a revert
that can be directly applied.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4YeywACgkQJNaLcl1U
h9Ah3wf+MDyukWg0tVh436KwxdTsrwn1OucKLb64Ll1MS9U38t0GcpHyTfqsPAjT
4Y0mSanevxLyrIvGotqI9ISf1bHiFuhGq5EhfZ3TdROPUfet4153XmLguVDA0hyg
y96Re9MuyvkMvhq9jGtTQoqTXGt90ajnsMEk6LxmdScADs3bzXyyEN2PxLUSCnAo
1tOKL4qjjKzFNvhgo7aoMXFjmitGhRMgi+bFEz3WAzVvEXSYPKAMeXAlyNgNtJKV
cF5lTQ36gBQuHoPAfdbnCzGyTRqkFGf9//9rYMFUf6rqZKzpwhPfFlL4O9cbNNQb
UYm2/wAGzp78Zc1i4ejmMUZC84K1+w==
=EG91
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
