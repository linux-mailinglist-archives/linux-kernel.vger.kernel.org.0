Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA02256AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 15:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfFZNm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 09:42:59 -0400
Received: from ozlabs.org ([203.11.71.1]:50815 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfFZNm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:42:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Ykk80tZrz9s3Z;
        Wed, 26 Jun 2019 23:42:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561556576;
        bh=WdWMbczdBClsn1CpVDEcIgMMCcotjBk6HNGVtmqrSsI=;
        h=Date:From:To:Cc:Subject:From;
        b=ndWUXuJah2xCKMlgROMIRhyxu2HzcfKZW4Ojh1XlkAm2+bA80eV+goiQiMvqddtF5
         7Pgjn5ZJLbf+SabCMMsVS/JvjC0S3K2LnaFrm7u5thjR/VXqziQb4z9euoj/05UO/b
         Aq7dnw+g6Kt+16LqxWjZ0xHpJQvc6a45OnfPozJ5T3neVdfgKUL0NYuHbQSFVK4Nli
         iUiXelmi12M8Yk3reouflT8NUjiN5+Ky4EFz0WSK2DGZs3KnpGMo+c64dqJrxyoohU
         M+Z7zfQ8q74yYVp8vev/LG6ByvujO3ZDRWky3/nHDEgkdBv2Fcfk3KSfJiWbyQon+b
         uRHVIdNkwo85g==
Date:   Wed, 26 Jun 2019 23:42:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20190626234251.67acfe79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Vg_=Hw1pb4_qzWk1n/toyOx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vg_=Hw1pb4_qzWk1n/toyOx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e3303268f9cf ("ASoC: soc-core: don't use soc_find_component() at snd_soc_=
find_dai()")

Fixes tag

  Fixes: commit b9f2e25c599bb ("ASoC: soc-core: use soc_find_component() at=
 snd_soc_find_dai()")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/Vg_=Hw1pb4_qzWk1n/toyOx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0TdlsACgkQAVBC80lX
0Gyduwf+PNrVL23wQxF6ABFSZsELxiz14FGmenDxR8uY0lD+gs1a4hQZJocR6vhd
Ce9Bv04cbc6ezXSSX/66lMAuY27N1TiaHIxVGJ3B0l+7j2v2YIYQ/5EBHfiq6dc2
6oNVfQBhkIxJqtTe6MWtpLZmBXl2Hu58lBiOpdXh8lYArpsG2AgMdXuCJ9e1IOlS
U1PL/M0ULo13ofedLhFB+myi2Zt+Nb7Xy68ajlv5ibzpwFXjht42nNjDKVJE1NQG
GuY8VNJ5UdaD+ND9LKvT+FqxfXw3iHfeDeItwvYvJWsUSLg8Ejudy/hKkSf2himS
OwopZQM5BcC98Ztuv1Bt7uClOZ4gAg==
=usu0
-----END PGP SIGNATURE-----

--Sig_/Vg_=Hw1pb4_qzWk1n/toyOx--
