Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC329867C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404256AbfHHRQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 13:16:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64366 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404241AbfHHRQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:16:26 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78H2bIO022520;
        Thu, 8 Aug 2019 10:16:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=npjuTu9EeYs/V1MnUYjt03JIoqevCKhTl75ZI42hdyM=;
 b=duOv6OwGLj8GDqMqMrzftuHzz6ZIM/JL7pC0tSVeDXfwBvG2rXhM1n3/V1+9ipRlNZ8H
 j4uDqcQrP5WOX0pAHrnF0O6twVDtSg6KhYztG1yOB/K7uiMyOxCyr+t+nIGihNd3fg4J
 qUGZELfRVuNeFrXZel1HnhPJRGPwzXykWEk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u8qpk832v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 10:16:17 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 8 Aug 2019 10:16:10 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 8 Aug 2019 10:16:09 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Aug 2019 10:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLMBrqgnvxT5C/KAqXrQ9nYZ6dRxV+jYTp+5OO1F/QAeVrnvnyCoqGNd++lmYY+QJtawb7IGjuNZGirbRLTrwYCmwtKScsiL6kjweeBCZJhmeVdNFW/jPDXCz3J3EKXfG2hg6BSHj4lwlSK/YuHnhBhIEHQ2s5ZOqX3HL0TjeplV8NWBj6ckTaauHFWfHwUfLbqP5ywcrlP4tOGPunXIDEYpmk6i5ZMCW0fvi6PE23XJPHDjRc7N6z2Oy/uH+OimC5sSYxQMvDFv5krgFjFYGQDCn5epc6bkW9rQ7VxcjoC0PGQW8ZMyE14RzY3EU8lhnSTiPVJc126Q8wkAZVIukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npjuTu9EeYs/V1MnUYjt03JIoqevCKhTl75ZI42hdyM=;
 b=heO/DrF6CFzZ+uTYuuAi8wVZYcjkTFsqajp3sNSZd4qJy0qnXbq2YYeaV5S528oZPPvDUknyJS71r16UKjilfayEazRe0xIZPMsjLZKDmj3iuLg0h1wpmKFlFdf8aSPcFyFf1LUN+JRV8IKCzwCIo3abXwlP7GmYIEdX5Ft/3eH31Ix3DUmx1fkrzc6rGSbrgtnB3Eb5Yh8fgohV5NyFV22iIXCcS0pQM1EUoDh8saaUKeehKemBChhePFX2WWu8U65ttKpDgUf2cuOeDruZQbn1ePQ1OY7SVCU1NjSG/S5p9uT1pLO/VIEErcTolqOmbTh5Cp7ceLok0yNEgFMaJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npjuTu9EeYs/V1MnUYjt03JIoqevCKhTl75ZI42hdyM=;
 b=cMrhUWOxeo4Esr1M4hcV5fiHCAVkstDAAhZtci/ayPcN0BfCrvmz8qYrqBI0w/xDrONyXjY9y+SYL8aiXe5xJMJTu+JwA+QPSCHu/wNIX36pAfUSg3ZOmxyczkxZNRRYCY+8JSCKi0sC6JGchfrfkthJy6t8/bFJF5GFTQgnD28=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1376.namprd15.prod.outlook.com (10.173.232.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Thu, 8 Aug 2019 17:16:08 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d%9]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 17:16:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 3/6] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Topic: [PATCH v12 3/6] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Index: AQHVTXk1mNBIE/jl/kWGntKwDXuhGKbxdEOAgAAKuIA=
Date:   Thu, 8 Aug 2019 17:16:08 +0000
Message-ID: <48316E06-10B2-439C-AD10-3EC8C86C259C@fb.com>
References: <20190807233729.3899352-1-songliubraving@fb.com>
 <20190807233729.3899352-4-songliubraving@fb.com>
 <20190808163745.GC7934@redhat.com>
