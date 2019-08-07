Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF98468B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 10:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfHGIAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 04:00:47 -0400
Received: from ozlabs.org ([203.11.71.1]:38141 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfHGIAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:00:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463P7w243wz9sBF;
        Wed,  7 Aug 2019 18:00:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565164844;
        bh=nWUso8Mumq9hEJIjbu03nhZTrk9SBdkWYlP1sbRhN5M=;
        h=Date:From:To:Cc:Subject:From;
        b=QxIgrBO2ExGCMZCIZKvY8d1NW3Q3GDzjaF7x3aOpfEgSAW4JpabnrWLQz9ls8iBzS
         inhSbvYI6FK2QdAUn/y6DSMxh0UaODdKZ5yrwl3lUSaE+4DYC8EzV4oFjkuAnW/C/b
         dh+7U03tnWvNBHs/HD//qW4nnuc6YW5s+fQrQZh+972NsFUsSm3mPpOp3da9PMDRXd
         Gplsq7FDVlyThyxp84rq2uBimCH+/s9G1f56H81KqDPoj0DvAhlNLioyVvqCjxqWkg
         osErTt4dcpb/j6+LBdSKKulxpIhlFTu6cZy6ENxMPI3DHcFuz0YJGcQGfrD0teuxqc
         j1Qog2S1jIZjA==
Date:   Wed, 7 Aug 2019 18:00:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190807180041.07f06dc0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Cat9BKs_Cts05iNlLKlEe7i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Cat9BKs_Cts05iNlLKlEe7i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/bits.h:22,
                 from arch/x86/include/asm/msr-index.h:5,
                 from arch/x86/boot/cpucheck.c:28:
include/linux/build_bug.h:49: warning: "BUILD_BUG_ON" redefined
 #define BUILD_BUG_ON(condition) \
=20
In file included from arch/x86/boot/cpucheck.c:22:
arch/x86/boot/boot.h:31: note: this is the location of the previous definit=
ion
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))

Caused by commit

  d72f2a993607 ("linux/bits.h: add compile time sanity check of GENMASK inp=
uts")

--=20
Cheers,
Stephen Rothwell

--Sig_/Cat9BKs_Cts05iNlLKlEe7i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1KhSkACgkQAVBC80lX
0Gz7QQf8DhiCZO/C8/QZInhLi1DwLpET6DdkpBHvLXhlusorqCcnsoeEBs+lDYWV
aZN24E4DMzezlUIbKBEDozQGPeWYMyjVjdtST4l4if1Z4Ak1rcxfKd20MulPX04Z
KeZZKZuqCHavtC3s5Ozuw81gXvwPc/z6z+bVSIZD4WxH0ZvZ42Jw08ZDOkZAY6Iw
I65aEUZSH++2+8d3VEZw8drMXIrXvtsG+cZdRaCXmbuwoXhsoLozjkzpMEvMfE8K
vz1mMcjFuIouSXBLkl8JW1ODWXr/o0UW/FYVKtMDFXkqM1wlhytN619LxGHcYYj/
iMV5PewDOvbv4frMdoNG8msAg9m9gg==
=55Mv
-----END PGP SIGNATURE-----

--Sig_/Cat9BKs_Cts05iNlLKlEe7i--
