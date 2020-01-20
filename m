Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E936142A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 13:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgATMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 07:22:21 -0500
Received: from foss.arm.com ([217.140.110.172]:59452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgATMWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:22:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6580730E;
        Mon, 20 Jan 2020 04:22:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3AA73F68E;
        Mon, 20 Jan 2020 04:22:19 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:22:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        drinkcat@chromium.org, dianders@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>, mka@chromium.org
Subject: Re: [PATCH] regulator: vctrl-regulator: Avoid deadlock getting and
 setting the voltage
Message-ID: <20200120122218.GC6852@sirena.org.uk>
References: <20200116094543.2847321-1-enric.balletbo@collabora.com>
 <1fdaed3c-05e0-4756-5013-5cc59a766e2f@gmail.com>
 <20200120120830.GA6852@sirena.org.uk>
 <73a24487-d9ff-88c3-2516-69ae89915c88@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <73a24487-d9ff-88c3-2516-69ae89915c88@collabora.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2020 at 01:10:18PM +0100, Enric Balletbo i Serra wrote:
> On 20/1/20 13:08, Mark Brown wrote:

> > Yes, you're right.

> Oops, right, Mark do you want me to send a follow-up patch, a second version or
> you can just apply a fix?

If you send a patch before I get round to writing one myself I'll apply
it.

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4lm3kACgkQJNaLcl1U
h9CQUAf/efsDEbcnnk5BetvKzz/QA1IVZVudBFNlB/IWqG7fpYtpSYX7d8nY2Azl
EA155XqmZKER5AgjeJECocwdiWPCVY+QLWNn3qLTQUGjgnkptF8VHgnidKwCBDTr
M9iAobouq35k1gwV9/Kk53goXywRYdJcLXbZjf35pxRoXqDE/wM5vCfBnEI8Tt5o
gbYMrZPBV+KAEfVgD5rFNKqCw7W51mNik7VUNH6lJYPDysv+IYw8yvM5+rzfWdur
u+JnthUrENxCVHD6qw7Pvuqz6wsfh6eK46b9edAMp2iDQMz+KE9twKIge+RghnlK
2hjL0mYRVz7Cw9R3uNoEtTLOIXQFGA==
=SHV2
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
