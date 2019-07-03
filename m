Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0391D5EEAD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 23:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfGCVkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 17:40:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35319 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCVky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 17:40:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fF0L6Hsjz9s4V;
        Thu,  4 Jul 2019 07:40:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562190052;
        bh=OJkZFP6NLq65sEFJbDEd0fLNTRzT95OMdKUgd2OL9Sc=;
        h=Date:From:To:Cc:Subject:From;
        b=l56p3JrUNtO8evHe22TfzbBn4bfPliA+3IvdXQaMHmn9GlB7/CkKAKqcXGyHcOcGl
         lhj2wLKM95N1QOVHwfVGPMxFP28lk5XqiCH/KWly/EGVgd3H+w1hMmUDGHwjJZbl2C
         bdi3M2/9y7zqHrU592KQeRYZGxxfWL0oS+W7t1mpl9nTEB367cBSuScR9K9KiZkePH
         qMIvQ4i54GOhOGFyVtLeP6LCUwTNvQjDuCttEDrplU+UWQ/GEaEoPUjKeLC0sJCOiC
         EEgg0FLGC/0+vpzQeignhyxom1NThKeYIfWfuf1BBO/fwTpPX1hrfL7IdZEZXyhLnw
         oV41Xj40uzdvQ==
Date:   Thu, 4 Jul 2019 07:40:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: linux-next: Fixes tag needs some work in the nfsd tree
Message-ID: <20190704074048.65556740@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/b/qeFCIEeXvgCWd3GD4ZQkW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b/qeFCIEeXvgCWd3GD4ZQkW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  56496758e181 ("nfsd: Fix overflow causing non-working mounts on 1 TB mach=
ines")

Fixes tag

  Fixes: 10a68cdf10 (nfsd: fix performance-limiting session calculation)

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: c54f24e338ed ("nfsd: fix performance-limiting session calculation")

--=20
Cheers,
Stephen Rothwell

--Sig_/b/qeFCIEeXvgCWd3GD4ZQkW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dIOAACgkQAVBC80lX
0Gy0Vwf+JoN0chDWh0B0uJPZOkOpWZsCqskPBxQQBuCYzrGCwkFaMb7V7BvLNWPW
25NyLTLO7fUU7qxwmzoqAaALjKjG1mPncuWHcE0Ry1UuEm/+KJH/7E6JKaAtr7Up
9LZdtNpo22hvBFkff7rAs9jffhP3wepwAhweZ9XZXWKR2cgo631ODNFrOql15spH
43V2BtZk187iL6Q//1AV3fXYj/DEiWfvQFeo8M+MFmC/v77MX5Z4hNX5jfqV8JtR
g7mi9A+FZbi0uxjQJhN66bp6g68B9L3bEBHXq3QcuEMdlzeWfZjsq6qI88YsOjtV
xKmrwAfpaZeOPLAMt9J7QmFL3Z6CBA==
=6bj4
-----END PGP SIGNATURE-----

--Sig_/b/qeFCIEeXvgCWd3GD4ZQkW--
