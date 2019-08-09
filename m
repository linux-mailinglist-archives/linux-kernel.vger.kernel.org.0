Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962EF881EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437325AbfHISBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 14:01:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436696AbfHISBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:01:37 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79HvNjx013017;
        Fri, 9 Aug 2019 11:01:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=O3AnU8diUS+8mHh7XdfV1+alfT02IrKTEceBQiLDm7o=;
 b=MoYkFjYLhdmCHTVoPyVDGPxFxUgUPEeFOQT4YAkaQNh4mXuJCgMD5XNoTRw2DyN0POl9
 xZyE6BGEUN2uZ8l5aSDG2X4jppLmLoE8eemZr00qOQ/YfAwPXIUB9KQdRSs2hm8+AHm0
 RHFnU9HgWn/cVFHVbQ2WBXQu7c6A74Qc9HM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u96uy9xkg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 09 Aug 2019 11:01:25 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 9 Aug 2019 11:01:20 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 9 Aug 2019 11:01:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Izzf2//0OQ89S7n+tHbWiao1Nrj7GFzquO4O4G+uFOvuYNxgRo1YH4RxpmrQfao9MThQWddYjr/KP653/lKTMRBeSQOPd3R+IzArErJf8Y4ojwH/colO+IWH19ybgQp50ZGx8CiCi285jhCM2Bh+gm1/TCxvYF/nCahB9IDE+w6/t+bl0U9uJ3s3Gl8yE9kxWOefgDi9/pfyxA0JIBqoIC2QkT3pkSI0+KeysImQaxLGRGQX/QIL51SKW/1B0aOQrGQ7YFO272hDetBBxHWPRPJ2Rn78eVLXF/3wPH3TcEbNVRwtW6zm+46Qy5djc4TSluizB/QsPpyjDwC2Q69/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3AnU8diUS+8mHh7XdfV1+alfT02IrKTEceBQiLDm7o=;
 b=EJqH90dWS4XtnhghvxkuCR7ailRA3LGzmjC8pqMQCAuaxVqQeCVK/suZRJKrAQyalE6/qnMd2WYdcOBe1Ra5aql1PCEaW39eXSbUENWqMewysue9Ic6/RQBqUtatGAO7WFF+A+fJcwIPxDRTBGcQ9RVY5PxWh2awcM2Y9Z2HFQGBIwhw/DJDqSKCvn1/LxGJ7z/c5F9+cf350AFvOUv1oWFxRD5hWiqyiNxq9HFxPk+TMgbaU5172AoKT1Gc7dJIQDTQLzTc5Rw7+yQTjJgC6LCixMNyl140L8MuV3+LPgBpDNPENvDWAJlcAlNEjuSjuOPYFsdtO12otEJcxvYf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3AnU8diUS+8mHh7XdfV1+alfT02IrKTEceBQiLDm7o=;
 b=UyYmoUh60tky5DpLUqsskyl7ixEy4Xpsgchg1Kz+MLWFHHNosI3jkunzrOoxz2WWPDbm4ozAWna0ZADVM7VCuW/uDyGNy+x6uYso3L6R33usSOvQS4B3DGXYrpCDMQiBEg6YESwzcScz/XjDJ8htRChfu5szcpsRwuO6DWAiNGQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1245.namprd15.prod.outlook.com (10.175.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Fri, 9 Aug 2019 18:01:19 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d%9]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 18:01:18 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox" <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "William Kucharski" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 5/6] khugepaged: enable collapse pmd for pte-mapped
 THP
Thread-Topic: [PATCH v12 5/6] khugepaged: enable collapse pmd for pte-mapped
 THP
Thread-Index: AQHVTXlDuUiBx4u3AUqTmiQ0C68ad6bxcvOAgAAJMACAAXXfAIAAEp4AgAAZUAA=
Date:   Fri, 9 Aug 2019 18:01:18 +0000
Message-ID: <4D8B8397-5107-456B-91FC-4911F255AE11@fb.com>
References: <20190807233729.3899352-1-songliubraving@fb.com>
 <20190807233729.3899352-6-songliubraving@fb.com>
 <20190808163303.GB7934@redhat.com>
 <770B3C29-CE8F-4228-8992-3C6E2B5487B6@fb.com>
 <20190809152404.GA21489@redhat.com>
 <3B09235E-5CF7-4982-B8E6-114C52196BE5@fb.com>
