Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F196A004
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 02:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbfGPAqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 20:46:34 -0400
Received: from ozlabs.org ([203.11.71.1]:38985 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbfGPAqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:46:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45nhY24fvQz9sBF;
        Tue, 16 Jul 2019 10:46:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563237990;
        bh=NYPbY3fuAcWI162LDv1eE5JulP/EGNYsx66AjCIB84g=;
        h=Date:From:To:Cc:Subject:From;
        b=Jjkh/CrcSp5ovD/SmkbRdG+itfCAVgoVFJs9TncswZkG69mxtiNJaYWf8GQNCfmQY
         UyizlxwCMKm6diOwMZOSLmoxu5k5ha7nHt8P0Lo6qRwo5NvxQRan51k+xWUfcf/M5N
         zjAI6I0gUbzUqFvVZrgxxkkdtOWXXHmD8/ZHqqks2y1ptuDvWh8h0r3WbtP0jIdhmo
         xrsOq5+pvShDWLK/BK9OOBNlIsPBqyj6uibHx3BDwdYFPhgW0sDMzPL7mLhS/cSPcp
         4u+BKpe789QMGmk2Kuao/xOj0lZ2DiS4g7WUXIveHGprlPw3SBLQGE70MmLYpIrQFo
         8d5t3/zy0B7Mg==
Date:   Tue, 16 Jul 2019 10:46:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the rdma tree with the v4l-dvb-next
 tree
Message-ID: <20190716104614.2ec8b57c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UCF0+_SusNV/iWmB5bDZx8m"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UCF0+_SusNV/iWmB5bDZx8m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma tree got a conflict in:

  Documentation/index.rst

between commit:

  09fdc957ad0d ("docs: leds: add it to the driver-api book")
(and others following)

from the v4l-dvb-next tree and commit:

  a3a400da206b ("docs: infiniband: add it to the driver-api bookset")

from the rdma tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/index.rst
index f379e43fcda0,869616b57aa8..000000000000
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@@ -96,23 -90,9 +96,24 @@@ needed)
 =20
     driver-api/index
     core-api/index
 +   locking/index
 +   accounting/index
 +   block/index
 +   cdrom/index
 +   ide/index
 +   fb/index
 +   fpga/index
 +   hid/index
 +   iio/index
 +   leds/index
+    infiniband/index
     media/index
 +   netlabel/index
     networking/index
 +   pcmcia/index
 +   target/index
 +   timers/index
 +   watchdog/index
     input/index
     hwmon/index
     gpu/index

--Sig_/UCF0+_SusNV/iWmB5bDZx8m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0tHlYACgkQAVBC80lX
0Gz/0AgAnh5PF5cFTlabGAwhQDCkqtClfxWieEu8pcv1ru0QiNKScJGPb8VuicrB
y9bTB1RtJzuR9jaP/Fz6cb0LSCwZKlJs8TdyJOR1c+dHaulTYFq4HVOrZ1ls468t
tAuYWIKkNxoOSSO87TTd+Y1XpG+Fu6nK1e7eyCax8s4Jyos5tmiT6umF3+HXoopW
EJwi3KN9Kx0CDEApn7ydfa4sayVVDgG8YO4hPB79RB4pBy3bgI0uYwW2A60nnunt
2gvF1gFnglG//LUPIJ4oC/jHsoLK94Lc9nrPJGEBwlURUwdh2zR1srBZjPpHQknQ
xVPA24RSzuNdEZt73i3ZdAIkmcgmUw==
=TjnG
-----END PGP SIGNATURE-----

--Sig_/UCF0+_SusNV/iWmB5bDZx8m--
