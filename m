Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF737FD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 23:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfFFVrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 17:47:09 -0400
Received: from ozlabs.org ([203.11.71.1]:58615 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFFVrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:47:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45KfQ22bmTz9s00;
        Fri,  7 Jun 2019 07:47:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559857626;
        bh=u4T5dX8moM7w15BG0KStj7ZpPlXZ8VG5M/RcYST5vWA=;
        h=Date:From:To:Cc:Subject:From;
        b=nx0S+aYK7QJppEImW5EIzZUfwRuTQeMp0u7GNUOcJMGbmSEj9sG2SU4PfZm/LQZ4W
         ugmTpBN4o1SUUyzluMlI3kzOJcgODp5e1SE3WmeXvvdEvfl8yafArL3gGLHs22FnlP
         /BfPoZxYss7Bsm4HvG4O/HRIvSfW+1DdxFJKy9ZeFBS3Y1h70RC1r5y3BqbvU/P+Qm
         xO6z2pF3lM98MJkgmE93HQgEbTTuP9QpeLk6iDSqXb+7G9NUIQLospxfpZjkeKvRQU
         Xta2fiFacT+JPVVXgJBIrB55JGvkdzoMN11Id2/ZRlYOwC5sYV4i3MbGhKhZZnsUbn
         OEdEIBck/dD0g==
Date:   Fri, 7 Jun 2019 07:46:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20190607074652.4b3d0c97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D1mk=oSoxR8UPqwNVGlEfLt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D1mk=oSoxR8UPqwNVGlEfLt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f6a8ff82ce68 ("clk: imx: imx8mm: correct audio_pll2_clk to audio_pll2_out=
")

Fixes tag

  Fixes: ba5625c3e27 ("clk: imx: Add clock driver support for imx8mm")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/D1mk=oSoxR8UPqwNVGlEfLt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz5icwACgkQAVBC80lX
0GzTlAf/ThRspccSxst8V04/r91jpe5GjMQ/Q0UoIGgVVV4q2WpWVZDChTtP00uA
v7jUeLwqUl2OUTZSXp+PT+LpRqTOm+YuKFcLA1MO1g6gMgjqPcDnxePWMsUjWvgX
SNKAXGIA55rEFAznKsS7vl9u2n5mcB8DZIFR9Wh1uMbMCy8seI8SIgVOXHfBek+b
rqvuWzMdiR45HF77/Vl8u1ip445BKdg8kAFwluCcG/ixU76gsBp2Yrq8rsLmMPIX
Ho7sclz4SM+h0tulwu1RA1TX7sVC5niF9cau0AOfYcLXmU/wpyM+NFXgIAas9f4s
7qlCFTRF0/mZlQwZLSfv7Ew/Ag14BQ==
=P6/z
-----END PGP SIGNATURE-----

--Sig_/D1mk=oSoxR8UPqwNVGlEfLt--
