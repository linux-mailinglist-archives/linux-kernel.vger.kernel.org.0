Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B98E7417
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 15:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390387AbfJ1Oyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 10:54:52 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:24338 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727227AbfJ1Oyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:54:52 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9SElNki002671;
        Mon, 28 Oct 2019 14:54:45 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2vww9k2bc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 14:54:45 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 4454E66;
        Mon, 28 Oct 2019 14:54:44 +0000 (UTC)
Received: from G4W9334.americas.hpqcorp.net (16.208.32.120) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 28 Oct 2019 14:54:38 +0000
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G4W9334.americas.hpqcorp.net (2002:10d0:2078::10d0:2078) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Mon, 28 Oct 2019 14:54:37 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Mon, 28 Oct 2019 14:54:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mowqx2GHrYmNkRbmnkAcy4GH/UWIrfqQn+Aloaq6gxvovLIiXXhLA30bmiERDhIw6GcfPyzgFwXMEXe2bZ3fTBq3tGBHqMAh4kI95+IVQGDeVqxep1w7HhS2gp1rj/xY11sZ4EiN9VFZ+ZQJJ8GIHTvmHxpvxJ+VXZD42NQ7vwhDDhxKeY1R+eNxFhDnFzWmK6hL1VT7H3AkcIlbNbmikkEg0qBFv10fwre8wUkLghqzfmzl2f3e8QRdIbY24MhqbTRRucPp5srRLjSmIfo4E0JRNQVVWK00qV+P+/Drb1RN3cUVd6Y94qOmT3/Aw1g8aFDCk2raCZaq5wN2I4eBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejIpsXs5aEam98mzdh6pCqtzYYcv1k8ADbSxOD5j06Y=;
 b=jS2K43yRc6g2pUpK4+iqUwz9791hPg1ZYuvWxFRF4BuGe5I9J3hUqk3lpo+4wuxn8wZk3BD61Npd4cIynqSPcu9W6oOOJgsFPVUx+Zu8owhzvA1ICmTyT26Zxz6cd65IMGhX9ga3d4aPBEzZU0e0ZJfj66yLafPKY/B4G7dtROIPZjjmGAiKpnOf4zzsJS/uHFDOvC29lh/CjtDZvj9CsXrkZPH2jfaHsQ7QOGHCFe5XFlxEdkEKlBwg3z6+xKESR3vOJWfm40dzBKBOlCz5tEoJj5zTh4nu9RsZCgAIQPT3i7j4kao87PBpDm6sIOTLt5hkG8/fAMneBPGxj2sJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM (10.169.44.19) by
 TU4PR8401MB1262.NAMPRD84.PROD.OUTLOOK.COM (10.169.49.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 14:54:35 +0000
Received: from TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::94e7:1fd4:5529:1507]) by TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::94e7:1fd4:5529:1507%11]) with mapi id 15.20.2387.025; Mon, 28 Oct
 2019 14:54:35 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "d.scott.phillips@intel.com" <d.scott.phillips@intel.com>
CC:     "decui@microsoft.com" <decui@microsoft.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Hoemann, Jerry" <jerry.hoemann@hpe.com>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Thread-Topic: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Thread-Index: AQHVi12UNgRpx6AWwkGexQAAJqZgUqdr9RaAgAADGwCABDA+AA==
Date:   Mon, 28 Oct 2019 14:54:35 +0000
Message-ID: <76ca7b4effada2c7219f66c211946a8178994d1c.camel@hpe.com>
References: <20191025175553.63271-1-d.scott.phillips@intel.com>
         <CAPcyv4iQpO+JF8b7NUJUZ3fQFU=PWFeiWrXSd47QGnQPeRsrTg@mail.gmail.com>
         <38f7f4852ad1cc76c7c7473a6fda85cb9acae14c.camel@intel.com>
