Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6498C63584
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfGIMUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 08:20:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55623 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfGIMUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:20:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jhGr3PWfz9sMr;
        Tue,  9 Jul 2019 22:20:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562674820;
        bh=HoygXb3/Zo6Iy6m7TvCJiEIzVG8U8NQlgvLlTjIgFRk=;
        h=Date:From:To:Cc:Subject:From;
        b=EJlZCQjiwVJbUoyiH/6xvaU+bilP3uWZ7eeqf6tNeOiZvVv6E+I3cdjFc8MMprOMr
         EYb1v2hYyIrpvWXw4LdFroayF6yQl3ERGVJ0BRMB2eNsYrIdEBp9jpakZiajbt78vV
         Nh6jW6rEUMMJyKkNNNqYNqRqOxsplDfUtzbp9mOBUCIz6u40WE/tt0iax7d1sl4+mq
         izboagDTxjnRb7RrCrCWdwaZ2BtEk92SIElkzBmwvo336Y0LBUdPni0gYysmgVhEvJ
         zW6EsMUkgrYzkQWjTC1EyNxvk8QHN1qrK760myabEF48ZPdmN4eCUvFlfXiYg0v/sJ
         O2tqkRzQ1gQ2A==
Date:   Tue, 9 Jul 2019 22:20:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kbuild tree
Message-ID: <20190709222019.5359e707@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lAHwKFOoHd3kTbOgLtIp/GK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lAHwKFOoHd3kTbOgLtIp/GK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8eaeddd155af ("kbuild: header-test: Exclude more headers for um and paris=
c")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/lAHwKFOoHd3kTbOgLtIp/GK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0khoMACgkQAVBC80lX
0Gyqfgf/eRUoUbdzGWq+N08wWLBPCbzjPv0tXnpn9lc9ttbdCTizlrG2gkTPW/yE
rORFZmWu52WeobEoDXZ6WX/0cHAdAt8b6ICLwY1mF/MfRNiKhZpjLt3Y+UOEXRYw
LKMWDKd1Ze6GKIcI62a2zGMNGIqZvUJeOQ5I9fzDzQnHucQa4Oh4D0UwNay1Z0sr
r8T/k3LmBSiipY6u549xM4UIxBshGg504AMhxrdqRmBI3GrQLmKuPu6tpDd2IC4L
wPF9OlVlj2W3SylACz0E7/Z6Ay97rGSrpSkPbzjrJdWof+jr4auiQ3FCWXsviDlK
9CwRTGLmd2kr7LQkS97aKjvViUO2aA==
=Xsmp
-----END PGP SIGNATURE-----

--Sig_/lAHwKFOoHd3kTbOgLtIp/GK--
