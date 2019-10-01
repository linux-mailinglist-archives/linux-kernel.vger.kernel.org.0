Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED278C2CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 07:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfJAFRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 01:17:05 -0400
Received: from mx.socionext.com ([202.248.49.38]:20873 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJAFRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 01:17:05 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 01 Oct 2019 14:17:02 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 18DC3605F8;
        Tue,  1 Oct 2019 14:17:03 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Tue, 1 Oct 2019 14:17:03 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX01V.e01.socionext.com (10.213.24.21) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Tue, 1 Oct 2019 14:17:02 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Tue, 1 Oct 2019 14:17:02 +0900
From:   <orito.takao@socionext.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <sugaya.taichi@socionext.com>,
        <kasai.kazuhiro@socionext.com>, <kanematsu.shinji@socionext.com>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-milbeaut: add Milbeaut SD driver
Thread-Topic: [PATCH v3 0/2] mmc: sdhci-milbeaut: add Milbeaut SD driver
Thread-Index: AQHVZ3ihYlxK3AfGCE+319PUx3aqu6dEyReA
Date:   Tue, 1 Oct 2019 05:17:02 +0000
Message-ID: <20191001141655.C8BE.F0D17A80@socionext.com>
References: <1568079631-28808-1-git-send-email-orito.takao@socionext.com>
In-Reply-To: <1568079631-28808-1-git-send-email-orito.takao@socionext.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Becky! ver. 2.74.02 [ja] (Unregistered)
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <AA2CA0E6E0E71E458AE7E083CDEB38D8@socionext.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIZWxsbw0KDQpEb2VzIGFueW9uZSBoYXZlIGFueSBjb21tZW50cyBvbiB0aGlzID8NCg0KPiBU
aGUgZm9sbG93aW5nIHBhdGNoZXMgYWRkIGRyaXZlciBmb3IgU0QgSG9zdCBjb250cm9sbGVyIG9u
DQo+IFNvY2lvbmV4dCdzIE1pbGJlYXV0IE0xMFYgcGxhdGZvcm1zLg0KPiANCj4gU0QgSG9zdCBj
b250cm9sbGVyIG9uIE1pbGJlYXV0IGNvbnNpc3RzIG9mIHR3byBjb250cm9sbGVyIHBhcnRzLg0K
PiBPbmUgaXMgY29yZSBjb250cm9sbGVyIEZfU0RIMzAsIHRoaXMgaXMgc2ltaWxhciB0byBzZGhj
aS1mdWppdHN1DQo+IGNvbnRyb2xsZXIuDQo+IEFub3RoZXIgaXMgYnJpZGdlIGNvbnRyb2xsZXIu
IFRoaXMgYnJpZGdlIGNvbnRyb2xsZXIgaXMgbm90IGNvbXBhdGlibGUNCj4gd2l0aCBzZGhjaS1m
dWppdHN1IGNvbnRyb2xsZXIuIFRoaXMgaXMgc3BlY2lhbCBmb3IgTWlsYmVhdXQgc2VyaWVzLg0K
PiANCj4gSXQgaGFzIHRoZSBzZXZlcmFsIHBhcnRzLA0KPiAgLSByZXNldCBjb250cm9sDQo+ICAt
IGNsb2NrIGVuYWJsZSAvIHNlbGVjdCBmb3IgU0RSNTAvMjUvMTINCj4gIC0gaG9sZCBjb250cm9s
IG9mIERBVEEvQ01EIGxpbmUNCj4gIC0gc2VsZWN0IGNoYXJhY3RlcmlzdGljcyBmb3IgV1AvQ0Qv
TEVEIGxpbmUNCj4gIC0gUmUtdHVuaW5nIGNvbnRyb2wgZm9yIG1vZGUzDQo+ICAtIENhcGFiaWxp
dHkgc2V0dGluZw0KPiAgICBUaW1lb3V0IENsb2NrIC8gQmFzZSBDbG9jayAvIFRpbWVyIENvdW50
IGZvciBSZS1UdW5pbmcgLw0KPiAgICBEZWJvdW5jZSBwZXJpb2QNCj4gVGhlc2UgcmVxdWlyZXMg
c3BlY2lhbCBwcm9jZWR1cmVzIGF0IHJlc2V0IG9yIGNsb2NrIGVuYWJsZS9jaGFuZ2Ugb3INCj4g
IGZ1cnRoZXIgdHVuaW5nIG9mIGNsb2NrLg0KPiANCj4gVGFrYW8gT3JpdG8gKDIpOg0KPiAgIGR0
LWJpbmRpbmdzOiBtbWM6IGFkZCBEVCBiaW5kaW5ncyBmb3IgTWlsYmVhdXQgU0QgY29udHJvbGxl
cg0KPiAgIG1tYzogc2RoY2ktbWlsYmVhdXQ6IGFkZCBNaWxiZWF1dCBTRCBjb250cm9sbGVyIGRy
aXZlcg0KPiANCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zZGhjaS1taWxiZWF1dC50
eHQgICAgIHwgIDMwICsrDQo+ICBkcml2ZXJzL21tYy9ob3N0L0tjb25maWcgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxMSArDQo+ICBkcml2ZXJzL21tYy9ob3N0L01ha2VmaWxlICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW1p
bGJlYXV0LmMgICAgICAgICAgICAgICAgICB8IDM2MiArKysrKysrKysrKysrKysrKysrKysNCj4g
IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2lfZl9zZGgzMC5jICAgICAgICAgICAgICAgICAgIHwgIDI2
ICstDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpX2Zfc2RoMzAuaCAgICAgICAgICAgICAgICAg
ICB8ICAzMiArKw0KPiAgNiBmaWxlcyBjaGFuZ2VkLCA0MzcgaW5zZXJ0aW9ucygrKSwgMjUgZGVs
ZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21tYy9zZGhjaS1taWxiZWF1dC50eHQNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL21tYy9ob3N0L3NkaGNpLW1pbGJlYXV0LmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL21tYy9ob3N0L3NkaGNpX2Zfc2RoMzAuaA0KPiANCj4gLS0gDQo+IDEuOS4xDQo+IA0K
DQpUaGFua3MNCk9yaXRvDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpUYWthbyBPcml0bw0KU29jaW9uZXh0IEluYy4N
CkUtbWFpbDpvcml0by50YWthb0Bzb2Npb25leHQuY29tDQpUZWw6KzgxLTgwLTk4MTUtMTQ2MA0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCg==
