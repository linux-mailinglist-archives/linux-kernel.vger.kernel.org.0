Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4582BBBC55
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 21:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733237AbfIWTlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 15:41:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728033AbfIWTlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:41:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NJcWf4138884;
        Mon, 23 Sep 2019 15:40:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v740wgqtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 15:40:52 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8NJepRZ145246;
        Mon, 23 Sep 2019 15:40:51 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v740wgqt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 15:40:51 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8NJaKCj017805;
        Mon, 23 Sep 2019 19:40:51 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 2v5bg6p73a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 19:40:51 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8NJemWb60358990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 19:40:48 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BB18C605F;
        Mon, 23 Sep 2019 19:40:48 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D39C4C605B;
        Mon, 23 Sep 2019 19:40:43 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.184])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 23 Sep 2019 19:40:43 +0000 (GMT)
Message-ID: <dc9fad3577551d34ead36c0f7340a573086c0cab.camel@linux.ibm.com>
Subject: Re: [PATCH v2 11/11] powerpc/mm/book3s64/pgtable: Uses counting
 method to skip serializing
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     John Hubbard <jhubbard@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Sep 2019 16:40:39 -0300
In-Reply-To: <8706a1f1-0c5e-d152-938b-f355b9a5aaa8@nvidia.com>
References: <20190920195047.7703-1-leonardo@linux.ibm.com>
         <20190920195047.7703-12-leonardo@linux.ibm.com>
         <1b39eaa7-751d-40bc-d3d7-41aaa15be42a@nvidia.com>
         <24863d8904c6e05e5dd48cab57db4274675ae654.camel@linux.ibm.com>
         <4ea26ffb-ad03-bdff-7893-95332b22a5fd@nvidia.com>
         <18c5c378db98f223a0663034baa9fd6ce42f1ec7.camel@linux.ibm.com>
         <8706a1f1-0c5e-d152-938b-f355b9a5aaa8@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-msT9mHa9dsgVOOqF07pT"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-msT9mHa9dsgVOOqF07pT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-23 at 11:14 -0700, John Hubbard wrote:
> On 9/23/19 10:25 AM, Leonardo Bras wrote:
> [...]
> That part is all fine, but there are no run-time memory barriers in the=
=20
> atomic_inc() and atomic_dec() additions, which means that this is not
> safe, because memory operations on CPU 1 can be reordered. It's safe
> as shown *if* there are memory barriers to keep the order as shown:
>=20
> CPU 0                            CPU 1
> ------                         --------------
>                                atomic_inc(val) (no run-time memory barrie=
r!)
> pmd_clear(pte)
> if (val)
>     run_on_all_cpus(): IPI
>                                local_irq_disable() (also not a mem barrie=
r)
>=20
>                                READ(pte)
>                                if(pte)
>                                   walk page tables
>=20
>                                local_irq_enable() (still not a barrier)
>                                atomic_dec(val)
>=20
> free(pte)
>=20
> thanks,

This is serialize:

void serialize_against_pte_lookup(struct mm_struct *mm)
{
	smp_mb();
	if (running_lockless_pgtbl_walk(mm))
		smp_call_function_many(mm_cpumask(mm), do_nothing,
NULL, 1);
}

That would mean:

CPU 0                            CPU 1
------                         --------------
                               atomic_inc(val)=20
pmd_clear(pte)
smp_mb()
if (val)
    run_on_all_cpus(): IPI
                               local_irq_disable()=20

                               READ(pte)
                               if(pte)
                                  walk page tables

                               local_irq_enable() (still not a barrier)
                               atomic_dec(val)

By https://www.kernel.org/doc/Documentation/memory-barriers.txt :
'If you need all the CPUs to see a given store at the same time, use
smp_mb().'

Is it not enough?=20
Do you suggest adding 'smp_mb()' after atomic_{inc,dec} ?

--=-msT9mHa9dsgVOOqF07pT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2JH7cACgkQlQYWtz9S
ttQbsg/+NzuiDsKHci5TYegDW6BmUL/AMfyvUr6EHhP0ki98ppV+Z6T24LKU8/Fd
FviJPbDIJMZlkk3vc1ZvDxxOYsF9DOojVxXXqBFb9HlecMgPJDWY/qwMUjzXlQSP
IpOfbeRXZ+qhq912shlCqBPQh1a4cj4MGp2OaxLEgyblj5tWciakunL+TqIBU3Gs
YYNpf1sBQ+y0uboAHDu9CH0ssN6czr9PyaR/8pgjQKPUCd8Cei26gcU45qnhqllU
ls8Fo5QjlKiY5DTGzX2cOvj5A+ZP8/AbL42nB1DEm2NsndmtGG3kNOmGxGzAnIO7
DwesqALzC/yKwwSLR6EFGFW7y+Ucm9FknrZ8e3ai/Filvd71YwsAF8LkQosC+qjv
BvWhR+RJLjjpysn8nQDYkJeWCEJ+8civxf1mgz4oBQ7bT/AHhQ75lolWe8QhZZwx
QnRpRBglBdZwir9gy15Huevjke3p3FklIwuDN4otTPlrWWS966BXLKxK+XAhb5j5
hzovVwge/iaSStEEZrLtBl8rhMmowXKa55/I97dBeDrnBHDVoJyYb5+moAYU75UA
M/5z1wwNQQWP7ftV2fkngtCsUsED6tDklyyyrAQ0zsfzOF6IZ6gbcvpZhrQyz5G5
WFPpc7V2uJWZJRN+Afk8Ittnl/GOH7WBozDka6dGiLurBnTnc50=
=mRcx
-----END PGP SIGNATURE-----

--=-msT9mHa9dsgVOOqF07pT--

