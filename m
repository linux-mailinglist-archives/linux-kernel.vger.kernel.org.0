Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40EE448D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 19:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfFMRLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 13:11:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46080 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729107AbfFLWRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 18:17:41 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CMF27q025292;
        Wed, 12 Jun 2019 15:17:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UVi6SBU+TU6DizdoSHF74BKKc4C3hYdoIzsJ+g9SNnA=;
 b=L/o+F1YEvKougvxpw/JLp475Ms2eLuI9AHg843Q0ZY6je/H1JRNLIss9qxkWUaBYlQvn
 g3obIW1d8pkaEHWzP8urS0plHtm7op2NxrThO/N6UdCytVrtlRE7CM4m2h6WK4nhLt8/
 F5lUzF/wO42ZevCzixoAI/tXJMpqmBekK6g= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t39sng1nu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 12 Jun 2019 15:17:02 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 12 Jun 2019 15:17:02 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 12 Jun 2019 15:17:02 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 12 Jun 2019 15:17:00 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 12 Jun 2019 15:17:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVi6SBU+TU6DizdoSHF74BKKc4C3hYdoIzsJ+g9SNnA=;
 b=M2lZKjXjsCPh5yF468P+OMr9EAZOnxWgy+qbjrOqk+eLxIUHWuK8ZWwtP80iA4ofZn/O+dTwJKLLrIf5/har0Nub15qzKSEQDV7ucPbpIrp6iKfGyRHDpDuNA46SLBVwCG7H6eIrk5my22+qsbDkYuPcQj7m7pIo0+MTzKjsjJ4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1614.namprd15.prod.outlook.com (10.175.140.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Wed, 12 Jun 2019 22:16:56 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.1987.012; Wed, 12 Jun 2019
 22:16:56 +0000
From:   Song Liu <songliubraving@fb.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "namit@vmware.com" <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH v3 6/6] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Topic: [PATCH v3 6/6] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Index: AQHVIWshArYC/hbTQ0OTiKqf6fr6IKaYlj+A
Date:   Wed, 12 Jun 2019 22:16:56 +0000
Message-ID: <A753B71F-6AA2-494F-A790-C32E13555B83@fb.com>
References: <20190612220320.2223898-1-songliubraving@fb.com>
 <20190612220320.2223898-7-songliubraving@fb.com>
