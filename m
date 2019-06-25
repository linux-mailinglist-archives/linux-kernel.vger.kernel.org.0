Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9456A54D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 13:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfFYLHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 07:07:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42085 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730353AbfFYLHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:07:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Y3Jr0G8rz9sCJ;
        Tue, 25 Jun 2019 21:07:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561460828;
        bh=hihaKy7q1Hw5bYXccx1Cll49xww55TabiwALukVXZWw=;
        h=Date:From:To:Cc:Subject:From;
        b=jJ/aTvTtkzSN9TZ0pC0NtB/SLZsSu02TiC7sKVL1izYK6xqqIXHX+9vOT7K9IbXar
         ycn+it9rK+CBAwnvSpadm/DTfU8BkdDzh109Ej99LStphbaOTOySTJ8ksIx0fWxecF
         mdE4BPelZ3BkmwM9qIQ0SIC+dGIR5j07DfePCMSa5MIBxSEBkjQsc4Jb9NoAW3mfQ/
         8xRmU8/0EgkuQv1PlB8VQI3S+qBObWKhswZefqJgknPBGA3F422j8SHxCq8fUFBQm4
         M+3xSgVBi/8ETNxtVYRpojAYhBr1xQnBxV/Bo5DIWDktTgGjmrPS2KqLJTHOzSvU8w
         MlnGzn/DY4v0A==
Date:   Tue, 25 Jun 2019 21:07:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the parisc-hd tree
Message-ID: <20190625210707.61e689bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9WQy1MhcKPOXptjUFW=p1sI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9WQy1MhcKPOXptjUFW=p1sI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  7148d434d451 ("parisc: asm: psw.h: missing header guard")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/9WQy1MhcKPOXptjUFW=p1sI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0SAFsACgkQAVBC80lX
0GxOuQf+PyX4A4K61SVryWsqXxLvnTaiQ7krd5+xLJbUQsRkmGpIC/FoD2rzUns1
0jnnFuXNpjgzLm7Ezt8P2Kh2C16BIhfmp9+bpcWNBmXjvQCgGA0TJMTzKMAcTncS
I0BS2ak/kF98GXJGW8hYB0qnSd52RjJpolG+tOuzr6F6117jp90wiK7Ch+J01sho
tWCZIeOe8gtoqyfQ6bnxVmHIq+XAADYsgf6ugKHWhu0PcGMvQIkwA/e7r2P8loJn
cNLf1nt4mP2HgHQtC2bG7YrZ5xJxHuvMZFYf7ZnCIpzY6lln2RqfEaToV991nqBe
VhpHIWBdKLneqUo5l3DxgMU2Lqt/IA==
=g3Fq
-----END PGP SIGNATURE-----

--Sig_/9WQy1MhcKPOXptjUFW=p1sI--
