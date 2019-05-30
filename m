Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715322F0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 06:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfE3EHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 00:07:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731084AbfE3DRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Dt6n5N36z9sQr;
        Thu, 30 May 2019 13:17:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559186242;
        bh=9+KNxKl040dLwGXZ8/yu2FEkk+iG0IsjYZFOHUKcuRA=;
        h=Date:From:To:Cc:Subject:From;
        b=vGCwgvCrGbi8kUfybY6qOeaGw3gfTGVIT8rEt4UPomauQWv181+NLL04TfzN5TXqq
         merrCo6EvDiX5DmvvtMzfXI4Q2rROxjGD45w+ksoTO/b51ssEyIJz+z098d+BdqqVB
         wirJnpyma6zcPOyVSqzeUFHEamKtIFqhKpNkXgK0VWRWJQ751i1zMGYvHvktzmOC2v
         I0klK38eCkHCwMlCFqe+u4w008uXBAxztBXSAxvqvraIPv6RNo/0M1LnVWzpq80CE+
         zXDqaaC/1/myHKROvLerZjC980raeT1rbjAMz/Jow7+EkY68YwEJtkGDMQClzj2rev
         q1y7g8uok0yRQ==
Date:   Thu, 30 May 2019 13:17:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: linux-next: manual merge of the userns tree with the arc-current
 tree
Message-ID: <20190530131721.0af603a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/w7Q+15IzRn7eThtdIF/Em2R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w7Q+15IzRn7eThtdIF/Em2R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the userns tree got a conflict in:

  arch/arc/mm/fault.c

between commits:

  a8c715b4dd73 ("ARC: mm: SIGSEGV userspace trying to access kernel virtual=
 memory")
  ea3885229b0f ("ARC: mm: do_page_fault refactor #5: scoot no_context to en=
d")
  acc639eca380 ("ARC: mm: do_page_fault refactor #6: error handlers to use =
same pattern")
  0c85612550a4 ("ARC: mm: do_page_fault refactor #7: fold the various error=
 handling")
  c5d7f7610d88 ("ARC: mm: do_page_fault refactor #8: release mmap_sem soone=
r")

from the arc-current tree and commits:

  351b6825b3a9 ("signal: Explicitly call force_sig_fault on current")
  2e1661d26736 ("signal: Remove the task parameter from force_sig_fault")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arc/mm/fault.c
index e93ea06c214c,5001f6418e92..000000000000
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@@ -187,21 -228,14 +187,21 @@@ bad_area
  		return;
  	}
 =20
 -	goto no_context;
 +	if (fault & VM_FAULT_SIGBUS) {
 +		sig =3D SIGBUS;
 +		si_code =3D BUS_ADRERR;
 +	}
 +	else {
 +		sig =3D SIGSEGV;
 +	}
 =20
 -do_sigbus:
 -	up_read(&mm->mmap_sem);
 +	tsk->thread.fault_address =3D address;
- 	force_sig_fault(sig, si_code, (void __user *)address, tsk);
++	force_sig_fault(sig, si_code, (void __user *)address);
 +	return;
 =20
 -	if (!user_mode(regs))
 -		goto no_context;
 +no_context:
 +	if (fixup_exception(regs))
 +		return;
 =20
 -	tsk->thread.fault_address =3D address;
 -	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 +	die("Oops", regs, address);
  }

--Sig_/w7Q+15IzRn7eThtdIF/Em2R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzvS0EACgkQAVBC80lX
0GxwLgf/Yb+XKEDiDHSEM4zEm0mSb5MepeW7+pG1D15FoMHOPIiG92B4sRcKtXSL
P7MMxkKxKNOM95FcHmu26wn6E4LsHGxSPx8L9R3mNfcWxfeLxysNY6EHWuFpAzHe
yqJhRimVsms/kNkj5+TJYYBz4dYMcapMfA7jvpZOaHOW2aaM9Ptkptm8CAW7C0jh
NyE1tCTrGCoudV1rFrOz2W7JiW5qLe4+MgLuUZev+M+feyBgWZZCxWDGNx3HSFOr
l9a5Pg9B9+PFbct3RV7HEH3k+7rFnqlYgmD41dB1CkKmZ/iEUuSpTYdSoNoCAWB/
IcWjfJmSMRS40RUndj2UAYT9sqViGw==
=zGZo
-----END PGP SIGNATURE-----

--Sig_/w7Q+15IzRn7eThtdIF/Em2R--
