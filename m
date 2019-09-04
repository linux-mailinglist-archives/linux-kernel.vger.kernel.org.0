Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3844A7F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 11:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfIDJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 05:43:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:42226 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbfIDJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:43:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-2-idzu5r6TOlu_emqmv_fYOA-1;
 Wed, 04 Sep 2019 10:43:24 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 4 Sep 2019 10:43:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 4 Sep 2019 10:43:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: RE: [PATCH] sched: make struct task_struct::state 32-bit
Thread-Topic: [PATCH] sched: make struct task_struct::state 32-bit
Thread-Index: AQHVYoQgiajii1HT8kenaFCmXyiHJqcbRQQA
Date:   Wed, 4 Sep 2019 09:43:23 +0000
Message-ID: <651c419e45e043e9be8d0877b5a5406d@AcuMS.aculab.com>
References: <20190902210558.GA23013@avx2>
 <d8ad0be1-4ed7-df74-d415-2b1c9a44bac7@arm.com> <20190903181920.GA22358@avx2>
In-Reply-To: <20190903181920.GA22358@avx2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: idzu5r6TOlu_emqmv_fYOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDAzIFNlcHRlbWJlciAyMDE5IDE5OjE5DQou
Li4NCj4gPiBIb3cgZGlkIHlvdSBjb21lIHVwIHdpdGggdGhpcyBjaGFuZ2VzZXQsIGRpZCB5b3Ug
cGlja2F4ZSBmb3Igc29tZSByZWdleHA/DQo+IA0KPiBObywgbWFudWFsbHksIGJhY2t0cmFja2lu
ZyB1cCB0byB0aGUgY2FsbCBjaGFpbi4NCj4gTWF5YmUgSSBtaXNzZWQgYSBmZXcgcGxhY2VzLg0K
DQpSZW5hbWluZyB0aGUgc3RydWN0dXJlIGZpZWxkIGFuZCBnZXR0aW5nIHRoZSBjb21waWxlciB0
byBmaW5kIGFsbCB0aGUgdXNlcyBjYW4gaGVscC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

