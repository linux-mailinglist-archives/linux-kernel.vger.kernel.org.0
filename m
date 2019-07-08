Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2CA62CA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 01:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfGHXZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 19:25:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54055 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfGHXZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:25:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jM4N2lfkz9sML;
        Tue,  9 Jul 2019 09:25:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562628309;
        bh=R6FJxEIW4X2axhdt72FQjel6rKt8A3pVIJFx6JmsHGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ESSB/OcKZMqBzCgnGPSvVQcyEUH0uBASuDbE3chu7UhXFDmOR/L11hDi+pbt2tVDO
         BCHtvPl22T/CBNGEQyQ92+WzxKw+mDsOVNMFBYuNpvvjm7QmXUZ9fKGZ5uZKqAXiPd
         onMYJyRTE+ODrGwuTeoN+/q/M6lHY4QVB1UdxrpdXDZaQNXorIzGVdpFp0jXX7KowH
         Hafxw7PBDOMgAaeLkq4zpUsEsrpDJYsgSD55m1Jz86mYk/5GVuznQDLntlclbydm3g
         dxjh0ALL4C37+4Qa+u62yodayz8Bn3a/W4q8yhuCXnho0MI8USNFouRY1BVYHFD4I2
         fIatmD51rLyqw==
Date:   Tue, 9 Jul 2019 09:25:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Herrmann <aherrmann@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: manual merge of the cgroup tree with Linus' tree
Message-ID: <20190709092507.67e13031@canb.auug.org.au>
In-Reply-To: <20190617160635.30927c7a@canb.auug.org.au>
References: <20190617160635.30927c7a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kJ7v3c9qB8HxFHJ.t.BCjjW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kJ7v3c9qB8HxFHJ.t.BCjjW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 17 Jun 2019 16:06:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the cgroup tree got a conflict in:
>=20
>   Documentation/cgroup-v1/blkio-controller.rst
>=20
> between commit:
>=20
>   fb5772cbfe48 ("blkio-controller.txt: Remove references to CFQ")
>=20
> from Linus' tree and commit:
>=20
>   99c8b231ae6c ("docs: cgroup-v1: convert docs to ReST and rename to *.rs=
t")
>=20
> from the cgroup tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc Documentation/cgroup-v1/blkio-controller.rst
> index d1a1b7bdd03a,2c1b907afc14..000000000000
> --- a/Documentation/cgroup-v1/blkio-controller.rst
> +++ b/Documentation/cgroup-v1/blkio-controller.rst
> @@@ -15,15 -19,71 +17,18 @@@ level logical devices like device mappe
>  =20
>   HOWTO
>   =3D=3D=3D=3D=3D
>  -Proportional Weight division of bandwidth
>  ------------------------------------------
>  -You can do a very simple testing of running two dd threads in two diffe=
rent
>  -cgroups. Here is what you can do.
>  -
>  -- Enable Block IO controller::
>  -
>  -	CONFIG_BLK_CGROUP=3Dy
>  -
>  -- Enable group scheduling in CFQ:
>  -
>  -
>  -	CONFIG_CFQ_GROUP_IOSCHED=3Dy
>  -
>  -- Compile and boot into kernel and mount IO controller (blkio); see
>  -  cgroups.txt, Why are cgroups needed?.
>  -
>  -  ::
>  -
>  -	mount -t tmpfs cgroup_root /sys/fs/cgroup
>  -	mkdir /sys/fs/cgroup/blkio
>  -	mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
>  -
>  -- Create two cgroups::
>  -
>  -	mkdir -p /sys/fs/cgroup/blkio/test1/ /sys/fs/cgroup/blkio/test2
>  -
>  -- Set weights of group test1 and test2::
>  -
>  -	echo 1000 > /sys/fs/cgroup/blkio/test1/blkio.weight
>  -	echo 500 > /sys/fs/cgroup/blkio/test2/blkio.weight
>  -
>  -- Create two same size files (say 512MB each) on same disk (file1, file=
2) and
>  -  launch two dd threads in different cgroup to read those files::
>  -
>  -	sync
>  -	echo 3 > /proc/sys/vm/drop_caches
>  -
>  -	dd if=3D/mnt/sdb/zerofile1 of=3D/dev/null &
>  -	echo $! > /sys/fs/cgroup/blkio/test1/tasks
>  -	cat /sys/fs/cgroup/blkio/test1/tasks
>  -
>  -	dd if=3D/mnt/sdb/zerofile2 of=3D/dev/null &
>  -	echo $! > /sys/fs/cgroup/blkio/test2/tasks
>  -	cat /sys/fs/cgroup/blkio/test2/tasks
>  -
>  -- At macro level, first dd should finish first. To get more precise dat=
a, keep
>  -  on looking at (with the help of script), at blkio.disk_time and
>  -  blkio.disk_sectors files of both test1 and test2 groups. This will te=
ll how
>  -  much disk time (in milliseconds), each group got and how many sectors=
 each
>  -  group dispatched to the disk. We provide fairness in terms of disk ti=
me, so
>  -  ideally io.disk_time of cgroups should be in proportion to the weight.
>  -
>   Throttling/Upper Limit policy
>   -----------------------------
> - - Enable Block IO controller
> + - Enable Block IO controller::
> +=20
>   	CONFIG_BLK_CGROUP=3Dy
>  =20
> - - Enable throttling in block layer
> + - Enable throttling in block layer::
> +=20
>   	CONFIG_BLK_DEV_THROTTLING=3Dy
>  =20
> - - Mount blkio controller (see cgroups.txt, Why are cgroups needed?)
> + - Mount blkio controller (see cgroups.txt, Why are cgroups needed?)::
> +=20
>           mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
>  =20
>   - Specify a bandwidth rate on particular device for root group. The for=
mat

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/kJ7v3c9qB8HxFHJ.t.BCjjW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j0NMACgkQAVBC80lX
0GzCvQf/XkAqkeTOZo1K5M0zNn1fj0aSnvRRmEj3VGuFnaLzMEJekkucjrKElFcu
0o6T7bNrn7N+XQvgkyuAmdR4gOJcUJfuxtZ+2NSSI8FpN47GK5yuT8ywkjWFMB/t
pM8RFJ5MDc1bOk8Q9Fiyj+qX9IntcEyw4gnCNPQe3Rn3bNZ6kS7xdZSrcE1Qtcya
h/3U7H0lOPO/Kg6dCzGIFsaPAiEKgX7qw7nPYt5E3wC3EAEycH7SaFsE3LQr4lAa
C+dM8cPT6/qp8chGeAJGI02N9ssPCD5dfkmxMTv7ZjWMVt6oxyXJ6Dc33WwcATW1
t+5bF6zZZ1E/h+7wgmLh2c+sIXAXSQ==
=hhZv
-----END PGP SIGNATURE-----

--Sig_/kJ7v3c9qB8HxFHJ.t.BCjjW--
