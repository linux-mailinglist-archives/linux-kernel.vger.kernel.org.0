Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4B14679C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 13:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAWMJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 07:09:31 -0500
Received: from foss.arm.com ([217.140.110.172]:38672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWMJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:09:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BBC5328;
        Thu, 23 Jan 2020 04:09:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01673F6C4;
        Thu, 23 Jan 2020 04:09:30 -0800 (PST)
Date:   Thu, 23 Jan 2020 12:09:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND 1/2] regulator: arizona-ldo1: Improve handling of
 regulator unbinding
Message-ID: <20200123120929.GB5440@sirena.org.uk>
References: <20200122110842.10702-1-ckeepax@opensource.cirrus.com>
 <20200122131149.GE3833@sirena.org.uk>
 <20200123092639.GC4098@ediswmail.ad.cirrus.com>
 <20200123114805.GA5440@sirena.org.uk>
 <20200123120240.GD4098@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20200123120240.GD4098@ediswmail.ad.cirrus.com>
X-Cookie: ((lambda (foo) (bar foo)) (baz))
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2020 at 12:02:40PM +0000, Charles Keepax wrote:

> I am more than happy to do the leg work if we really don't like
> this solution. Do either you or Lee have any thoughts on my
> selective MFD remove helpers? That seemed like the most promising
> alternative solution to me.

That's my first thought if you need to control removal order which is
basically what's going on here.

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4pjPgACgkQJNaLcl1U
h9Di+wf/QzyKud67CmftD46xQMkjZjkU2gbmqkitDbuJOuipbmsdSUHDVq5cNPkz
u4ziJUNrR73n6DTevWU4mslN0TaSJM6kFrd0DWWn6+uZpcUTB7fNITZv3K85H9Tj
tIHFqy07S/fOxJjdVUZab2sBkh8d3q6BbbDubAN+EZOHghg0pA3horGAOOLMg3aA
mR5Wlawv7VJDSfgOuFCG4J2fTohNC6zxwuczacO/SjOtxssUJkvRZHscIC6CqBmG
xsN9mRn/qZIzw6BDI8r8YhCRYcvslOnFQKCg0TiM3ejwog2uof0OYHpxo4WzTBVL
074WnIkvGca7/WuEj4ICJ32K5Bn16Q==
=L8iY
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
