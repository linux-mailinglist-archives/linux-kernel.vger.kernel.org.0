Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E95A1A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 14:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfH2Mgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 08:36:33 -0400
Received: from mail2.tencent.com ([163.177.67.195]:40007 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2Mgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:36:33 -0400
Received: from EXHUB-SZMail03.tencent.com (unknown [10.14.6.33])
        by mail2.tencent.com (Postfix) with ESMTP id 236128ED3B;
        Thu, 29 Aug 2019 20:36:30 +0800 (CST)
Received: from EX-SZ008.tencent.com (10.28.6.32) by EXHUB-SZMail03.tencent.com
 (10.14.6.33) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 29 Aug 2019
 20:36:30 +0800
Received: from EX-SZ013.tencent.com (10.28.6.37) by EX-SZ008.tencent.com
 (10.28.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 29 Aug
 2019 20:36:29 +0800
Received: from EX-SZ013.tencent.com ([fe80::ad97:241e:365:d21a]) by
 EX-SZ013.tencent.com ([fe80::ad97:241e:365:d21a%8]) with mapi id
 15.01.1713.004; Thu, 29 Aug 2019 20:36:29 +0800
From:   =?gb2312?B?dG9ubnlsdSjCvda+uNUp?= <tonnylu@tencent.com>
To:     Matthew Wilcox <willy@infradead.org>,
        zhigang lu <luzhigang001@gmail.com>
CC:     "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?aHpob25nemhhbmco1cXqu9bQKQ==?= <hzhongzhang@tencent.com>,
        =?gb2312?B?a25pZ2h0emhhbmco1cXX2sP3KQ==?= <knightzhang@tencent.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBtbS9odWdldGxiOiBhdm9pZCBsb29waW5nIHRvIHRo?=
 =?gb2312?B?ZSBzYW1lIGh1Z2VwYWdlIGlmICFwYWdlcyBhbmQgIXZtYXMoSW50ZXJuZXQg?=
 =?gb2312?Q?mail)?=
Thread-Topic: [PATCH] mm/hugetlb: avoid looping to the same hugepage if !pages
 and !vmas(Internet mail)
Thread-Index: AQHVXl4rJSmKppaj5kmsIm45+JghiqcRfk+AgACO92A=
Date:   Thu, 29 Aug 2019 12:36:29 +0000
Message-ID: <f5d5fd353d744ce2b267bfe27db26b1f@tencent.com>
References: <CABNBeK+6C9ToJcjhGBJQm5dDaddA0USOoRFmRckZ27PhLGUfQg@mail.gmail.com>
 <20190829115457.GC6590@bombadil.infradead.org>
In-Reply-To: <20190829115457.GC6590@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.252]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5m
cmFkZWFkLm9yZz4gDQq3osvNyrG85DogMjAxOcTqONTCMjnI1SAxOTo1NQ0KytW8/sjLOiB6aGln
YW5nIGx1IDxsdXpoaWdhbmcwMDFAZ21haWwuY29tPg0Ks63LzTogbWlrZS5rcmF2ZXR6QG9yYWNs
ZS5jb207IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
dG9ubnlsdSjCvda+uNUpIDx0b25ueWx1QHRlbmNlbnQuY29tPjsgaHpob25nemhhbmco1cXqu9bQ
KSA8aHpob25nemhhbmdAdGVuY2VudC5jb20+OyBrbmlnaHR6aGFuZyjVxdfaw/cpIDxrbmlnaHR6
aGFuZ0B0ZW5jZW50LmNvbT4NCtb3zOI6IFJlOiBbUEFUQ0hdIG1tL2h1Z2V0bGI6IGF2b2lkIGxv
b3BpbmcgdG8gdGhlIHNhbWUgaHVnZXBhZ2UgaWYgIXBhZ2VzIGFuZCAhdm1hcyhJbnRlcm5ldCBt
YWlsKQ0KDQpPbiBUaHUsIEF1ZyAyOSwgMjAxOSBhdCAwNzozNzoyMlBNICswODAwLCB6aGlnYW5n
IGx1IHdyb3RlOg0KPiBUaGlzIGNoYW5nZSBncmVhdGx5IGRlY3JlYXNlIHRoZSB0aW1lIG9mIG1t
YXBpbmcgYSBmaWxlIGluIGh1Z2V0bGJmcy4NCj4gV2l0aCBNQVBfUE9QVUxBVEUgZmxhZywgaXQg
dGFrZXMgYWJvdXQgNTAgbWlsbGlzZWNvbmRzIHRvIG1tYXAgYQ0KPiBleGlzdGluZyAxMjhHQiBm
aWxlIGluIGh1Z2V0bGJmcy4gV2l0aCB0aGlzIGNoYW5nZSwgaXQgdGFrZXMgbGVzcw0KPiB0aGVu
IDEgbWlsbGlzZWNvbmQuDQoNCllvdSdyZSBnb2luZyB0byBuZWVkIHRvIGZpbmQgYSBuZXcgd2F5
IG9mIHNlbmRpbmcgcGF0Y2hlczsgdGhpcyBwYXRjaCBpcw0KbWFuZ2xlZCBieSB5b3VyIG1haWwg
c3lzdGVtLg0KDQoNCj4gQEAgLTQzOTEsNiArNDM5MSwxNyBAQCBsb25nIGZvbGxvd19odWdldGxi
X3BhZ2Uoc3RydWN0IG1tX3N0cnVjdCAqbW0sDQo+IHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1h
LA0KPiAgIGJyZWFrOw0KPiAgIH0NCj4gICB9DQo+ICsNCj4gKyBpZiAoIXBhZ2VzICYmICF2bWFz
ICYmICFwZm5fb2Zmc2V0ICYmDQo+ICsgICAgICh2YWRkciArIGh1Z2VfcGFnZV9zaXplKGgpIDwg
dm1hLT52bV9lbmQpICYmDQo+ICsgICAgIChyZW1haW5kZXIgPj0gcGFnZXNfcGVyX2h1Z2VfcGFn
ZShoKSkpIHsNCj4gKyB2YWRkciArPSBodWdlX3BhZ2Vfc2l6ZShoKTsNCj4gKyByZW1haW5kZXIg
LT0gcGFnZXNfcGVyX2h1Z2VfcGFnZShoKTsNCj4gKyBpICs9IHBhZ2VzX3Blcl9odWdlX3BhZ2Uo
aCk7DQo+ICsgc3Bpbl91bmxvY2socHRsKTsNCj4gKyBjb250aW51ZTsNCj4gKyB9DQoNClRoZSBj
b25jZXB0IHNlZW1zIGdvb2QgdG8gbWUuICBUaGUgZGVzY3JpcHRpb24gYWJvdmUgY291bGQgZG8g
d2l0aCBzb21lDQpiZXR0ZXIgZXhwbGFuYXRpb24gdGhvdWdoLg0KDQpUaGFua3MsIFdpbGx5LiBJ
IHdpbGwgYWRkIG1vcmUgZXhwbGFuYXRpb24gYW5kIHJlc2VuZCB0aGUgcGF0Y2hlcyBpbiBwbGFp
biB0ZXh0IG1vZGUuDQo=
