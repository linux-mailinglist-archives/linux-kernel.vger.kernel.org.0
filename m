Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA359251
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 06:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfF1EKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 00:10:22 -0400
Received: from ozlabs.org ([203.11.71.1]:50073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfF1EKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:10:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ZjwW4qpwz9s3Z;
        Fri, 28 Jun 2019 14:10:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561695020;
        bh=I55zkrMesqKne3KNEzZE8U42iz5xAdNYBrsAy1XmwNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZgAP40FdlZjb2yEhOECndGyeLh1QfrT2/DbfoBVqZy3lC+bAJCo+Xa28DynCRqdBn
         EUS89x1QjDGxmVnVe7ZSwoduC5otYHiMeR5FCaZCyJxoRiLzyElm9QP6nbisMT1DA6
         mrEa5DsH3PUg03A5Q2OOWbBhMGRpHo8Wy4oSV3DJYLttTIfBpFtCAhIAvMCTwCEBHS
         +RWL7nKUZVjDDh3uYaOytL5fBnRaGws9jyD2r2DPCL3QRFM1/n8qer7OgkUSoY2SYC
         jSrshrGn+4SJ5ZeN+eZeW0WwppwwSdBvJwETBB3smrnqwEdB2ncwdYCClO5bSk0YN9
         OtGx6H4eqjorw==
Date:   Fri, 28 Jun 2019 14:10:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s/radix: Define arch_ioremap_p4d_supported()
Message-ID: <20190628141018.5ad2603d@canb.auug.org.au>
In-Reply-To: <6d201cb8-4c39-b7ea-84e6-f84607cc8b4f@arm.com>
References: <1561555260-17335-1-git-send-email-anshuman.khandual@arm.com>
        <87d0iztz0f.fsf@concordia.ellerman.id.au>
        <6d201cb8-4c39-b7ea-84e6-f84607cc8b4f@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wq/1diQb=+V7OS3bGVMftw9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wq/1diQb=+V7OS3bGVMftw9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anshuman,

On Fri, 28 Jun 2019 09:14:46 +0530 Anshuman Khandual <anshuman.khandual@arm=
.com> wrote:
>
> On linux-next (next-20190627) this change has already been applied though=
 a
> merge commit 153083a99fe431 ("Merge branch 'akpm-current/current'"). So we
> are good on this ? Or shall I send out a V2 for the original patch. Please
> suggest. Thank you.

Please send Andrew a v2.

--=20
Cheers,
Stephen Rothwell

--Sig_/wq/1diQb=+V7OS3bGVMftw9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0VkyoACgkQAVBC80lX
0Gw6+gf/Y06x3WT9WXSTWwMk6GeiltDHujuBd130HVkWnVGWvwg8RQc9/VfvqINS
XV0T6wzeSBWrWx5oPcbhTjvWy6a69nYs6x4gxHE9WUWyg5NVK8qFwhQ7h7oQEgDq
hHSxZ29YSp8yx1SN/JG7Lsebpkfo8JHbSLI6e7icI4odv/D/p6WeOgJI2cIGvkkb
PJaw6nO/shGvtqI9VyLHlcut0Ay42x4/jvXwrPyZWYJpdJ6I2ssw2tXFNzMHAiJa
k5Hj69KXCXolZ7fZlYUmf+zMA0EcMvGIWjoa/rwSZYwnrRc0mYAMburImlu4FnCT
u+TtTQ6frusmg5BqSfuN3Z7I9nFz7Q==
=PTBt
-----END PGP SIGNATURE-----

--Sig_/wq/1diQb=+V7OS3bGVMftw9--
