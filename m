Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2583366F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 23:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFEVtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 17:49:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57601 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfFEVtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:49:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45K2Vj4lXNz9s3Z;
        Thu,  6 Jun 2019 07:49:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559771341;
        bh=lqxXci9/w5LV/fO591yge4/Ea86XzBP77/AfhaqWM9Q=;
        h=Date:From:To:Cc:Subject:From;
        b=qJgEQ1wFd0hs4nqzVi1O5/stfSq4fnxAL08/dPi1THduENXoD2I5gNPN+cArj4Lpd
         1O6Hble0O1EUPwGoJLQeSAPZxOcUiFaN06ld7jT/9OifT/3aZ1L5Z90W2s6ANoFVog
         36t2bUFLG/jH1gMmb/gm+r8/QnrBJt5wp6vdcuDuCS+BGq9fXiRCY0DXwL0r/oj4j6
         9luuVa575g0VMgk2uuSai77lgc7UvH30F1qibD2OEb4UDAbZPY5v381q/aoWZd814C
         /MV2yFpWhqwYeU9wcnfHa7Ca14NTqG+YYxMTUOaN9+yyyvIL2E4kQierJJbxSP/te+
         JR5+hMN0TB1xg==
Date:   Thu, 6 Jun 2019 07:48:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sage Weil <sage@newdream.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>
Subject: linux-next: Fixes tag needs some work in the ceph tree
Message-ID: <20190606074853.69a7b07b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.obmgY=Il4.cZZcJjqKbo+y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.obmgY=Il4.cZZcJjqKbo+y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sage,

In commit

  7b2f936fc828 ("ceph: fix error handling in ceph_get_caps()")

Fixes tag

  Fixes: 1199d7da2d ("ceph: simplify arguments and return semantics of try_=
get_cap_refs")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/.obmgY=Il4.cZZcJjqKbo+y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz4OMUACgkQAVBC80lX
0GyEtQf9G0PMBiXfNt9LB1+AgGgRk9+BVIZup9stxuIbY9qoJr/112B25NESkWWu
JuCKNNKlKuI+f79Sqxi73Avelad/BXDlPurjFlLEfTCeaCIAvR6VcC/i7OPXpA5K
HJrSqJ6Tei4HLwrc8ODDDoP+hM7Z/bXa+VvL/Us2S7rAdOUwDV7NpswFyoQjP8Df
SnpFZxETXiLZGN/waTr2mxlX44NSU7siv0+DLaf03NQjhrhQrQk9VlrPOXNvflT9
8DF8v+5Jv5SWcZ7+oHAclLSJWsLHL/m2+nvUZ9Mas4S/fZXsanMh0VK3y6D6O5Ya
Tqp5QvqpoIuUJ/oZSLscdyynhH4N/w==
=dIMC
-----END PGP SIGNATURE-----

--Sig_/.obmgY=Il4.cZZcJjqKbo+y--
