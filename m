Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E91DC3158
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 12:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfJAK2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 06:28:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:44995 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbfJAK2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:28:12 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-104-QriuFpqrN4OOGp2kPcqmDw-1; Tue, 01 Oct 2019 11:28:08 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 1 Oct 2019 11:28:07 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 1 Oct 2019 11:28:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Nicholas Mc Guire" <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: x86/random: Speculation to the rescue
Thread-Topic: x86/random: Speculation to the rescue
Thread-Index: AQHVd6pl492SQGjALUePXRzXPfNmoqdFkRMg
Date:   Tue, 1 Oct 2019 10:28:07 +0000
Message-ID: <41646d76683844e7baf068bed35891ad@AcuMS.aculab.com>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <20190930033706.GD4994@mit.edu> <20190930131639.GF4994@mit.edu>
 <CAHk-=wg7YAx_+CDe6fUqApPD_ghP18H9sPnJWWUg32pQ4pU82g@mail.gmail.com>
In-Reply-To: <CAHk-=wg7YAx_+CDe6fUqApPD_ghP18H9sPnJWWUg32pQ4pU82g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: QriuFpqrN4OOGp2kPcqmDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMzAgU2VwdGVtYmVyIDIwMTkgMTc6MTYNCj4g
DQo+IE9uIE1vbiwgU2VwIDMwLCAyMDE5IGF0IDY6MTYgQU0gVGhlb2RvcmUgWS4gVHMnbyA8dHl0
c29AbWl0LmVkdT4gd3JvdGU6DQo+ID4NCj4gPiBXaGljaCBpcyB0byBzYXksIEknbSBzdGlsbCB3
b3JyaWVkIHRoYXQgcGVvcGxlIHdpdGggZGVlcCBhY2Nlc3MgdG8gdGhlDQo+ID4gaW1wbGVtZW50
YXRpb24gZGV0YWlscyBvZiBhIENQVSBtaWdodCBiZSBhYmxlIHRvIHJldmVyc2UgZW5naW5lZXIg
d2hhdA0KPiA+IGEgaml0dGVyIGVudHJvcHkgc2NoZW1lIHByb2R1Y2VzLiAgVGhpcyBpcyB3aHkg
SSdkIGJlIGN1cmlvdXMgdG8gc2VlDQo+ID4gdGhlIHJlc3VsdHMgd2hlbiBzb21lb25lIHRyaWVz
IHRvIGF0dGFjayBhIGppdHRlciBzY2hlbWUgb24gYSBmdWxseQ0KPiA+IG9wZW4sIHNpbXBsZSBh
cmNoaXRlY3R1cmUgc3VjaCBhcyBSSVNDLVYuDQo+IA0KPiBPaCwgSSBhZ3JlZS4NCj4gDQo+IE9u
ZSBvZiB0aGUgcmVhc29ucyBJIGRpZG4ndCBsaWtlIHNvbWUgb2YgdGhlIG90aGVyIGppdHRlciBl
bnRyb3B5DQo+IHRoaW5ncyB3YXMgdGhhdCB0aGV5IHNlZW1lZCB0byByZWx5IF9lbnRpcmVseV8g
b24ganVzdCBwdXJlbHkNCj4gbG93LWxldmVsIENQVSB1bnByZWRpY3RhYmlsaXR5LiBJIHRoaW5r
IHRoYXQgZXhpc3RzLCBidXQgSSB0aGluayBpdA0KPiBtYWtlcyBmb3IgcHJvYmxlbXMgZm9yIHJl
YWxseSBzaW1wbGUgY29yZXMuDQo+IA0KPiBUaW1pbmcgb3ZlciBhIGJpZ2dlciB0aGluZyBhbmQg
YW4gYWN0dWFsIGludGVycnVwdCAoZXZlbiBpZiBpdCdzDQo+ICJqdXN0IiBhIHRpbWVyIGludGVy
cnVwdCwgd2hpY2ggaXMgYXJndWFibHkgbXVjaCBjbG9zZXIgdG8gdGhlIENQVSBhbmQNCj4gaGFz
IGEgbXVjaCBoaWdoZXIgbGlrZWxpaG9vZCBvZiBoYXZpbmcgY29tbW9uIGZyZXF1ZW5jeSBkb21h
aW5zIHdpdGgNCj4gdGhlIGN5Y2xlIGNvdW50ZXIgZXRjKSBtZWFucyB0aGF0IEknbSBwcmV0dHkg
ZGFtbiBjb252aW5jZWQgdGhhdCBhIGJpZw0KPiBjb21wbGV4IENQVSB3aWxsIGFic29sdXRlbHkg
c2VlIGlzc3VlcywgZXZlbiBpZiBpdCBoYXMgYmlnIGNhY2hlcy4NCg0KQWdyZWVkLCB5b3UgbmVl
ZCBzb21ldGhpbmcgdGhhdCBpcyBhY3R1YWxseSBub24tZGV0ZXJtaW5pc3RpYy4NCldoaWxlICdz
cGVjdWxhdGlvbicgaXMgZGlmZmljdWx0IHRvIHByZWRpY3QsIGl0IGlzIGFjdHVhbGx5IGZ1bGx5
IGRldGVybWluaXN0aWMuDQpVbnRpbCB5b3UgZ2V0IHNvbWUgcGVydHVyYmF0aW9uIGZyb20gYW4g
b3V0c2lkZSBzb3VyY2UgdGhlIGNwdSBzdGF0ZQ0KKGluY2x1ZGluZyBjYWNoZXMgYW5kIERSQU0p
IGlzIGxpa2VseSB0byBiZSB0aGUgc2FtZSBvbiBldmVyeSBib290Lg0KRm9yIGEgZGVza3RvcCAo
ZXRjKSBQQyBib290aW5nIGZyb20gYSBkaXNrIChldmVuIFNTRCkgeW91J2xsIGdldCBzb21lIHZh
cmlhdGlvbi4NCkJvb3QgYW4gZW1iZWRkZWQgc3lzdGVtIGZyb20gb25ib2FyZCBmbGFzaCBhbmQg
ZXZlcnkgYm9vdCBjb3VsZA0Kd2VsbCBiZSB0aGUgc2FtZSAob3Igb25lIG9mIGEgc21hbGwgbnVt
YmVyIG9mIHJlc3VsdHMpLg0KDQpTeW5jaHJvbmlzaW5nIGEgc2lnbmFsIGJldHdlZW4gZnJlcXVl
bmN5IGRvbWFpbnMgbWlnaHQgZ2VuZXJhdGUNCnNvbWUgJ3JhbmRvbW5lc3MnLCBidXQgbWF5YmUg
bm90IGlmIGJvdGggY29tZSBmcm9tIHRoZSBzYW1lIFBMTC4NCg0KRXZlbiBpZiB0aGVyZSBhcmUg
dmFyaWF0aW9ucywgdGhleSBtYXkgbm90IGJlIGxhcmdlIGVub3VnaCB0byBnaXZlDQphIGxvdCBv
ZiB2YXJpYXRpb25zIGluIHRoZSBzdGF0ZS4NClRoZSB2YXJpYXRpb25zIGJldHdlZW4gc3lzdGVt
cyBjb3VsZCBhbHNvIGJlIGEgbG90IGxhcmdlciB0aGFuIHRoZQ0KdmFyaWF0aW9ucyB3aXRoaW4g
YSBzeXN0ZW0uDQoNCklmIHRoZXJlIGFyZSAnb25seScgMl4zMiB2YXJpYXRpb25zIGFuIGV4aGF1
c3RpdmUgc2VhcmNoIG1pZ2h0IGJlDQpwb3NzaWJsZSB0byBmaW5kIGFuIHNzaCBrZXkuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

