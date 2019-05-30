Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925F32F65E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 06:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbfE3Eze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 00:55:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389159AbfE3Ez2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:55:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45DwHy1HfMz9s5c;
        Thu, 30 May 2019 14:55:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559192126;
        bh=u6qX2YcuuXUCj/6CtLWX3CJivrXavFG+g3vTC3MYfAc=;
        h=Date:From:To:Cc:Subject:From;
        b=MwFQC0UI8ucaEuuFqT5vif7bsig8REJxHLJjTwdpysfmXDzHBsd+c90jQQ9Eeu3xj
         mJCgs3itT/0eovrlyNSDloRzfbglDsAJCSOqJCFo1vAmAHtlmFWizmY0j3ft8sW+Vz
         CDqY54mnIT5cucBWn8DtEfK12V+vo5KkHLk0AlXNe/SwGPj/d6BcpvBMDhxi/9YQqW
         DCkSyR9DPw3U/CYlPmyYdatHaJQpiDQFxtODblzgk4UUWctpnROXOk/CoyDMj8ILiv
         jl1N814XoOGvgsd4K3CSiHrGWM7zJraRNlXHseqXzXMLA5ZuPqE7K9Ep6PkM5a6BwA
         tYfg6n6xDcefA==
Date:   Thu, 30 May 2019 14:55:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matteo Croce <mcroce@redhat.com>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190530145525.3cca17cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8aSEcKm1n18JLWopbjCv0hG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8aSEcKm1n18JLWopbjCv0hG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

net/tipc/sysctl.c:42:12: warning: 'one' defined but not used [-Wunused-vari=
able]
 static int one =3D 1;
            ^~~
net/tipc/sysctl.c:41:12: warning: 'zero' defined but not used [-Wunused-var=
iable]
 static int zero;
            ^~~~

Introduced by commit

  6a33853c5773 ("proc/sysctl: add shared variables for range check")

--=20
Cheers,
Stephen Rothwell

--Sig_/8aSEcKm1n18JLWopbjCv0hG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzvYj0ACgkQAVBC80lX
0GwB6wgAmmW1oDLUmcW6Jc2Q79FQC0TF/nrsmwrnrFajk64ae3ZfZYJpfRZn++9p
QyqqPNyEIKbIeFEZ2TG30LPZ6NgKStitxF4MhgnUr25NEmp1WjoCbniZhxNy4YG/
7VezifgRRiWkaTEHWutSDvdyiq3y6lR9K6flYYr2oQhpCnvqlAWLVyn6gJNTh9Vu
boELoEuJsePyiayxjK/Hryp4QW2b2QVMlU3uooueo7mVRUsxzeNd/nwiEgLFmmEO
e/3rDYA8yhCNKSy2zWw+40bSjpVY5MTm0moLBOM9Gnw4aTZcVyPtG+Pq4fpnED+T
w8ClR4AEddix/9uKLHAAw4mDvuSQFA==
=kH6a
-----END PGP SIGNATURE-----

--Sig_/8aSEcKm1n18JLWopbjCv0hG--