In-Reply-To: <20190808163745.GC7934@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3099]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5e3fcc2-70df-48ea-c555-08d71c241a5c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1376;
x-ms-traffictypediagnostic: MWHPR15MB1376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1376D097BE38B182B26A9A89B3D70@MWHPR15MB1376.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(4326008)(6116002)(86362001)(478600001)(8936002)(57306001)(50226002)(256004)(71200400001)(71190400001)(99286004)(6512007)(14454004)(316002)(25786009)(6436002)(6486002)(33656002)(7736002)(6506007)(53546011)(102836004)(76176011)(8676002)(6246003)(2906002)(305945005)(53936002)(229853002)(54906003)(64756008)(66476007)(5660300002)(76116006)(66446008)(66556008)(36756003)(446003)(6916009)(486006)(81166006)(66946007)(11346002)(2616005)(476003)(81156014)(186003)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1376;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: raRe+bqwaambHJJS8rh+ihbSu1RzF5qckBqGDlaEXmVqeUc9OTbMj2e/t4AMBUDLeJpSKoErAvZA+z5rt7WlAQ+Qqr91yAL/7dXKW2bkWdNOhMUKrijEST2TqvF+UKRKxXR12P7vPrMTAPvzG+iYiM5B9zF2uU6siVCnqiukRn/JTrDBz5LnvMvCpRYXMQnJJrpWzpHKDbUy3sxi7L5VonPBE6CqU1p68yzW9PR8h/4CW6xDAbbbrbAbAW0wFRa156J0CA/QLdFftMLH+iZWcY3Gs7DElPX/u9HDDAcSU6LHqIxt4GkiYuDz9hCnk5Y+yb0fM6T8+if08ng8lSHoN02K78nJVqFjcxNsRoMy1004C78gZ6x2c3m7z0mh/UejnoRIlEIMPT8iRzUkvdT75zU12aiaaaSz+G9MRp+0gSM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FEE4CC21C3D5284787AF110DEEDE7D12@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e3fcc2-70df-48ea-c555-08d71c241a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 17:16:08.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQWtUvIXPiJDMJozyL77Mq5vJnG5XrjzgXg3gCovQfXmBHlSOLFdEjEiqAzEh9bawOsCYL6/StzGD7hyXco5rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1376
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=959 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080154
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 8, 2019, at 9:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 08/07, Song Liu wrote:
>>=20
>> @@ -399,7 +399,7 @@ static struct page *follow_pmd_mask(struct vm_area_s=
truct *vma,
>> 		spin_unlock(ptl);
>> 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
>> 	}
>> -	if (flags & FOLL_SPLIT) {
>> +	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
>> 		int ret;
>> 		page =3D pmd_page(*pmd);
>> 		if (is_huge_zero_page(page)) {
>> @@ -408,7 +408,7 @@ static struct page *follow_pmd_mask(struct vm_area_s=
truct *vma,
>> 			split_huge_pmd(vma, pmd, address);
>> 			if (pmd_trans_unstable(pmd))
>> 				ret =3D -EBUSY;
>> -		} else {
>> +		} else if (flags & FOLL_SPLIT) {
>> 			if (unlikely(!try_get_page(page))) {
>> 				spin_unlock(ptl);
>> 				return ERR_PTR(-ENOMEM);
>> @@ -420,6 +420,10 @@ static struct page *follow_pmd_mask(struct vm_area_=
struct *vma,
>> 			put_page(page);
>> 			if (pmd_none(*pmd))
>> 				return no_page_table(vma, flags);
>> +		} else {  /* flags & FOLL_SPLIT_PMD */
>> +			spin_unlock(ptl);
>> +			split_huge_pmd(vma, pmd, address);
>> +			ret =3D pte_alloc(mm, pmd) ? -ENOMEM : 0;
>> 		}
>=20
> Can't resist, let me repeat that I do not like this patch because imo
> it complicates this code for no reason.

Personally, I don't think this is more complicated than your version.=20
This patch is safe as it doesn't change any code for is_huge_zero_page()=20
case.=20

Also, if some code calls follow_pmd_mask() with flags contains both=20
FOLL_SPLIT and FOLL_SPLIT_PMD, we should honor FOLL_SPLIT and split the
huge page. Of course, there is no code that sets both flags.

Does this resolve your concern here?

Thanks,
Song

