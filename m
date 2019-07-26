Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63975E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 07:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfGZFtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 01:49:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48479 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfGZFtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:49:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45vyp371pVz9s4Y;
        Fri, 26 Jul 2019 15:49:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564120172;
        bh=ctSMwARS1PqMRvmez8r6GVeBL1+AKxRRl4x7F2Eg+zA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ncsrw2og3I/PSv/ypTSfueuwbuyB0haMWpEMaCp4qnbLvY1k42nLro+nYEknP+tHT
         3bLy7kUbgPah+kNVeTBsyId7OXCOAnmT12qw8w9VSniM4e2ny0YlMsXUYpFYTBWq0m
         IGZuajm8tKQPGWNY5GdkKfRNzwGcZ27qNZfUW39nirU0OJUz9xNDvWikb2SmRA61mx
         0ygz3bwEkP3s2i/kHS4KyngLOGHWafq7f+FMgTgRs58kAbyFTtgMoTbOmr5lW/tUXE
         J/KmukC4FDhFx/MxVqjYSnQrhyzetGYqyFKUk5O/mszoY47dqiiM0Z0Q/ZO6z/iIkf
         +9ALSjV5e9eIw==
Date:   Fri, 26 Jul 2019 15:49:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <20190726154931.1d2fa8d5@canb.auug.org.au>
In-Reply-To: <20190726044909.ubf4rhzmsgjd3xgk@treble>
References: <20190726130327.1f707cb3@canb.auug.org.au>
        <20190726044909.ubf4rhzmsgjd3xgk@treble>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MqXIVcadHNhZYb87e7oTTiw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MqXIVcadHNhZYb87e7oTTiw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Thu, 25 Jul 2019 23:49:09 -0500 Josh Poimboeuf <jpoimboe@redhat.com> wro=
te:
>
> This will be fixed by:
>=20
>   https://lkml.kernel.org/r/51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564=
086017.git.jpoimboe@redhat.com

Thanks

--=20
Cheers,
Stephen Rothwell

--Sig_/MqXIVcadHNhZYb87e7oTTiw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl06lGsACgkQAVBC80lX
0GxPPAf+IgPFJ1HZy8aqJdpQcBMH2lyLZKe2fhl7igFGuMVUV8XAa6qbatboguN8
t0cJVzmYQNAXTz3zZiEyersanUCyhqJJsQn6v4R5vTwJXKa5e0p9z1F459WUjtOV
mBESoOJsRK3GU/QieyqPvunbzbMEnjVHjlFuPPIGNP0Nh/pUfpcYkm+D3mRkwVeV
x3f7Ml4L8zHKJ39biww7r5FM7m1nNKpVLT19f/mHHNiHRLeTaTBe8jH4p1GzW8/g
4pO0YjdyqCG7UIKBmnDEuEmZYmYdVeXthuxE4ZP698nXOLAZSz2fyV6sw6TXSSuG
TF81P0kmfvRhNJmtMiniaffJv1X0hQ==
=awb3
-----END PGP SIGNATURE-----

--Sig_/MqXIVcadHNhZYb87e7oTTiw--