In-Reply-To: <3B09235E-5CF7-4982-B8E6-114C52196BE5@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:68ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 361820ad-59c1-4c02-ec89-08d71cf39477
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1245;
x-ms-traffictypediagnostic: MWHPR15MB1245:
x-microsoft-antispam-prvs: <MWHPR15MB1245FD5032443A93E84D1C14B3D60@MWHPR15MB1245.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(136003)(346002)(199004)(189003)(64756008)(102836004)(8936002)(66476007)(6506007)(256004)(5024004)(53546011)(46003)(186003)(25786009)(14444005)(66556008)(36756003)(66446008)(33656002)(50226002)(66946007)(54906003)(81156014)(8676002)(2906002)(6512007)(316002)(81166006)(99286004)(86362001)(229853002)(6116002)(76176011)(76116006)(478600001)(6486002)(7736002)(305945005)(53936002)(6436002)(6916009)(57306001)(486006)(11346002)(71190400001)(476003)(2616005)(5660300002)(14454004)(6246003)(71200400001)(446003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1245;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 89k9gf40zFIKQxla5a1uzoz8JgIq+gA3xthSRdSTputMYbBJvwdopusYuArfkaurM2dOR7GbRvBgE0E5+pzK8mtqk6B0kN4Ge3WxtdBhgMyubFc8MBofkFDhdSFxvyosVEd9qpLGUwGKV2uI/A+fyLA7EuyLOylAd1gvvqX6+6f808y0QDMssX6NLULKRWx5ucSQSoOPuIH94DIUzZz3So7q4jb6VItslp3xAhVOuSG7AO4WhatLOVVOWHBu4UFIRXvq6WBcmGhs0+E/mzZLGTyT1/6VYI7DVAMjucVsOGyJZ6PRrxJiypH7t20/N5mHL/oiKPGZB2O6b4otp/Yo2DMfhB5YhZP7Kdk8uA+K4ZifW1/UDmp0I1p+0YvLhJiLVd8naEqVNvrjzoLrnwtFh8a9+inMu6Wk8s1QI6pgpE4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7A123780FC5B54AA37939CE472B86C5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 361820ad-59c1-4c02-ec89-08d71cf39477
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 18:01:18.7633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /uhwyue1QbL3+fxrwSlILwwhWwrsWAX9VYw2YDQkWwxprbDCPZNSMkJNCJDwhrGTnJ9JzaYJQUHD55n+ohMZpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1245
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=929 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090179
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 9, 2019, at 9:30 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Aug 9, 2019, at 8:24 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>=20
>> On 08/08, Song Liu wrote:
>>>=20
>>>> On Aug 8, 2019, at 9:33 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>>=20
>>>>> +	for (i =3D 0, addr =3D haddr; i < HPAGE_PMD_NR; i++, addr +=3D PAGE=
_SIZE) {
>>>>> +		pte_t *pte =3D pte_offset_map(pmd, addr);
>>>>> +		struct page *page;
>>>>> +
>>>>> +		if (pte_none(*pte))
>>>>> +			continue;
>>>>> +
>>>>> +		page =3D vm_normal_page(vma, addr, *pte);
>>=20
>> just noticed... shouldn't you also check pte_present() before
>> vm_normal_page() ?
>=20
> Good catch! Let me fix this.=20
>=20
>>=20
>>>>> +		if (!page || !PageCompound(page))
>>>>> +			return;
>>>>> +
>>>>> +		if (!hpage) {
>>>>> +			hpage =3D compound_head(page);
>>>>=20
>>>> OK,
>>>>=20
>>>>> +			if (hpage->mapping !=3D vma->vm_file->f_mapping)
>>>>> +				return;
>>>>=20
>>>> is it really possible? May be WARN_ON(hpage->mapping !=3D vm_file->f_m=
apping)
>>>> makes more sense ?
>>>=20
>>> I haven't found code paths lead to this,
>>=20
>> Neither me, that is why I asked. I think this should not be possible,
>> but again this is not my area.
>>=20
>>> but this is technically possible.
>>> This pmd could contain subpages from different THPs.
>>=20
>> Then please explain how this can happen ?
>>=20
>>> The __replace_page()
>>> function in uprobes.c creates similar pmd.
>>=20
>> No it doesn't,
>>=20
>>> Current uprobe code won't really create this problem, because
>>> !PageCompound() check above is sufficient. But it won't be difficult to
>>> modify uprobe code to break this.
>>=20
>> I bet it will be a) difficult and b) the very idea to do this would be w=
rong.
>>=20
>>> For this code to be accurate and safe,
>>> I think both this check and the one below are necessary.
>>=20
>> I didn't suggest to remove these checks.
>>=20
>>> Also, this code
>>> is not on any critical path, so the overhead should be negligible.
>>=20
>> I do not care about overhead. But I do care about a poor reader like me
>> who will try to understand this code.
>>=20
>> If you too do not understand how a THP page can have a different mapping
>> then use VM_WARN or at least add a comment to explain that this is not
>> supposed to happen!
>=20
> Fair enough. I will add WARN and more comments.=20
>=20
> Thanks,
> Song

To reduce spamming, I attached updated 5/6 here.=20

Thanks,
Song

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

From 3fb735e03b149bf8a90918dd383a3a31b3f9008a Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Sun, 28 Jul 2019 03:43:48 -0700
Subject: [PATCH v13 5/6] khugepaged: enable collapse pmd for pte-mapped THP

khugepaged needs exclusive mmap_sem to access page table. When it fails
to lock mmap_sem, the page will fault in as pte-mapped THP. As the page
is already a THP, khugepaged will not handle this pmd again.

This patch enables the khugepaged to retry collapse the page table.

struct mm_slot (in khugepaged.c) is extended with an array, containing
addresses of pte-mapped THPs. We use array here for simplicity. We can
easily replace it with more advanced data structures when needed.

In khugepaged_scan_mm_slot(), if the mm contains pte-mapped THP, we try
to collapse the page table.

Since collapse may happen at an later time, some pages may already fault
in. collapse_pte_mapped_thp() is added to properly handle these pages.
collapse_pte_mapped_thp() also double checks whether all ptes in this pmd
are mapping to the same THP. This is necessary because some subpage of
the THP may be replaced, for example by uprobe. In such cases, it is not
possible to collapse the pmd.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/khugepaged.h |  12 +++
 mm/khugepaged.c            | 154 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 082d1d2a5216..bc45ea1efbf7 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -15,6 +15,14 @@ extern int __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 				      unsigned long vm_flags);
