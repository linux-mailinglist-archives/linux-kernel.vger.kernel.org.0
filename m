Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A545D160A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfEGJSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 05:18:43 -0400
Received: from mx.socionext.com ([202.248.49.38]:3500 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfEGJSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:18:43 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 May 2019 18:18:41 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 28CB56117D;
        Tue,  7 May 2019 18:18:41 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Tue, 7 May 2019 18:18:41 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX02V.e01.socionext.com (10.213.24.22) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Tue, 7 May 2019 18:18:40 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Tue, 7 May 2019 18:18:40 +0900
From:   <orito.takao@socionext.com>
To:     <ulf.hansson@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <sugaya.taichi@socionext.com>,
        <kasai.kazuhiro@socionext.com>, <kanematsu.shinji@socionext.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-milbeaut: add Milbeaut SD controller
 driver
Thread-Topic: [PATCH 2/2] mmc: sdhci-milbeaut: add Milbeaut SD controller
 driver
Thread-Index: AQHU+9RfYkmmIj60pUy4Wj4B7rC5AKZSXwKAgAx+LAA=
Date:   Tue, 7 May 2019 09:18:40 +0000
Message-ID: <20190507181831.9D75.F0D17A80@socionext.com>
References: <1556244405-15863-1-git-send-email-orito.takao@socionext.com>
 <CAPDyKFrBJeBNOPh9H3Yn-6-um2B-9Gt6_pW8Qh0ZGQB26-tq+Q@mail.gmail.com>
In-Reply-To: <CAPDyKFrBJeBNOPh9H3Yn-6-um2B-9Gt6_pW8Qh0ZGQB26-tq+Q@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Becky! ver. 2.74.02 [ja] (Unregistered)
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <7D48D25CA52EE9408F98EFD1A593606E@socionext.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGFuayB5b3UgZm9yIHJldmlld2luZyBteSBwYXRjaGVzLg0KDQo+IFsuLi5dDQo+IA0KPiA+
ICsNCj4gPiArc3RhdGljIHZvaWQgc2RoY2lfbWlsYmVhdXRfcG93ZXJfb2ZmKHN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZl9zZGhvc3RfcHJpdiAq
cHJpdiA9IHNkaGNpX3ByaXYoaG9zdCk7DQo+ID4gKw0KPiA+ICsgICAgICAgZ3Bpb2Rfc2V0X3Zh
bHVlKHByaXYtPnBvd2VyX2dwaW8sIDApOw0KPiA+ICsgICAgICAgdWRlbGF5KDEwMDApOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBzZGhjaV9taWxiZWF1dF9wb3dlcl9vbihzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IGZfc2Rob3N0
X3ByaXYgKnByaXYgPSBzZGhjaV9wcml2KGhvc3QpOw0KPiA+ICsNCj4gPiArICAgICAgIGdwaW9k
X3NldF92YWx1ZShwcml2LT5wb3dlcl9ncGlvLCAxKTsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IEFz
IHN0YXRlZCBmb3IgdGhlIERUIGRvYyBwYXRjaCwgcGxlYXNlIHVzZSBhIGZpeGVkIEdQSU8gcmVn
dWxhdG9yDQo+IGluc3RlYWQuIEluIHRoaXMgd2F5IHlvdSB3aWxsIGFsc28gZ2V0IGEgdGhlIE9D
UiBtYXNrIGJhc2VkIHVwb24gdGhlDQo+IEdQSU8gcmVndWxhdG9yLCB3aGljaCBpcyBwYXJzZWQg
b3V0IGJ5IHRoZSBtbWMgY29yZSB3aGVuIHNkaGNpIGNhbGxzDQo+IG1tY19yZWd1bGF0b3JfZ2V0
X3N1cHBseSgpLg0KDQpJIHNlZS4gSSB3aWxsIHVwZGF0ZSB0aGlzIHBhcnQgdG9vIGF0IHRoZSB2
aWV3IHBvaW50IG9mIHVzaW5nIHJlZ3VyYXRvci4NCg0KVGhhbmtzDQpPcml0bw0KDQo+IA0KPiBP
dGhlcndpc2UsIHRoaXMgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFsuLi5dDQo+IA0KPiBLaW5k
IHJlZ2FyZHMNCj4gVWZmZQ0KDQotLSANClRha2FvIE9yaXRvIDxvcml0by50YWthb0Bzb2Npb25l
eHQuY29tPg0K
