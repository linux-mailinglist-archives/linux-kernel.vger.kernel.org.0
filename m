Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C12DF73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 16:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfE2ORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 10:17:05 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58570 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfE2ORF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:17:05 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hVzO1-0008Fm-Mu; Wed, 29 May 2019 10:17:01 -0400
Message-ID: <5af5f7aa8ac48d2c8a2d1809e3c7932824958a76.camel@surriel.com>
Subject: Re: question on lazy tlb flush
From:   Rik van Riel <riel@surriel.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 29 May 2019 10:17:01 -0400
In-Reply-To: <cd421c2c-8507-6652-2ef7-a6f3b20efcd2@oracle.com>
References: <cd421c2c-8507-6652-2ef7-a6f3b20efcd2@oracle.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BUP/KSIbX0iV8YiqY2Qg"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BUP/KSIbX0iV8YiqY2Qg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-05-29 at 12:54 +0800, Zhenzhong Duan wrote:
> Hi Maintainers,
>=20
> A question raised when I learned below code.  Appreciate any help me=20
> understand the code.
>=20
> void native_flush_tlb_others(const struct cpumask *cpumask,
>                               const struct flush_tlb_info *info)
>=20
> {
>=20
> ...
>=20
>          /*
>           * If no page tables were freed, we can skip sending IPIs to
>           * CPUs in lazy TLB mode. They will flush the CPU themselves
>           * at the next context switch.
>           *
>           * However, if page tables are getting freed, we need to
> send the
>           * IPI everywhere, to prevent CPUs in lazy TLB mode from
> tripping
>           * up on the new contents of what used to be page tables,
> while
>           * doing a speculative memory access.
>           */
>          if (info->freed_tables)
>                  smp_call_function_many(cpumask,
> flush_tlb_func_remote,
>                                 (void *)info, 1);
>          else
>                  on_each_cpu_cond_mask(tlb_is_not_lazy,=20
> flush_tlb_func_remote,
>                                  (void *)info, 1, GFP_ATOMIC,
> cpumask);
>=20
> }
>=20
> I just didn't understand how a kernel thread could trip up on the
> new=20
> contents of what used to be page tables. I presume the freed page
> tables=20
> are user mapping?

That is correct, and you ask a very good question.

The software does indeed not access userspace memory
addresses from kernel threads.

However, the CPU itself can do speculative loads from
userspace memory addresses, even when the software thread
is running exclusively in kernel mode.

Add to that the fact that the page table pages can get
reused for something else after they have been freed, and
that the CPU can cache intermediate translations (eg. PUD
and PMD level things get cached in the TLB), and you might
end up with a speculative load poking at a PCI register,
or something else that trips up the machine.

For that reason, when page table pages get freed, we need
to flush the TLBs of all users, inluding lazy TLB kernel
threads.

--=20
All Rights Reversed.

--=-BUP/KSIbX0iV8YiqY2Qg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlzulF0ACgkQznnekoTE
3oO5UAgAmLQE8OuXmJLwRoDedZ/CnXGDyhQhheMbVtFur3TTnYFSVh+SErMu7oRa
zjeAA1+ySyQ8UAhJFCbi32LONTzS6PG8SRwo9A3G2DYbtLd1HL3A5nnFHOeFWAR8
zZKeQm2fdRarisH2fT+dR0kxjSQJSbXoRACdENJdwcH9cvXGPEtWAzHdsEaTg9pI
mCEc38fj0DqhJZLpAb/9qF1hmTqxQiLlNnVKi2awLXiodVvFWpUBe9BjofdOt5wN
L25eAbmrHWsayrXACLtcHYjEe438npuyT29mn8EJqMXxZq7Lfhi6/GLxGd13ZkDk
9IF1F8YfYRGsfaHzsXrdxjogw+u+4g==
=W8pT
-----END PGP SIGNATURE-----

--=-BUP/KSIbX0iV8YiqY2Qg--

