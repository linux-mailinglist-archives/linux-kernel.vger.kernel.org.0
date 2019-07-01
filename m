Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D54BE1576D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 03:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfEGBwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 21:52:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbfEGBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:52:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x471plWZ094156
        for <linux-kernel@vger.kernel.org>; Mon, 6 May 2019 21:52:52 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2saus5a73v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 21:52:51 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sbobroff@linux.ibm.com>;
        Tue, 7 May 2019 02:52:49 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 May 2019 02:52:47 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x471qkxL50724906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 May 2019 01:52:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CACD4A4040;
        Tue,  7 May 2019 01:52:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A0C2A4053;
        Tue,  7 May 2019 01:52:46 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 May 2019 01:52:46 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2C345A00E2;
        Tue,  7 May 2019 11:52:45 +1000 (AEST)
Date:   Tue, 7 May 2019 11:52:44 +1000
From:   Sam Bobroff <sbobroff@linux.ibm.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-pci/nvlink2: Fix potential VMA leak
References: <155568823785.601037.2151744205292679252.stgit@bahia.lan>
 <20190506155845.70f3b01d@x1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20190506155845.70f3b01d@x1.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-TM-AS-GCONF: 00
x-cbid: 19050701-0020-0000-0000-00000339FB48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050701-0021-0000-0000-0000218C9368
Message-Id: <20190507014915.GA10274@tungsten.ozlabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 03:58:45PM -0600, Alex Williamson wrote:
> On Fri, 19 Apr 2019 17:37:17 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > If vfio_pci_register_dev_region() fails then we should rollback
> > previous changes, ie. unmap the ATSD registers.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
>=20
> Applied to vfio next branch for v5.2 with Alexey's R-b.  Thanks!
>=20
> Alex

Should this have a fixes tag? e.g.:
Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdri=
ver")

> >  drivers/vfio/pci/vfio_pci_nvlink2.c |    2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfi=
o_pci_nvlink2.c
> > index 32f695ffe128..50fe3c4f7feb 100644
> > --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> > +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> > @@ -472,6 +472,8 @@ int vfio_pci_ibm_npu2_init(struct vfio_pci_device *=
vdev)
> >  	return 0;
> > =20
> >  free_exit:
> > +	if (data->base)
> > +		memunmap(data->base);
> >  	kfree(data);
> > =20
> >  	return ret;
> >=20
>=20

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlzQ5OsACgkQMX8w6AQl
/iLZ/Qf/a2uoZMkf/WjdRce1EAfSE6HjkKRrr1PS33DS2L9FeAqgQONGSri4KFnl
rLzZvsLzMYF44Ai2T4PPOvNAA1OAOZEpIt4J29AFThCIFBm59y1SPuAkiqUrKJfe
KW0L9OG4e9L7ea/wNutFJ/bCV/tqOyFazGxp1S0nlcofguQp39tfhtUq50DYptxP
1bOY91t9A4HtUU82vmT7hJ+OG7PpEhlh1UPqNr541RUwnMfVyjdSHB+NEbMAklun
tZtjMGmv3F9p/7cwHLIlIR1dMJhvqgJeMyxHPhx1clfn1Vt33ZzcBjTE52smto+K
WUkqeQWdXpl3m6Q0wmxGf+8i/qkVPA==
=H10W
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

