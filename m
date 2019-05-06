Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB4A14BA5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEFORd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 10:17:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEFORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=okr7F/afGL+GHrlf9E7+rCz+2b34y7Hll8aDPJEnwHw=; b=TIvvIxxuteVrvtZD7RpM9qQdO
        wEKyCOsX55oXqAhLbG1aVEiHbRXh0BEheLf0R7OJX/Ow8wWrBttjdsC3ylhRBkbYh8xHwNXSqbynK
        i2fbXyA58QkfRNBpcHLr0YKkt3MFAEqpwuj/1xYQke/t7J8fvKuEpnGLbdVyGf+gUR1eg=;
Received: from kd111239184067.au-net.ne.jp ([111.239.184.67] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNeQs-0001nP-Bx; Mon, 06 May 2019 14:17:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F40AB44000C; Mon,  6 May 2019 15:17:25 +0100 (BST)
Date:   Mon, 6 May 2019 23:17:25 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for v5.2
Message-ID: <20190506141725.GS14916@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KI6XeYrntNhU1GwB"
Content-Disposition: inline
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KI6XeYrntNhU1GwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.2

for you to fetch changes up to 615c4d9a50e25645646c3bafa658aedc22ab7ca9:

  Merge branch 'regmap-5.2' into regmap-next (2019-04-25 20:27:04 +0100)

----------------------------------------------------------------
regmap: Updates for v5.2

A larger than usual set of changes, though mainly small:

 - An optimization to the debugfs code to greatly improve performance
   when dumping extremely sparse register maps from Lucas Tanure.
 - Stricter enforcement of writability checks from Han Nandor.
 - A fix for default interrupt mode configuration from Srinivas Kandagatla.
 - SPDX header conversion from Greg Kroah-Hartman.

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      regmap: add proper SPDX identifiers on files that did not have them.

Han Nandor (1):
      regmap: verify if register is writeable before writing operations

Lucas Tanure (2):
      regmap: debugfs: Replace code by already existing function
      regmap: debugfs: Jump to the next readable register

Mark Brown (2):
      Merge branch 'regmap-5.1' into regmap-linus
      Merge branch 'regmap-5.2' into regmap-next

Srinivas Kandagatla (1):
      regmap: regmap-irq: fix getting type default values

 drivers/base/regmap/internal.h        |  5 +---
 drivers/base/regmap/regcache-flat.c   | 18 +++++--------
 drivers/base/regmap/regcache-lzo.c    | 18 +++++--------
 drivers/base/regmap/regcache-rbtree.c | 18 +++++--------
 drivers/base/regmap/regcache.c        | 18 +++++--------
 drivers/base/regmap/regmap-ac97.c     | 22 ++++------------
 drivers/base/regmap/regmap-debugfs.c  | 48 ++++++++++++++++++++++-------------
 drivers/base/regmap/regmap-i2c.c      | 18 +++++--------
 drivers/base/regmap/regmap-irq.c      | 21 +++++----------
 drivers/base/regmap/regmap-mmio.c     | 22 ++++------------
 drivers/base/regmap/regmap-spi.c      | 18 +++++--------
 drivers/base/regmap/regmap-spmi.c     | 29 ++++++++-------------
 drivers/base/regmap/regmap-w1.c       | 16 +++++-------
 drivers/base/regmap/regmap.c          | 27 ++++++++------------
 14 files changed, 118 insertions(+), 180 deletions(-)

--KI6XeYrntNhU1GwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQQfUACgkQJNaLcl1U
h9Dd4gf/cSTSSfhTIO4bdhqceRFqe1pezQLu/9Hxh6Uhw9RBUDRYc4ZJEcZT94bv
HBS//e1IKPkuXdle651SZts325u2ybj4GRJv8ViZvgikifWGRUFEx4FUNnQXyi6j
ZUF8TwtZnsQCYWuAWhn1BPG8Y5VCzMf5VIAw1D5BOYXUDgZqMDEPJG4o5sjEw+i/
wtfi6oN3AyLd/I3xm3OhCwtTIjHGixJX6YAJktb5FKV0KxuCFWejOQ8Wlv7edszH
LYVVH8evDMDjoHe2DVqowPqrMhrREbVD41I07Yau/GKIeuvegqoPd3rvxqhYPMyt
JUpuWDYV6uSlEcRsUATHLVKPZbsXKw==
=QKRj
-----END PGP SIGNATURE-----

--KI6XeYrntNhU1GwB--
