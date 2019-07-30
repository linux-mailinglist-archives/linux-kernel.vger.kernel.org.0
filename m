Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 916237A017
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 06:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfG3Ep2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 00:45:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33839 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfG3Ep2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:45:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yPBG41FXz9s3Z;
        Tue, 30 Jul 2019 14:45:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564461926;
        bh=jVD+AoMQGxi/wGGXONCIPWY+Ktwi9IFbSQiYXXW609I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vHr5CCoOOUOXhslZFa6FwTY+3WcjSvShnk5udQDMSTK8z4KTNI75mqtrzgVlNqIqg
         EkehG84POXKm5lST85lzzOB8G7CixJVfOofDlzVl7Pa0kDobAPIzwNARdaZupi1dVv
         4FQ8nnr3MLRyJIqVEeqw6DUszojUsevZ6UH244LZHBlH2HmYWcoU4IRj4sA2+VyC8h
         0uh0j77wVTCixZJ9mI6mindrSXaDSi/7JcU9/XBZ21ycqVVIdMFBqr1uFcZ05KN2fg
         p4mS2zxvWchv0nNAMNxFuWEm2q6wrbg/iBbMLdWpAiEr66fll6T9rdNnO/2Ij5F87i
         X21VklLnoF41A==
Date:   Tue, 30 Jul 2019 14:45:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/macintosh/smu.c: Mark expected switch
 fall-through
Message-ID: <20190730144526.3088aad4@canb.auug.org.au>
In-Reply-To: <20190730143704.060a2606@canb.auug.org.au>
References: <20190730143704.060a2606@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CPhGrAmmSmh99vXtb+BIRHN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CPhGrAmmSmh99vXtb+BIRHN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 Jul 2019 14:37:04 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Mark switch cases where we are expecting to fall through.
>=20
> This patch fixes the following warning (Building: powerpc):
>=20
> drivers/macintosh/smu.c: In function 'smu_queue_i2c':
> drivers/macintosh/smu.c:854:21: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>    cmd->info.devaddr &=3D 0xfe;
>    ~~~~~~~~~~~~~~~~~~^~~~~~~
> drivers/macintosh/smu.c:855:2: note: here
>   case SMU_I2C_TRANSFER_STDSUB:
>   ^~~~
>=20
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Fixes: 0365ba7fb1fa ("[PATCH] ppc64: SMU driver update & i2c support")

Sorry, forgot :-)
--=20
Cheers,
Stephen Rothwell

--Sig_/CPhGrAmmSmh99vXtb+BIRHN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0/y2YACgkQAVBC80lX
0Gyt0wgAi3jthifR+t5hLJW4sbfr3P+HukPfwX1FebITb+a65Uu+7K8zNV9n6g1J
MsmihdRnaaO2rD+YLCnqSBDZjNdD1j5cXDcWQJe3nPM69nfblQyhNPbdyk48/q2b
vT8OkvPfGvJelf73ph1gkkn6zXR3J3LAx9dpp3ittcSlLIsfhjlXz67IMDl8z8Bk
ZxxFX8Rv2ivByxWDO4PGtxDFtAV3C/SlK6fzyIUvXBG5M+xPAe9Vy2UYRVY1ZekM
l4c+3+dAXIod3G6SNBt2u/1NNn0xiXX0jPtkIw0j5n0fB3NQK2EmRpM32IKAcUYu
XX55Y1BZxGJ01G7/eT0TNtVYJww9bQ==
=7y4x
-----END PGP SIGNATURE-----

--Sig_/CPhGrAmmSmh99vXtb+BIRHN--
