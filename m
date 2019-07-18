Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7B6D280
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfGRRFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 13:05:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10374 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726649AbfGRRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:05:19 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IGwu4J012906;
        Thu, 18 Jul 2019 10:05:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=QojuxV2jTJXF80TcjA6Wa8saY53a7gMAKLPJsicXWR4=;
 b=dU5C6bmioayx34WQLchBEaQmfTdkx4m/PhmMUlHVwZCLbPxAg4JHb8DVSP29ZpnFkxMT
 51+MCqZth0cDrrIO9VnXX9E3995PmM9WoCX562X0SufoZ4XhlmZ96kL8wwK7Ypp/TewB
 qSIBSMfj6dE0JmIEkRklV7sAxYTIkAgVbR0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ttvqxg1ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jul 2019 10:05:07 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 18 Jul 2019 10:05:06 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Jul 2019 10:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMlNi8RcGzz6mmDpKFXrMzeEEcm3Ewjy8wiLovIPFoL5uMX2bisWLrxewvOj/vA8UitzVFM5QHEmwB7K7wHGdE/8HD7WP4inks3465VwwbQ1lI2flIYP+MnDS+xTrlBdUJuOWJY7GrT1SEy1UnAPVrCrFRxbsN5yi00kxb+6aq1WYsPwftFawiNMpdkOnqF05SMKyZmkicZW0VTMrq4dYnWm5h7bj+54Rxz5pjo9bYd0p2XaOE9hu68yitNgKdVttqd3MgjWqzlogi4hbAIWBQyfVaov+qO886BExp8E7hysRfKRg60Ke0Ne8/HbHMu5SDusNAEXj2XEffby8+legw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QojuxV2jTJXF80TcjA6Wa8saY53a7gMAKLPJsicXWR4=;
 b=ZUwOgw9K+79xfkYy5XXxmziUUv8v31aThYvOqaZz7eH/6ScD0IID6nVtofyg59h75QJhneK9HTKNZoOddjRuiG+Mc8jgujn1FyLJ7MgbQqyCRxhrT4mAluy4OSQ6bEesu4JJplb0pp61i09/EWR8yq9iZ3tZYICDO8GVfKZUtiw51i0Dt91BFF4DEhP+pxBhVIBlLKmJVEsm3seFzOOObfnNhYhbiErlIzkGUZYEXp+PTRLgPysGacYkzupiX8mIM9zE4dOnRpJZbLHIXf59/TK4/+xjCThk8bE0Ev11ks4mba657GKz26P7SrkNmyINvMI2x8cfv8zYo3ZoVNpuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QojuxV2jTJXF80TcjA6Wa8saY53a7gMAKLPJsicXWR4=;
 b=uHsjF9GsVErIv1RFrd4zzUd8RNma7MZSvASTr0gz/JnlixvuLJRL42H/fjeCytYEULIvt97mhE2X0MyG7MsSV1pyWeo7l1t4neegM20OG4pxjJvLSQKsrjiFPnTSFC+PjAqcHmsnRleJ5C6BNirxr6HlTLK08yDD+X19xitBCLo=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3212.namprd15.prod.outlook.com (20.179.48.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 17:05:05 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053%3]) with mapi id 15.20.2094.011; Thu, 18 Jul 2019
 17:05:05 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Waiman Long <longman@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Vladimir Davydov" <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] mm, slab: Extend slab/shrink to shrink all memcg
 caches
Thread-Topic: [PATCH v2 1/2] mm, slab: Extend slab/shrink to shrink all memcg
 caches
Thread-Index: AQHVPN3TlomcCJJgFEONei6lr3vfPKbQQNKAgABbTQA=
Date:   Thu, 18 Jul 2019 17:05:04 +0000
Message-ID: <20190718170458.GA6139@castle.dhcp.thefacebook.com>
References: <20190717202413.13237-1-longman@redhat.com>
 <20190717202413.13237-2-longman@redhat.com>
 <0100016c04e0192f-299df02d-a35f-46db-9833-37ba7a01f5f0-000000@email.amazonses.com>
