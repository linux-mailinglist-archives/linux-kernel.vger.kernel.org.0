Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D41F914A861
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA0QzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:55:05 -0500
Received: from foss.arm.com ([217.140.110.172]:47064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgA0QzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:55:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08D0431B;
        Mon, 27 Jan 2020 08:55:05 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BC103F67D;
        Mon, 27 Jan 2020 08:55:04 -0800 (PST)
Date:   Mon, 27 Jan 2020 16:55:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for v5.6
Message-ID: <20200127165502.GB3763@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
X-Cookie: Hangover, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/r=
egmap-v5.6

for you to fetch changes up to ea87683909bcda665527a828505c5e9c6a625429:

  Merge branch 'regmap-5.6' into regmap-next (2020-01-21 17:29:48 +0000)

----------------------------------------------------------------
regmap: Updates for v5.6

This is quite a busy release for a subsystem that's usually very quiet,
though still a small set of updates in the grand scheme of things:

 - A fix for writes to non-incrementing registers.
 - An iopoll() style helper for use with atomic safe regmaps, making
   it easier to transition from raw memory mapped I/O.
 - Some constification.

----------------------------------------------------------------
Ben Whitten (1):
      regmap: fix writes to non incrementing registers

Mark Brown (1):
      Merge branch 'regmap-5.6' into regmap-next

Micha=C5=82 Miros=C5=82aw (1):
      regmap-i2c: constify regmap_bus structures

Sameer Pujar (1):
      regmap: add iopoll-like atomic polling macro

 drivers/base/regmap/regmap-i2c.c | 10 ++++-----
 drivers/base/regmap/regmap.c     | 17 ++++++++++-----
 include/linux/regmap.h           | 45 ++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 62 insertions(+), 10 deletions(-)

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4vFeYACgkQJNaLcl1U
h9CqhAf/R4qrFykqQUwBD+KND29uIWV8L5ZcQHJmOSIVG+soXg8or77KupkIOfGu
xqvNIc28AZKc29vLKPHyi4GlmvMCzGTjLmZHQ3EKQN3jkHd8IwZSFDIwBz/5Xoni
uiDTqBakNFn3uuJ6sih8SD6BTN8DwGErZgCYF/H2acp5pbI0LUJsroWGus/zuDbz
SPAIowto5JMACvfjaEHXGekezoQUUNFar036fRgDsG8jr+H94yUvYK4tziAYFUME
tbO0f9Ftl7dCV3KhMXSZuxaxuRu66axUG6XeSG7dt8JkTU5A4BRptGTPF2jml2eb
8x8Hqq0327Yg1qBdyWHolj+XzLi3Ug==
=gI53
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
