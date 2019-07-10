Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8169263EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 03:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfGJBbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 21:31:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4882 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbfGJBbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:31:15 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x6A1R57V014613;
        Tue, 9 Jul 2019 18:31:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Yo+nMAgCISsh/6qPmf+HArUmccudeopyRCbaYu4G0a8=;
 b=DbrMHflP0n8NqEnbGKHZDaGlcV9ACq183IeOhOJGo1uGVd4yjs3gAciCON2xlT2rFuyA
 hY3IBKb6rC3ip5QVheeD5ifNJyGx8oHOBDnSUnQNU/G5UeRSmePsGRaOVT8+xNmZ/Lgo
 tdPzyi2VzCctTfQJVIGjD7V0L0nm8nm27rs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2tmxrb1kmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 18:31:09 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Jul 2019 18:31:07 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 9 Jul 2019 18:31:07 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 9 Jul 2019 18:31:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yo+nMAgCISsh/6qPmf+HArUmccudeopyRCbaYu4G0a8=;
 b=LBh7tE+zX4EqhzR9StgMDTu9O8jHN6X5SEDLD5AjwnKc7qxEZF2UyBvUOCgzGXY61D+IdKCAJyML93PSnEPiSGvLX1TMb+9s4Koa8B8ijSQskpepf9fU/My3n98hzhNP3wkiJvO9vkjgZzYl3rV/OJ25+/ITPEu5A6+VrFCkaRA=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3050.namprd15.prod.outlook.com (20.179.16.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Wed, 10 Jul 2019 01:31:05 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053%3]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 01:31:05 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RESEND] mm: show number of vmalloc pages in /proc/meminfo
Thread-Topic: [PATCH RESEND] mm: show number of vmalloc pages in /proc/meminfo
Thread-Index: AQHVNhuLGO3yqyJ4/UmBmYR/KZa3WabDEgsA
Date:   Wed, 10 Jul 2019 01:31:05 +0000
Message-ID: <20190710013100.GA21604@tower.DHCP.thefacebook.com>
References: <20190514235111.2817276-1-guro@fb.com>
 <20190514235111.2817276-2-guro@fb.com>
 <CAEwNFnALK=aAnyBypHbvw4khRwbOeMN=5gtgLWY+3F3HEpb2Ng@mail.gmail.com>
In-Reply-To: <CAEwNFnALK=aAnyBypHbvw4khRwbOeMN=5gtgLWY+3F3HEpb2Ng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:104:5::26) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:164b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49f663c1-64c4-4000-e87c-08d704d646bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR15MB3050;
x-ms-traffictypediagnostic: DM6PR15MB3050:
x-microsoft-antispam-prvs: <DM6PR15MB30505BA33DA27AB2DAA4D04DBEF00@DM6PR15MB3050.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(305945005)(7736002)(11346002)(6436002)(2906002)(53936002)(6116002)(186003)(99286004)(5660300002)(476003)(6506007)(14454004)(486006)(76176011)(386003)(446003)(52116002)(71190400001)(316002)(54906003)(86362001)(256004)(478600001)(81166006)(8676002)(66476007)(102836004)(8936002)(81156014)(53546011)(46003)(71200400001)(9686003)(25786009)(6246003)(68736007)(229853002)(33656002)(110136005)(6486002)(66556008)(66446008)(66946007)(64756008)(6512007)(4326008)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3050;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i+OCVHUoRVLGupd3HDiTdCOsxVffu0dnl2LRl9qOwscjFRp+PwgNyb+KALOtHvOQVwunz57AEu18Eg3HgHkmxeumHf9LzlkYfQpaTBYuyHR9YvWgIGnSRZQmC46kZoeLpYEONrZSfPEcuXzz5aaL2oOmexaOrRZUJBwmKrlwZhRbWt4ITsDhZA61j1QZ5ACmM0Y3vqBXZtuNztAIP22cdKwc/XmhPfvx+SR37m5oVeIbSrDf0IAtnQaCs1hDt4gfYyl+o1AUlVrYaiqm9b1WJu6tOi2sQntHRN/IaAtoGPKq/1TSdS8CQ/6VJ+rBlqtYt7BXvkhyW2dCCLavehIjNq3W70NNSy38qGlc/WGkBP0xEIOSEMiiGFhfRrESwOrpjnrJncwPlI+NSUUnCZeWuRZIomqNfouP19EuZkDihFU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D13729F1F2ACD44A07E9894FB8EA387@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f663c1-64c4-4000-e87c-08d704d646bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 01:31:05.6067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3050
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907100016
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 02:59:42PM +0900, Minchan Kim wrote:
> Hi Roman,
>=20
>=20
> On Wed, May 15, 2019 at 8:51 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > Vmalloc() is getting more and more used these days (kernel stacks,
> > bpf and percpu allocator are new top users), and the total %
> > of memory consumed by vmalloc() can be pretty significant
> > and changes dynamically.
> >
> > /proc/meminfo is the best place to display this information:
> > its top goal is to show top consumers of the memory.
> >
> > Since the VmallocUsed field in /proc/meminfo is not in use
> > for quite a long time (it has been defined to 0 by the
> > commit a5ad88ce8c7f ("mm: get rid of 'vmalloc_info' from
> > /proc/meminfo")), let's reuse it for showing the actual
> > physical memory consumption of vmalloc().
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Minchan Kim <minchan@kernel.org>
>=20
> How it's going on?
> Android needs this patch since it has gathered vmalloc pages from
> /proc/vmallocinfo. It's too slow.
>=20

Andrew, can you, please, pick this one?

It has been in the mm tree already, but then it was dropped
because of some other non-related patches in the series
conflicted with some x86 changes. This patch is useful
by itself, and doesn't depend on anything else.

Thanks!
