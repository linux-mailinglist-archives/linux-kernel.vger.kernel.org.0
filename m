Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56EED9511A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 00:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfHSWrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 18:47:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14436 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728014AbfHSWrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:47:03 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JMj3ML028043;
        Mon, 19 Aug 2019 15:46:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=6fiAQadW6iDdHRiZoEhTIH3EdiQD+7TZnR9CQbwr32E=;
 b=RZy534ZOMpdImy47HNa/aBlzGZRqaijdS+T1cgat/rCz2X7pPOtQGe6dw1adu6pzbOgM
 2Cd/Y6x7W8DoBqfyRcNJhZlH4NByTSfercIw26bE5jbnwIzyYzyHhZupRSIyxWK+b6mt
 KC+qs8vTP0PWVW3tVBpOm8c6Yiuw78QO5b0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ug1vv8u05-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Aug 2019 15:46:57 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 19 Aug 2019 15:46:51 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 19 Aug 2019 15:46:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4g45B8uvOTBX4IXQZDhAM/Fn6yYNrGLaAvqJJhbzQ4gruHtumMMzKQbnraVSGE0c6XDcRLA8pkN4NyYJd7JVhDezxiYGoQ9nwaQG2NcQU9glQAts7l2dmjlGd+c29Gr4/wp0v/mMIf68SukgNR/S7XUWRLTxWi5IuNxe6qg5DcZnxMFGSGf5yVJ3pF3zJnJZGWCXPxa4DhZgzraM1qAuptfdyeEP1T7QKeMa6HdR+klmbGhfsXqReujFmGR3rTF8F2iOZgoxeujg7Qz4W1GwUn+H4GaoM0YeCmtYlC4kJMf5ru7kC/qet/fIM79pBmKdo1XllCG6++VWkrfSitecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fiAQadW6iDdHRiZoEhTIH3EdiQD+7TZnR9CQbwr32E=;
 b=elSyI7bAYUXPlBjE6qcfZkShL7uhn0z+L00N3F1hzHF9TMkhfiUtHLiM2uXvIhKjcQDzAU3s1eQr3mmfppZraGnou7edaqZB5FTXF+88n0FHgINrT9gOjQzpNCyE4USn3v7r3tUMp38COHdo6pXZewbZ2ZqkdVZ6Z3HZq3SzL2x0sU/tVwaQL4dLEGz6yJXIPhqbQHa9vRzY8q+zQ5zsC8E6ktK57RdNeNFH9GwePFaRSScmxPEjCGMMJUeob1wILrzAMInpRykJO4ab5aPPC2CpKRHlvuUAAwxXQgZDuTP8D5kyM1cg0XzLnyjyN2AoliZz6gjLQvRHeS4cFHX7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fiAQadW6iDdHRiZoEhTIH3EdiQD+7TZnR9CQbwr32E=;
 b=YSH/9ArX4rJOLbsWNtiXTXVSQY5wnxWhha+D1+fah4UZ3uhCcf4kzsDxwYnY/XHa4l2zd5lVkG6y9NsAxfpg7Ao2U/bIna1Yps/blQuJ48j33/D/YaDZFf8b7fvr8HR+QcMNABE7+7+qP1XaKV0bZtwD3IOsdKB73/CiDU/759A=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3529.namprd15.prod.outlook.com (10.141.164.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 22:46:50 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::d1fc:b5c5:59a1:bd7e]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::d1fc:b5c5:59a1:bd7e%3]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 22:46:50 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v2 2/3] mm: memcontrol: flush percpu slab vmstats on kmem
 offlining
Thread-Topic: [PATCH v2 2/3] mm: memcontrol: flush percpu slab vmstats on kmem
 offlining
Thread-Index: AQHVVswYi9tJ73uK1EOdJ5Db7XgkjKcDDQsAgAAFUIA=
Date:   Mon, 19 Aug 2019 22:46:50 +0000
Message-ID: <20190819224645.GA9473@tower.dhcp.thefacebook.com>
References: <20190819202338.363363-1-guro@fb.com>
 <20190819202338.363363-3-guro@fb.com>
 <20190819152744.4ab8478cfb8697856408425b@linux-foundation.org>
