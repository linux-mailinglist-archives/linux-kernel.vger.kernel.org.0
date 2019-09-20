Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A4AB984F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 22:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfITUMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 16:12:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbfITUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:12:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8KKBp49107401;
        Fri, 20 Sep 2019 16:12:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v55dx8k2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 16:12:14 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8KKBsfE107895;
        Fri, 20 Sep 2019 16:12:14 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v55dx8k1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 16:12:14 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8KKAGVB020744;
        Fri, 20 Sep 2019 20:12:13 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 2v3vbuw0x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 20:12:13 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8KKCB4C50004354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 20:12:11 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECBBDC6059;
        Fri, 20 Sep 2019 20:12:10 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 921CFC6055;
        Fri, 20 Sep 2019 20:12:06 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.184])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 20 Sep 2019 20:12:06 +0000 (GMT)
Message-ID: <1f5d9380418ad8bb90c6bbdac34716c650b917a0.camel@linux.ibm.com>
Subject: Re: [PATCH v2 00/11] Introduces new count-based method for
 monitoring lockless pagetable wakls
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>
Date:   Fri, 20 Sep 2019 17:12:00 -0300
In-Reply-To: <20190920195047.7703-1-leonardo@linux.ibm.com>
References: <20190920195047.7703-1-leonardo@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nucwkzcjL6z05I66cwMm"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909200165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nucwkzcjL6z05I66cwMm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If a process (qemu) with a lot of CPUs (128) try to munmap() a large
chunk of memory (496GB) mapped with THP, it takes an average of 275
seconds, which can cause a lot of problems to the load (in qemu case,
the guest will lock for this time).

Trying to find the source of this bug, I found out most of this time is
spent on serialize_against_pte_lookup(). This function will take a lot
of time in smp_call_function_many() if there is more than a couple CPUs
running the user process. Since it has to happen to all THP mapped, it
will take a very long time for large amounts of memory.

By the docs, serialize_against_pte_lookup() is needed in order to avoid
pmd_t to pte_t casting inside find_current_mm_pte(), or any lockless
pagetable walk, to happen concurrently with THP splitting/collapsing.

It does so by calling a do_nothing() on each CPU in mm->cpu_bitmap[],
after interrupts are re-enabled.=20
Since, interrupts are (usually) disabled during lockless pagetable
walk, and serialize_against_pte_lookup will only return after
interrupts are enabled, it is protected.

So, by what I could understand, if there is no lockless pagetable walk
running, there is no need to call serialize_against_pte_lookup().

So, to avoid the cost of running serialize_against_pte_lookup(), I
propose a counter that keeps track of how many find_current_mm_pte()
are currently running, and if there is none, just skip=20
smp_call_function_many().

The related functions are:
start_lockless_pgtbl_walk(mm)
	Insert before starting any lockless pgtable walk
end_lockless_pgtbl_walk(mm)
	Insert after the end of any lockless pgtable walk
	(Mostly after the ptep is last used)
running_lockless_pgtbl_walk(mm)
	Returns the number of lockless pgtable walks running


On my workload (qemu), I could see munmap's time reduction from 275
seconds to 418ms.

> Leonardo Bras (11):
>   powerpc/mm: Adds counting method to monitor lockless pgtable walks
>   asm-generic/pgtable: Adds dummy functions to monitor lockless pgtable
>     walks
>   mm/gup: Applies counting method to monitor gup_pgd_range
>   powerpc/mce_power: Applies counting method to monitor lockless pgtbl
>     walks
>   powerpc/perf: Applies counting method to monitor lockless pgtbl walks
>   powerpc/mm/book3s64/hash: Applies counting method to monitor lockless
>     pgtbl walks
>   powerpc/kvm/e500: Applies counting method to monitor lockless pgtbl
>     walks
>   powerpc/kvm/book3s_hv: Applies counting method to monitor lockless
>     pgtbl walks
>   powerpc/kvm/book3s_64: Applies counting method to monitor lockless
>     pgtbl walks
>   powerpc/book3s_64: Enables counting method to monitor lockless pgtbl
>     walk
>   powerpc/mm/book3s64/pgtable: Uses counting method to skip serializing
>=20
>  arch/powerpc/include/asm/book3s/64/mmu.h     |  3 +++
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  5 +++++
>  arch/powerpc/kernel/mce_power.c              | 13 ++++++++++---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c          |  2 ++
>  arch/powerpc/kvm/book3s_64_mmu_radix.c       | 20 ++++++++++++++++++--
>  arch/powerpc/kvm/book3s_64_vio_hv.c          |  4 ++++
>  arch/powerpc/kvm/book3s_hv_nested.c          |  8 ++++++++
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c          |  9 ++++++++-
>  arch/powerpc/kvm/e500_mmu_host.c             |  4 ++++
>  arch/powerpc/mm/book3s64/hash_tlb.c          |  2 ++
>  arch/powerpc/mm/book3s64/hash_utils.c        |  7 +++++++
>  arch/powerpc/mm/book3s64/mmu_context.c       |  1 +
>  arch/powerpc/mm/book3s64/pgtable.c           | 20 +++++++++++++++++++-
>  arch/powerpc/perf/callchain.c                |  5 ++++-
>  include/asm-generic/pgtable.h                |  9 +++++++++
>  mm/gup.c                                     |  4 ++++
>  16 files changed, 108 insertions(+), 8 deletions(-)
>=20

--=-nucwkzcjL6z05I66cwMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2FMpAACgkQlQYWtz9S
ttQJDRAAm7UrD3Hn32mqNVvo0il+czdU8CD0TY9JTgwQVy5w623VhAlNK0RSqdbX
NN6XebcOau//QQleUrXseAf4kuniMJZn62qDeUj0wcQMaVqSlpqF7+4KDIINVS7K
WbymiNSCTGFYDG7575+kcBPn3baKWV6EoGe80qmd5DTXN5W5pBKbfHqJ36u/rEZA
cKzVlDLOHxvQ/VopYSydx4wl3T+CcUziVNf3ooT83ktwOHUcGRMfFLsuAMK3Ws5P
fLUbK4iWQgda8DH4pvDb9ZtfH/01+lqR7VJSUu9fDbtis5JNRt7TxwglPN3zf1vw
eF4p75mlIIxk6KM7/kCksSqn6ZBiHS5ldehaYaKWwsuM4leTP32TYMOB7woOOgDL
xW/KNxja+CuFhoIt3dsSDwFWAYwt3cSPsCtgYgiN4t2CkWZQaw+W+6j2wBYg7SPn
iGg04qGNDr3Um3OklxU8GHgbkPmBKZ2Yjhxx9mdf0sLoF9//o3td3BrqP8sw4AXK
bBnixpOpbVnTvUbK1sc1PyxEJ5qMmmS9kE2I05ysIKHvSPMoDZiXwW92MesXotoi
2Rocc4T0UP0tzTunADdc9iq2d8egHa1r9LjL49sP1FPNYUbYkeEJTjXyIXS07qVe
sdQgYcZZ7NwvR0ZASqJCM2yKQBxMQ+Iv3pyUjXFyySlwhS2nSQk=
=F3zh
-----END PGP SIGNATURE-----

--=-nucwkzcjL6z05I66cwMm--

