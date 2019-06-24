Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF58851F65
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 01:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfFXX7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 19:59:10 -0400
Received: from ozlabs.org ([203.11.71.1]:48289 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfFXX7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:59:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XmV32DlRz9s8m;
        Tue, 25 Jun 2019 09:59:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561420747;
        bh=Hen2snqqpEObpSAq2c6bshrMW+1cGI3PPwZNjQakpws=;
        h=Date:From:To:Cc:Subject:From;
        b=CMaJmjXUhWZSH3G7ZF7TucJBfxTCoVOgmwW80GXCHgGM6Nfc8AS8Ds63ea7gLdhyu
         NcBa9GATEILZC+EPTZ6JYIXKReSBPN97knyzJPnRN4p/n3kNTTEXoQxmvD6xQBLNHf
         Rt/P1rS9IgyYNGDZ8uNUDbhkvWOGNPcN0HbJraEG+XoviP2oBZRs4AwlmLJxzKr0G+
         ZlSvvNg7kuTQ3A8C+X4biPK1oKa1G0jiJVcCo4bXbgTvjBkUKfxzuXFSEtwkRVmuDt
         3EvKjdwTdeI5CxEWb9vDm4Brl70PE2Z47B9q4Ob9OoOh81ZpZAh6rSwkXaq0g3wG6p
         fb5K32jp9BqAw==
Date:   Tue, 25 Jun 2019 09:59:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the samsung-krzk tree with the arm-soc
 tree
Message-ID: <20190625095906.06c97e0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DYAqH5VtESGNex_VbQzPLet"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DYAqH5VtESGNex_VbQzPLet
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the samsung-krzk tree got a conflict in:

  arch/arm/configs/s3c6400_defconfig

between commit:

  6c48edcc955a ("ARM: configs: Remove useless UEVENT_HELPER_PATH")

from the arm-soc tree and commit:

  5a96019ce5cd ("ARM: defconfig: samsung: Cleanup with savedefconfig")

from the samsung-krzk tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/DYAqH5VtESGNex_VbQzPLet
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0RY8oACgkQAVBC80lX
0GwGPAf+PNcyQkEMDRMVNk1uGZdsRY8sHdbhNGKJU2euhikT1WZiVamOhWrRTnfj
UZBBGAlM7JqKZJ39qGzk5yvEPFUKiVOGeg7Xx3xT8febF+S9vKYN3XnOcPMjrMxe
S8RD4vF0WtLpFzFCRu/hd1GdL78TL1LtNtvIy20Ph7Z9Q/aO8VwPxsHE7BYGxSsA
IHfs5YOjlSCZxZdUbZK3rXceTXO553EM6H9sn/Xr9O0brG2VJmJ6XcAZAcybB4Oh
E+pMCl5gHD1Kl/dhMxPn5qQkte9u3Kgvf8WNDVUOxJL+3JEXZ5qFtdjh4NREXE1v
0dyp3bnna0+DkCDuyMym/FiQclr2cQ==
=N9qa
-----END PGP SIGNATURE-----

--Sig_/DYAqH5VtESGNex_VbQzPLet--
