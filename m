Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0D17C318
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 17:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCFQjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 11:39:09 -0500
Received: from foss.arm.com ([217.140.110.172]:36300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFQjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:39:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADC5530E;
        Fri,  6 Mar 2020 08:39:08 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EBF03F237;
        Fri,  6 Mar 2020 08:39:08 -0800 (PST)
Date:   Fri, 6 Mar 2020 16:39:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator fixes for v5.6
Message-ID: <20200306163906.GD4114@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 44e9b3446423164dd04f58a5f9efd988c4d5e84b:

  dt-bindings: regulator: add document bindings for mpq7920 (2020-01-27 17:23:47 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.6-rc4

for you to fetch changes up to 02fbabd5f4ed182d2c616e49309f5a3efd9ec671:

  regulator: stm32-vrefbuf: fix a possible overshoot when re-enabling (2020-03-04 13:57:28 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.6

A couple of small fixes, one for a minor issue in the stm32-vrefbuf
driver and a documentation fix in the Qualcomm code.

----------------------------------------------------------------
Fabrice Gasnier (1):
      regulator: stm32-vrefbuf: fix a possible overshoot when re-enabling

Petr Vorel (1):
      regulator: qcom_spmi: Fix docs for PM8004

 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt | 2 +-
 drivers/regulator/stm32-vrefbuf.c                                   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5ifKkACgkQJNaLcl1U
h9Awqwf7B/gEu+vTEE/tS/qgqPsug8bOKWzx8++oB8la5C+5+ZhRTHZtZalTXx3S
1/hClTik9cVtlq2RxOh5MytlXEFW9BE9Fqvf0mBaXvvBnAR3pqh8/OTwtaIn44Ls
N162oiJSTazEL0moSERWRqNJT+p+yzX8n0z9VC1pcJMlQm2YPx8U/RtLdcYD0ja8
K+dmRAS2QLj1URrekILHJ5tReJsOF0wprWH0aQzAE6ZlLaaKown33HVGkXeBNE3g
MIYepdTOkiQ4CmnQdKv3le+dVFZwqtUPhNEwHNAG1b0W2uzCDbAHe3ZLzWg8Ot4a
ABF7R2uAWDtLTadOZeJPlZ6+DxEZ/Q==
=OUI/
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
