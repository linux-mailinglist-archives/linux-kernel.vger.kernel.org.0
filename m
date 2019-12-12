Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9611011D2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 17:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfLLQxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 11:53:16 -0500
Received: from foss.arm.com ([217.140.110.172]:53366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbfLLQxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:53:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 884F830E;
        Thu, 12 Dec 2019 08:53:13 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0452F3F6CF;
        Thu, 12 Dec 2019 08:53:12 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:53:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        guennadi.liakhovetski@linux.intel.com, tglx@linutronix.de,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm8962: fix lambda value
Message-ID: <20191212165311.GK4310@sirena.org.uk>
References: <1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com>
 <20191212164835.GD10451@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Content-Disposition: inline
In-Reply-To: <20191212164835.GD10451@ediswmail.ad.cirrus.com>
X-Cookie: We have DIFFERENT amounts of HAIR --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2019 at 04:48:35PM +0000, Charles Keepax wrote:
> On Wed, Dec 11, 2019 at 07:57:22PM +0800, Shengjiu Wang wrote:
> > According to user manual, it is required that FLL_LAMBDA > 0
> > in all cases (Integer and Franctional modes).

> How well tested is this change, and is it addressing an issue you
> have observed? I agree this does better fit the datasheet just a
> little nervous as its an older part that has seen a lot of usage.

I've got a feeling that requirement might've been added in later
versions of the datasheet...

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3ycHYACgkQJNaLcl1U
h9CUewf9HCpR8m1farmmx9Se1np+I9L3i4ncQb8j5AD1UGgSmhZMsNze4JTk6oWA
9DT0aL69PsnCxrYL8gV8CMy0vJPKhLg3+nRQvb1aVsRPBbWbtFQkSZA4YJ/xnmuu
lC7PGYlGH7XM2z8QU7XwRsZQVwZ183+1QF4srp4w+VSCDtTku8I4nHzVzCOvGMaF
3T8dZQkGZ642sYUA3ZZCBRfVJOKIE/JsEQYLTksyOLqIAhjzvg31uyT+P1GnvZjV
iD7C8zj22PjiICoEhOFk+0KpLcb38763CCxC7jF4Z3prrNY+jV0ExukK4VfG3vCh
67xrgyK5Y7JF8tUgkZ5Zu9c9/ulLZQ==
=q6x7
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--
