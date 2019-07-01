Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D6B1F987
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfEORpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 13:45:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35294 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbfEORpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:45:50 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FHgSkU026950;
        Wed, 15 May 2019 10:45:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8YLjWnTTgnr/erjUEPLbYzpmCAvv8TXNZWSzERyN8dg=;
 b=TJ7SgEJSKgR2WS02W5DAYfqZU13OV6WTimJ7yxqSB0SfweRiXIDyFuMI6nXX6xBeDwIN
 gVU5+EISqaVAIKuOnVCR0WvA1k/mHhs8itu8gNigRq+uzbQVZxkLFDT0LjeLODaYarXQ
 tYTKYC71Khsy0xvTuDqkwwlanudxkpttsPU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sgh5p9cw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 15 May 2019 10:45:41 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 15 May 2019 10:45:40 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 15 May 2019 10:45:39 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 15 May 2019 10:45:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YLjWnTTgnr/erjUEPLbYzpmCAvv8TXNZWSzERyN8dg=;
 b=TWb6VOR9Qt4N5kUiocy31Z8MLj5kPs6FN+zad3vt+y6jtBOPnBJpHH0VkTSfjvq4kCfxvvlJoHAgEd8HurB+7MxwjI+3dzYhO7wbWqhftwfQEjD1tlbsGaCiVp54ujyDThI9rA3vAPqeEfw6wtKRKnHg2YE1HczMdK9B5DUmbh4=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3496.namprd15.prod.outlook.com (20.179.60.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 17:45:38 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 17:45:37 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: refactor __vunmap() to avoid duplicated call to
 find_vm_area()
Thread-Topic: [PATCH] mm: refactor __vunmap() to avoid duplicated call to
 find_vm_area()
Thread-Index: AQHVCq//khAEDBlALkSFD6zmmU+RfaZsc8kAgAACzgA=
Date:   Wed, 15 May 2019 17:45:37 +0000
Message-ID: <20190515174525.GA11013@castle>
References: <20190514235111.2817276-1-guro@fb.com>
 <20190515173525.GB1888@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190515173525.GB1888@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0023.namprd20.prod.outlook.com
 (2603:10b6:301:15::33) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::3038]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1757bbd-e87f-4330-6147-08d6d95d23c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3496;
x-ms-traffictypediagnostic: BYAPR15MB3496:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB349637BFF202B0B8F8C18D4BBE090@BYAPR15MB3496.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(396003)(39860400002)(376002)(346002)(366004)(189003)(199004)(66446008)(64756008)(66556008)(66476007)(73956011)(386003)(6506007)(76176011)(99286004)(5660300002)(66946007)(6116002)(71190400001)(53936002)(102836004)(52116002)(54906003)(71200400001)(6916009)(6306002)(478600001)(6246003)(256004)(6512007)(9686003)(6436002)(1076003)(68736007)(186003)(81166006)(81156014)(8676002)(316002)(2906002)(6486002)(305945005)(7736002)(229853002)(4326008)(966005)(33716001)(46003)(486006)(8936002)(4744005)(33656002)(446003)(11346002)(25786009)(86362001)(14454004)(476003)(37363001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3496;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b9HIUHclZVQBS7Jh3Fqxswglr6qS+MsuimIRfX32r2bSQOIcmHIK5STATW8YcD6ucUVTVRt0IiRdydtKdTImWdkNd1MM1V6ElU+MzsmyBUOl2SLKxtjWkfLFyczwzFqwzMwNI/P3+y5AAGeb+BeFn8yRzLujkqA1/m+nxXZ3BKppHBp5D+/CSBBnt6ZcaAaHTqaaSdrFVV8z26ww6KYixejWJkOLFFw68YQriG3OMwHLBiYWGJNM3azly59d7OqCGqWHnWQIoNCE5gNTtfgisRfztNleLg//YdFGQXaXi1Tvlr539kAae/ZYmKcC3kfEhyE696JIgs6e5zUq9l09RnMBoqt5XoKMW+dpxKFDFQeTTWAeZ4dXc7X9Ah33buZGbam1daIbUTV9vRkoc18osZbFiQT0yaasUGIU6ksTqd4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81CA0AE8225665428DAD330CE627EB8E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c1757bbd-e87f-4330-6147-08d6d95d23c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 17:45:37.8132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3496
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 10:35:26AM -0700, Ira Weiny wrote:
> > =20
> > -/* Handle removing and resetting vm mappings related to the vm_struct.=
 */
> > -static void vm_remove_mappings(struct vm_struct *area, int deallocate_=
pages)
> > +/* Handle removing and resetting vm mappings related to the va->vm vm_=
struct. */
> > +static void vm_remove_mappings(struct vmap_area *va, int deallocate_pa=
ges)
>=20
> Does this apply to 5.1?  I'm confused because I can't find vm_remove_mapp=
ings()
> in 5.1.

Not really, it's based on top of the current mm tree.
You can find the earlier version which applies on 5.1 here:
https://lkml.org/lkml/2019/4/17/954

Thanks!
