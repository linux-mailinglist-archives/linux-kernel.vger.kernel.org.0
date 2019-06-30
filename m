Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BAD5B225
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2019 23:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfF3VtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 17:49:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39323 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfF3VtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 17:49:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cPKM2pXXz9s4V;
        Mon,  1 Jul 2019 07:49:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561931352;
        bh=O/Y5svxR89JBDFNq/bdF3kpJz7bNfTxUebVyz/vh7gI=;
        h=Date:From:To:Cc:Subject:From;
        b=AvbuDWzwVbxAIgqlLITV20B3HFCTzJcM/0InHsvupI9fUiGZQeP3/C31kjLnzFMPa
         0lKlSOywmG8kjMnZrcyvWJKSekn9okeHbUeSBiHFAFmZX4foxNSfaNouU7Z5+0ExEW
         tXx0QAeMgO1n7O1ee2nIChCpYx+7Rtv3rIq88V4ocOy6+/b8Br7fJAbbMyudGg1NGW
         cLKDSF52VKe0/5ORIQrRJSod9RtyxibEdLEw1LTC4hHU7a3HsOt/JBYW6Gaip6H/mE
         Ta7mmZJS+r5B4KpWyPunBef8T/qQt4mvYdd+FZIf1DnSs6fQBlFRVCd7WpWOwDAvjg
         OxoTnNrK8JoCw==
Date:   Mon, 1 Jul 2019 07:49:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190701074911.5bb8a58c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DhWd_BwTnNx59M7Wj2/FX1A"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DhWd_BwTnNx59M7Wj2/FX1A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8a90efd15ef6 ("ASoC: vc4: vc4_htmi: consider CPU-Platform possibility")

Fixes tag

  Fixes: commit 6c6de1c9e2bf2 ("ASoC: vc4: vc4_hdmi: don't select unnecessa=
ry Platform")

has these problem(s):

  - leading word 'commit' unexpected

This as also the case for the whole follogin series of commits :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/DhWd_BwTnNx59M7Wj2/FX1A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ZLlcACgkQAVBC80lX
0GwJ8gf+PEHRtQuGagPju9MVntBoRpFOXUNtzpwVLRaZbpCKWUZ1Dz7fq/M6g5j3
Nw+xNWaRfYDrhId2gX1vIDcWFJOFBKljMty9gw1JoV0bQu8bNTZ737WWbesWrhq1
fgAASmbE8r/NueyZPqxqz2gRHQ2ZTOxNTQx2DzLGh+yVg7nPs5Z5cz0T3GJVhuRZ
w/++gbYYBP1+p+rw1uCcr0NXEbI+Qsl4BwbmhpgiUMo9ym/1u3ugKRbEGmqxW3OG
vCUDcG4++LkdWi0sOvtEa4oLVH64MAlwhb5DD0Btbv0s/9pyPGNMysWvGT7lPJoX
VA/81hOEgAZyx60T1pJ9WwQvfED9OA==
=Fn06
-----END PGP SIGNATURE-----

--Sig_/DhWd_BwTnNx59M7Wj2/FX1A--
