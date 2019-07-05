Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893A160884
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGEO5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 10:57:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41535 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGEO5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:57:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45gHxb6XmDz9sNs;
        Sat,  6 Jul 2019 00:57:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562338628;
        bh=txUqTds39BmFfn7YenAgJVcExVIYDOmEE3u2GkGoKyo=;
        h=Date:From:To:Cc:Subject:From;
        b=jHk7PfvnOGvFxcVCQgHNE92rmq2JkB2EOZtbkEuAlrpDU7AGXa27kxBnyAkWXbgbS
         Piqeroj6MuAhVnS1Fa0PLkCLEWZKvU6dg79FCFCW3PnKhFUon4PDB4GizIMWxm68kP
         TKL/cUavEpnNbsd3MJDWCTjc5BxmQFGgm4LFz13AIFDZ9FGD3HIop5wyz0x/mOGKTp
         Pp/Dd7uso/zae2QWMxPiPrUz3x8rDHnhITMnhNKongafPwxFzHvSkGQqZMc93XrEu1
         dYO/3nah7LeYbH9bj5rihq28D8EAx+FxdWbWgb7+kTe9+VrgvBxteo6CmTkT6fYOTN
         CoEjAY/y8DVnw==
Date:   Sat, 6 Jul 2019 00:57:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bodong Wang <bodong@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: Fixes tag needs some work in the rdma tree
Message-ID: <20190706005705.2e6c268c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D3uk7HqFxiY3baeN9l/BJnZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D3uk7HqFxiY3baeN9l/BJnZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  16fff98a7e82 ("net/mlx5: E-Switch, Reg/unreg function changed event at co=
rrect stage")

Fixes tag

  Fixes: 61fc880839e6 ("net/mlx5: E-Switch, Handle representors creation in=
 handler context")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: ac35dcd6e4bd ("net/mlx5: E-Switch, Handle representors creation in h=
andler context")

--=20
Cheers,
Stephen Rothwell

--Sig_/D3uk7HqFxiY3baeN9l/BJnZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0fZUEACgkQAVBC80lX
0GzvAQgAhSZsldECwFkISkBcmXbEgHqH9T3njoz/mlb505BE0Y6PPFM48biTQxDK
lGnAvagmL5z9W5E1xXFCy2eLRpbe3KSzCwEsrEBJgYq+gPnKQro9tT2XxtaaTZ3H
fl6nzhHrqWsMebZgwk4sWUC14dP5u++Iw0eqPvKpuGkmzZE57LoXhYky0gfdjaJT
1UU5XKML5fCGFhuJNSMlbpP84KtxfH7zEm6R3KvA2lGPlBdwQ8ky7winNuoLUJKB
xRBd1nwzg0uKGgkEKe+sfUtA2F+O8hh1DfjpvKu4F0pl59W4B/wJSMLN14cvLgKC
vZJsc3/wj/RRIXJKU9VaF5JW5hds1w==
=kQuu
-----END PGP SIGNATURE-----

--Sig_/D3uk7HqFxiY3baeN9l/BJnZ--
