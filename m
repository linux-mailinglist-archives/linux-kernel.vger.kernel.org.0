Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DE679B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 23:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbfG2V1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 17:27:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52169 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfG2V1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:27:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yCSn47g4z9sBZ;
        Tue, 30 Jul 2019 07:27:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564435641;
        bh=5SYlHagQN9wuhawv6nZ96Yt+4ofAPf2cqsGCK/7tpC0=;
        h=Date:From:To:Cc:Subject:From;
        b=HSY0qQin76PQJJ/OaP35NzsACwj2vh+vigZR3A9FyZRWq6CX4fzWXx635b0G3RATx
         99bTUuYhqORKL7DQZK7M4HAVJ63ccL1Gj79J0sOIgJFQ9lPBRQ193VFm2TUHGETZny
         r1p5Bd6aR/0ls/mjRFs9g9utr8JdLAY06ooItP/GJP2hj8m7nZmBSnj2zGaJoZ/zWF
         KNxkA0MOoqyezn8Fx1ho8qrW28EJgOUG+GmYGQxKXqIHHRebPTFzO0xlRgrhSTTbvU
         JnXuVWqsHOUomy9FooMv5cRJARSDBzg62fV1daceRVFlxUX7ze3fbx/DmzDloWlFFd
         aXqPAl7/DIFBQ==
Date:   Tue, 30 Jul 2019 07:27:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: Signed-off-by missing for commit in the mlx5-next tree
Message-ID: <20190730072720.44c0db8e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S2FORy3FZTRNcBTKBCpZvyM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S2FORy3FZTRNcBTKBCpZvyM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  cc1c097b880a ("net/mlx5: fix -Wtype-limits compilation warnings")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/S2FORy3FZTRNcBTKBCpZvyM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0/ZLgACgkQAVBC80lX
0GzF2AgAg/s0gIZrXR2d8jEFwgemoeBFv+HPldC/6WbcWfIbuJIU7zYQBFZfoIW+
FyQ+9hKJOFiDRkUAnWdbsr43CmCiLckXIRNmuq/ICiithuEq1l/DLh04rFuvSkEn
aHOuiTx6aIDNQYr4tcEJkDPzvKr+zLs6WG7SySzpcN7ztEx5SqKXuBUnlP4Jnp0s
oRSYpEdGk6ER7faXZ8/GtxXdOfGUoEWc+M9uGGtD9XgYrcaMd4CvQxeYcPmcUlKL
tf/a+ed53QcFNIBN6kKVFd5bpa/57fLOMDZiPoYn1I+INzTaUwb4TSLLPkmHHN9U
16QdtE4cj+4im5jxo1CDj8M6HJ+j1Q==
=Wuqk
-----END PGP SIGNATURE-----

--Sig_/S2FORy3FZTRNcBTKBCpZvyM--
