Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0C924EE6E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFUSFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 14:05:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfFUSFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:05:51 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LHuuR2018220;
        Fri, 21 Jun 2019 11:04:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=FWemofaf8uSqGQ2e+Mw9eso7l4EUE0Vc74xetOz5aHs=;
 b=kbZ+w2JvkzV36Fw8YO3Pu+QaA5hFXBndWuiFwrd0c4BZC+EZm02yu9m2ReSfzLY6A4Yt
 MBfn3gpPabgLEpm1ivN+QwpJhWIx5DuWWDUQzMwylozggxMRrIV1RCRB7VwDMu69OTRg
 l7557N36qyJ4BRLv6xaOLE5SXXLG9ttcYQY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t91rg0m29-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 11:04:53 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 21 Jun 2019 11:04:16 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 21 Jun 2019 11:04:16 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 21 Jun 2019 11:04:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWemofaf8uSqGQ2e+Mw9eso7l4EUE0Vc74xetOz5aHs=;
 b=jCPiOhSgvDmHGZaJgNueqNA+M/CgA24X0k9TD+QxRmDrDvTX4gna8CO61zgkF5cF5SZF+BuEyFWOFQ58nRIJXM8kgeA0yB0TMOb7dd5qZZQWtOKcO4ldi0+HD3HGTKSs+T5zWE7ut1oo00Yh7hc1pOoiJh9QYgdcv+EYbEtk1Io=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1166.namprd15.prod.outlook.com (10.175.9.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 21 Jun 2019 18:04:14 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Fri, 21 Jun 2019
 18:04:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH v4 5/5] uprobe: collapse THP pmd after removing all
 uprobes
Thread-Topic: [PATCH v4 5/5] uprobe: collapse THP pmd after removing all
 uprobes
Thread-Index: AQHVIhGkBNxZAI1nUkK1d2OfbYvmTqamGxWAgAAIBYCAAAVYgIAAAncAgAAuG4CAABpPgA==
Date:   Fri, 21 Jun 2019 18:04:14 +0000
Message-ID: <DB6689FE-8528-4883-8CD9-CFE5F3BEC321@fb.com>
References: <20190613175747.1964753-1-songliubraving@fb.com>
 <20190613175747.1964753-6-songliubraving@fb.com>
 <20190621124823.ziyyx3aagnkobs2n@box>
 <B72B62C9-78EE-4440-86CA-590D3977BDB1@fb.com>
 <20190621133613.xnzpdlicqvjklrze@box>
 <4B58B3B3-10CB-4593-8BEC-1CEF41F856A1@fb.com>
 <707D52CA-E782-4C9A-AC66-75938C8E3358@fb.com>
