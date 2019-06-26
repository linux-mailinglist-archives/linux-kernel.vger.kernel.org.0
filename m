Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F9A57402
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 00:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfFZWBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 18:01:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZWBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:01:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45YxnP5DwYz9s7h;
        Thu, 27 Jun 2019 08:01:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561586490;
        bh=F+6QfOWUggJ0adx+STywXobLMxhSo75zIVPdEfFSjgc=;
        h=Date:From:To:Cc:Subject:From;
        b=fhjZ5Qy3uIsNQY919w5qwK1Hs4QCpxF/857iWmDxTIRj+sCXCYDlDitigxv6nC7QC
         e/2F7AoJAQjrbVimel/Ge7fy4QsFRJQeUofmSynuNbtNsCRRFQNxWZpbu5/EzoqLhp
         Ow4HtEasz/iaNv+uAndUwLaod4gxwaTf9GIyC3flNK2m78xacPn120lVKLtYZ8igZw
         nUGK8ypenwgKo7iWI0tO+VuVE8/naO6eekOzmbA96eStY120tmrbnBHCUJeP2gtgyK
         MKYVU304minYUKWzB+g9OAgi5AZObtaEW+DbWKn05M6QaPP8NmUqUrE+CKsP49cDnK
         CfLE4EkXJfChw==
Date:   Thu, 27 Jun 2019 08:01:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the jc_docs tree
Message-ID: <20190627080123.5fd05a63@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.2Quykg0=9WbwckkIv8P265"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.2Quykg0=9WbwckkIv8P265
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Commit

  fad3d54ef8a8 ("Documentation: PGP: update for newer HW devices")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/.2Quykg0=9WbwckkIv8P265
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0T6zMACgkQAVBC80lX
0Gw21Af+Ma8orx3J1ToXmhDJ/3SAXF8gT7TwPENLuaPqxKWpIJ4Fk1wU6baKAJ1C
WlgMDp8/g6J5mnqodAl9f9j+mmxIoxiSN5PepAnx1RNGRka5Kzco487rMvTe91/X
16zs9Q+nf4v29xVOhgNQeYSFA8Yy3pP46M0P+227ZDif94AhqW7x8e6nr4Hb8yTH
MWllD2lA9YAgZIhO1xEPIw8Gn4mjxmCcbjw5Ap5+mvMcwDLAOcNb3D3NUB4MLq6a
sAuiBb/4+yG+K3htxccqvcH/9CQV36JyqIGh4BnKBK99l7Krb2DMkYktZefqJDAZ
xHSCobznO+4LhjVjU5A75XFV8qLp3g==
=K72A
-----END PGP SIGNATURE-----

--Sig_/.2Quykg0=9WbwckkIv8P265--
