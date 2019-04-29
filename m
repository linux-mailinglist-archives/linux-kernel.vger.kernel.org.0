Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE04ED4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 01:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfD2X2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 19:28:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39061 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbfD2X2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:28:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tLSv6kXLz9s9G;
        Tue, 30 Apr 2019 09:28:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556580528;
        bh=GAfdNdM0FNa6v0cd5h2zn7GgRPoz6ITpJvz7IQpzcXE=;
        h=Date:From:To:Cc:Subject:From;
        b=j7i/G5jV44wP6+rRQCFXKY1k410eHprE7FcJxwuTHLt7LZjTFgfh5vqiGTl16uqyI
         HIsw2aOeNLs2Js9FAUgPXvjUHuImQ+eh4+lrfZ++loNRUoRVEYCgzxE20kXn2O6V6j
         0PUon8ArxyM7z0+Tg8p3RwHkxlBtqMasQxk5YkhbuwHWY43rdNqGLJcGYZbSwE5ssy
         uP/9ceygw6i1JRBo2bMHHTdUV3OzTmVs4L+4/Bzs4EMkzJ4xL6Zq4qCvEO0E2kjjEz
         IPo+q6Wsh1OCC7CxIJMK5nNTMyBGyF3ftzOl7+lo9UUvcAA1TSmEffPanfYLoB0bhX
         yXmqqsfGKNhwg==
Date:   Tue, 30 Apr 2019 09:28:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: linux-next: build warning after merge of the arm-soc tree
Message-ID: <20190430092839.767e5bf8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Cr.CHQ3_ggx8N8O/fzy9HBX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Cr.CHQ3_ggx8N8O/fzy9HBX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-soc tree, today's linux-next build
(x86_64 allmodconfig) produced this warning:

drivers/clocksource/timer-ixp4xx.c:78:20: warning: 'ixp4xx_read_sched_clock=
' defined but not used [-Wunused-function]
 static u64 notrace ixp4xx_read_sched_clock(void)
                    ^~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  13e0b4059b98 ("clocksource/drivers/ixp4xx: Add driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/Cr.CHQ3_ggx8N8O/fzy9HBX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzHiKcACgkQAVBC80lX
0Gze3AgAkfB+yWpYTkkBBg7gDbQVQDIskULEnUsU1p1GnnLuTYZNRUDde5MWc+bf
izxQ2Mpz0wWhhBMr/SDNjlcW0ssv6BOnF7L8hv6tyejN6evx4Brq9GVk9ThELILC
nwOh0nRsW1VXcFvllKFIp1KzeQPOrb+JgNKcvJVWbnWadwzVchdjORh3q6gNWysw
zd059M2SD85pPHvZzFfYF39jRTgmtMLp43PDt9cU5b79EPAmXogowTRHTLDr0WKS
ULIg6VXf2/dnFI2qSBE2aqVrvz4D2LgRnp11ldtWdHHldIPOeFG8rIV85+pndUWW
FhOxJOCsdcZYgYXFPPy8xNPl5EK+fQ==
=tCZt
-----END PGP SIGNATURE-----

--Sig_/Cr.CHQ3_ggx8N8O/fzy9HBX--
