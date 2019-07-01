Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA33949919
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 08:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfFRGoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 02:44:32 -0400
Received: from mail-eopbgr780049.outbound.protection.outlook.com ([40.107.78.49]:64591
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbfFRGob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv/zcxHs3P231QVvyumvym/s1YBuiRl2VWYRhjotz80=;
 b=KLugPSwKSuhFecU35KbXOQJy+CyhaE/SaTkoN0ZVpY+dbULOmqr5gh46qxHYysBfcCnqQNqg/Vj3j8dvDt3WgT2LUv0pbrwHc8fVZdQPCv2DoOlIhW76+vpW3NBlO5dvPOAss5vT2o8SKjpYJKEPCQRXRkWEh+/81WMdPjX/WUA=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5303.namprd05.prod.outlook.com (20.177.127.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.12; Tue, 18 Jun 2019 05:40:11 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2008.007; Tue, 18 Jun 2019
 05:40:11 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Borislav Petkov <bp@suse.de>, Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] resource: Introduce resource cache
Thread-Topic: [PATCH 3/3] resource: Introduce resource cache
Thread-Index: AQHVIaTIgkJbYpRVG0mXAw73pWsOuqag4XgAgAAJ4gCAAAHyAA==
Date:   Tue, 18 Jun 2019 05:40:11 +0000
Message-ID: <8072D878-BBF2-47E4-B4C9-190F379F6221@vmware.com>
References: <20190613045903.4922-1-namit@vmware.com>
 <20190613045903.4922-4-namit@vmware.com>
 <20190617215750.8e46ae846c09cd5c1f22fdf9@linux-foundation.org>
 <98464609-8F5A-47B9-A64E-2F67809737AD@vmware.com>
In-Reply-To: <98464609-8F5A-47B9-A64E-2F67809737AD@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89928f49-5134-43d9-baa0-08d6f3af6e5b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5303;
x-ms-traffictypediagnostic: BYAPR05MB5303:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR05MB5303070CD5B2A73A64CBD4D2D0EA0@BYAPR05MB5303.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(189003)(199004)(14454004)(6512007)(8676002)(11346002)(3846002)(6306002)(81156014)(86362001)(76176011)(14444005)(446003)(53376002)(486006)(2906002)(186003)(54906003)(6506007)(26005)(2616005)(6116002)(476003)(256004)(53546011)(53936002)(25786009)(229853002)(7416002)(6246003)(7736002)(66556008)(73956011)(66446008)(33656002)(76116006)(305945005)(71190400001)(71200400001)(36756003)(6916009)(66946007)(66476007)(64756008)(66066001)(68736007)(4326008)(5660300002)(6486002)(316002)(966005)(478600001)(81166006)(102836004)(99286004)(8936002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5303;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0qTJE/RW3BxsCA1BFzX2wmx0pmuGX6WxVLS++EyYcaVc15USGWxFOvO5qEoFQTINrIFRLN8XJq1wNpVIBuGJD0qn3E8y++75EVkSWLG8O0Xd9Cihi46qmTNqgZxMFCTCzIm+sRB8ifEAb/za3N1P496dHtDzfviTxU1nmo4Z2INkRhQRH5A6RxU31itjO8AijlCM0ZRF8vttxFI5OZtDJLFc3IBEvyhlxjQCXKVRV8/C+S/mD3dUOtTmSWKbuwzFraMxjIl7SRjzSXMjuk/Hma6dnT9CYqHCN8kP0f0pP6Qz+TER98H5FC1KWgUVHA/NC4dR9ma1DOIDoHkyA6wYZV/NA5r7Pwf1rtwd6i1cnE9GTEzUvw9OYliCExEThmhqVi30BrFZaCy1BcsCoKbuG4st3CBZtUHSOIYdWP8Ean4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32E999B6085D2041929989B8FECCAD54@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89928f49-5134-43d9-baa0-08d6f3af6e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 05:40:11.4316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5303
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMTcsIDIwMTksIGF0IDEwOjMzIFBNLCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUu
Y29tPiB3cm90ZToNCj4gDQo+PiBPbiBKdW4gMTcsIDIwMTksIGF0IDk6NTcgUE0sIEFuZHJldyBN
b3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPj4gDQo+PiBPbiBXZWQs
IDEyIEp1biAyMDE5IDIxOjU5OjAzIC0wNzAwIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+
IHdyb3RlOg0KPj4gDQo+Pj4gRm9yIGVmZmljaWVudCBzZWFyY2ggb2YgcmVzb3VyY2VzLCBhcyBu
ZWVkZWQgdG8gZGV0ZXJtaW5lIHRoZSBtZW1vcnkNCj4+PiB0eXBlIGZvciBkYXggcGFnZS1mYXVs
dHMsIGludHJvZHVjZSBhIGNhY2hlIG9mIHRoZSBtb3N0IHJlY2VudGx5IHVzZWQNCj4+PiB0b3At
bGV2ZWwgcmVzb3VyY2UuIENhY2hpbmcgdGhlIHRvcC1sZXZlbCBzaG91bGQgYmUgc2FmZSBhcyBy
YW5nZXMgaW4NCj4+PiB0aGF0IGxldmVsIGRvIG5vdCBvdmVybGFwICh1bmxpa2UgdGhvc2Ugb2Yg
bG93ZXIgbGV2ZWxzKS4NCj4+PiANCj4+PiBLZWVwIHRoZSBjYWNoZSBwZXItY3B1IHRvIGF2b2lk
IHBvc3NpYmxlIGNvbnRlbnRpb24uIFdoZW5ldmVyIGEgcmVzb3VyY2UNCj4+PiBpcyBhZGRlZCwg
cmVtb3ZlZCBvciBjaGFuZ2VkLCBpbnZhbGlkYXRlIGFsbCB0aGUgcmVzb3VyY2VzLiBUaGUNCj4+
PiBpbnZhbGlkYXRpb24gdGFrZXMgcGxhY2Ugd2hlbiB0aGUgcmVzb3VyY2VfbG9jayBpcyB0YWtl
biBmb3Igd3JpdGUsDQo+Pj4gcHJldmVudGluZyBwb3NzaWJsZSByYWNlcy4NCj4+PiANCj4+PiBU
aGlzIHBhdGNoIHByb3ZpZGVzIHJlbGF0aXZlbHkgc21hbGwgcGVyZm9ybWFuY2UgaW1wcm92ZW1l
bnRzIG92ZXIgdGhlDQo+Pj4gcHJldmlvdXMgcGF0Y2ggKH4wLjUlIG9uIHN5c2JlbmNoKSwgYnV0
IGNhbiBiZW5lZml0IHN5c3RlbXMgd2l0aCBtYW55DQo+Pj4gcmVzb3VyY2VzLg0KPj4gDQo+Pj4g
LS0tIGEva2VybmVsL3Jlc291cmNlLmMNCj4+PiArKysgYi9rZXJuZWwvcmVzb3VyY2UuYw0KPj4+
IEBAIC01Myw2ICs1MywxMiBAQCBzdHJ1Y3QgcmVzb3VyY2VfY29uc3RyYWludCB7DQo+Pj4gDQo+
Pj4gc3RhdGljIERFRklORV9SV0xPQ0socmVzb3VyY2VfbG9jayk7DQo+Pj4gDQo+Pj4gKy8qDQo+
Pj4gKyAqIENhY2hlIG9mIHRoZSB0b3AtbGV2ZWwgcmVzb3VyY2UgdGhhdCB3YXMgbW9zdCByZWNl
bnRseSB1c2UgYnkNCj4+PiArICogZmluZF9uZXh0X2lvbWVtX3JlcygpLg0KPj4+ICsgKi8NCj4+
PiArc3RhdGljIERFRklORV9QRVJfQ1BVKHN0cnVjdCByZXNvdXJjZSAqLCByZXNvdXJjZV9jYWNo
ZSk7DQo+PiANCj4+IEEgcGVyLWNwdSBjYWNoZSB3aGljaCBpcyBhY2Nlc3NlZCB1bmRlciBhIGtl
cm5lbC13aWRlIHJlYWRfbG9jayBsb29rcyBhDQo+PiBiaXQgb2RkIC0gdGhlIGxhdGVuY3kgZ2V0
dGluZyBhdCB0aGF0IHJ3bG9jayB3aWxsIHN3YW1wIHRoZSBiZW5lZml0IG9mDQo+PiBpc29sYXRp
bmcgdGhlIENQVXMgZnJvbSBlYWNoIG90aGVyIHdoZW4gYWNjZXNzaW5nIHJlc291cmNlX2NhY2hl
Lg0KPj4gDQo+PiBPbiB0aGUgb3RoZXIgaGFuZCwgaWYgd2UgaGF2ZSBtdWx0aXBsZSBDUFVzIHJ1
bm5pbmcNCj4+IGZpbmRfbmV4dF9pb21lbV9yZXMoKSBjb25jdXJyZW50bHkgdGhlbiB5ZXMsIEkg
c2VlIHRoZSBiZW5lZml0LiAgSGFzDQo+PiB0aGUgYmVuZWZpdCBvZiB1c2luZyBhIHBlci1jcHUg
Y2FjaGUgKHJhdGhlciB0aGFuIGEga2VybmVsLXdpZGUgb25lKQ0KPj4gYmVlbiBxdWFudGlmaWVk
Pw0KPiANCj4gTm8uIEkgYW0gbm90IHN1cmUgaG93IGVhc3kgaXQgd291bGQgYmUgdG8gbWVhc3Vy
ZSBpdC4gT24gdGhlIG90aGVyIGhhbmRlcg0KPiB0aGUgbG9jayBpcyBub3Qgc3VwcG9zZWQgdG8g
YmUgY29udGVuZGVkIChhdCBtb3N0IGNhc2VzKS4gQXQgdGhlIHRpbWUgSSBzYXcNCj4gbnVtYmVy
cyB0aGF0IHNob3dlZCB0aGF0IHN0b3JlcyB0byDigJxleGNsdXNpdmUiIGNhY2hlIGxpbmVzIGNh
biBiZSBhcw0KPiBleHBlbnNpdmUgYXMgYXRvbWljIG9wZXJhdGlvbnMgWzFdLiBJIGFtIG5vdCBz
dXJlIGhvdyB1cCB0byBkYXRlIHRoZXNlDQo+IG51bWJlcnMgYXJlIHRob3VnaC4gSW4gdGhlIGJl
bmNobWFyayBJIHJhbiwgbXVsdGlwbGUgQ1BVcyByYW4NCj4gZmluZF9uZXh0X2lvbWVtX3Jlcygp
IGNvbmN1cnJlbnRseS4NCj4gDQo+IFsxXSBodHRwOi8vc2lnb3BzLm9yZy9zL2NvbmZlcmVuY2Vz
L3Nvc3AvMjAxMy9wYXBlcnMvcDMzLWRhdmlkLnBkZg0KDQpKdXN0IHRvIGNsYXJpZnkgLSB0aGUg
bWFpbiBtb3RpdmF0aW9uIGJlaGluZCB0aGUgcGVyLWNwdSB2YXJpYWJsZSBpcyBub3QNCmFib3V0
IGNvbnRlbnRpb24sIGJ1dCBhYm91dCB0aGUgZmFjdCB0aGUgZGlmZmVyZW50IHByb2Nlc3Nlcy90
aHJlYWRzIHRoYXQNCnJ1biBjb25jdXJyZW50bHkgbWlnaHQgdXNlIGRpZmZlcmVudCByZXNvdXJj
ZXMuDQoNCg==
