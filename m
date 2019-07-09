Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F13B6361B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 14:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGIMoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 08:44:01 -0400
Received: from ozlabs.org ([203.11.71.1]:51229 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfGIMoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:44:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jhp63N9jz9sMr;
        Tue,  9 Jul 2019 22:43:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562676238;
        bh=5JjOhCOo11HpuKoBcIj0Kf1ot/ILy7rkimX/W67HR+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XkXlxNLdLb00bIBy5OCjlkxud/G/wKad9OJXBLZ62mSbkHcFYczuztriaI2xSPnPk
         I8FinmkYOaxkgEmrUNbRh1nP7ffUXROgGYGN2yi243jsib2ahmfUhAhrOKWpqWE3iG
         /hT2u13AFbr1crF8RfzCXMg69xopgYIA+Wz7bc5i+9JmTZ/EzoXD9rG1qw0Bl3cbcS
         vdct+Ev063A/vjc2RQgfN5ok7ctY2rQZbdHxXsZ56IplSR7Y0UkXSPipVw6g8tf49b
         yFp6LA/G5IfA7y2IQ8h8fPzirfpviGeYKuedfaNR1xXQPUvsyVIdskm9OvSeo3VWV1
         MgbkUoSfB78Iw==
Date:   Tue, 9 Jul 2019 22:43:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        asahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Message-ID: <20190709224356.325065d1@canb.auug.org.au>
In-Reply-To: <20190709071758.GI7034@mtr-leonro.mtl.com>
References: <20190709133019.25a8cd27@canb.auug.org.au>
        <ba1dd3e2-3091-816c-c308-2f9dd4385596@mellanox.com>
        <20190709071758.GI7034@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YnSUDgIuMqJTzfnXl9xBHgl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YnSUDgIuMqJTzfnXl9xBHgl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Leon,

On Tue, 9 Jul 2019 07:18:00 +0000 Leon Romanovsky <leonro@mellanox.com> wro=
te:
>
> For some reason, I wasn't in initial email report, can you please check w=
hy?

Sorry about that, I manually grab email addresses from SOB lines in
commits I am reporting and managed to miss yours this time.  I might
try to script this up.

--=20
Cheers,
Stephen Rothwell

--Sig_/YnSUDgIuMqJTzfnXl9xBHgl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0kjAwACgkQAVBC80lX
0GwKLwgAnNHfe00EzcQiMH3rRm3GvT9gMckAiH3dSYS3vnIdMiJ7yPILfwUZz3rk
Kqpteq46cw9MxfBkeSPyBAiWvd7WgzaPATH36DOn9pkCYTKhde0LLZ4OX0WJUMmq
R5KhfsDgKrljJTuR3DmpGFWkRGWkUp+n9JlpAVDdXdZbN8JNcgxz6X6PUum1nrlJ
mLewhkszsH9gP+JgEEpIXsmUf3Ex3fpYPcLAaCi2z9PEUA9soTb92obFnbxnmVUy
Y0cu/+k3L4IGtu/RIENM9tglY2T0F3wF2vAInr0zZ5iygP8n8kTNk980Uddgktm7
tq9BaY9kgLpqBd37ADBsCr9xnm5C5A==
=AdZ4
-----END PGP SIGNATURE-----

--Sig_/YnSUDgIuMqJTzfnXl9xBHgl--
