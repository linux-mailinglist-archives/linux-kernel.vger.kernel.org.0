Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4119B921
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 01:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgDAXyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 19:54:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732682AbgDAXye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:54:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031NYt6D027340;
        Wed, 1 Apr 2020 19:53:49 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 304gsstyww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 19:53:49 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 031NpI4U002885;
        Wed, 1 Apr 2020 23:53:48 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 301x77nuq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 23:53:48 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 031NrlTM57082224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 23:53:47 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC82E7805E;
        Wed,  1 Apr 2020 23:53:46 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EA327805F;
        Wed,  1 Apr 2020 23:53:40 +0000 (GMT)
Received: from LeoBras (unknown [9.85.162.156])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 23:53:39 +0000 (GMT)
Message-ID: <e304952f5177f85faff4560ded5aa1dad7af5fe2.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ppc/crash: Reset spinlocks during crash
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Enrico Weigelt <info@metux.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Apr 2020 20:53:31 -0300
In-Reply-To: <20200401092618.GW20713@hirez.programming.kicks-ass.net>
References: <20200401000020.590447-1-leonardo@linux.ibm.com>
         <20200401092618.GW20713@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KDf7FjQwdoNO4X4hfXtK"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxlogscore=879 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KDf7FjQwdoNO4X4hfXtK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Peter,=20

On Wed, 2020-04-01 at 11:26 +0200, Peter Zijlstra wrote:
> You might want to add a note to your asm/spinlock.h that you rely on
> spin_unlock() unconditionally clearing a lock.
>=20
> This isn't naturally true for all lock implementations. Consider ticket
> locks, doing a surplus unlock will wreck your lock state in that case.
> So anybody poking at the powerpc spinlock implementation had better know
> you rely on this.

Good idea. I will add this to my changes and generate a v4.

Thank you,

--=-KDf7FjQwdoNO4X4hfXtK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl6FKXsACgkQlQYWtz9S
ttT6PRAAlfpMg9qZK9Q7d5BJCzhUZdsE2wsPmmI7ynbk+XKYd4VHECBE6Lf7u1t+
ShKanwxHRz0Bk1UxzP3UBLP5e7twvXcmgrZehNaT2kQd457B40Oli44JsBFZXsi4
inN/HVcPaI+c5imygIb9tlae7hNX6XBfdj0sH4uRXcgafm/dJIRzc8OHUrfPBh7G
GEDP72loBYwOqqt7n6nz03GCeHvV97Lq4frpx8fca70+u7+JH4gK9Hv21/gwuwSA
yfF6vgY4xBMN7aWpeE+lw1A0xVfQv4aw6d4SgkDVUKTPV1jhWP44EfURwcyRl7ID
OhOQ2ppYkuH7AIjCgaAYKClJ9JU/9TCRz2gJJ0/5ebZ6sPdD8fhcpz6WSQQMES6g
mxhjXi2uram2KPf6OCA2TIyxgkRsez8XODU6qqxhV9QPxJjt8x0KeL2oHkl1SU7U
H4u/ckxesRL0eFT/BbMCFaksPyQP9+GgzvRSPqueQHjjsqLf6zotwRCHVdF1diYg
7FWKuFfNLHz19aq7M427+AhNTXhkSqzE5c2qa6MU+DMc31r1XRTJ9nCGB0omQ7h6
NRaBkvn0ZXI0NlTBQXMVtrLfPJucsVM14PbTSgayttDQThAG9ulIHmeFsxQypTv/
pB6LDSZVOdhFNI+RX/hG6GVIXpBoz7yZxeExeFWEYjYoOqMkKu0=
=Ustc
-----END PGP SIGNATURE-----

--=-KDf7FjQwdoNO4X4hfXtK--

