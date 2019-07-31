Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12517CC98
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 21:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfGaTPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 15:15:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38438 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729021AbfGaTPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:15:24 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VJ2cMV000549;
        Wed, 31 Jul 2019 12:15:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zUv39lAwOIZATPyuoD0mBqM8312B4B/AA8lhn8qqi/s=;
 b=TP0Qxo1KE32wsETT8MOcEo5gJoQq7SK8c+8d+iSu/CZLMeBmd482bqpQNIFHugriUTAa
 /TEfHltGkG7J2LewSv0CVM6fI5MH+r5Sn6wITLoRqswuA6F8it40MokrfftmIMAdw1zD
 v8NQrfdi4cmmMt6LPy4I64BMWG/xzYcKbyE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u3c8bsa7u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 31 Jul 2019 12:15:15 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 12:14:56 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 10:10:13 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 31 Jul 2019 10:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrhgU2bvxfipaLF4J47ZkTq9/MrFmi6TBNtaC7WE5ajxJuB9pFP6MFFaMAiSYdBDV44PkYVmeilZ2Ol/E1hcZom272H4HiepEyoMdGZtkzJp82sZYV9Fb8ntkCDu1z55Z6hRHtw9zQf4Sf8m/1Rx8ilukXuIQJxnghComTqM2a7pWf32vBmPz+5B38SvxURSsAtE7GCBOCwvYLIur5sQgbDGyxpWRd3Fek9fpzS62yHkASLh/AFuPRBJy9ITJuyTjzr2QUs0ATI2P3+pWDaE0yrqiR6hNcwJk/yarWqxNo/6G+hC5ta6kra2gG03qJtf6EjH1YWwwhC9a2OJHBJUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUv39lAwOIZATPyuoD0mBqM8312B4B/AA8lhn8qqi/s=;
 b=HdYNuHY+tER0apnPomC5whcSBmwhOlpRZd0bKf7qBMr/yjkxw6jhpnUVWi9RWdQlE9/yZUJSSiy1yAE8o7vA346vlV43PE8bivojDy3hy7nGv0nIr9espu0dKfH0zktPiGMCNh6Fz+XD8yGrFjbAn7SKBgJbrXolPshg1UXVKy9YIK1alw9TctFQQS71ml5rJXE5Ys4YzLRYe9+CeOQFUUZxjJzrQhJk/X6cFDXN0Muzsj4Y40JQ59jxZIoV5EX2K45+Q5lPrZxNhWTDfrEVnmd5VpH4YV0kaBd75ZhVT1DIhiuvEQRjanJlg9lHr72XGcRHbTzRgjVSmDvW/BFLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUv39lAwOIZATPyuoD0mBqM8312B4B/AA8lhn8qqi/s=;
 b=UqdqZg9n6rmkIY/QucHgiSL9agrYpbEGYaNrL7p4TfeDALWZBpC6fRkDnS94BEn6NF52TQOJ3o9lbmjhASMiLcA8PuIrbiNQxFiNGjkYGSei1VDL6MCuUAP+Rgx3FfB2bTZsBJDmllFPwB4y2gYc5Xjf0s39AVKQ1o3LAg5Nh2I=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1309.namprd15.prod.outlook.com (10.175.3.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Wed, 31 Jul 2019 17:10:11 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::d4fc:70c0:79a5:f41b%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 17:10:11 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v10 3/4] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Topic: [PATCH v10 3/4] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Index: AQHVRpbyXlkLbIiwxECjtBJ+XLP3V6bjVaQAgAAZagCAAWo+gIAAHyQA
Date:   Wed, 31 Jul 2019 17:10:11 +0000
Message-ID: <04FB43C3-6E2B-4868-B9D5-C00342DA5C6F@fb.com>
References: <20190730052305.3672336-1-songliubraving@fb.com>
 <20190730052305.3672336-4-songliubraving@fb.com>
 <20190730161113.GC18501@redhat.com>
 <1E2B5653-BA85-4A05-9B41-57CF9E48F14A@fb.com>
 <20190731151842.GB25078@redhat.com>
In-Reply-To: <20190731151842.GB25078@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:70cb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf4a40bf-da5a-4e1d-e2bc-08d715d9f256
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1309;
x-ms-traffictypediagnostic: MWHPR15MB1309:
x-microsoft-antispam-prvs: <MWHPR15MB1309E439A41AF210247D251CB3DF0@MWHPR15MB1309.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(6506007)(6486002)(53546011)(71200400001)(102836004)(71190400001)(36756003)(6116002)(57306001)(2616005)(486006)(446003)(476003)(229853002)(50226002)(8676002)(81166006)(5660300002)(81156014)(6436002)(6512007)(11346002)(86362001)(186003)(46003)(478600001)(68736007)(8936002)(6246003)(316002)(25786009)(4326008)(2906002)(53936002)(54906003)(66476007)(66556008)(64756008)(66946007)(66446008)(76176011)(99286004)(76116006)(256004)(6916009)(305945005)(14454004)(33656002)(14444005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1309;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MgQeCXNQ2LYa+ewUjS1JZuDrzAG7tvpXljycVOS02WWpQ4CWoP95zEH7dNC4TzT+4CgR10o+Pzhys6qemhUaiWqgyindti1MzfQVnFNRj9zjPWM7dcXqhtZnZv1vPc83xpYXwMfGzdMTpS2e/wDvgjxa7uwbgY4+hORHYqWwKqfD+vbg3fO0RAj+xoGo1XGQzmwzzYY2GPn2oj15523EZqgbpS2cYEoRnyDPJ48uLOKg8ErjfODyfpNSj/VCtx9XYYmGzEBNE9GsL/UX0xJAJ6RbR9XcNY6HqVUdp2jXwti+NsskO8NhP8NUXl4nRxX04SFxAoDgMbkiSGigbkokFxf7FSF4hmovFfS33zYAX4IjBMHkKokimOe65CJb1hMPRwMRqK8A3iIkLdiQMEKfzCEcaY8vYlcpfnvmIXZD8Fo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <440364F82D87CB439B1BD89C43F6E8EB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4a40bf-da5a-4e1d-e2bc-08d715d9f256
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:10:11.2360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1309
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=859 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310190
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 31, 2019, at 8:18 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 07/30, Song Liu wrote:
>>=20
>>=20
>>> On Jul 30, 2019, at 9:11 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>=20
>>> So after the next patch we have a single user of FOLL_SPLIT_PMD (uprobe=
s)
>>> and a single user of FOLL_SPLIT: arch/s390/mm/gmap.c:thp_split_mm().
>>>=20
>>> Hmm.
>>=20
>> I think this is what we want. :)
>=20
> We? I don't ;)
>=20
>> FOLL_SPLIT is the fallback solution for users who cannot handle THP.
>=20
> and again, we have a single user: thp_split_mm(). I do not know if it
> can use FOLL_SPLIT_PMD or not, may be you can take a look...

