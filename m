Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAA84CB70
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfFTKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 06:00:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52727 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFTKAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:00:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Ty3h16TBz9s4V;
        Thu, 20 Jun 2019 19:59:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561024800;
        bh=IipggBUwCm8dG12BaaBdSFNwAisAMU72LTzcB1dN14I=;
        h=Date:From:To:Cc:Subject:From;
        b=Us8FuvMV8tLgi5WXoX0bXJURl8e7PbGPhEcUaxa2Ea5zL0IEf5l5Vv20O6pNMdydx
         dMEI0tF9RjJ2JqgN9ouJV5D658zmEkLgiVxHpIw0ZLkiY1iNZYD8/sDtPk5PYFw1L5
         JUhuAgme/XbgtMN3E2xE94Q0jqLFLgdFna+MUEmhvX7iRB+1v09fU24bLWJ1nZT3Ek
         9Lfbbpfzrvl6OUBtx3BJDb/iH6m3BvL9jcKkTkeqz9iDyDP4rLoDUzOIoZaj8/2gqf
         k7pyEj3jX+X7aUoVb/5HLTtxFJZAvJiuKhnAwjjrKtDugD8mjW8+ML1Ykk7B+WCL3S
         l2gi2Te1vDhyw==
Date:   Thu, 20 Jun 2019 19:59:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matteo Croce <mcroce@redhat.com>
Subject: linux-next: manual merge of the akpm tree with the s390 tree
Message-ID: <20190620195958.44841896@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gQ=SzubxHMkTfaRKs_V7Ny6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gQ=SzubxHMkTfaRKs_V7Ny6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  drivers/s390/char/sclp_async.c

between commit:

  191fa92b3448 ("s390/sclp: remove call home support")

from the s390 tree and patch:

   proc/sysctl: add shared variables for range check

from the akpm tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/gQ=SzubxHMkTfaRKs_V7Ny6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LWR4ACgkQAVBC80lX
0GyB7Qf/Tani1A7xx/mSXffQ8membEuKI+vLA3o1IWWZG3fTC9NKMjcwDLEvrbrj
+/xRsdeHpIqlxh0/9CKcMpqY9ArFSlRj9EJkPYtSlfE/hWVl1b7S7/rZ9Qfy9hM0
tZcaPp4kMoUfsV8RfbT8rXE/4B0ftYgKyUrAA+JIH2UsIfgWbc8cOkr3wSeqvfbj
eIud8a9urAHCd02DL/iLNwOh+mxYmDcxMDZnfp36B4qTqAvyLQ1nCz12uthQZhiE
ZW1LRbJs4wTIA9nGeORgK6cS8g8F80/At7ztVkt7Qp1Og20DKyIKy5GgbovIjJwA
4ECqL72qzuw62ARpuKK3/u9Gi0SrlA==
=ntpj
-----END PGP SIGNATURE-----

--Sig_/gQ=SzubxHMkTfaRKs_V7Ny6--
