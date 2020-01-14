Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3466513B001
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 17:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgANQut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 11:50:49 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:57752 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgANQus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:50:48 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-75-pFC22tL3O0OjVY1uMnxQBA-1; Tue, 14 Jan 2020 16:50:44 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 14 Jan 2020 16:50:43 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 14 Jan 2020 16:50:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vincent Guittot' <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: sched/fair: scheduler not running high priority process on idle cpu
Thread-Topic: sched/fair: scheduler not running high priority process on idle
 cpu
Thread-Index: AdXK8cUFXa7JpPXmQNq7oQ32S9fYHA==
Date:   Tue, 14 Jan 2020 16:50:43 +0000
Message-ID: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: pFC22tL3O0OjVY1uMnxQBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSd2ZSBhIHRlc3QgdGhhdCB1c2VzIGZvdXIgUlQgcHJpb3JpdHkgcHJvY2Vzc2VzIHRvIHByb2Nl
c3MgYXVkaW8gZGF0YSBldmVyeSAxMG1zLg0KT25lIHByb2Nlc3Mgd2FrZXMgdXAgdGhlIG90aGVy
IHRocmVlLCB0aGV5IGFsbCAnYmVhdmVyIGF3YXknIGNsZWFyaW5nIGEgcXVldWUgb2YNCmpvYnMg
YW5kIHRoZSBsYXN0IG9uZSB0byBmaW5pc2ggc2xlZXBzIHVudGlsIHRoZSBuZXh0IHRpY2suDQpV
c3VhbGx5IHRoaXMgdGFrZXMgYWJvdXQgMC41bXMsIGJ1dCBzb21ldGltZXMgdGFrZXMgb3ZlciAz
bXMuDQoNCkFGQUlDVCB0aGUgcHJvY2Vzc2VzIGFyZSBub3JtYWxseSB3b2tlbiBvbiB0aGUgc2Ft
ZSBjcHUgdGhleSBsYXN0IHJhbiBvbi4NClRoZXJlIHNlZW1zIHRvIGJlIGEgcHJvYmxlbSB3aGVu
IHRoZSBzZWxlY3RlZCBjcHUgaXMgcnVubmluZyBhIChsb3cgcHJpb3JpdHkpDQpwcm9jZXNzIHRo
YXQgaXMgbG9vcGluZyBpbiBrZXJuZWwgWzFdLg0KSSdkIGV4cGVjdCBteSBwcm9jZXNzIHRvIGJl
IHBpY2tlZCB1cCBieSBvbmUgb2YgdGhlIGlkbGUgY3B1cywgYnV0IHRoaXMNCmRvZXNuJ3QgaGFw
cGVuLg0KSW5zdGVhZCB0aGUgcHJvY2VzcyBzaXRzIGluIHN0YXRlICd3YWl0aW5nJyB1bnRpbCB0
aGUgYWN0aXZlIHByb2Nlc3NlcyBzbGVlcHMNCihvciBjYWxscyBjb25kX3Jlc2NoZWQoKSkuDQoN
CklzIHRoaXMgcmVhbGx5IHRoZSBleHBlY3RlZCBiZWhhdmlvdXI/Pz8/Pw0KDQpUaGlzIGlzICA1
LjQuMC1yYzcga2VybmVsLg0KSSBjb3VsZCB0cnkgdGhlIGN1cnJlbnQgNS41LXJjIG9uZSBpZiBh
bnkgcmVjZW50IGNoYW5nZXMgbWlnaHQgYWZmZWN0IHRoaW5ncy4NCg0KQWRkaXRpb25hbGx5IChw
cm9iYWJseSBiZWNhdXNlIGN2X3dhaXQoKSBpcyBpbXBsZW1lbnRlZCB3aXRoICd0aWNrZXQgbG9j
a3MnKQ0Kbm9uZSBvZiB0aGUgb3RoZXIgcHJvY2Vzc2VzIHdhaXRpbmcgZm9yIHRoZSBjdiBhcmUg
d29rZW4gZWl0aGVyLg0KDQpbMV0gWG9yZyBzZWVtcyB0byBwZXJpb2RpY2FsbHkgcmVxdWVzdCB0
aGUga2VybmVsIHdvcmtxdWV1ZSBydW4NCmRybV9jZmx1c2hfc2coKSB0byBmbHVzaCB0aGUgZGlz
cGxheSBidWZmZXIgY2FjaGUuDQpGb3IgYSAyNTYweDExNDAgZGlzcGxheSB0aGlzIGlzIDM2MDAg
NGsgcGFnZXMgYW5kIHRoZSBmbHVzaCBsb29wDQp0YWtlcyB+My4zbXMuDQpIb3dldmVyIHRoZXJl
IGFyZSBwcm9iYWJseSBvdGhlciBwbGFjZXMgd2hlcmUgYSBwcm9jZXNzIGNhbiBydW4gaW4NCmtl
cm5lbCBmb3Igc2lnbmlmaWNhbnQgbGVuZ3RocyBvZiB0aW1lLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

