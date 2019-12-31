Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAD912D747
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 10:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfLaJQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 04:16:34 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:58935 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLaJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 04:16:33 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBV9G1Kv026279, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBV9G1Kv026279
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 31 Dec 2019 17:16:01 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Tue, 31 Dec 2019 17:16:01 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Dec 2019 17:16:00 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Tue, 31 Dec 2019 17:16:00 +0800
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
Subject: RE: [PATCH 05/14] ARM: dts: rtd1195: Add CRT syscon node
Thread-Topic: [PATCH 05/14] ARM: dts: rtd1195: Add CRT syscon node
Thread-Index: AQHVqT1wU1zGfnse50605xj8lgt7lKfUIyxw
Date:   Tue, 31 Dec 2019 09:16:00 +0000
Message-ID: <0c101eb62fe44bd3b45acc5302271ff3@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-6-afaerber@suse.de>
In-Reply-To: <20191202182205.14629-6-afaerber@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBQcmVwYXJlIGEgQ1JUIHN5c2NvbiBtZmQgbm9kZS4NCj4gDQo+IENjOiBKYW1lcyBUYWkgPGph
bWVzLnRhaUByZWFsdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxh
ZmFlcmJlckBzdXNlLmRlPg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3J0ZDExOTUuZHRz
aSB8IDkgKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvcnRkMTE5NS5kdHNpIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvcnRkMTE5NS5kdHNpDQo+IGluZGV4IGE3NGY1MzBkYzQzOS4uYWMzNzM2NmZmN2M0
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9ydGQxMTk1LmR0c2kNCj4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvcnRkMTE5NS5kdHNpDQo+IEBAIC0xMDAsNiArMTAwLDE1IEBADQo+
ICAJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gIAkJCXJhbmdlcyA9IDwweDAgMHgxODAwMDAwMCAw
eDcwMDAwPjsNCj4gDQo+ICsJCQljcnQ6IHN5c2NvbkAwIHsNCj4gKwkJCQljb21wYXRpYmxlID0g
InN5c2NvbiIsICJzaW1wbGUtbWZkIjsNCj4gKwkJCQlyZWcgPSA8MHgwIDB4MTAwMD47DQo+ICsJ
CQkJcmVnLWlvLXdpZHRoID0gPDQ+Ow0KPiArCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAr
CQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiArCQkJCXJhbmdlcyA9IDwweDAgMHgwIDB4MTAwMD47
DQo+ICsJCQl9Ow0KPiArDQo+ICAJCQlpc286IHN5c2NvbkA3MDAwIHsNCj4gIAkJCQljb21wYXRp
YmxlID0gInN5c2NvbiIsICJzaW1wbGUtbWZkIjsNCj4gIAkJCQlyZWcgPSA8MHg3MDAwIDB4MTAw
MD47DQo+IC0tDQo+IDIuMTYuNA0KPiANCj4gDQpBY2tlZC1ieTogSmFtZXMgVGFpIDxqYW1lcy50
YWlAcmVhbHRlay5jb20+DQoNCg==
