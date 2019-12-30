Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEBDF12D0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 15:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfL3OnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 09:43:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59555 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfL3OnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 09:43:20 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBUEh505016963, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBUEh505016963
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 22:43:05 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 30 Dec 2019 22:43:04 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 30 Dec 2019 22:43:04 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Mon, 30 Dec 2019 22:43:04 +0800
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
Subject: RE: [PATCH 09/14] arm64: dts: realtek: rtd16xx: Add CRT syscon node
Thread-Topic: [PATCH 09/14] arm64: dts: realtek: rtd16xx: Add CRT syscon node
Thread-Index: AQHVqT1w+SSrqtXhnUG5EZL0WTOy8qfS7CZw
Date:   Mon, 30 Dec 2019 14:43:04 +0000
Message-ID: <20e5025d02de484ab3f94a5773c2085c@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-10-afaerber@suse.de>
In-Reply-To: <20191202182205.14629-10-afaerber@suse.de>
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

PiBQcmVwYXJlIGEgQ1JUIHN5c2NvbiBtZmQgbm9kZS4NCj4gDQo+IENjOiBKYW1lcyBUYWkgPGph
bWVzLnRhaUByZWFsdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxh
ZmFlcmJlckBzdXNlLmRlPg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9y
dGQxNnh4LmR0c2kgfCA5ICsrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQx
Nnh4LmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTZ4eC5kdHNpDQo+
IGluZGV4IDhmOGYyYjMyOGNkMS4uNzc2ZWZjMTBiYWIyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTZ4eC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvcmVhbHRlay9ydGQxNnh4LmR0c2kNCj4gQEAgLTExOCw2ICsxMTgsMTUgQEANCj4gIAkJ
CSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJcmFuZ2VzID0gPDB4MCAweDk4MDAwMDAwIDB4MjAw
MDAwPjsNCj4gDQo+ICsJCQljcnQ6IHN5c2NvbkAwIHsNCj4gKwkJCQljb21wYXRpYmxlID0gInN5
c2NvbiIsICJzaW1wbGUtbWZkIjsNCj4gKwkJCQlyZWcgPSA8MHgwIDB4MTAwMD47DQo+ICsJCQkJ
cmVnLWlvLXdpZHRoID0gPDQ+Ow0KPiArCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJ
CSNzaXplLWNlbGxzID0gPDE+Ow0KPiArCQkJCXJhbmdlcyA9IDwweDAgMHgwIDB4MTAwMD47DQo+
ICsJCQl9Ow0KPiArDQo+ICAJCQlpc286IHN5c2NvbkA3MDAwIHsNCj4gIAkJCQljb21wYXRpYmxl
ID0gInN5c2NvbiIsICJzaW1wbGUtbWZkIjsNCj4gIAkJCQlyZWcgPSA8MHg3MDAwIDB4MTAwMD47
DQo+IC0tDQo+IDIuMTYuNA0KPiANCj4gDQoNCkFja2VkLWJ5OiBKYW1lcyBUYWkgPGphbWVzLnRh
aUByZWFsdGVrLmNvbT4NCg0K
