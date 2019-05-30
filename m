Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5192FB01
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 13:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfE3Lhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 07:37:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:39561 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfE3Lhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:37:48 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-68-XcXpo9w1PbC4Usz7fk1Iyw-1; Thu, 30 May 2019 12:37:43 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 30 May 2019 12:37:42 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 30 May 2019 12:37:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] add typeof_member() macro
Thread-Topic: [PATCH 1/2] add typeof_member() macro
Thread-Index: AQHVFlHCTxfMtSMsnEGvjLdiCN8dJ6aDiwCw
Date:   Thu, 30 May 2019 11:37:42 +0000
Message-ID: <a32bb1376821422fa3c647c01f3f1a95@AcuMS.aculab.com>
References: <20190529190720.GA5703@avx2>
In-Reply-To: <20190529190720.GA5703@avx2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: XcXpo9w1PbC4Usz7fk1Iyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDI5IE1heSAyMDE5IDIwOjA3DQo+IA0KPiBB
ZGQgdHlwZW9mX21lbWJlcigpIG1hY3JvIHNvIHRoYXQgdHlwZXMgY2FuIGJlIGV4Y3RyYWN0ZWQg
d2l0aG91dA0KPiBpbnRyb2R1Y2luZyBkdW1teSB2YXJpYWJsZXMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4ZXkgRG9icml5YW4gPGFkb2JyaXlhbkBnbWFpbC5jb20+DQo+IC0tLQ0KPiANCj4g
IGluY2x1ZGUvbGludXgva2VybmVsLmggfCAgICAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspDQo+IA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2tlcm5lbC5oDQo+ICsrKyBi
L2luY2x1ZGUvbGludXgva2VybmVsLmgNCj4gQEAgLTg4LDYgKzg4LDggQEANCj4gICAqLw0KPiAg
I2RlZmluZSBGSUVMRF9TSVpFT0YodCwgZikgKHNpemVvZigoKHQqKTApLT5mKSkNCj4gDQo+ICsj
ZGVmaW5lIHR5cGVvZl9tZW1iZXIoVCwgbSkJdHlwZW9mKCgoVCopMCktPm0pDQoNClNob3VsZCBw
cm9iYWJseSBiZSAndCcgKG5vdCAnVCcpIGFuZCB1cHBlciBjYXNlID8NCg0KSG1tbS4uLi4gdGhl
ICNkZWZpbmUgaXMgbG9uZ2VyIHRoYXQgd2hhdCBpdCBleHBhbmRzIHRvIC4uLg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

