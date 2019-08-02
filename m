Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479E87EC5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 08:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbfHBGCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 02:02:18 -0400
Received: from ozlabs.org ([203.11.71.1]:50955 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfHBGCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:02:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 460GlW0Z1Vz9s3Z;
        Fri,  2 Aug 2019 16:02:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564725735;
        bh=QcacQy62KZvy3xvKqAv2QOynVH5hQhqPsFU6C9VTWeQ=;
        h=Date:From:To:Cc:Subject:From;
        b=bouJGFmTL6kmfoPbmson5mD/ahw/74e6c5j0g0qjebqrFAHPb1DpcDsI+2Xgux+gh
         SlH4UqEn/shEcJ9vLhSUmipLE7ONlyoS8dqSpTh99WiolN7398Ils4BNoQ3CHV+2Am
         QWt3xnVuJHrw6Pk3qn9yJhLXwdjuPMVea0BkqEjQueTubNYla5FKfCGIW2uVc+8N4H
         xPhtwpG2gc/yUUBZmuWgHSl2utIEBEB/zPCNBFfwJwAnQm8rE+7HxF3G293S6A/nTm
         1sSxCTOKBYPcBqRcC3IE5xKhzBwrsgdz++eqKgFQ9kjWIwUnJ24pQ9uhGGov14psDs
         4e3HN1tB6QelA==
Date:   Fri, 2 Aug 2019 16:02:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: linux-next: Fixes tag needs some work in the crypto tree
Message-ID: <20190802160214.171eabe8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LTm4NEkJwbrULZlNDusF1HF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LTm4NEkJwbrULZlNDusF1HF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  1b82feb6c5e1 ("crypto: qat - Silence smp_processor_id() warning")

Fixes tag

  Fixes: ed8ccaef52 ("crypto: qat - Add support for SRIOV")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/LTm4NEkJwbrULZlNDusF1HF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1D0eYACgkQAVBC80lX
0Gxsawf8D59atE5xo1O9JSPHjlH6GX1k+V1mMH1PsAW4ZfKbKqrWqQGkGZjQUFbN
mesgwFERqslxEoJIEoVfyHAHok4plJWnMkWdhbM9vC6d7rdEQCm6rQjWRL5gsu9T
msjltONhFL+XGImeuFWY5FqE/INyb+JyhzU6oVbCVO34arCOdGFjB1gp4MvmGY8T
9m60IBJeWbdtwdY3FAeRkZrIyQ+OU4SWCAz3fpYB6u401duDJRE+rkgkYMJmHY6Z
B/99CANL6LEZBNt5V1erLUljcZNzcRQjUXD+wvHNNmS4TYDbzWNVBdJCEBU1KAML
qcuxr2oBEGieuXsKifcv2cAeY1r5KQ==
=7np3
-----END PGP SIGNATURE-----

--Sig_/LTm4NEkJwbrULZlNDusF1HF--
