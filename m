Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E30C14AD6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEFNWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 09:22:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44333 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfEFNWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:22:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yNgY75NTz9sBV;
        Mon,  6 May 2019 23:22:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557148922;
        bh=kfTLx+xXfJxD7LUn6+ixKHMZQDIcvXUReZ7bka84+Ng=;
        h=Date:From:To:Cc:Subject:From;
        b=a4fF89IlRD6iogSJHzwcHP8BbSq+TZrdP+hGuzvyMf1V8xYRR99XfWGygmtK45Hiu
         LYBW8C1sNrZARfqkD41rkiZuedxgL7pP+KluYGxxSY/PvUuUmzCtRg82TjiYqHh5Th
         t+0BU1pGmTVR6Whi3dYQJ2NsxJwqYJD2/NefCOJ3o3a07FQFDPDBfB3t7hyqOj0ftH
         Uc18M/g4b/ncgUKr3lNYumpafvUzck90CFVnOwKlRokAizAPkF1ZCiGZD+99gD02Aa
         Oxa7L5VbqhH4e/iaJNyFl3Wt4t/oFV7kFCUt5kb840NeCFxaKkq+fFsWE5LcfuYKpC
         MEPY4nOtcjpFw==
Date:   Mon, 6 May 2019 23:22:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20190506232200.1acfe572@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/a28TwsnwpW9V5LZub9mSM0J"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a28TwsnwpW9V5LZub9mSM0J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cc86bb923508 ("platform/x86: thinkpad_acpi: fix spelling mistake "capabil=
ites" -> "capabilities"")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/a28TwsnwpW9V5LZub9mSM0J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzQNPgACgkQAVBC80lX
0GxjGgf7BC+Atj5DkaYwW7NFNib74ZqV5RzKo8nHvbcWVOhZe5ifPqe81PVIUCKp
tfNS+JNDiFm9SgGqPwzWwTCHMYW3WrHo4vDhG/JC7U9D/symqURSs8Qc4Kw22tl5
yOBJPOcYGSOi8pP9S+ZYQ/YMFr7hyxxZQM4YPyhGBumZopP7qqNZ4hW7FDdBNrI9
oMmQyvGKVtW/X1NBzqE5QlluzPa9WbZi7a2DNT19WHTE03ba16G4oPloNgeBd02g
z3zrxYOHQUk1Pxhv+hCJCEbpS7+dni+aQLGFim4klF3i7do6bMreqr2v5QfrFbvn
xsWwBRkS80m3eLEgHHPHMFPvZAnJUQ==
=h3pg
-----END PGP SIGNATURE-----

--Sig_/a28TwsnwpW9V5LZub9mSM0J--