In-Reply-To: <38f7f4852ad1cc76c7c7473a6fda85cb9acae14c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [15.219.163.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7b9d402-331f-42c6-0bd2-08d75bb6bfc2
x-ms-traffictypediagnostic: TU4PR8401MB1262:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TU4PR8401MB126298062CE5897AFB6F7C7782660@TU4PR8401MB1262.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39860400002)(189003)(199004)(186003)(86362001)(476003)(2616005)(229853002)(36756003)(26005)(25786009)(7736002)(478600001)(102836004)(6512007)(66476007)(66446008)(64756008)(5660300002)(6436002)(76176011)(11346002)(14454004)(66946007)(76116006)(6506007)(446003)(2201001)(53546011)(110136005)(2501003)(6486002)(54906003)(486006)(4326008)(256004)(305945005)(8936002)(81156014)(8676002)(99286004)(118296001)(4001150100001)(81166006)(66066001)(6116002)(6246003)(71190400001)(58126008)(3846002)(316002)(2906002)(71200400001)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB1262;H:TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRkLRyWDv4Zr8Am8SdyMFn7icYq9s4+YCUfxQlf2sCvmz8BRZHrAxP111SBpA1bWGqpuGku0SDubmDlJfDYgcrGX4XYk7BNgcw7m1xFVAdWgvs6wYL/BDByQvhiXFqUel02Vq42/+7xkmxB72sQzagAYi0NV23rVtDfRuuigzg7qxc3mAo1QMv/FdqDBALRX49+gWI6MB3iAvPZwFADlatxpXBRzob8VnAEKweDWoRX3qOieCfP/ypjDRKHkLKcgY011sXXn+DlS6a9kW4kq9DGUfEepCmGke/rNhDBIYgRKMrhcT0TnYB3aGYOeeEAqdJxG3Zz3LH+3QaGzlJjdMXzDFCk/ehQa9oO/PdNFyOUBrvZiRTmHsr4etUv5UHEqCIBKtGaSEDDA6ZrBQtSfQednm1vgoR7DNt5Qwa+siIYWrxF3IXogwKxTE5X5ia/+
Content-Type: text/plain; charset="utf-8"
Content-ID: <180F81A0C7C33A4CB124EF3C7D0C09E7@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b9d402-331f-42c6-0bd2-08d75bb6bfc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 14:54:35.4155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6uvaQ5k+KvlgZAufNV1Gv6+moM+huJc9gpzbiCKI1K1hnKAW2QVC0U5c3rmg0Qpsd+dkBxQKIfv7HEBpd83Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB1262
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_06:2019-10-28,2019-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910280153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTEwLTI1IGF0IDIyOjU2ICswMDAwLCBWZXJtYSwgVmlzaGFsIEwgd3JvdGU6
DQo+IE9uIEZyaSwgMjAxOS0xMC0yNSBhdCAxNTo0NSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdyb3Rl
Og0KPiA+IE9uIEZyaSwgT2N0IDI1LCAyMDE5IGF0IDEwOjU1IEFNIEQgU2NvdHQgUGhpbGxpcHMN
Cj4gPiA8ZC5zY290dC5waGlsbGlwc0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gQWxsb3cgbmRj
dGwuaCB0byBiZSBsaWNlbnNlZCB3aXRoIEJTRC0yLUNsYXVzZSBzbyB0aGF0IG90aGVyDQo+ID4g
PiBvcGVyYXRpbmcgc3lzdGVtcyBjYW4gcHJvdmlkZSB0aGUgc2FtZSB1c2VyIGxldmVsIGludGVy
ZmFjZS4NCj4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiBJJ3ZlIGJlZW4gd29ya2luZyBvbiBudmRp
bW0gc3VwcG9ydCBpbiBGcmVlQlNEIGFuZCB3b3VsZCBsaWtlIHRvDQo+ID4gPiBvZmZlciB0aGUg
c2FtZSBuZGN0bCBBUEkgdGhlcmUgdG8gZWFzZSBwb3J0aW5nIG9mIGFwcGxpY2F0aW9uDQo+ID4g
PiBjb2RlLiBIZXJlIEknbSBwcm9wb3NpbmcgdG8gYWRkIHRoZSBCU0QtMi1DbGF1c2UgbGljZW5z
ZSB0byB0aGlzDQo+ID4gPiBoZWFkZXIgZmlsZSwgc28gdGhhdCBpdCBjYW4gbGF0ZXIgYmUgY29w
aWVkIGludG8gRnJlZUJTRC4NCj4gPiA+IA0KPiA+ID4gSSBiZWxpZXZlIHRoYXQgYWxsIHRoZSBh
dXRob3JzIG9mIGNoYW5nZXMgdG8gdGhpcyBmaWxlIChpbiB0aGUgVG86DQo+ID4gPiBsaXN0KSB3
b3VsZCBuZWVkIHRvIGFncmVlIHRvIHRoaXMgY2hhbmdlIGJlZm9yZSBpdCBjb3VsZCBiZQ0KPiA+
ID4gYWNjZXB0ZWQsIHNvIGFueSBzaWduZWQtb2ZmLWJ5IGlzIGludGVudGlvbmFsbHkgb21taXRl
ZCBmb3Igbm93Lg0KPiA+ID4gVGhhbmtzLA0KPiA+IA0KPiA+IEkgaGF2ZSBubyBwcm9ibGVtIHdp
dGggdGhpcyBjaGFuZ2UsIGJ1dCBsZXQncyB0YWtlIHRoZSBvcHBvcnR1bml0eSB0bw0KPiA+IGxl
dCBTUERYIGRvIGl0cyBqb2IgYW5kIGRyb3AgdGhlIGZ1bGwgbGljZW5zZSB0ZXh0Lg0KPiANCj4g
VGhpcyBpcyBmaW5lIGJ5IG1lIHRvbywgYmFycmluZyB0aGUgZnVsbCBsaWNlbnNlIHRleHQgdnMu
IFNQRFggY2F2ZWF0DQo+IERhbiBtZW50aW9ucy4NCg0KSSBhZ3JlZSB3aXRoIHRoZSBwbGFuLg0K
DQpUaGFua3MsDQpUb3NoaQ0K