+#ifdef CONFIG_SHMEM
+extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long ad=
dr);
+#else
+static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
+					   unsigned long addr)
+{
+}
+#endif
=20
 #define khugepaged_enabled()					       \
 	(transparent_hugepage_flags &				       \
@@ -73,6 +81,10 @@ static inline int khugepaged_enter_vma_merge(struct vm_a=
rea_struct *vma,
 {
 	return 0;
 }
+static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
+					   unsigned long addr)
+{
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
=20
 #endif /* _LINUX_KHUGEPAGED_H */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 40c25ddf29e4..3e722065e909 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -77,6 +77,8 @@ static __read_mostly DEFINE_HASHTABLE(mm_slots_hash, MM_S=
LOTS_HASH_BITS);
=20
 static struct kmem_cache *mm_slot_cache __read_mostly;
=20
+#define MAX_PTE_MAPPED_THP 8
+
 /**
  * struct mm_slot - hash lookup from mm to mm_slot
  * @hash: hash collision list
@@ -87,6 +89,10 @@ struct mm_slot {
 	struct hlist_node hash;
 	struct list_head mm_node;
 	struct mm_struct *mm;
+
+	/* pte-mapped THP in this mm */
+	int nr_pte_mapped_thp;
+	unsigned long pte_mapped_thp[MAX_PTE_MAPPED_THP];
 };
