Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F7E7E4FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 23:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbfHAVsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 17:48:38 -0400
Received: from ozlabs.org ([203.11.71.1]:38897 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfHAVsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:48:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4603nv05Sgz9s3Z;
        Fri,  2 Aug 2019 07:48:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564696115;
        bh=aIngYeEzEy2hPKC6P+EjAYCZpyzJwPIbJ1tSaVX7aK4=;
        h=Date:From:To:Cc:Subject:From;
        b=hnBldSv2ThzJTeoJ56CsuX9AZZdqlOAFGlw9OFGNNwylEkAIRLsOBWis7gWO/3n/T
         /aIUKShwD1j7U7Ds8sRAWdrxejNUdhXrp5aoB8h4wj6Q/LD8e67wY3y6VO+aFvxV+8
         9WWFeXEgYjWU4vGAGcADz2ZQ0M87B2RY/QdivsckKc1029DnmEsrYShpITkK0uHao/
         Sc7C/iBFtQh9l0PyF9RE/wNjL0Sum+H6wqO4oK/8sAsNAF2y4Y0G6AAV9yajAicdUQ
         huF2PWvKm9ezYzHAVbAp6kLY3kxWw/nldyK06zmShYgBCDfvG7+f/wvjdBuAid1iTY
         khLTJKgAgILkA==
Date:   Fri, 2 Aug 2019 07:48:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: linux-next: Fixes tag needs some work in the arm64-fixes tree
Message-ID: <20190802074813.73b82a14@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uWc0yy8xSu08lkEq9.urLiD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uWc0yy8xSu08lkEq9.urLiD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  72de4a283cb1 ("arm64: kprobes: Recover pstate.D in single-step exception =
handler")

Fixes tag

  Fixes: commit 7419333fa15e ("arm64: kprobe: Always clear pstate.D in brea=
kpoint exception handler")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/uWc0yy8xSu08lkEq9.urLiD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1DXh0ACgkQAVBC80lX
0Gy0rggAnS3PZqGfhWWnKtOBIRAxqGoAabOxnbJRg8bzQtU2x1vbYZ7Qw2P6KJJz
TGQQVqG+sIEEbP81Z0aX0Q0icz+Ft6oOLvOb2XOA4DVSnzs7Or2qGK3vbq1bidd6
PB/E8QEGdZUovcLyJT2HCgxTaor/Oqmh8PnniXmcURJr7U2YoJj6ihiVAZZXliBk
bXALsaeN0Wgx+Ygp+gVwKGXnzo83gbctMG21fvn67SHgJBxqvzhSUmmJiW3PaRAs
aCZR9cX0aqBycZCM9qM2VUaszEpHKskeYmXuLiNdB8/Bq/uF9OgBikLmQoP2Ni/2
wl77t3dqXitUbI2RKAk40UJFNw4RlA==
=qGdW
-----END PGP SIGNATURE-----

--Sig_/uWc0yy8xSu08lkEq9.urLiD--
