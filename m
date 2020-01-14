Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78713A776
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 11:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgANKhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 05:37:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:33231 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgANKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:37:00 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-XKAK83k4MUOUHB-MOVF62w-1; Tue, 14 Jan 2020 10:36:56 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 14 Jan 2020 10:36:55 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 14 Jan 2020 10:36:55 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'xuesong Chen' <xuesong1977@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Question about output of kmalloc()
Thread-Topic: Question about output of kmalloc()
Thread-Index: AQHVyqsmnSz1LEifykaY0jdG+ufF0Kfp95Mg
Date:   Tue, 14 Jan 2020 10:36:55 +0000
Message-ID: <22e494d8f2c7448dbf75a70a949d1280@AcuMS.aculab.com>
References: <CAJKSTDwPX3D956yMaNakgjbHSd7hyyU7YbGN-nM=LmR3qXMtxQ@mail.gmail.com>
In-Reply-To: <CAJKSTDwPX3D956yMaNakgjbHSd7hyyU7YbGN-nM=LmR3qXMtxQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: XKAK83k4MUOUHB-MOVF62w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIHh1ZXNvbmcgQ2hlbg0KPiBTZW50OiAxNCBKYW51YXJ5IDIwMjAgMDc6MjENCj4gQmVs
b3cgY29kZSBzbmlwcGV0IGluIHRoZSAua286DQo+IA0KPiB1bnNpZ25lZCBsb25nICpwID0gKHVu
c2lnbmVkIGxvbmcgKilrbWFsbG9jKHNpemVvZigqcCksIEdGUF9LRVJORUwpOw0KPiBwcmludGso
IkFkZHIgb2YgcCA9IDB4JXBcbiIsIHApOw0KPiANCj4gVGhlIG91dHB1dCBpczoNCj4gQWRkciBv
ZiBwID0gMHgwMDAwMDAwMDE4NjA2Y2U3DQo+IA0KPiBJbiBteSBtaW5kLCBkdXJpbmcgdGhlIGVh
cmx5IGRheSwgdGhlIHAgc2hvdWxkIGJlIDB4ZmZmZmYuLi4uLCBjYW4NCj4gYW55Ym9keSBnaXZl
IHNvbWUgdGlwcyB3aHkgdGhlIG91dHB1dCBsb29rcyBsaWtlIGl0J3MgYSBwaHlzaWNhbA0KPiBh
ZGRyZXNzPw0KDQpUaGUgcHJpbnRlZCB2YWx1ZSBpcyBoYXNoZWQgdG8gYXZvaWQgbGVha2luZyBp
bmZvLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

