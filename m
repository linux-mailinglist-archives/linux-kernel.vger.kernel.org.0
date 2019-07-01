Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADEA5A6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 23:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfF1V7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 17:59:42 -0400
Received: from mail-eopbgr800084.outbound.protection.outlook.com ([40.107.80.84]:63126
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726754AbfF1V7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 17:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5CICPJw0eTXocZnziVNnjhO/UoKQcF/BqBpuzzdoeo=;
 b=t9aF1X87iBmBq6lczlpKWMLyU6M/rS0oDhhxMETjgQpbujbOFd06yS0gqxC8XLrmrc3eGayolqgs+4RYwx4QlL+BeeE8sHD2RYP/xHBAuNfE7rch+FynVjujkPXbt/fB4wiBTcvorOv4D3qSg3ubmrwEV7VOmmln9Br/hjChXPM=
Received: from CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) by
 CY4PR12MB1285.namprd12.prod.outlook.com (10.168.167.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Fri, 28 Jun 2019 21:59:33 +0000
Received: from CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::38d5:5f22:2510:9e44]) by CY4PR12MB1798.namprd12.prod.outlook.com
 ([fe80::38d5:5f22:2510:9e44%9]) with mapi id 15.20.2008.019; Fri, 28 Jun 2019
 21:59:33 +0000
From:   "Phillips, Kim" <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Liska <mliska@suse.cz>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>, Pu Wen <puwen@hygon.cn>,
        Stephane Eranian <eranian@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 2/2 RESEND3] perf/x86/amd/uncore: set the thread mask for F17h
 L3 PMCs
Thread-Topic: [PATCH 2/2 RESEND3] perf/x86/amd/uncore: set the thread mask for
 F17h L3 PMCs
Thread-Index: AQHVLfzE4xmWuP/6j0S77TtF+wX25g==
Date:   Fri, 28 Jun 2019 21:59:33 +0000
Message-ID: <20190628215906.4276-2-kim.phillips@amd.com>
References: <20190628215906.4276-1-kim.phillips@amd.com>
In-Reply-To: <20190628215906.4276-1-kim.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:805:8e::29) To CY4PR12MB1798.namprd12.prod.outlook.com
 (2603:10b6:903:11a::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beb4333a-0c18-4c64-a321-08d6fc13e6e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR12MB1285;
x-ms-traffictypediagnostic: CY4PR12MB1285:
x-microsoft-antispam-prvs: <CY4PR12MB1285E7974A0779D6C91AFA1A87FC0@CY4PR12MB1285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(2906002)(110136005)(486006)(71190400001)(8936002)(186003)(71200400001)(25786009)(68736007)(7736002)(3846002)(45080400002)(81166006)(81156014)(6116002)(305945005)(5660300002)(7416002)(66476007)(64756008)(66556008)(99286004)(86362001)(8676002)(50226002)(1076003)(26005)(14454004)(316002)(36756003)(478600001)(66446008)(66946007)(6512007)(256004)(73956011)(102836004)(4326008)(476003)(66066001)(386003)(6436002)(6506007)(76176011)(52116002)(6486002)(11346002)(2616005)(446003)(53936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1285;H:CY4PR12MB1798.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 380dK433YTfC6xh/u/acsLbCq84tIsjnHqOCG+DV2kzk27hTLAT8SPXnGprhftjOig3ilEVc6eI6RKIX28syxlizXDTM2O2zZewJ572kQDTL/ZrmlLxYkByWSTaJQJLGohs6uv5wvDA7DoWoOJ/S4iym0wlgT+Uz2TiMdb1uAdkJPC5pqtybCI9afPz/CkgBmUcYGJ7djX3hhVgoUkWjXQX3zayttSIl0pzvDOjHxj0EkwzHacFgSw2yY0EF05sCwtx5QFaWW4RvgOJ5232i21SGPu4w6W7VIV6MzpBs2055os6ln1a5JRWIJFHUx2B2zi65KROfQyavhUvE7U/qruMk6iRWHoKKAhWEHvuLczJzKRTKq2sHWcjoaDkinGMzMIeXtrfAZrSoMqhXa1MgFlEiEJwvcR0oC5kOTa4M9vg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <848AB005D24AB4488FFC6F7659890929@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb4333a-0c18-4c64-a321-08d6fc13e6e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 21:59:33.1994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kphillips@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

Fill in the L3 performance event select register ThreadMask
bitfield, to enable per hardware thread accounting.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Martin Liska <mliska@suse.cz>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Gary Hook <Gary.Hook@amd.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: x86@kernel.org
---
RESEND3: file sent with header:

	Content-Type: text/plain; charset=3D"us-ascii"

to work around a bug in the Microsoft Outlook SMTP servers.

 arch/x86/events/amd/uncore.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index c2c4ae5fbbfc..a6ea07f2aa84 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -202,15 +202,22 @@ static int amd_uncore_event_init(struct perf_event *e=
vent)
 	hwc->config =3D event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx =3D -1;
=20
+	if (event->cpu < 0)
+		return -EINVAL;
+
 	/*
 	 * SliceMask and ThreadMask need to be set for certain L3 events in
 	 * Family 17h. For other events, the two fields do not affect the count.
 	 */
-	if (l3_mask && is_llc_event(event))
-		hwc->config |=3D (AMD64_L3_SLICE_MASK | AMD64_L3_THREAD_MASK);
+	if (l3_mask && is_llc_event(event)) {
+		int thread =3D 2 * (cpu_data(event->cpu).cpu_core_id % 4);
=20
-	if (event->cpu < 0)
-		return -EINVAL;
+		if (smp_num_siblings > 1)
+			thread +=3D cpu_data(event->cpu).apicid & 1;
+
+		hwc->config |=3D (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
+				AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
+	}
=20
 	uncore =3D event_to_amd_uncore(event);
 	if (!uncore)
--=20
2.22.0

