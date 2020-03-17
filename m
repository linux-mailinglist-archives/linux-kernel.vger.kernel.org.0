Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A331B188A76
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 17:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCQQfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 12:35:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:54419 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgCQQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:35:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-54-wpgio0jsNKOxoSgWOfZ68Q-1; Tue, 17 Mar 2020 16:35:43 +0000
X-MC-Unique: wpgio0jsNKOxoSgWOfZ68Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 17 Mar 2020 16:35:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 17 Mar 2020 16:35:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>, Jakub Jelinek <jakub@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Michael Matz <matz@suse.de>
Subject: RE: [PATCH] x86: fix early boot crash on gcc-10
Thread-Topic: [PATCH] x86: fix early boot crash on gcc-10
Thread-Index: AQHV/GtMWfiMKj6940mmYKYHLC3u9KhM+y6w
Date:   Tue, 17 Mar 2020 16:35:42 +0000
Message-ID: <e5df172c76dd4bb4aeb45e4baef0eff3@AcuMS.aculab.com>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic> <20200316180303.GR2156@tucnak>
 <20200317143602.GC15609@zn.tnic> <20200317143914.GI2156@tucnak>
 <20200317144942.GE15609@zn.tnic>
In-Reply-To: <20200317144942.GE15609@zn.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDE3IE1hcmNoIDIwMjAgMTQ6NTANCj4gT24g
VHVlLCBNYXIgMTcsIDIwMjAgYXQgMDM6Mzk6MTRQTSArMDEwMCwgSmFrdWIgSmVsaW5layB3cm90
ZToNCj4gPiBUaGF0IGlzIGJlY2F1c2UgdGhlIG9wdGlvbiBpcyBjYWxsZWQgLWZuby1zdGFjay1w
cm90ZWN0b3IsIHNvIG9uZSBuZWVkcyB0bw0KPiA+IHVzZSBfX2F0dHJpYnV0ZV9fKChvcHRpbWl6
ZSgibm8tc3RhY2stcHJvdGVjdG9yIikpKQ0KPiANCj4gSGEsIHRoYXQgd29ya3MgZXZlbiEgOi0p
DQo+IA0KPiBBbmQgbXkgZ3Vlc3QgYm9vdHMuDQo+IA0KPiBJIGd1ZXNzIHdlIGNhbiBkbyB0aGF0
IHRoZW4uIExvb2tzIGxpa2UgdGhlIG9wdGltYWwgc29sdXRpb24gdG8gbWUuDQo+IA0KPiBBbHNv
LCBJJ20gYXNzdW1pbmcgb2xkZXIgZ2NjcyB3aWxsIHNpbXBseSBpZ25vcmUgdW5rbm93biBvcHRp
bWl6ZQ0KPiBvcHRpb25zPw0KDQoNClVubGlrZWx5IHNpbmNlIGl0IHJlamVjdGVkIHRoZSBtaXNz
cGVsdCBvbmUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

