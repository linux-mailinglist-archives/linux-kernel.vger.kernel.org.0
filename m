Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E264196D31
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 14:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgC2MJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 08:09:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:25506 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728160AbgC2MJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 08:09:21 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-232-Plif2OlMMmS4hBXoj5hg1A-1; Sun, 29 Mar 2020 13:09:17 +0100
X-MC-Unique: Plif2OlMMmS4hBXoj5hg1A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 29 Mar 2020 13:09:16 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 29 Mar 2020 13:09:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Randy Dunlap' <rdunlap@infradead.org>,
        Omar Kilani <omar.kilani@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>
Subject: RE: Weird issue with epoll and kernel >= 5.0
Thread-Topic: Weird issue with epoll and kernel >= 5.0
Thread-Index: AQHWBTYs4uAoSuVbY0K/kFw4ScJFNqhfeToQ
Date:   Sun, 29 Mar 2020 12:09:16 +0000
Message-ID: <e31f945d6d854398b4236872d1636c41@AcuMS.aculab.com>
References: <CA+8F9hhy=WPMJLQ3Ya_w4O6xyWk7KsXi=YJofmyC577_UJTutA@mail.gmail.com>
 <34206eb5-1280-4aac-9a50-76f967646ca1@infradead.org>
In-Reply-To: <34206eb5-1280-4aac-9a50-76f967646ca1@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmFuZHkgRHVubGFwDQo+IFNlbnQ6IDI4IE1hcmNoIDIwMjAgMTk6MjINCi4uLg0KPiBU
aGVyZSBoYXZlIGJlZW4gYXJvdW5kIDEwIGNoYW5nZXMgaW4gZnMvZXZlbnRwb2xsLmMgc2luY2Ug
djUuMCB3YXMNCj4gcmVsZWFzZWQgaW4gTWFyY2gsIDIwMTksIHNvIGl0IHdvdWxkIGJlIGhlbHBm
dWwgaWYgeW91IGNvdWxkIHRlc3QNCj4gdGhlIGxhdGVzdCBtYWlubGluZSBrZXJuZWwgdG8gc2Vl
IGlmIHRoZSBwcm9ibGVtIGlzIHN0aWxsIHByZXNlbnQuDQoNCklzIHRoZXJlIGFueSBpbmZvIGFi
b3V0IHRoZSBzY2VuYXJpb3MgdGhhdCB0aGUgZml4ZXMgYWZmZWN0Pw0KV2UndmUgYW4gYXBwbGlj
YXRpb24gdGhhdCBjYW4gdXNlIGVwb2xsKCkgb3IgcG9sbCgpIGFuZCBJIHdvbmRlcg0KaWYgSSBz
aG91bGQgbm90IGRlZmF1bHQgdG8gZXBvbGwoKSBvbiA1LjArIGtlcm5lbHMgdGhhdCBtaWdodCBi
ZSBkb2RneS4NCg0KSXQgcmF0aGVyIGRlcGVuZHMgd2hldGhlciB3YWtldXBzIGp1c3QgZ2V0IGxv
c3QgLSBidXQgdGhlIG5leHQNCnJ4IGRhdGEgd2lsbCB3YWtlIHRoaW5ncyB1cCwgb3Igd2hldGhl
ciB0aGUgbGlua2VkIGxpc3RzIGdldA0KY29tcGxldGVseSBob3NlZCBhbmQgJ2FsbCBoZWxsJyBi
cmVha3Mgb3V0IChvciBkb2Vzbid0KS4NCg0KSW4gb3VyIGNhc2UgdGhlcmUgaXMgb25seSBvbmUg
cmVhZGVyIGFuZCB0aGUgZmQgYXJlIGFsbA0KVURQIHNvY2tldHMgKGFkZGVkIGFuZCByZW1vdmVk
IHdoZW4gdGhlIHNvY2tldCBpcyBjcmVhdGVkL2Nsb3NlZCkuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

