Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF0108E65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 14:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKYNEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 08:04:15 -0500
Received: from foss.arm.com ([217.140.110.172]:50204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfKYNEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:04:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2116131B;
        Mon, 25 Nov 2019 05:04:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 938833F68E;
        Mon, 25 Nov 2019 05:04:14 -0800 (PST)
Date:   Mon, 25 Nov 2019 13:04:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap update for v5.5
Message-ID: <20191125130413.GB4535@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
X-Cookie: -- Owen Meredith
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.5

for you to fetch changes up to a20db58f3e6e6770362614c488e5426f972de97e:

  regmap: regmap-w1: Drop unreachable code (2019-11-19 13:09:20 +0000)

----------------------------------------------------------------
regmap: Update for v5.5

Just one patch for this release removing some dead code.

----------------------------------------------------------------
Mika Westerberg (1):
      regmap: regmap-w1: Drop unreachable code

 drivers/base/regmap/regmap-w1.c | 4 ----
 1 file changed, 4 deletions(-)

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3b0UwACgkQJNaLcl1U
h9DVwwf+Nwsm3rs1WPy0nWRvj3TTpwzk8o6gMYu3J9t9WMZugeaMT/A1hp4k3l0Y
+tV8wP/WJ9Ch1R34v5VTeXmgf9jB6Gvv1ZJkaDhVg2zrhLA9qquuIT8bHt054j4J
XvxOqN9edGnAZbO7fQ7LKM4Kkxqj4xgZfio3g0MVoU1650vr1vFR6arQQUOlc5iZ
A0+ugJ9wsIdh0u6xSzxzCjf7ern1xAp4QsFG7DzTym5EsYtCdgnVVw6saCKTzgGR
J9h/xzHB0bdMFmq3dOVgNJqV8XpAdLjRiPzuaG8s/RUODNRv5f8oJT/QSvgJf3PH
SkcOFzIHtA2RQzYCTlwwrFQUUZBBNA==
=Yk8/
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
