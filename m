Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCEE1242D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 23:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfEBVfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 17:35:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56807 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBVfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:35:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44w7q80xRsz9s9N;
        Fri,  3 May 2019 07:35:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556832948;
        bh=pcMRuo2OC5AoJySKNsfJAye2bVUDGeIQF2ObzMd1sYQ=;
        h=Date:From:To:Cc:Subject:From;
        b=kDi19J9IUudhj6btQXde23pJmwohp0m2RmzH5IsX2w3jwcKgF6v6IbiWwYWFY/Win
         6BSWFcXY1wfGVtBfSjY8q7BvRceBEhxFARQew1tRIorzacKMh0Kq4e7HqTuqu2uCZ4
         PE80AjVXjG+JbDd+8sWSWTYKS0+5XeBmdIARboNkQlnGTBVGEYAvN4BmCYpqK+xSgt
         V8T/cI/wPGLgNDlCtWl2j44jmJsEpfUq10I6IMIRcri7c3PHNZ9t69CdgZ36a4l4DZ
         uTw2g4cgxNivxN/0kUWGcZs0mrVerf/WQaUAHK7KT8P76pUoYlDElZp9clwZGtuTK/
         zTh5lBKU8mkbQ==
Date:   Fri, 3 May 2019 07:35:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: linux-next: Signed-off-by missing for commit in the btrfs-kdave
 tree
Message-ID: <20190503073523.5fa28df7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/txrj=/ehl5h7oLp=pKu4Epq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/txrj=/ehl5h7oLp=pKu4Epq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b835a4a3faec ("btrfs: use the existing reserved items for our first prop =
for inheritance")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/txrj=/ehl5h7oLp=pKu4Epq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzLYqsACgkQAVBC80lX
0Gxsvwf+LE+kqv1DiuGFmEuhmfufcHuz4S2WAx6ccH+IYkg11gRIoGtyFfuRKZG9
LP5RYV7m9eKu3hCX0ag8xDdFeqVAUsWWT3X5SCthln9dGTe2ltwZinWG0EHU//in
WT49iYqbXpsOVdak8H/IXYPujz3SA0jH7r3WLWHG3+/sBKrU6hxYRM06D7BgUkHB
dXRUqZQ3Qe0s60/hhWS8U1rdTaInYkFRdE5cFXL61SR8gMzcLQhROAllNjo7adLu
Czo84KPjQjQSeWIsIGjNrsBhC/AlG/fSf9dVN8oYqraKHgD7AcENjOgbQbxVd6iX
OQnUmBbGKLySgWi9Hte1TYPOFz0XPQ==
=nx9F
-----END PGP SIGNATURE-----

--Sig_/txrj=/ehl5h7oLp=pKu4Epq--
