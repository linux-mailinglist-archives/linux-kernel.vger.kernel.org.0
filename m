Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B785A1257C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 00:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLRX3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 18:29:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbfLRX3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:29:01 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBINMbSA133681;
        Wed, 18 Dec 2019 18:28:47 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wykb75681-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 18:28:47 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBINAJPX010147;
        Wed, 18 Dec 2019 23:28:46 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 2wvqc6hfx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 23:28:46 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBINSjXT45285854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 23:28:45 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D2F778060;
        Wed, 18 Dec 2019 23:28:45 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABD637805C;
        Wed, 18 Dec 2019 23:28:42 +0000 (GMT)
Received: from LeoBras (unknown [9.85.190.169])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 Dec 2019 23:28:42 +0000 (GMT)
Message-ID: <0c598160a866318e1fa672afdb07d3ee762c2ac1.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] kvm/book3s_64: Fixes crash caused by not cleaning
 vhost IOTLB
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, farosas@linux.ibm.com,
        David Gibson <david@gibson.dropbear.id.au>
Date:   Wed, 18 Dec 2019 20:28:37 -0300
In-Reply-To: <be0c0f8f-3c8e-acd1-c6a2-479f6bd3c373@ozlabs.ru>
References: <20191217210658.73144-1-leonardo@linux.ibm.com>
         <be0c0f8f-3c8e-acd1-c6a2-479f6bd3c373@ozlabs.ru>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7xFj9Ce0+bnxIEdC6hQc"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=1 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7xFj9Ce0+bnxIEdC6hQc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-18 at 15:53 +1100, Alexey Kardashevskiy wrote:
> H_STUFF_TCE is always called with 0. Well, may be some AIX somewhere
> calls it with a value other than zero, and I probably saw some other
> value somewhere but in QEMU/KVM case it is 0 so you effectively disable
> in-kernel acceleration of H_STUFF_TCE which is
> undesirable.
>=20

Thanks for the feedback!

> For now we should disable in-kernel H_STUFF_TCE/... handlers in QEMU
> just like we do for VFIO for older host kernels:
>=20
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/ppc/spapr_iommu.c;h=3D=
3d3bcc86496a5277d62f7855fbb09c013c015f27;hb=3DHEAD#l208
=20
I am still reading into this temporary solution, I could still not
understand how it works.

> I am not sure what a proper solution would be, something like an eventfd
> and KVM's kvmppc_h_stuff_tce() signaling vhost that the latter needs to
> invalidate iotlbs. Or we can just say that we do not allow KVM
> acceleration if there is vhost+iommu on the same liobn (=3D=3D vPHB, pret=
ty
> much). Thanks,

I am not used to eventfd, but i agree it's a valid solution to talk to
QEMU and then use it to send a message via /dev/vhost.
KVM -> QEMU -> vhost

But I can't get my mind out of another solution: doing it in
kernelspace.  I am not sure how that would work, though.

If I could understand correctly, there is a vhost IOTLB per vhost_dev,
and H_STUFF_TCE is not called in 64-bit DMA case (for tce_value =3D=3D 0
case, at least), which makes sense, given it doesn't need to invalidate
entries on IOTLB.

So, we would need to somehow replace `return H_TOO_HARD` in this patch
with code that could call vhost_process_iotlb_msg() with
VHOST_IOTLB_INVALIDATE.

For that, I would need to know what are the vhost_dev's of that
process, which I don't know if it's possible to do currently (or safe
at all).

I am thinking of linking all vhost_dev's with a list (list.h) that
could be searched, comparing `mm_struct *` of the calling task with all
vhost_dev's, and removing the entry of all IOTLB that hits.

Not sure if that's the best approach to find the related vhost_dev's.

What do you think?

Best regards,
Leonardo Bras

--=-7xFj9Ce0+bnxIEdC6hQc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl36tiUACgkQlQYWtz9S
ttTP1w//e4LZi8WJKQ814uoxRAOq1LVfp4j8iZy9f5bV+gvWnAcfGMEi89Pk2fZq
97NUYgmJ/LJqeD+01bNGB4B2F8PNJ5iO4ZYZCcWJqGiXfqFrn1TMSvoZSuDvmzkm
1B19T7cd+kIVRLDNgNqM7dEdRhgX4rERFRCPgp9V5HJ7DS4WegqpYB0jXxjIRsmL
9G++y4Fi6aJwN3IavQCDzf9CYiOZnjSCV3uC9mCfJb2Bn1JDRK+JdL4FZaIU7X4Q
zmLsEZBC5NpdOPdFqzchW1r9fDxvY5hYRXlWPXk+V4e2CNczM9dZ/5nkr+YAXB9X
A72IBFHoz0yKXtP2D2x5gKvRYBeCJL9/2Ts3zNebEwT3xhjVEo76TXBj7TeEX03c
pEgxZNlpgGU9IIaHCvmxNni3EXBheNvY6T2PkQD4CIsLZo6OukotKhix4TUJ/XZu
iVeK5DWo1IGzFxPxFoePYojrUb0PopQv2h60yfvk0L2nVoVPN9qQ0d4q67jqOtWo
+2El4ZX7OE79UXJEv12TsbjGTiAKq7m0QIZDfibiVjCr7u8YoL4j4b7RvC9iTMkI
NnY0emDEW9HSuJ0SaS1aM7Tr9aCcBAHHYt09A5ChL0Mz0dy1NJdEYPgno/gxVAgQ
22IRaYQnKz/LPxNirU7Nz2TYl0CwH/l04f1n2osJEa+aWmeph94=
=pl8Q
-----END PGP SIGNATURE-----

--=-7xFj9Ce0+bnxIEdC6hQc--

