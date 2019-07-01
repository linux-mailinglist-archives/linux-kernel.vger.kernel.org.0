Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5E3C368
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 07:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391202AbfFKFYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 01:24:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38921 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391044AbfFKFYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:24:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45NJMS5CLLz9s6w;
        Tue, 11 Jun 2019 15:24:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560230644;
        bh=QJPDp6hkCDquK5eksgMhI6xqZ1XaNY2awH4ssjTacHA=;
        h=Date:From:To:Cc:Subject:From;
        b=LOWBtZ0pX4QsMm1RFXu46/TTlTcvvmiIcYfrQiGC6wfDMSjcQZQ3bWXfHajFp4i6W
         nEJ6FAx5NZtlY2j45/SrHKftaDM/HUS3GlUF+8JILHmztQUlQ4VVKbIzUQtVE6tNRK
         wxKTRij/W9WykefNDuaEdcArnuxwGdCE5F350s6A6xFSLpR/e0RDp/DhzEhsTOaVk5
         xffzoTy/eYKMTOOppocDQqnFH50oFtEFI2Sb8sVfQ8qTR8wstI/uT5UgZtA2MC66J7
         +3nBS+luIouKg9+UETB8/R1qugOmLrQvF0a0674w4yZW8P5tLetRrKRqUmOf28OPfA
         SPJvQyALDBSbw==
Date:   Tue, 11 Jun 2019 15:24:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: linux-next: manual merge of the clockevents tree with Linus' tree
Message-ID: <20190611152402.59f9cc0b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/A/PEMEyF/YNGD3rvZWCai7K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A/PEMEyF/YNGD3rvZWCai7K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the clockevents tree got a conflict in:

  drivers/clocksource/timer-tegra.c

between commit:

  9c92ab619141 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 282")

from Linus' tree and commit:

  75e9f7c6dca8 ("clocksource/drivers/tegra: Use SPDX identifier")

from the clockevents tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/clocksource/timer-tegra.c
index 1e7ece279730,9406855781ff..000000000000
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@@ -1,11 -1,11 +1,11 @@@
 -// SPDX-License-Identifier: GPL-2.0
 +// SPDX-License-Identifier: GPL-2.0-only
  /*
   * Copyright (C) 2010 Google, Inc.
-  *
-  * Author:
-  *	Colin Cross <ccross@google.com>
+  * Author: Colin Cross <ccross@google.com>
   */
 =20
+ #define pr_fmt(fmt)	"tegra-timer: " fmt
+=20
  #include <linux/clk.h>
  #include <linux/clockchips.h>
  #include <linux/cpu.h>

--Sig_/A/PEMEyF/YNGD3rvZWCai7K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz/OvIACgkQAVBC80lX
0GwOhAf/TAU1T095cbsc5y2wFoB9A5ttQhV/LgY5Y/271/OoB/5yxBahB0CfF4TY
1OEF7ngf5yjoHjKxwWrAGXuCvJZUfWlg6rzmGOA88aSvG2jWjgvF2dNtkL+SiP/y
PzB+oGYzSYz9I8UaKJXRMw5HuqsbY1M9eNk8Eyiz3uCGJOPimyJBJRkK8O3hGcDd
wXmVh6mMRQv5BitMmbNzIVc++dcQRCmUSUvISLRxSgGNCAdUD7hXocyYEpXBvpIg
A3RfsnAvC9lSikKNznVjVI/DJD5erIlWrKBxgTi9MTycT1gW+CyCo2ezwy7ohtLC
n3BCk+o98WIBXSQnPOV0FKNCbhv1Ww==
=VtU5
-----END PGP SIGNATURE-----

--Sig_/A/PEMEyF/YNGD3rvZWCai7K--
