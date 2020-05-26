Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD6F19BAC7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 05:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbgDBDx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 23:53:58 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43960 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgDBDx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 23:53:58 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0323kD2C017447;
        Wed, 1 Apr 2020 20:53:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=TdMZ5L/4KWv0WdPepcDu1s5mbml6nJ+GWgyYvlSNUfE=;
 b=UHnzN7pXFByz+plTXKYje3E5hctmY2V35e4FlgLV0qj69FFzbhEm5BqOfYHNbKVtODmG
 470xehp8X087/zQsDlcKFoWMuTszloubFxHnmJycBINRwT6HKjk3OomkhoIZ0m4pOVWT
 hdnMF/yrfi0uE4jhFZfl+7XEakpeypVdIczleg66fdci8ZOhnf0sqdJPD7eeIhf5DQCW
 Lbs5jaP0120dhEBtJ1GZbHKVEFETQA0dleyH64XaNnDf0eYwkmkzFFm2mUUAl9Lxtns5
 3arFs/m+WfoqtUYaJjD5VtZqK4daqaviIDpKfE+IaApvG+0KGVsiKy5BBQ6g/Flsmfg0 /w== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 304855r5jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 20:53:44 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Apr
 2020 20:53:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 1 Apr 2020 20:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXJiF3zG+G39h+AaBfeK8nru3wR8IHljX3vvS8jT3LrbYg8fR15IPXj7KplS4L4CfJkMtpF3lA2lz36wxKPyiIihOCsq3Uy+eTdbmb1c+KxEG9rLh6LYIH80ezRjfRCvSBdPJSlkgFMbwtxolcs/uYJLCEf537JF5+Fl9GMQlsv/LBBFXGueyM2HDpTybckUK5NGbmgj2kZ7ixjeDPYYNfMsjv/Ny+40UDdso56PZwYBmLE6QdLZ1T3QZT+1H5b386KEZNgpMMDioFrArbBNfUTNmunKJIPebJQgHx8N76vXob6Gz04h0DkxThlgYTkkTabOsSgVE06PC9JrB5euIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdMZ5L/4KWv0WdPepcDu1s5mbml6nJ+GWgyYvlSNUfE=;
 b=FuIYcAD8jobRyhAQGMjdcxFiHSxBV1E+mBeLQlMqMgWs25dyNsmK5vzIBncsBkPyYb+vsOLbbJwXXrgSZcUQbMUx9I/AYnT2DnfLb0mZSaaFx4ZN5MxdfNLBWarvUPBoGav2rQML+lPptK/OjwFHDNTxJZdnQTJZTNIBJtZlvu6dUSxFcrVVfnAgXBtsMLvSnDUYcYZZqKMEzoQjZgPHMOu5iQ4NxNI3aPgF/m4Y1jBoeOO4F/FUhAxgSWY1UWM+KMtSpHl5uprch+RZwz4Y1lJ9epSIAfWcg78VxF0xNQb3YRh7uqrjzLeHl2hOuIyfZCU+yE+54l27OgT/iceN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdMZ5L/4KWv0WdPepcDu1s5mbml6nJ+GWgyYvlSNUfE=;
 b=UwZ1Il1o0+PIdrjVSah+nEy0VAJhrh+7Fn0JW2Nk6fxas1aeb54wn1XmhcGMtBe9b12mWoKGlbABxfAQLC4vnlcoUfZC1+5iHc+EJDBLY2UNqSJiwSjoNIujkKAS+Ks9cQz/LrwluRYGZRWP/aSO2wpPaNMOyMJRrQ0ZJyV2wA8=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB2061.namprd18.prod.outlook.com
 (2603:10b6:301:69::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 03:53:40 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 03:53:40 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [EXT] Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap
 supported by endpoint
Thread-Topic: [EXT] Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap
 supported by endpoint
Thread-Index: AQHWCBodnv/LuIC4jE+z/7uFFnxSTKhkOsKAgAAvTgCAAMkOkA==
Date:   Thu, 2 Apr 2020 03:53:40 +0000
Message-ID: <MWHPR1801MB19667BA1D59590BC3DFD87C7E3C60@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200401113804.21616-1-bbhushan2@marvell.com>
 <b75beb74-89ce-fd6a-6207-3c0d7f479215@arm.com>
 <20200401154932.GA1124215@myrica>
In-Reply-To: <20200401154932.GA1124215@myrica>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.179.45.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af362715-39aa-46af-d0f6-08d7d6b96e7a
x-ms-traffictypediagnostic: MWHPR1801MB2061:
x-microsoft-antispam-prvs: <MWHPR1801MB2061D631028D77A163C19F73E3C60@MWHPR1801MB2061.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1966.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(7416002)(54906003)(66556008)(64756008)(66946007)(966005)(478600001)(316002)(8676002)(81156014)(52536014)(66476007)(110136005)(66446008)(81166006)(53546011)(76116006)(8936002)(86362001)(26005)(9686003)(4326008)(33656002)(186003)(5660300002)(71200400001)(2906002)(55016002)(6506007)(7696005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hzxe7N9mskSjD7pFK51oWx6ZJTmbHe/ycK8NEf03EwTKw4Yv9eJKUwGFj5T8N/qaT3Dgd99j5Lu8N7giGFGz7simv+iQHcEJPtdd+3uKU0M93razh1iKkwRts9kzlThTO30zmqPfyiBVinSxhxfOWoKfwM3X3NmJT27R4XF53h/j5DQVE1bMsrcVBDvrdwx22BDt/mgwFAReYD17PgK87vqyPPN9b/sZiED6JP9jU6WZbMTcQG83WV1H0p8IsQiCjhJSc5Z2ipLW5wYccaXa5rH+XgnWBvM83sspNcNpuT26yllITBytphfyibyVUrzZIOhiKsOe9b8aBvh9pkixCHXaavltZ55wik2T4x2MenxH7DPOWnGx2koesDxNKWsTLoT3SniTP+ScQsef4aP5BfmOYS0nuEtg3+PodY+Maps6bjVFnDy7YIfOrMcgsjRwTqLYNzTP4L/R/mNUyC267E+yPU2Z1LTzC9+yw3Qie0m91DKX5fU+pnaQsumjSiW+CmHf3QBvpGXiV97cLFzl0Q==
x-ms-exchange-antispam-messagedata: mpr/UUiiEEVXU/blXduJTH0IgqyJykfb+wLU90iyB/KvGH1jyweqeaBsayzVorlDwdJLnchL7pVXGxxCohE/sYU0cB0KUKrxgLVZVySdc5g+yytDhc0myvmy/t1LS67GdqVpN8MnTxqpyUi+5umnKQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: af362715-39aa-46af-d0f6-08d7d6b96e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 03:53:40.5252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMK3G8vwPCknc5E75sTY3YTKWGZxF9ToGemMfmWM8NYNqlosYxwJZzwj+4ptGAUaxwqsGLALz1uBUW7zFc2Ubw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB2061
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Wednesday, April 1, 2020 9:20 PM
> To: Robin Murphy <robin.murphy@arm.com>
> Cc: Bharat Bhushan <bbhushan2@marvell.com>; joro@8bytes.org;
> mst@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
> foundation.org; iommu@lists.linux-foundation.org; linux-kernel@vger.kerne=
l.org;
> eric.auger.pro@gmail.com; eric.auger@redhat.com
> Subject: [EXT] Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap supp=
orted by
> endpoint
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, Apr 01, 2020 at 02:00:13PM +0100, Robin Murphy wrote:
> > On 2020-04-01 12:38 pm, Bharat Bhushan wrote:
> > > Different endpoint can support different page size, probe endpoint
> > > if it supports specific page size otherwise use global page sizes.
> > >
> > > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > > ---
> > >   drivers/iommu/virtio-iommu.c      | 33 +++++++++++++++++++++++++++-=
---
> > >   include/uapi/linux/virtio_iommu.h |  7 +++++++
> > >   2 files changed, 36 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iommu/virtio-iommu.c
> > > b/drivers/iommu/virtio-iommu.c index cce329d71fba..c794cb5b7b3e
> > > 100644
> > > --- a/drivers/iommu/virtio-iommu.c
> > > +++ b/drivers/iommu/virtio-iommu.c
> > > @@ -78,6 +78,7 @@ struct viommu_endpoint {
> > >   	struct viommu_dev		*viommu;
> > >   	struct viommu_domain		*vdomain;
> > >   	struct list_head		resv_regions;
> > > +	u64				pgsize_bitmap;
> > >   };
> > >   struct viommu_request {
> > > @@ -415,6 +416,20 @@ static int viommu_replay_mappings(struct
> viommu_domain *vdomain)
> > >   	return ret;
> > >   }
> > > +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> > > +				    struct virtio_iommu_probe_pgsize_mask *mask,
> > > +				    size_t len)
> > > +
> > > +{
> > > +	u64 pgsize_bitmap =3D le64_to_cpu(mask->pgsize_bitmap);
> > > +
> > > +	if (len < sizeof(*mask))
> > > +		return -EINVAL;
> > > +
> > > +	vdev->pgsize_bitmap =3D pgsize_bitmap;
> > > +	return 0;
> > > +}
> > > +
> > >   static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> > >   			       struct virtio_iommu_probe_resv_mem *mem,
> > >   			       size_t len)
> > > @@ -494,11 +509,13 @@ static int viommu_probe_endpoint(struct
> viommu_dev *viommu, struct device *dev)
> > >   	while (type !=3D VIRTIO_IOMMU_PROBE_T_NONE &&
> > >   	       cur < viommu->probe_size) {
> > >   		len =3D le16_to_cpu(prop->length) + sizeof(*prop);
> > > -
>=20
> Whitespace change
>=20
> > >   		switch (type) {
> > >   		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> > >   			ret =3D viommu_add_resv_mem(vdev, (void *)prop, len);
> > >   			break;
> > > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > > +			ret =3D viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> > > +			break;
> > >   		default:
> > >   			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> > >   		}
> > > @@ -607,16 +624,23 @@ static struct iommu_domain
> *viommu_domain_alloc(unsigned type)
> > >   	return &vdomain->domain;
> > >   }
> > > -static int viommu_domain_finalise(struct viommu_dev *viommu,
> > > +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> > >   				  struct iommu_domain *domain)
> > >   {
> > >   	int ret;
> > >   	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> > > +	struct viommu_dev *viommu =3D vdev->viommu;
> > >   	vdomain->viommu		=3D viommu;
> > >   	vdomain->map_flags	=3D viommu->map_flags;
> > > -	domain->pgsize_bitmap	=3D viommu->pgsize_bitmap;
> > > +	/* Devices in same domain must support same size pages */
> >
> > AFAICS what the code appears to do is enforce that the first endpoint
> > attached to any domain has the same pgsize_bitmap as the most recently
> > probed viommu_dev instance, then ignore any subsequent endpoints
> > attached to the same domain. Thus I'm not sure that comment is accurate=
.
> >
>=20
> Yes viommu_domain_finalise() is only called once. What I had in mind is
> something like:

Ohh, I did not realized that viommu_domain_finalise().
I have included below suggested changes

>=20
> ---- 8< ----
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c =
index
> 750f69c49b95..8303b7b513ff 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -639,6 +639,29 @@ static int viommu_domain_finalise(struct
> viommu_endpoint *vdev,
>  	return 0;
>  }
>=20
> +/*
> + * Check whether the endpoint's capabilities are compatible with other
> +endpoints
> + * in the domain. Report any inconsistency.
> + */
> +static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
> +					  struct viommu_domain *vdomain)
> +{
> +	struct device *dev =3D vdev->dev;
> +
> +	if (vdomain->viommu !=3D vdev->viommu) {
> +		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> +		return false;
> +	}
> +
> +	if (vdomain->domain.pgsize_bitmap !=3D vdev->pgsize_bitmap) {
> +		dev_err(dev, "incompatible domain bitmap 0x%lx !=3D 0x%lx\n",
> +			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static void viommu_domain_free(struct iommu_domain *domain)  {
>  	struct viommu_domain *vdomain =3D to_viommu_domain(domain); @@ -
> 670,9 +693,8 @@ static int viommu_attach_dev(struct iommu_domain *domain,
> struct device *dev)
>  		 * owns it.
>  		 */
>  		ret =3D viommu_domain_finalise(vdev, domain);
> -	} else if (vdomain->viommu !=3D vdev->viommu) {
> -		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> -		ret =3D -EXDEV;
> +	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
> +		ret =3D -EINVAL;
>  	}
>  	mutex_unlock(&vdomain->mutex);
> ---- >8 ----
>=20
> >
> > > +	if ((domain->pgsize_bitmap !=3D viommu->pgsize_bitmap) &&
> > > +	    (domain->pgsize_bitmap !=3D vdev->pgsize_bitmap))
> > > +		return -EINVAL;
> > > +
> > > +	domain->pgsize_bitmap =3D vdev->pgsize_bitmap;
> > > +
> > >   	domain->geometry	=3D viommu->geometry;
> > >   	ret =3D ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> > > @@ -657,7 +681,7 @@ static int viommu_attach_dev(struct iommu_domain
> *domain, struct device *dev)
> > >   		 * Properly initialize the domain now that we know which viommu
> > >   		 * owns it.
> > >   		 */
> > > -		ret =3D viommu_domain_finalise(vdev->viommu, domain);
> > > +		ret =3D viommu_domain_finalise(vdev, domain);
> > >   	} else if (vdomain->viommu !=3D vdev->viommu) {
> > >   		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> > >   		ret =3D -EXDEV;
> > > @@ -875,6 +899,7 @@ static int viommu_add_device(struct device *dev)
> > >   	vdev->dev =3D dev;
> > >   	vdev->viommu =3D viommu;
> > > +	vdev->pgsize_bitmap =3D viommu->pgsize_bitmap;
> > >   	INIT_LIST_HEAD(&vdev->resv_regions);
> > >   	fwspec->iommu_priv =3D vdev;
> > > diff --git a/include/uapi/linux/virtio_iommu.h
> > > b/include/uapi/linux/virtio_iommu.h
> > > index 237e36a280cb..dc9d3f40bcd8 100644
> > > --- a/include/uapi/linux/virtio_iommu.h
> > > +++ b/include/uapi/linux/virtio_iommu.h
> > > @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
> > >   #define VIRTIO_IOMMU_PROBE_T_NONE		0
> > >   #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> > > +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> > >   #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
> > > @@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
> > >   	__le16					length;
> > >   };
> > > +struct virtio_iommu_probe_pgsize_mask {
> > > +	struct virtio_iommu_probe_property	head;
> > > +	__u8					reserved[4];
> > > +	__u64					pgsize_bitmap;
>=20
> Should be __le64

Based on" iommu/virtio: Fix sparse warning" patch https://www.spinics.net/l=
ists/linux-virtualization/msg41944.html changed to __u64 (not __le64)

Will keep __le64.

Thanks
-Bharat

>=20
> Thanks,
> Jean
>=20
> > > +};
> > > +
> > >   #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> > >   #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> > >
