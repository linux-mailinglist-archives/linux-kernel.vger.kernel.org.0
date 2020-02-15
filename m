Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C53815FD1B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 07:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgBOG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 01:29:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbgBOG31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 01:29:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01F6Od3D147756;
        Sat, 15 Feb 2020 01:29:05 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6b53gbr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Feb 2020 01:29:05 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01F6PZNS010259;
        Sat, 15 Feb 2020 06:29:04 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 2y6895h839-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Feb 2020 06:29:04 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01F6T2Oe53150192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Feb 2020 06:29:02 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE4E2BE05B;
        Sat, 15 Feb 2020 06:29:02 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63DCCBE04F;
        Sat, 15 Feb 2020 06:29:00 +0000 (GMT)
Received: from LeoBras (unknown [9.85.178.59])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 15 Feb 2020 06:29:00 +0000 (GMT)
Message-ID: <546ce4737f308a4ba99a53f550de5b44abc06444.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/8xx: Fix clearing of bits 20-23 in ITLB miss
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Sat, 15 Feb 2020 03:28:58 -0300
In-Reply-To: <4f70c2778163affce8508a210f65d140e84524b4.1581272050.git.christophe.leroy@c-s.fr>
References: <4f70c2778163affce8508a210f65d140e84524b4.1581272050.git.christophe.leroy@c-s.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5kXEsvSYMa1jJ9ldR3mf"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-15_01:2020-02-14,2020-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002150052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5kXEsvSYMa1jJ9ldR3mf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-02-09 at 18:14 +0000, Christophe Leroy wrote:
> In ITLB miss handled the line supposed to clear bits 20-23 on the
> L2 ITLB entry is buggy and does indeed nothing, leading to undefined
> value which could allow execution when it shouldn't.
>=20
> Properly do the clearing with the relevant instruction.
>=20
> Fixes: 74fabcadfd43 ("powerpc/8xx: don't use r12/SPRN_SPRG_SCRATCH2 in TL=
B Miss handlers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/head_8xx.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8x=
x.S
> index 9922306ae512..073a651787df 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -256,7 +256,7 @@ InstructionTLBMiss:
>  	 * set.  All other Linux PTE bits control the behavior
>  	 * of the MMU.
>  	 */
> -	rlwimi	r10, r10, 0, 0x0f00	/* Clear bits 20-23 */
> +	rlwinm	r10, r10, 0, ~0x0f00	/* Clear bits 20-23 */
>  	rlwimi	r10, r10, 4, 0x0400	/* Copy _PAGE_EXEC into bit 21 */
>  	ori	r10, r10, RPN_PATTERN | 0x200 /* Set 22 and 24-27 */
>  	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */

Looks a valid change.
rlwimi  r10, r10, 0, 0x0f00 means:=20
r10 =3D ((r10 << 0) & 0x0f00) | (r10 & ~0x0f00) which ends up being
r10 =3D r10=20

On ISA, rlwinm is recommended for clearing high order bits.
rlwinm  r10, r10, 0, ~0x0f00 means:
r10 =3D (r10 << 0) & ~0x0f00

Which does exactly what the comments suggests.

FWIW:
Reviwed-by: Leonardo Bras <leonardo@linux.ibm.com>

--=-5kXEsvSYMa1jJ9ldR3mf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl5Hj6oACgkQlQYWtz9S
ttQWoxAAkMDIynrGqSBGS3wqJaf0Wkr6UJnb2oJd8WOg7ZQB9a2IG9QtKadFz1sk
MahuBsMwfQBTntHszpiU0v4v1Z/6S3ibDOvacTaD6iRETl++yPojxoUSw4VyfJQQ
WaHYTotuFPjCIo5qQJXuyV1mfXBCQ2SuxuX9gu/eQI0yIfKhRR5zdX9XbaTyytjQ
BgU/OLXJJmeJfuAvGk+qzws703XdotG8JhK3Neodqn+4yQSibd4P7Cpqwh4gAOPN
Uo2D7yABPrAZ2dEyJYpsRuesaOOptxnks+0B3pQ/kXj0JggkOu67GrNWYERo0xXp
rneL+fc966WhwXtblzBqXsSb/6OuhhPH7EEMqJyOJgmn5jX5Ua39bATz7F453ZLz
ksBYKA3c+zUOH5L9u5jiJ0ldfHf0UlxEU6t9Qp4QckEIwVaOwDX4/+hijtY1fTmp
iW7CyKrvsdeuPe2b4+MSx/EwYD5Ab5N1OgKpxswz8QVuvdrzSmpCZyu0UHru1Rmd
mqmzbf5MVw5P54u2xrppiOhRiIP6P/PRzX2EbDDl7PHhI0kf9AOgCM2SiBb1Xrc+
7lcXxebPlZttPWyI0Hx1mt7qhH3z/Ht/FTPr5t2SiHr8Wt1fA5tkOw8yETzXpQ+F
NREgXa6DoyomToxuOZcyla0yVJ38gPGEzqQwj8U2Qks1uE0akmA=
=Z6FN
-----END PGP SIGNATURE-----

--=-5kXEsvSYMa1jJ9ldR3mf--

