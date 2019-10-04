Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B358CC6A3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 01:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfJDXpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 19:45:30 -0400
Received: from shelob.surriel.com ([96.67.55.147]:59532 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDXpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:45:30 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1iGXGI-00049i-S7; Fri, 04 Oct 2019 19:45:26 -0400
Message-ID: <9358295b1d9cc173940a58038123128b4dafc5d0.camel@surriel.com>
Subject: Re: [PATCH] mm/rmap.c: reuse mergeable anon_vma as parent when fork
From:   Rik van Riel <riel@surriel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com,
        khlebnikov@yandex-team.ru
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Oct 2019 19:45:26 -0400
In-Reply-To: <20191004160632.30251-1-richardw.yang@linux.intel.com>
References: <20191004160632.30251-1-richardw.yang@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pyM9/LzSGvdMtJgYPqRg"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pyM9/LzSGvdMtJgYPqRg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-10-05 at 00:06 +0800, Wei Yang wrote:
> In function __anon_vma_prepare(), we will try to find anon_vma if it
> is
> possible to reuse it. While on fork, the logic is different.
>=20
> Since commit 5beb49305251 ("mm: change anon_vma linking to fix
> multi-process server scalability issue"), function anon_vma_clone()
> tries to allocate new anon_vma for child process. But the logic here
> will allocate a new anon_vma for each vma, even in parent this vma
> is mergeable and share the same anon_vma with its sibling. This may
> do
> better for scalability issue, while it is not necessary to do so
> especially after interval tree is used.
>=20
> Commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma
> hierarchy")
> tries to reuse some anon_vma by counting child anon_vma and attached
> vmas. While for those mergeable anon_vmas, we can just reuse it and
> not
> necessary to go through the logic.
>=20
> After this change, kernel build test reduces 20% anon_vma allocation.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-pyM9/LzSGvdMtJgYPqRg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl2X2ZYACgkQznnekoTE
3oPWpQf/b82uQvESfiRANm55vxx5yC3OU0qDt3+yd1D//k3lnCEADg1KLuT53P/a
Iq9fLZ/3EnDg2pwx5Vqnm+G4knmjSgQN0JC9f1E455R4mOpF3OJfX6U2EDDrycck
UONRE0qRMxMeTjbrxQPdyXGlrwKXekL3jvk25jqhO6F0eTR6chxrK0rZG9sfrNC/
5Ii4VLSmhlCT6YOaCrA/CMzRgS1pRxWmigMvXLPwQpRvspAca//XTCN9fh2213dV
8BbSasCdczPByHi2zWb4kd92jMYSSC9hAs+8NoT/jC/bvxZV9sMgwOKsrrToICJl
3t/vk7sWhfXe3oVe+mVAbO5D2/cGNA==
=WM9u
-----END PGP SIGNATURE-----

--=-pyM9/LzSGvdMtJgYPqRg--

