Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BD785262
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 19:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbfHGRvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 13:51:21 -0400
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:60999
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388323AbfHGRvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:51:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXtyE25G3xpLGXX/rt//zw4804WFmHvXf06GoxyEfeIPKr4Vc2YKaASvU8WuKTF8yMxf6ELSDdzIVSlbBnX1t1Gil/y/Y5FntQh6xMkGviKZjITPTEyZf3MgDFA3rU9yQAGbvPf/MQcEba4ECBxB4N1oNgjx/mB4Tw2aAdFKTuOH4CutyUyrYCXXv6zCqzNYJurYVN+/0gMbBUeUTk9mbCMno01CpdjxzZJFY9wmHpvuwyIEsYVOWe38hfCDPWxXn+0zYWWsgXd2TlDAmD76N3V8bHqh2XruHq2EiFhrIwMqOQgCARfdc1UhyocNdKS7HpZjV9iOfpyYspD40EK2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAlAMG+JLtGu7rKGT5llROIM3tAMQg7D1447E3gVtM4=;
 b=bXmPki7M34ONwDreXer1P/NQQPYPpfh9XpG1wqQzRj0M4syioPOpXEO/bvpa+BWbbXTDTMYUGEYq1DUwleqj9qx3E6x88g+SQCaAaapkiV9tW+XkiCcPAJnZCvaQqQqh46Sd/yOQC2iuizoxXYpMG+XjrdzrfqwC+FTu0FQwO8Kl+v8H/bj5pOqyiGtoyEmnWN5OA0PIiixFFHFubpTelT5mLkIGpfi7z/FoZ17ZblYVmffvGxKJJ8OoQqA3+e0ihrAnoH4nwhFoR4yJRNlJ35nlW3RUKLG04Nnr57M0+3sqm3Snk4DYQX148B5gZeBPUw209KnMd04n3l9rIjjbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAlAMG+JLtGu7rKGT5llROIM3tAMQg7D1447E3gVtM4=;
 b=R3wXDFk6hnDteCxXS5NGpq8bVi7h8mU45v/Hcen6oX7SLOE3QihKNnxadklMLOLtZjcpfYpLyLJ+TgiwOFr5gQGZvO1khRoeBKtHaahn6H34cW+VZlLVseM8NIIy2mRkQlN4EUXXV8WJNyfNZ6cHjbkPrRzNIsMOYPqFX/hCpnk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6607.eurprd05.prod.outlook.com (20.178.205.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 17:51:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 17:51:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/15] mm: remove the page_shift member from struct
 hmm_range
Thread-Topic: [PATCH 07/15] mm: remove the page_shift member from struct
 hmm_range
