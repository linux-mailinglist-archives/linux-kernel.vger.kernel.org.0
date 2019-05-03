Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB5112B66
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfECKWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 06:22:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfECKWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:22:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44wSqq445Lz9s4Y;
        Fri,  3 May 2019 20:22:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556878952;
        bh=dfq93gCPcu8lf0B+CK97qU/3PXKRdCF71e29VU8aKlI=;
        h=Date:From:To:Cc:Subject:From;
        b=WnHAfizQcePfP6vaWcB/SQnCbvFfH4HQ8Ysg5Ie2lfP6V3vL07XFZCfqK9tBzYCAB
         5NcEOWWbsnbjTcwF4oEdLtBw9zAvWGQBsdgX8pJU4Upmyr3BXNLf4a/cVVVAwJIEqj
         roDJnQR4Wk2KcH91P0nctJH8VsINbmFydd+vRfOiV623gnj7eWPC9Ob8RZ+jWfdGxw
         hoIeJ+ELSOQffoB0NLldMppb73u9tBEbtVRHoiBiVUURkkOrHhkGZBloozjR6bvrdb
         7ynf2IM4wCEvc+K0coKVJxqXeb3p3vOHQA/z2xQyX/yS+OeNGBOYTetp+mnKpQe7mo
         Srket/AfwyHRA==
Date:   Fri, 3 May 2019 20:22:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bo YU <tsu.yubo@gmail.com>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20190503202230.3327af07@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/t18M1VKjA4QbQyCBnHOWmQH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t18M1VKjA4QbQyCBnHOWmQH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2e712675ffd1 ("perf bpf: Return value with unlocking in perf_env__find_bt=
f()")

Fixes tag

  Fixes: 2db7b1e0bd49d: (perf bpf: Return NULL when RB tree lookup fails in=
 perf_env__find_btf())

has these problem(s):

  - the colon after the SHA1 is unexpected
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/t18M1VKjA4QbQyCBnHOWmQH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzMFmYACgkQAVBC80lX
0Gz6zAf+JKCAd6+h9l+BIkTS1rsx5bUSzL/DLjquiv/pMgM4jNmmsEwTPi3ic1gz
9+3aguopebStuFebNCViTvrsKqPE6U38N1EKnJG1VTUi7zSny/eIn0T3X7ZM8AdJ
Mj4l2djat5a2FSldRgaMkKnUl09wscbKlM08d8oW5P27cf0JgRaC5HpY0q8XNhQn
qcRlKIz0lwkMll/v7elMzicBtwWNG2BxVcwx1fm+uoSxWzX3fbSXJ5LkJ9Bjd2T9
ZEqRehE9aSqyxVcxBbWh0jvw7UsINVnrpIgct2nRW0cuoy8mX4fsF+xbq8Hg2H69
3VZiCGuzJQVmxKJBGbENkn9DZXKtFQ==
=4e1b
-----END PGP SIGNATURE-----

--Sig_/t18M1VKjA4QbQyCBnHOWmQH--