=20
 /**
@@ -1254,6 +1260,145 @@ static void collect_mm_slot(struct mm_slot *mm_slot=
)
 }
=20
 #if defined(CONFIG_SHMEM) && defined(CONFIG_TRANSPARENT_HUGE_PAGECACHE)
+/*
+ * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
+ * khugepaged should try to collapse the page table.
+ */
+static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
+					 unsigned long addr)
+{
+	struct mm_slot *mm_slot;
+
+	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
+
+	spin_lock(&khugepaged_mm_lock);
+	mm_slot =3D get_mm_slot(mm);
+	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
+		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] =3D addr;
+	spin_unlock(&khugepaged_mm_lock);
+	return 0;
+}
+
+/**
+ * Try to collapse a pte-mapped THP for mm at address haddr.
+ *
+ * This function checks whether all the PTEs in the PMD are pointing to th=
e
+ * right THP. If so, retract the page table so the THP can refault in with
+ * as pmd-mapped.
+ */
+void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
+{
+	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
+	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct page *hpage =3D NULL;
+	pmd_t *pmd, _pmd;
+	spinlock_t *ptl;
+	int count =3D 0;
+	int i;
+
+	if (!vma || !vma->vm_file ||
+	    vma->vm_start > haddr || vma->vm_end < haddr + HPAGE_PMD_SIZE)
+		return;
+
+	/*
+	 * This vm_flags may not have VM_HUGEPAGE if the page was not
+	 * collapsed by this mm. But we can still collapse if the page is
+	 * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
+	 * will not fail the vma for missing VM_HUGEPAGE
+	 */
+	if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
+		return;
+
+	pmd =3D mm_find_pmd(mm, haddr);
+	if (!pmd)
+		return;
+
+	/* step 1: check all mapped PTEs are to the right huge page */
+	for (i =3D 0, addr =3D haddr; i < HPAGE_PMD_NR; i++, addr +=3D PAGE_SIZE)=
 {
+		pte_t *pte =3D pte_offset_map(pmd, addr);
+		struct page *page;
+
+		if (pte_none(*pte) || !pte_present(*pte))
+			continue;
+
+		page =3D vm_normal_page(vma, addr, *pte);
+
+		if (!page || !PageCompound(page))
+			return;
+
+		if (!hpage) {
+			hpage =3D compound_head(page);
+			/*
+			 * The mapping of the THP should not change.
+			 *
+			 * Note that uprobe may change the page table, but
+			 * the new page installed by uprobe will not pass
+			 * PageCompound() check.
+			 */
+			if (VM_WARN_ON(hpage->mapping !=3D vma->vm_file->f_mapping))
+				return;
+		}
+
+		/*
+		 * Confirm the page maps to the correct subpage.
+		 *
+		 * Note that uprobe may change the page table, but the new
+		 * page installed by uprobe will not pass PageCompound()
+		 * check.
+		 */
+		if (VM_WARN_ON(hpage + i !=3D page))
+			return;
+		count++;
+	}
+
+	/* step 2: adjust rmap */
+	for (i =3D 0, addr =3D haddr; i < HPAGE_PMD_NR; i++, addr +=3D PAGE_SIZE)=
 {
+		pte_t *pte =3D pte_offset_map(pmd, addr);
+		struct page *page;
+
+		if (pte_none(*pte))
+			continue;
+		page =3D vm_normal_page(vma, addr, *pte);
+		page_remove_rmap(page, false);
+	}
+
+	/* step 3: set proper refcount and mm_counters. */
+	if (hpage) {
+		page_ref_sub(hpage, count);
+		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
+	}
+
+	/* step 4: collapse pmd */
+	ptl =3D pmd_lock(vma->vm_mm, pmd);
+	_pmd =3D pmdp_collapse_flush(vma, addr, pmd);
+	spin_unlock(ptl);
+	mm_dec_nr_ptes(mm);
+	pte_free(mm, pmd_pgtable(_pmd));
+}
+
+static int khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
+{
+	struct mm_struct *mm =3D mm_slot->mm;
+	int i;
+
+	if (likely(mm_slot->nr_pte_mapped_thp =3D=3D 0))
+		return 0;
+
+	if (!down_write_trylock(&mm->mmap_sem))
+		return -EBUSY;
+
+	if (unlikely(khugepaged_test_exit(mm)))
+		goto out;
+
+	for (i =3D 0; i < mm_slot->nr_pte_mapped_thp; i++)
+		collapse_pte_mapped_thp(mm, mm_slot->pte_mapped_thp[i]);
+
+out:
+	mm_slot->nr_pte_mapped_thp =3D 0;
+	up_write(&mm->mmap_sem);
+	return 0;
+}
+
 static void retract_page_tables(struct address_space *mapping, pgoff_t pgo=
ff)
 {
 	struct vm_area_struct *vma;
@@ -1287,7 +1432,8 @@ static void retract_page_tables(struct address_space =
*mapping, pgoff_t pgoff)
 			up_write(&vma->vm_mm->mmap_sem);
 			mm_dec_nr_ptes(vma->vm_mm);
 			pte_free(vma->vm_mm, pmd_pgtable(_pmd));
-		}
+		} else
+			khugepaged_add_pte_mapped_thp(vma->vm_mm, addr);
 	}
 	i_mmap_unlock_write(mapping);
 }
@@ -1709,6 +1855,11 @@ static void khugepaged_scan_file(struct mm_struct *m=
m,
 {
 	BUILD_BUG();
 }
+
+static int khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
+{
+	return 0;
+}
 #endif
=20
 static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
@@ -1733,6 +1884,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned =
int pages,
 		khugepaged_scan.mm_slot =3D mm_slot;
 	}
 	spin_unlock(&khugepaged_mm_lock);
+	khugepaged_collapse_pte_mapped_thps(mm_slot);
=20
 	mm =3D mm_slot->mm;
 	/*
--=20
2.17.1




