Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC68154F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 22:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEFUgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 16:36:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfEFUgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:36:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yZJb1RGzz9s6w;
        Tue,  7 May 2019 06:36:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557174975;
        bh=yRboxG6cZAjeUj189gOH45xKEr3blFB/J/AR8hpVvHc=;
        h=Date:From:To:Cc:Subject:From;
        b=NAzwDe1PT944tDLSw4XPcGtn1GQM2Qeit+2VFWb3heqvpDHXB6s/sHshb3WqZv1Q9
         5rxjm4pivsm3e0ccQwrYErYRJbswIWcSdMS++XnVBv+2lIgDGPl6NLTZ1qtjhXBA//
         hi5knqrTWkjdWRFin4nFbH1Z+abpGXZdkkbLtEY0qVo4oTg+7FBlcWqeGIfqq3fGLb
         1TIC97ra3Wk5ZMEXiW8ZHNiCtKGq61ir/rfDJosbg5RnJ/O9+nteTd5ggHgAwKom/O
         fkMwkiDtbi6ardu2of3j8vHiVfze1YeKzl2goflqdtumYu2PcePD7nQA8j8dZLbrCk
         IDPRCcvVOxGHw==
Date:   Tue, 7 May 2019 06:35:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: linux-next: Signed-off-by missing for commit in the powerpc tree
Message-ID: <20190507063559.4922971c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vzW+/dFCG.78gfMV2QMIxFu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vzW+/dFCG.78gfMV2QMIxFu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  04a1942933ce ("powerpc/mm: Fix hugetlb page initialization")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/vzW+/dFCG.78gfMV2QMIxFu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzQmq8ACgkQAVBC80lX
0GwBxAf9Hi/CMUKMMo2Kt71IgUgPJ33Fa67pr2leR6MdL4qYbBfo4oXcSlO2AI+m
GJBmhBEz0ozzZpDwLpHc4eIm62P7COZ1bAUQZ/Q2GAm04UUU/3hHeoQbBaRj1DYE
FzPnaW1bx0mBkS5f5mgJq8zGEO5DFoBinXpy/r514jZ4THJjo81GSB3wnhJf2ZU8
BaxbIXmCit+aHrcRQTfn6qBrcTUJ8XqLdjyG4WkEineIXtoRzU9TLocaPNGbM89O
fQ2H81T+yIM5LFC9ITBzNUm6ZfwpeG79hKNoTxHRlCa4PaP72URTbUaeYO5MflXU
MMvGD07VdnDRFWoGaTy4CANhH1LQJg==
=K3O/
-----END PGP SIGNATURE-----

--Sig_/vzW+/dFCG.78gfMV2QMIxFu--
