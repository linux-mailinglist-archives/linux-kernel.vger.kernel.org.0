Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8268E305A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 02:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEaAGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 20:06:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfEaAGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:06:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FPrQ741xz9sBr;
        Fri, 31 May 2019 10:06:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559261207;
        bh=rqK0tbfdK3qtwdDFZ6cLkkqkVj6eNvUQSUM12vFYfEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JycNenuPjdnS7XVwCmkOFbDhkEw5+7BiLZxhqROb5ILi5678i9m1GBlu+j+KIxZL6
         bUKsRpmQ7XBMJXtBZrhZs8mUK3lldYrSf+KVwK1+Vl4RNWaR5/cMNepyVfejGHIQ3+
         tVSwRtwttdf/D71Hw9WiSa3ItUSPjzAcTFj2GiVMf7HZt43H5lsjEhwdnTDEHtdoQA
         iMy972YrMRbiEmV82zitrO0xl9Y9tvtoTHLJnhKCRz/gYptuP4bLmj0Oqltngdinv/
         G6Eud8TBUwzmKAhzDbmfx0PSbZbuszCU2zVrZuVa7zVwLDOqKM27oyfhkPW/sGEAIK
         ATVQIGng5uRJA==
Date:   Fri, 31 May 2019 10:06:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for May 30 (firmware_loader)
Message-ID: <20190531100646.212b065f@canb.auug.org.au>
In-Reply-To: <28716a14-772d-bc82-5111-34cd38cfda54@infradead.org>
References: <20190530162132.6081d246@canb.auug.org.au>
        <28716a14-772d-bc82-5111-34cd38cfda54@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PWONkdadaEC6ybOc1SCPBQ4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PWONkdadaEC6ybOc1SCPBQ4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 30 May 2019 09:10:13 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> on i386 or x86_64:
> when CONFIG_PROC_SYSCTL is not set/enabled:
>=20
> ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x1c): undefined=
 reference to `sysctl_vals'
> ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x20): undefined=
 reference to `sysctl_vals'
> ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x40): undefined=
 reference to `sysctl_vals'
> ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x44): undefined=
 reference to `sysctl_vals'

Caused by commit

  6a33853c5773 ("proc/sysctl: add shared variables for range check")

Added some more cc's
--=20
Cheers,
Stephen Rothwell

--Sig_/PWONkdadaEC6ybOc1SCPBQ4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwcBYACgkQAVBC80lX
0Gxtegf/Qph5FzdyfJGZyjn0oChmSq959oJsCpiVzFEHiCERPRIauHX+L1OQL9nD
ByRaXZejxUJsK0zNqICBwPlvhKGVZ7sxl7h6JVLCAZS4SEF3CuMa5tTU2WFHfPbB
7EKPBiE+3elRLHEsCrI71UVwPIDJR7/ryul/7k85tU5qXq6i83JQpRjyURBDemue
cqG6sYrRI+o55scQjkQR6lwIIsadcSvajgr/cGNsUvl5HRzhvwXQvksOtY28C1lR
+x//HM4rx8Gjog4iSlnqOf3/+fTtlxaC0yr+ZixACNCSX9bfJpTyNO645NkHKODu
WKAkI3bxb1uSz2JOwmORRm4KUUpQtw==
=uahV
-----END PGP SIGNATURE-----

--Sig_/PWONkdadaEC6ybOc1SCPBQ4--
