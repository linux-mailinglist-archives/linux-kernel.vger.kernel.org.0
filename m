Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154233C134
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 04:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390801AbfFKCTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 22:19:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44257 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390455AbfFKCTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 22:19:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45NDGd2qLKz9sCJ;
        Tue, 11 Jun 2019 12:19:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560219581;
        bh=riCLNpOP44OBCwlLt1K2xxEy7XqqVkYwOn6mw2Or/+s=;
        h=Date:From:To:Cc:Subject:From;
        b=bEVS0WB23bwo1ka49nKFafHCSBvAdzzdIbYBwGClmezK6vJr/cnLI4J8YpEmlP/kU
         wINTJKYSfBgg1+mER7f8TyTRVCsfH0BvUkudB7gRQ0lVz6wMq6selU6BXr5v7Iryp5
         1daVSwJhZZTdGFofqIqQq5uPyS5uDKC6sEtimvGX2JYo1JYAcG4K5BDd5RsHr8iRtu
         VanigzOBpT6VuM6WBGGye8QRHCbl6Cc75lDvRmnVFDId8IEKMoIon4jM60LpbzMdYL
         zxHclboS+MP9+zrYEAJL0KiSda75Vf/wy3BzjK4mqBGZl0ft8MMmwRKvsB2k2wTTiM
         IoJV9bSDSlMbQ==
Date:   Tue, 11 Jun 2019 12:19:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20190611121935.5c7807bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.HUYm0xNRyThX+AV/LktJUw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.HUYm0xNRyThX+AV/LktJUw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got conflicts in:

  drivers/gpu/drm/cirrus/cirrus_drv.h
  include/drm/gma_drm.h

between commits:

  a61127c21302 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 335")
  c51669eafb45 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 377")

from Linus' tree and commits:

  d825c565304f ("drm/gma500: remove empty gma_drm.h header file")
  0388f2f61bef ("drm/cirrus: remove leftover files")

from the drm tree.

I fixed it up (I just removed te file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/.HUYm0xNRyThX+AV/LktJUw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz/D7cACgkQAVBC80lX
0GxDewf/aYO+GE3bsUgYe3Pl3au9KebW2srvatsyblkIiqiQzkiuDhjHTM9qHof+
mp8KesGMbmw6IUCV66A0kjT1Qb/FfTHULcJ8LQ3ptqJahvF7lUnAzs+LqwUBf5V2
2kTKMGDy2MqS4lUmhaUDDd+LE1atUwdcdWa7Cqmg46PqZ91p6ncdpkudib+miesp
5zx0eEDi28icTWUINqg06Xx4nwtnZ4V9eWofVoDVQapQEunWJt89/w0X2F63FvW4
/RJ0Z2gumS8QAG22Yv9+twZfQtew3VPWDscsazgS3MEN7+4DuxRh7ceEt7K7V5Ty
SZfqOakOm91+6MB3SwQmBlUpih2tCg==
=7AzB
-----END PGP SIGNATURE-----

--Sig_/.HUYm0xNRyThX+AV/LktJUw--
