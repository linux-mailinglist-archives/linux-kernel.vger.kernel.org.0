Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EAD3C0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 02:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfFKAhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 20:37:54 -0400
Received: from ozlabs.org ([203.11.71.1]:47859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbfFKAhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:37:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45NB1B5yz4z9s6w;
        Tue, 11 Jun 2019 10:37:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560213471;
        bh=LApRJ/z+bE9As444VerdrsONXsMGcN0MCgEVQHgZHgA=;
        h=Date:From:To:Cc:Subject:From;
        b=hzZ44tv8l7xbSx+urUhZgOTIXtzGMwdZW9ymKYNm73ug1afLKnj9E3IipGkNOOs9o
         CpUpwhjD8C32rJSjc/da0SOn0M/RjkzF4R1J1dwYTtfhXga1gYoxc4coaeBxmmhIDi
         qFKG6tQJLeBQRHYvnkb0/XjfVuw70yz8jy+Hp0eUwVs1PVVc2VJYfC1El5PJm1a14O
         gc2GU4CXKwhBMRDUdek/T3ZGeXyJXaSIDPTl4ohx903QIE23yoUuYLbX1qC0EMC6cN
         asfHfNw03p6snqT64GbHjFxrvjNu3RXq19OfbgkmS8wJnYBeQNkXKfUcU4URMBSMCb
         i82jKz1SoUaFA==
Date:   Tue, 11 Jun 2019 10:37:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>
Subject: linux-next: manual merge of the fbdev tree with Linus' tree
Message-ID: <20190611103749.01b1f922@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Z4fE.w_vLjwIZ6T2Vb52IiE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z4fE.w_vLjwIZ6T2Vb52IiE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fbdev tree got a conflict in:

  drivers/video/fbdev/mxsfb.c

between commit:

  c942fddf8793 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 157")

from Linus' tree and commit:

  f225f1393f03 ("video: fbdev: mxsfb: Remove driver")

from the fbdev tree.

I fixed it up (I removed the file) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Z4fE.w_vLjwIZ6T2Vb52IiE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz+990ACgkQAVBC80lX
0Gyadgf9HgVSEMSbwgwG6QGeWoIEGU1Vjkav8JI4k4xrVlrgXoUce+w5rpXYPXGK
m9AXJ3pgqJwcyYoUWTAHeUhb8yK8LVC6dK4UcHUFED0v/SAdEZMf2ydElqB+uUkA
8G9id8tyNyYVkAbVeJ77NhaRMkcVpPp296x4XvMATQ6SFz0Uwc8QCL5McjWaFagJ
y2G8kpCwi0dPiRj7sJ0RdcamcDaQh6hNNZVaI9kWB0Z6iZ+nHty0CfRJ58A7Tw4P
umKx6heptIw6jOHqrDQoc7fs31FdfJRG2dbk2HcmreHF4BXZFKQ4ILJ5NWVKKrBg
bOntckzVRJyac2haE2KVLwqVf3PCYg==
=JfG9
-----END PGP SIGNATURE-----

--Sig_/Z4fE.w_vLjwIZ6T2Vb52IiE--
