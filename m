Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE012D113
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 15:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfL3Opk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 09:45:40 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59614 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3Opj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 09:45:39 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBUEjMx7017383, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBUEjMx7017383
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 22:45:22 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 30 Dec 2019 22:45:22 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 30 Dec 2019 22:45:22 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Mon, 30 Dec 2019 22:45:22 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 13/14] arm64: dts: realtek: rtd16xx: Add SB2 and SCPU Wrapper syscon nodes
Thread-Topic: [PATCH 13/14] arm64: dts: realtek: rtd16xx: Add SB2 and SCPU
 Wrapper syscon nodes
Thread-Index: AQHVqT1xZxfGDYhqBUG4SVUl9UytQ6fS7OYA
Date:   Mon, 30 Dec 2019 14:45:21 +0000
Message-ID: <ea1e0d3edab44092a9ecd9d3557bb977@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-14-afaerber@suse.de>
In-Reply-To: <20191202182205.14629-14-afaerber@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.37.128.25]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBZGQgc3lzY29uIG1mZCBub2RlcyBmb3IgU0IyIGFuZCBTQ1BVIFdyYXBwZXIgdG8gUlREMTZ4
eCBEVC4NCj4gDQo+IENjOiBKYW1lcyBUYWkgPGphbWVzLnRhaUByZWFsdGVrLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPg0KPiAtLS0NCj4g
IGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQxNnh4LmR0c2kgfCAxOCArKysrKysrKysr
KysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDE2eHguZHRzaQ0KPiBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQxNnh4LmR0c2kNCj4gaW5kZXggNzc2ZWZjMTBi
YWIyLi5iYzg4Y2Y3NDlmMzMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVh
bHRlay9ydGQxNnh4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0
ZDE2eHguZHRzaQ0KPiBAQCAtMTM2LDYgKzEzNiwxNSBAQA0KPiAgCQkJCXJhbmdlcyA9IDwweDAg
MHg3MDAwIDB4MTAwMD47DQo+ICAJCQl9Ow0KPiANCj4gKwkJCXNiMjogc3lzY29uQDFhMDAwIHsN
Cj4gKwkJCQljb21wYXRpYmxlID0gInN5c2NvbiIsICJzaW1wbGUtbWZkIjsNCj4gKwkJCQlyZWcg
PSA8MHgxYTAwMCAweDEwMDA+Ow0KPiArCQkJCXJlZy1pby13aWR0aCA9IDw0PjsNCj4gKwkJCQkj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gKwkJCQly
YW5nZXMgPSA8MHgwIDB4MWEwMDAgMHgxMDAwPjsNCj4gKwkJCX07DQo+ICsNCj4gIAkJCW1pc2M6
IHN5c2NvbkAxYjAwMCB7DQo+ICAJCQkJY29tcGF0aWJsZSA9ICJzeXNjb24iLCAic2ltcGxlLW1m
ZCI7DQo+ICAJCQkJcmVnID0gPDB4MWIwMDAgMHgxMDAwPjsNCj4gQEAgLTE0NCw2ICsxNTMsMTUg
QEANCj4gIAkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gIAkJCQlyYW5nZXMgPSA8MHgwIDB4MWIw
MDAgMHgxMDAwPjsNCj4gIAkJCX07DQo+ICsNCj4gKwkJCXNjcHVfd3JhcHBlcjogc3lzY29uQDFk
MDAwIHsNCj4gKwkJCQljb21wYXRpYmxlID0gInN5c2NvbiIsICJzaW1wbGUtbWZkIjsNCj4gKwkJ
CQlyZWcgPSA8MHgxZDAwMCAweDEwMDA+Ow0KPiArCQkJCXJlZy1pby13aWR0aCA9IDw0PjsNCj4g
KwkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4g
KwkJCQlyYW5nZXMgPSA8MHgwIDB4MWQwMDAgMHgxMDAwPjsNCj4gKwkJCX07DQo+ICAJCX07DQo+
IA0KPiAgCQlnaWM6IGludGVycnVwdC1jb250cm9sbGVyQGZmMTAwMDAwIHsNCj4gLS0NCj4gMi4x
Ni40DQo+IA0KPiANCg0KQWNrZWQtYnk6IEphbWVzIFRhaSA8amFtZXMudGFpQHJlYWx0ZWsuY29t
Pg0KDQo=