In-Reply-To: <20190819152744.4ab8478cfb8697856408425b@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0060.namprd14.prod.outlook.com
 (2603:10b6:300:81::22) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:4a49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2cc57a6-2520-4323-da96-08d724f71f6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR15MB3529;
x-ms-traffictypediagnostic: DM6PR15MB3529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR15MB352931300FC1444316F2C9FEBEA80@DM6PR15MB3529.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(1076003)(8676002)(102836004)(53936002)(305945005)(66476007)(64756008)(229853002)(6116002)(386003)(7736002)(66446008)(6506007)(66556008)(71190400001)(71200400001)(66946007)(256004)(11346002)(5660300002)(446003)(6916009)(81156014)(81166006)(486006)(86362001)(6436002)(6486002)(99286004)(4326008)(2906002)(52116002)(54906003)(476003)(8936002)(76176011)(6246003)(316002)(25786009)(186003)(6512007)(9686003)(46003)(33656002)(478600001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3529;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +QqJ7g8ufwl8PKAf13qulPMwVuPHi3mx/VJqJpDeQ8TOuG8Ld/bfxPaJUIpiWtIJ0j7iY9xL8Zg857VQwHUIrS/8AcdwdRh0CaSSzaVqDvMR/7CpP0cUwPllTiry5XKkNqXQODhwz5HCSAikbPNZO8LC7zo3obrOY4BoXhIX4X+OYBSK66516sRbJjvT/MeSrUwU4GgK6IBT7/FmKIG/rPJiIOtI547rHAy1G5bgySDz+urEW619psi5Y7kC8VThMZQ6xzMhrWzRs/Wn2AsoGJeoStPh3WBeFyT6PeLBCZXjKo+uqBj8QnwhEFEbj2wFuMoukvYgwYmvTJp50mN28zZL+xG6RRnlVWmsmiabAbkrBod/v36ORCcCc73VAB7nKyT7CNRcQAaTj3gmwNu9CfrZV1RoasHEsguSmzBcuto=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5100D4FBDDC1884F9DF504E70C7535F7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cc57a6-2520-4323-da96-08d724f71f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 22:46:50.0644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlbQ65gAUrBAiwo+wMjJVTMJaNcoLASkvIm1VDIgZBn6hkfdLybyipJvLoxdYQLf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3529
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=665 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190226
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 03:27:44PM -0700, Andrew Morton wrote:
> On Mon, 19 Aug 2019 13:23:37 -0700 Roman Gushchin <guro@fb.com> wrote:
>=20
> > I've noticed that the "slab" value in memory.stat is sometimes 0,
> > even if some children memory cgroups have a non-zero "slab" value.
> > The following investigation showed that this is the result
> > of the kmem_cache reparenting in combination with the per-cpu
> > batching of slab vmstats.
> >=20
> > At the offlining some vmstat value may leave in the percpu cache,
> > not being propagated upwards by the cgroup hierarchy. It means
> > that stats on ancestor levels are lower than actual. Later when
> > slab pages are released, the precise number of pages is substracted
> > on the parent level, making the value negative. We don't show negative
> > values, 0 is printed instead.
> >=20
> > To fix this issue, let's flush percpu slab memcg and lruvec stats
> > on memcg offlining. This guarantees that numbers on all ancestor
> > levels are accurate and match the actual number of outstanding
> > slab pages.
> >=20
> > Fixes: fb2f2b0adb98 ("mm: memcg/slab: reparent memcg kmem_caches on cgr=
oup removal")
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>=20
> [1/3] and [3/3] have cc:stable.  [2/3] does not.  However [3/3] does
> not correctly apply without [2/3] having being applied.

Right, [2/3] is required by slab kmem reparenting, which appeared in 5.3.

I can rearrange [2/3] and [3/3] so that first two patches will have
cc table and apply correctly. Let me do this, I'll send v3 shortly.

Thanks!