Thread-Index: AQHVTHDhMApuLJXfWUaciRaOjOxjbqbv+IOA
Date:   Wed, 7 Aug 2019 17:51:15 +0000
Message-ID: <20190807175111.GK1571@mellanox.com>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-8-hch@lst.de>
In-Reply-To: <20190806160554.14046-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae992588-10fd-446d-e1eb-08d71b5fd822
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6607;
x-ms-traffictypediagnostic: VI1PR05MB6607:
x-microsoft-antispam-prvs: <VI1PR05MB6607589B4FB067B309C429B1CFD40@VI1PR05MB6607.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(26005)(446003)(186003)(81156014)(54906003)(2616005)(36756003)(1076003)(33656002)(6116002)(66446008)(66476007)(66556008)(64756008)(3846002)(4326008)(66946007)(2906002)(25786009)(486006)(5660300002)(86362001)(6512007)(6486002)(68736007)(66066001)(102836004)(229853002)(305945005)(14444005)(256004)(316002)(7416002)(81166006)(476003)(53936002)(6916009)(11346002)(6436002)(6246003)(386003)(8676002)(52116002)(99286004)(14454004)(7736002)(6506007)(76176011)(8936002)(71190400001)(478600001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6607;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kfUNTOMdAfho2KNsdjUo3q203BZssmyXfelnc8PxTtXuszCmv806J1OoBxn+fnZ9d/xz1i2ho2cFcWqEK+AwbdK0EnJEZy0eMhzYSoU66nlbPDvjPo2L8Ozi7hPw527x131L1iV1r2YQ2lSNnfY81sW3DAibEz9pD9OWh6E0DjIZa3m+Lvc4zYLbLWTWPDS4MvmsJeXsSiBujBvCxMe4wHq3VVl2G0/0elnSyowCCiQYRQ5nzisObESi5aJ6VMUJ+4AhgXV7SplcCFxFvPsUnFlcA3rU9tOruJVHAbahwtoO5S44IC/Q+59/rMEvy929Okjv7+PVUroEUwcEiBXu1qG3brDbZhHkAY/UKRtNc3sefaAb9d1VH7TV/q+aTFymGNex5sMyQ2x2u76Y4yon9QkCSI0dQE3znay8y7fKK6k=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <86EB60C23734734B9F17174012EEEC37@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae992588-10fd-446d-e1eb-08d71b5fd822
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 17:51:15.9361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6607
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:05:45PM +0300, Christoph Hellwig wrote:
> All users pass PAGE_SIZE here, and if we wanted to support single
> entries for huge pages we should really just add a HMM_FAULT_HUGEPAGE
> flag instead that uses the huge page size instead of having the
> caller calculate that size once, just for the hmm code to verify it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  1 -
>  drivers/gpu/drm/nouveau/nouveau_svm.c   |  1 -
>  include/linux/hmm.h                     | 22 -------------
>  mm/hmm.c                                | 42 ++++++-------------------
>  4 files changed, 9 insertions(+), 57 deletions(-)

Having looked at ODP more closley this doesn't seem to match what it
needs anyhow. It can keep using its checking algorithm
=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 71d6e7087b0b..8bf79288c4e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -818,7 +818,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo=
, struct page **pages)
>  				0 : range->flags[HMM_PFN_WRITE];
>  	range->pfn_flags_mask =3D 0;
>  	range->pfns =3D pfns;
> -	range->page_shift =3D PAGE_SHIFT;
>  	range->start =3D start;
>  	range->end =3D start + ttm->num_pages * PAGE_SIZE;
> =20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouv=
eau/nouveau_svm.c
> index 41fad4719ac6..668d4bd0c118 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -680,7 +680,6 @@ nouveau_svm_fault(struct nvif_notify *notify)
>  			 args.i.p.addr + args.i.p.size, fn - fi);
> =20
>  		/* Have HMM fault pages within the fault window to the GPU. */
> -		range.page_shift =3D PAGE_SHIFT;
>  		range.start =3D args.i.p.addr;
>  		range.end =3D args.i.p.addr + args.i.p.size;
>  		range.pfns =3D args.phys;
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index c5b51376b453..51e18fbb8953 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -158,7 +158,6 @@ enum hmm_pfn_value_e {
>   * @values: pfn value for some special case (none, special, error, ...)
>   * @default_flags: default flags for the range (write, read, ... see hmm=
 doc)
>   * @pfn_flags_mask: allows to mask pfn flags so that only default_flags =
matter
> - * @page_shift: device virtual address shift value (should be >=3D PAGE_=
SHIFT)
>   * @pfn_shifts: pfn shift value (should be <=3D PAGE_SHIFT)
>   * @valid: pfns array did not change since it has been fill by an HMM fu=
nction
>   */
> @@ -172,31 +171,10 @@ struct hmm_range {
>  	const uint64_t		*values;
>  	uint64_t		default_flags;
>  	uint64_t		pfn_flags_mask;
> -	uint8_t			page_shift;
>  	uint8_t			pfn_shift;
>  	bool			valid;
>  };
> =20
> -/*
> - * hmm_range_page_shift() - return the page shift for the range
> - * @range: range being queried
> - * Return: page shift (page size =3D 1 << page shift) for the range
> - */
> -static inline unsigned hmm_range_page_shift(const struct hmm_range *rang=
e)
> -{
> -	return range->page_shift;
> -}
> -
> -/*
> - * hmm_range_page_size() - return the page size for the range
> - * @range: range being queried
> - * Return: page size for the range in bytes
> - */
> -static inline unsigned long hmm_range_page_size(const struct hmm_range *=
range)
> -{
> -	return 1UL << hmm_range_page_shift(range);
> -}
> -
>  /*
>   * hmm_range_wait_until_valid() - wait for range to be valid
>   * @range: range affected by invalidation to wait on
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 926735a3aef9..f26d6abc4ed2 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -344,13 +344,12 @@ static int hmm_vma_walk_hole_(unsigned long addr, u=
nsigned long end,
>  	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
>  	struct hmm_range *range =3D hmm_vma_walk->range;
>  	uint64_t *pfns =3D range->pfns;
> -	unsigned long i, page_size;
> +	unsigned long i;
> =20
>  	hmm_vma_walk->last =3D addr;
> -	page_size =3D hmm_range_page_size(range);
> -	i =3D (addr - range->start) >> range->page_shift;
> +	i =3D (addr - range->start) >> PAGE_SHIFT;
> =20
> -	for (; addr < end; addr +=3D page_size, i++) {
> +	for (; addr < end; addr +=3D PAGE_SIZE, i++) {
>  		pfns[i] =3D range->values[HMM_PFN_NONE];
>  		if (fault || write_fault) {
>  			int ret;
> @@ -772,7 +771,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, uns=
igned long hmask,
>  				      struct mm_walk *walk)
>  {
>  #ifdef CONFIG_HUGETLB_PAGE
> -	unsigned long addr =3D start, i, pfn, mask, size, pfn_inc;
> +	unsigned long addr =3D start, i, pfn, mask;
>  	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
>  	struct hmm_range *range =3D hmm_vma_walk->range;
>  	struct vm_area_struct *vma =3D walk->vma;
> @@ -783,24 +782,12 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, u=
nsigned long hmask,
>  	pte_t entry;
>  	int ret =3D 0;
> =20
> -	size =3D huge_page_size(h);
> -	mask =3D size - 1;
> -	if (range->page_shift !=3D PAGE_SHIFT) {
> -		/* Make sure we are looking at a full page. */
> -		if (start & mask)
> -			return -EINVAL;
> -		if (end < (start + size))
> -			return -EINVAL;
> -		pfn_inc =3D size >> PAGE_SHIFT;
> -	} else {
> -		pfn_inc =3D 1;
> -		size =3D PAGE_SIZE;
> -	}
> +	mask =3D huge_page_size(h) - 1;
> =20
>  	ptl =3D huge_pte_lock(hstate_vma(vma), walk->mm, pte);
>  	entry =3D huge_ptep_get(pte);
> =20
> -	i =3D (start - range->start) >> range->page_shift;
> +	i =3D (start - range->start) >> PAGE_SHIFT;
>  	orig_pfn =3D range->pfns[i];
>  	range->pfns[i] =3D range->values[HMM_PFN_NONE];
>  	cpu_flags =3D pte_to_hmm_pfn_flags(range, entry);
> @@ -812,8 +799,8 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, uns=
igned long hmask,
>  		goto unlock;
>  	}
> =20
> -	pfn =3D pte_pfn(entry) + ((start & mask) >> range->page_shift);
> -	for (; addr < end; addr +=3D size, i++, pfn +=3D pfn_inc)
> +	pfn =3D pte_pfn(entry) + ((start & mask) >> PAGE_SHIFT);
> +	for (; addr < end; addr +=3D PAGE_SIZE, i++, pfn++)
>  		range->pfns[i] =3D hmm_device_entry_from_pfn(range, pfn) |
>  				 cpu_flags;
>  	hmm_vma_walk->last =3D end;
> @@ -850,14 +837,13 @@ static void hmm_pfns_clear(struct hmm_range *range,
>   */
>  int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirro=
r)
>  {
> -	unsigned long mask =3D ((1UL << range->page_shift) - 1UL);
>  	struct hmm *hmm =3D mirror->hmm;
>  	unsigned long flags;
> =20
>  	range->valid =3D false;
>  	range->hmm =3D NULL;
> =20
> -	if ((range->start & mask) || (range->end & mask))
> +	if ((range->start & (PAGE_SIZE - 1)) || (range->end & (PAGE_SIZE - 1)))
>  		return -EINVAL;

PAGE_SIZE-1 =3D=3D PAGE_MASK ? If yes I can fix it

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
