Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17A564CB35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 11:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfFTJmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 05:42:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfFTJmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:42:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Txgp5M9zz9s3l;
        Thu, 20 Jun 2019 19:42:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561023766;
        bh=BnWu035yer0Ose+3iL8DXlaSET5VRns6Pd3E+LOltjc=;
        h=Date:From:To:Cc:Subject:From;
        b=KjdMkESukwjUSnxFl6p2jcFLOM6qGW7HnGqsvxlbXqyBAWf161K1/S6UIuwoV2xg7
         Xr5Cwy3yvBxXuFkr5ucHmTwpxBzdDEYiSqvT23st5CJIfBxjKUzDliu5vQuSAc+a6R
         GmC+TCetO3vwFE1ezEfcaalPnutbzdjRiepWJ4o3c82s2uR10OMq9q7Tbj1dcu9Vrp
         xkyUL2aWm/fsdBfawjJrAhnUPpuBZImGDixNclx8mccBjqkFjnloA80U0nSAx4PECb
         IkVPWX5XjpYNx2T26O3VkP4cE+e+jnTX5IHsH4XaLC5FkxCXZhoSGsr7LYddO90yHd
         jfkr0Q3Tqx7pw==
Date:   Thu, 20 Jun 2019 19:42:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190620194244.474a83e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GmjbN.zEeNy_F7a4Pi8p9zb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GmjbN.zEeNy_F7a4Pi8p9zb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/base/memory.c: In function 'find_memory_block':
drivers/base/memory.c:621:43: error: 'hint' undeclared (first use in this f=
unction); did you mean 'uint'?
  return find_memory_block_by_id(block_id, hint);
                                           ^~~~
                                           uint
drivers/base/memory.c:621:43: note: each undeclared identifier is reported =
only once for each function it appears in
drivers/base/memory.c:622:1: warning: control reaches end of non-void funct=
ion [-Wreturn-type]
 }
 ^

Caused by commit

  29be27f12cc8 ("drivers/base/memory.c: Get rid of find_memory_block_hinted=
()")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/GmjbN.zEeNy_F7a4Pi8p9zb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LVRQACgkQAVBC80lX
0GxWxAf+P8Opt9Xr27NriFBGKoLNBakqhKlgZrTWQ30uTIUgr0KqcrgmYij642pi
yVHz61M9epU5ZQfv7gtAgD8ikUbRmjUeiThqXvlvZtEbJFeOtcnhgEf1exq5Fc0b
G5x6PL4H0EaHCjDm3zS3HNyGycYfcqgHciyCPpgLdA4Om5Y3U7kc7DsPt7s+/c5+
agUXoocujuj7ZmH7QK64BezQeGUPOluyq/TPf2TT6kvI1+nw4T/Sic5XtDFKTFwT
cFfdFlRBVPWGDGPpr5H4LS2RpP+Aj7XK2b/HvDXq+xMSDZnV6WrgUnXaBT2iTr5m
4Y2JCeN/2WBAAMPWWXvGPWztHu/gPw==
=1t42
-----END PGP SIGNATURE-----

--Sig_/GmjbN.zEeNy_F7a4Pi8p9zb--
