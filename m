Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB325B5A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 09:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfGAHP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 03:15:29 -0400
Received: from ozlabs.org ([203.11.71.1]:60319 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbfGAHP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:15:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cdth4Rf3z9s3Z;
        Mon,  1 Jul 2019 17:15:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561965326;
        bh=NQCoMmp1fRfhn8eCaGqip33lfSACdYmYe4GpESB/Ko4=;
        h=Date:From:To:Cc:Subject:From;
        b=iOnubJZ0VEAkAq6nY1PaIw5UQd8sC+zpy0TBmfC8VNL6iOTuXYJgy+GIy8pArqr72
         Py0QiF/98+5bd3EdOSiYSQF9yrEFCqhQK0A7mwyqSXOJEK2fwjnU4YLzUDwy/mhnt8
         GUAhhD0Jtt0Hk3DV9xly0MYo8CDEmjD149IG5ruOUY+Tiq8P6FaWV/i3Ck8Ottv+hL
         B9LdujG2gdloD0E6wT0AU0jJOmHqnKufOVnqTVyKrcnLiL0h/lZO9qp8X4P27xdb6v
         X0OUAK/OQVN9lqumYB+7px4SB98fOXFLbfX7OXn1VStKKbX04XQmabvcC73wj1e2pG
         f7yNwgdbbYKaw==
Date:   Mon, 1 Jul 2019 17:15:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabian Schindlatz <fabian.schindlatz@fau.de>,
        Len Brown <len.brown@intel.com>
Subject: linux-next: manual merge of the tip tree with the hwmon-staging
 tree
Message-ID: <20190701171524.774dfc75@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HrNCJG3JCzkTk8y_hkyymzc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HrNCJG3JCzkTk8y_hkyymzc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/hwmon/coretemp.c

between commit:

  601fdf7e6635 ("hwmon: Correct struct allocation style")

from the hwmon-staging tree and commit:

  835896a59b95 ("hwmon/coretemp: Cosmetic: Rename internal variables to zon=
es from packages")

from the tip tree.

I fixed it up (the comment fixed in the latter was also fixed in the
former) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/HrNCJG3JCzkTk8y_hkyymzc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ZswwACgkQAVBC80lX
0GwZQAf/f5UwVhk2Yx3oPfS1elxVbRN00idMMvrACIO7LTaKDcaNRHE0UVWtRVzL
OmSo8yXqMxAB1G3DG1oCXQ3pSKUGYBEuKGfP3XmS61IRl/tFw8vbcjArWuXesHbM
a3t1JJ26DoD+/x8tY/TavraLvOmXfQp5M+Ev5b2zIsrpwXlXr9FEIxYl1f266yq4
Zhu61/5EZvjjgt6lYVWWTUDih9zU6uZefxrtPm83b8zS9AtYfK0rBsmn2kY5awOb
j1vOfMNK4aGz4GY7wTEiBUh0Ju1VnSjvSDm8vUwIvHNFevO1n7ZU2XEgYNjxvhe9
8rmu3Lv2X4byUCwj9esQk5sBKsM6pA==
=dxoz
-----END PGP SIGNATURE-----

--Sig_/HrNCJG3JCzkTk8y_hkyymzc--