In-Reply-To: <20190612220320.2223898-7-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [199.201.64.139]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 088d4e8b-f3f5-492f-ed51-08d6ef83ae62
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1614;
x-ms-traffictypediagnostic: MWHPR15MB1614:
x-microsoft-antispam-prvs: <MWHPR15MB1614E995C0D243BE4E20EE68B3EC0@MWHPR15MB1614.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(186003)(66066001)(305945005)(53936002)(71200400001)(8676002)(2906002)(76176011)(71190400001)(6512007)(11346002)(81166006)(14454004)(50226002)(68736007)(25786009)(54906003)(110136005)(446003)(3846002)(86362001)(57306001)(316002)(6436002)(6486002)(81156014)(8936002)(6116002)(256004)(14444005)(4326008)(6506007)(66946007)(66556008)(73956011)(6246003)(64756008)(76116006)(66446008)(7736002)(36756003)(33656002)(99286004)(476003)(2616005)(478600001)(102836004)(53546011)(26005)(229853002)(486006)(66476007)(2501003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1614;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rbs4AV9+FvBWKWHT4g3MPc8dI6PlePm4QQPrm7MpQh5caEqT9v4vJxuwSmAi0MICslS2yI879/Vwii8SjaIZpNaGEZ6KkdRlig6bjh1fo284ckq4EwvfLQSYApnkeUXlyBGLCB9xpkuEIdj2B2OtQ4PLN0ts1+5D2fTm+ckVgxKhQ8ZjbxNFudST1E+gKNV6rdLSUbKiCpDocvrieBuME5IB0eS1QStRDs00C2WxhaO0HTlI6pPpl5AzaKEbaKFheai5euyR/V8lIt2AeJ/H1LR585AQ9MfS98Yq0Q9RcVdhYvLlH8nB//NFeDPB/sLcf+AsziUWTl0P9Bzmf7Op6eXQgE3F6DrE+rsnr2sWzxjDex+1Z5tyIXHMJF9zgZ5Hp42NTEuZ+fMfK9O0tS+qmdA5qX32YxEgX1DT7FaUZuI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0643978759D03543AAFF76D809971BC1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 088d4e8b-f3f5-492f-ed51-08d6ef83ae62
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 22:16:56.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1614
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120155
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 12, 2019, at 3:03 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This patches introduces a new foll_flag: FOLL_SPLIT_PMD. As the name says
> FOLL_SPLIT_PMD splits huge pmd for given mm_struct, the underlining huge
> page stays as-is.
>=20
> FOLL_SPLIT_PMD is useful for cases where we need to use regular pages,
> but would switch back to huge page and huge pmd on. One of such example
> is uprobe. The following patches use FOLL_SPLIT_PMD in uprobe.
>=20
> Signed-off-by: Song Liu <songliubraving@fb.com>

Please ignore this one. It is a duplicated copy of 3/5, sent by accident.=20

Sorry for the noise.=20

Song

> ---
> include/linux/mm.h |  1 +
> mm/gup.c           | 38 +++++++++++++++++++++++++++++++++++---
> 2 files changed, 36 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ab8c7d84cd0..e605acc4fc81 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2642,6 +2642,7 @@ struct page *follow_page(struct vm_area_struct *vma=
, unsigned long address,
> #define FOLL_COW	0x4000	/* internal GUP flag */
> #define FOLL_ANON	0x8000	/* don't do file mappings */
> #define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see belo=
w */
> +#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
>=20
> /*
>  * NOTE on FOLL_LONGTERM:
> diff --git a/mm/gup.c b/mm/gup.c
> index ddde097cf9e4..3d05bddb56c9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -398,7 +398,7 @@ static struct page *follow_pmd_mask(struct vm_area_st=
ruct *vma,
> 		spin_unlock(ptl);
> 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
> 	}
> -	if (flags & FOLL_SPLIT) {
> +	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
> 		int ret;
> 		page =3D pmd_page(*pmd);
> 		if (is_huge_zero_page(page)) {
> @@ -407,7 +407,7 @@ static struct page *follow_pmd_mask(struct vm_area_st=
ruct *vma,
> 			split_huge_pmd(vma, pmd, address);
> 			if (pmd_trans_unstable(pmd))
> 				ret =3D -EBUSY;
> -		} else {
> +		} else if (flags & FOLL_SPLIT) {
> 			if (unlikely(!try_get_page(page))) {
> 				spin_unlock(ptl);
> 				return ERR_PTR(-ENOMEM);
> @@ -419,8 +419,40 @@ static struct page *follow_pmd_mask(struct vm_area_s=
truct *vma,
> 			put_page(page);
> 			if (pmd_none(*pmd))
> 				return no_page_table(vma, flags);
> -		}
> +		} else {  /* flags & FOLL_SPLIT_PMD */
> +			unsigned long addr;
> +			pgprot_t prot;
> +			pte_t *pte;
> +			int i;
> +
> +			spin_unlock(ptl);
> +			split_huge_pmd(vma, pmd, address);
> +			lock_page(page);
> +			pte =3D get_locked_pte(mm, address, &ptl);
> +			if (!pte) {
> +				unlock_page(page);
> +				return no_page_table(vma, flags);
> +			}
>=20
> +			/* get refcount for every small page */
> +			page_ref_add(page, HPAGE_PMD_NR);
> +
> +			prot =3D READ_ONCE(vma->vm_page_prot);
> +			for (i =3D 0, addr =3D address & PMD_MASK;
> +			     i < HPAGE_PMD_NR; i++, addr +=3D PAGE_SIZE) {
> +				struct page *p =3D page + i;
> +
> +				pte =3D pte_offset_map(pmd, addr);
> +				VM_BUG_ON(!pte_none(*pte));
> +				set_pte_at(mm, addr, pte, mk_pte(p, prot));
> +				page_add_file_rmap(p, false);
> +			}
> +
> +			spin_unlock(ptl);
> +			unlock_page(page);
> +			add_mm_counter(mm, mm_counter_file(page), HPAGE_PMD_NR);
> +			ret =3D 0;
> +		}
> 		return ret ? ERR_PTR(ret) :
> 			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
> 	}
> --=20
> 2.17.1
>=20