In-Reply-To: <707D52CA-E782-4C9A-AC66-75938C8E3358@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:e314]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5634722e-60f0-496e-6d30-08d6f672dedc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1166;
x-ms-traffictypediagnostic: MWHPR15MB1166:
x-microsoft-antispam-prvs: <MWHPR15MB1166D4074EF180B7FF2FBFFBB3E70@MWHPR15MB1166.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(39860400002)(396003)(346002)(199004)(189003)(7736002)(81166006)(6246003)(305945005)(6512007)(478600001)(71190400001)(53936002)(66946007)(71200400001)(36756003)(73956011)(6486002)(6916009)(25786009)(76116006)(91956017)(66446008)(64756008)(66556008)(66476007)(8676002)(50226002)(5660300002)(81156014)(4326008)(2616005)(102836004)(446003)(11346002)(57306001)(68736007)(316002)(2906002)(6436002)(46003)(53546011)(6506007)(229853002)(6116002)(14454004)(76176011)(86362001)(256004)(186003)(8936002)(54906003)(476003)(486006)(33656002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1166;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A2JOUaphmh+bz2MODVm8MOyn63tJW/k2hAJ2zw+OMw8IXPP7mByBG/ORALLvthGJIYmYCuQAZ/M/G1Wm9t27iaAjTGIDEprDMusmqNO7wRqaS3w8IT6+fvAnu7mi9xa1iU2gup26B9xOy9GolvTF7TNYPv/3uzuuIX02yYRTJjmxg21koHgm6N3oOHJmYeAyL3B01p9Kn+8Zne/DqzpYWAmBi8GDDoDRgfJdOpmwerUKcogMZpgS7QPzVYDdCRYAYRdyigijfS4bfN3XIh4rzL3mKf+0duirDemNLEHJTKeqxgps7tsNWvj8AakvgrbEPjbV412WZOIBCUZiB27QlJZiRnhIR7uze5Np7DCNfADzoPV7XPf/nULgJETZJpnzu3jdg/ehyrOzHYvJwdZyYGyJfkNlwuC6cbFRc7ysXdU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <446372C009AAB14B9BC46B7E5721E607@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5634722e-60f0-496e-6d30-08d6f672dedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 18:04:14.3264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=877 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210139
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 21, 2019, at 9:30 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Jun 21, 2019, at 6:45 AM, Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Jun 21, 2019, at 6:36 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>>>=20
>>> On Fri, Jun 21, 2019 at 01:17:05PM +0000, Song Liu wrote:
>>>>=20
>>>>=20
>>>>> On Jun 21, 2019, at 5:48 AM, Kirill A. Shutemov <kirill@shutemov.name=
> wrote:
>>>>>=20
>>>>> On Thu, Jun 13, 2019 at 10:57:47AM -0700, Song Liu wrote:
>>>>>> After all uprobes are removed from the huge page (with PTE pgtable),=
 it
>>>>>> is possible to collapse the pmd and benefit from THP again. This pat=
ch
>>>>>> does the collapse.
>>>>>>=20
>>>>>> An issue on earlier version was discovered by kbuild test robot.
>>>>>>=20
>>>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>>>>> ---
>>>>>> include/linux/huge_mm.h |  7 +++++
>>>>>> kernel/events/uprobes.c |  5 ++-
>>>>>> mm/huge_memory.c        | 69 +++++++++++++++++++++++++++++++++++++++=
++
>>>>>=20
>>>>> I still sync it's duplication of khugepaged functinallity. We need to=
 fix
>>>>> khugepaged to handle SCAN_PAGE_COMPOUND and probably refactor the cod=
e to
>>>>> be able to call for collapse of particular range if we have all locks
>>>>> taken (as we do in uprobe case).
>>>>>=20
>>>>=20
>>>> I see the point now. I misunderstood it for a while.=20
>>>>=20
>>>> If we add this to khugepaged, it will have some conflicts with my othe=
r=20
>>>> patchset. How about we move the functionality to khugepaged after thes=
e
>>>> two sets get in?=20
>>>=20
>>> Is the last patch of the patchset essential? I think this part can be d=
one
>>> a bit later in a proper way, no?
>>=20
>> Technically, we need this patch to regroup pmd mapped page, and thus get=
=20
>> the performance benefit after the uprobe is detached.=20
>>=20
>> On the other hand, if we get the first 4 patches of the this set and the=
=20
>> other set in soonish. I will work on improving this patch right after th=
at..
>=20
> Actually, it might be pretty easy. We can just call try_collapse_huge_pmd=
()=20
> in khugepaged.c (in khugepaged_scan_shmem() or khugepaged_scan_file() aft=
er=20
> my other set).=20
>=20
> Let me fold that in and send v5.=20

On a second thought, if we would have khugepaged to do collapse, we need a
dedicated bit to tell khugepaged which pmd to collapse. Otherwise, it may=20
accidentally collapse pmd that are split by other split_huge_pmd.=20

I could not think of a good solution here. In this case, we really need a
flag for this specific pmd. Flags for the compound_page or for the vma=20
would not work, as those could be shared by multiple pmds.=20

If the analysis above is correct, we probably need uprobe to specifically
call try_collapse_huge_pmd() for now.

Please share your suggestions.=20

Thanks!
Song