In-Reply-To: <0100016c04e0192f-299df02d-a35f-46db-9833-37ba7a01f5f0-000000@email.amazonses.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:300:ad::29) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:500::f13c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05be2f81-de36-44b7-4bba-08d70ba21433
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR15MB3212;
x-ms-traffictypediagnostic: DM6PR15MB3212:
x-microsoft-antispam-prvs: <DM6PR15MB3212CC7F86C6E222DC26C67ABEC80@DM6PR15MB3212.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(376002)(136003)(366004)(199004)(189003)(7416002)(256004)(66476007)(6436002)(316002)(386003)(66946007)(54906003)(486006)(8936002)(6486002)(4326008)(6506007)(14454004)(2906002)(66556008)(64756008)(1076003)(33656002)(6512007)(9686003)(66446008)(86362001)(52116002)(46003)(102836004)(478600001)(53936002)(6916009)(5660300002)(446003)(6246003)(11346002)(76176011)(25786009)(229853002)(186003)(6116002)(476003)(81166006)(71190400001)(99286004)(68736007)(81156014)(7736002)(71200400001)(8676002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3212;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UttzXwjYz37a6xJhARcdDdxfMzY4N4l1ZkfZSMesNi8hLKGwauWy+tYiZS3Fd4o8bv/TsGhPecEXj6K6Mx1cO/asgEvI/Q0G9pUzCGc7Qn6nP8qr1sXys3FiV+XhGFDU+pj2Eukd4fJKpuMuEOZfu2/laAxQvThl2+6VG35RyFdsq6bjjwAyqk/y3W7xZA+Cec2utpY5Apq0U+viC+1WswFlwrOzDRmDVHbhyEJp4d08Ak/0JdA484lMpADsM/HXutXaWzuyWRmXoTWogPcmoON845pEZY5qxgvZ8NM8fQwCdoCxKgg0nV0xdr9wzmlvNUiH+FmYDpdh56cJ0TARFUvLoOrAIsZPx9Wgjlznc4dscFyuFOUF7hdAVvVJz4FFARgUHs5golbHfblvoNYEL3/u1FwLY79KV+GJ9jQGGYw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF12C64E016D9B4989D6104F9506902D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 05be2f81-de36-44b7-4bba-08d70ba21433
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:05:05.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3212
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=868 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180179
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 11:38:11AM +0000, Christopher Lameter wrote:
> On Wed, 17 Jul 2019, Waiman Long wrote:
>=20
> > Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
> > file to shrink the slab by flushing out all the per-cpu slabs and free
> > slabs in partial lists. This can be useful to squeeze out a bit more me=
mory
> > under extreme condition as well as making the active object counts in
> > /proc/slabinfo more accurate.
>=20
> Acked-by: Christoph Lameter <cl@linux.com>
>=20
> >  # grep task_struct /proc/slabinfo
> >  task_struct        53137  53192   4288   61    4 : tunables    0    0
> >  0 : slabdata    872    872      0
> >  # grep "^S[lRU]" /proc/meminfo
> >  Slab:            3936832 kB
> >  SReclaimable:     399104 kB
> >  SUnreclaim:      3537728 kB
> >
> > After shrinking slabs:
> >
> >  # grep "^S[lRU]" /proc/meminfo
> >  Slab:            1356288 kB
> >  SReclaimable:     263296 kB
> >  SUnreclaim:      1092992 kB
>=20
> Well another indicator that it may not be a good decision to replicate th=
e
> whole set of slabs for each memcg. Migrate the memcg ownership into the
> objects may allow the use of the same slab cache. In particular together
> with the slab migration patches this may be a viable way to reduce memory
> consumption.
>=20

Btw I'm working on an alternative solution. It's way too early to present
anything, but preliminary results are looking promising: slab memory usage
is decreased by 10-40% depending on the workload.

Thanks!