I haven't played with s390, so it gonna take me some time to ramp up.=20
I will add it to my to-do list.=20

>=20
>> With
>> more THP aware code, there will be fewer users of FOLL_SPLIT.
>=20
> Fewer than 1? Good ;)

Yes! It will be great if thp_split_mm() can use FOLL_SPLIT_PMD=20
instead.=20

>=20
>>>> @@ -399,7 +399,7 @@ static struct page *follow_pmd_mask(struct vm_area=
_struct *vma,
>>>> 		spin_unlock(ptl);
>>>> 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
>>>> 	}
>>>> -	if (flags & FOLL_SPLIT) {
>>>> +	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
>>>> 		int ret;
>>>> 		page =3D pmd_page(*pmd);
>>>> 		if (is_huge_zero_page(page)) {
>>>> @@ -408,7 +408,7 @@ static struct page *follow_pmd_mask(struct vm_area=
_struct *vma,
>>>> 			split_huge_pmd(vma, pmd, address);
>>>> 			if (pmd_trans_unstable(pmd))
>>>> 				ret =3D -EBUSY;
>>>> -		} else {
>>>> +		} else if (flags & FOLL_SPLIT) {
>>>> 			if (unlikely(!try_get_page(page))) {
>>>> 				spin_unlock(ptl);
>>>> 				return ERR_PTR(-ENOMEM);
>>>> @@ -420,6 +420,10 @@ static struct page *follow_pmd_mask(struct vm_are=
a_struct *vma,
>>>> 			put_page(page);
>>>> 			if (pmd_none(*pmd))
>>>> 				return no_page_table(vma, flags);
>>>> +		} else {  /* flags & FOLL_SPLIT_PMD */
>>>> +			spin_unlock(ptl);
>>>> +			split_huge_pmd(vma, pmd, address);
>>>> +			ret =3D pte_alloc(mm, pmd);
>>>=20
>>> I fail to understand why this differs from the is_huge_zero_page() case=
 above.
>>=20
>> split_huge_pmd() handles is_huge_zero_page() differently. In this case, =
we
>> cannot use the pmd_trans_unstable() check.
>=20
> Please correct me, but iiuc the problem is not that split_huge_pmd() hand=
les
> is_huge_zero_page() differently, the problem is that __split_huge_pmd_loc=
ked()
> handles the !vma_is_anonymous(vma) differently and returns with pmd_none(=
) =3D T
> after pmdp_huge_clear_flush_notify(). This means that pmd_trans_unstable(=
) will
> fail.

Agreed.=20

>=20
> Now, I don't understand why do we need pmd_trans_unstable() after
> split_huge_pmd(huge-zero-pmd), but whatever reason we have, why can't we
> unify both cases?
>=20
> IOW, could you explain why the path below is wrong?

I _think_ the following patch works (haven't fully tested yet). But I am no=
t=20
sure whether this is the best. By separating the two cases, we don't duplic=
ate=20
much code. And it is clear that the two cases are handled differently.=20
Therefore, I would prefer to keep these separate for now.=20

Thanks,
Song

>=20
>=20
> --- x/mm/gup.c
> +++ x/mm/gup.c
> @@ -399,14 +399,16 @@ static struct page *follow_pmd_mask(struct vm_area_=
struct *vma,
> 		spin_unlock(ptl);
> 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
> 	}
> -	if (flags & FOLL_SPLIT) {
> +	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
> 		int ret;
> 		page =3D pmd_page(*pmd);
> -		if (is_huge_zero_page(page)) {
> +		if ((flags & FOLL_SPLIT_PMD) || is_huge_zero_page(page)) {
> 			spin_unlock(ptl);
> -			ret =3D 0;
> 			split_huge_pmd(vma, pmd, address);
> -			if (pmd_trans_unstable(pmd))
> +			ret =3D 0;
> +			if (pte_alloc(mm, pmd))
> +				ret =3D -ENOMEM;
> +			else if (pmd_trans_unstable(pmd))
> 				ret =3D -EBUSY;
> 		} else {
> 			if (unlikely(!try_get_page(page))) {
>=20

