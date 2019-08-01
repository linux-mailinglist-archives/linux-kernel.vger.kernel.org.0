Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5C7D22E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 02:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfHAAOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 20:14:22 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:43882 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfHAAOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:14:22 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A973C891A9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2019 12:14:18 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1564618458;
        bh=m0dFn/jIWjNPu4vEeUW08daPgxVNzEHWmmqX9Qjqlec=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=PaIA23JIqDf6kb6eb9ccMSd6zKFTizBKifHwP0qPXNOwAi3sJGcP6rEWKNsyB9S5E
         x51QcvgrFqAvvEyPe9UXbRhGRRDHwsyco/XUL0De6zmoJLvlDDPMK5B/r5nwlC63h7
         /RQyC53zFTniOU62iTvxedye+0M/e0Cwi5mB2VRzOQMHdeHqefVKOOflCiMY7fHo9G
         71hnKtwRnNeIO3TnzLWpglpUAucOIubjvD3CxLg6J+xdBfmQMBfXBZkWCn1AumkLlk
         x3M23Lf+jjNwLv2n9kD13W+BeOkCtkLxITRk8tb1fzR4L2QDLIiEXtAuIBfZYEBU/6
         1b1QupWepU8JA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d422ed90001>; Thu, 01 Aug 2019 12:14:17 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Thu, 1 Aug 2019 12:14:18 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 1 Aug 2019 12:14:18 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Support CMDLINE_EXTEND
Thread-Topic: [PATCH] powerpc: Support CMDLINE_EXTEND
Thread-Index: AQHVQeFH9dM2UcWg8kibPPBr3exODabh/KaAgADsyoCAAKt3gIABGkoA
Date:   Thu, 1 Aug 2019 00:14:18 +0000
Message-ID: <1564618458.15343.28.camel@alliedtelesis.co.nz>
References: <20190724053303.24317-1-chris.packham@alliedtelesis.co.nz>
         <59674457-eda5-fe3b-65e0-29c20102fe4d@c-s.fr>
         <1564521015.6123.11.camel@alliedtelesis.co.nz>
         <32ae09e8-0d32-4266-aa37-d5a34cb4e707@c-s.fr>
In-Reply-To: <32ae09e8-0d32-4266-aa37-d5a34cb4e707@c-s.fr>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="utf-8"
Content-ID: <30C19FECAFE6B84CAF572C2C1CBF43DF@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTMxIGF0IDA5OjIzICswMjAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiANCj4gTGUgMzAvMDcvMjAxOSDDoCAyMzoxMCwgQ2hyaXMgUGFja2hhbSBhIMOpY3JpdMKg
Og0KPiA+IA0KPiA+IEhpIENocmlzdG9waGUsDQo+ID4gDQo+ID4gT24gVHVlLCAyMDE5LTA3LTMw
IGF0IDA5OjAyICswMjAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiAN
Cj4gPiA+IExlIDI0LzA3LzIwMTkgw6AgMDc6MzMsIENocmlzIFBhY2toYW0gYSDDqWNyaXTCoDoN
Cj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBEZXZpY2UgdHJlZSBhd2FyZSBwbGF0Zm9ybXMg
Y2FuIG1ha2UgdXNlIG9mIENNRExJTkVfRVhURU5EIHRvDQo+ID4gPiA+IGV4dGVuZCB0aGUNCj4g
PiA+ID4ga2VybmVsIGNvbW1hbmQgbGluZSBwcm92aWRlZCBieSB0aGUgYm9vdGxvYWRlci4gVGhp
cyBpcw0KPiA+ID4gPiBwYXJ0aWN1bGFybHkNCj4gPiA+ID4gdXNlZnVsIHRvIHNldCBwYXJhbWV0
ZXJzIGZvciBidWlsdC1pbiBtb2R1bGVzIHRoYXQgd291bGQNCj4gPiA+ID4gb3RoZXJ3aXNlDQo+
ID4gPiA+IGJlDQo+ID4gPiA+IGRvbmUgYXQgbW9kdWxlIGluc2VydGlvbi4gQWRkIHN1cHBvcnQg
Zm9yIHRoaXMgaW4gdGhlIHBvd2VycGMNCj4gPiA+ID4gYXJjaGl0ZWN0dXJlLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxp
ZWR0ZWxlc2lzLmNvLm56DQo+ID4gPiA+ID4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKgwqAgYXJj
aC9wb3dlcnBjL0tjb25maWcgfCAxMiArKysrKysrKysrKysNCj4gPiA+IEkgdGhpbmsgeW91IGFs
c28gaGF2ZSB0byBpbXBsZW1lbnQgc29tZSBzdHVmZiBpbg0KPiA+ID4gZWFybHlfY21kbGluZV9w
YXJzZSgpDQo+ID4gPiBpbiBhcmNoL3Bvd2VycGMva2VybmVsL3Byb21faW5pdC5jDQo+ID4gSSBt
eSBjYXNlIEkgZGlkbid0IG5lZWQgdG8gc2luY2UgdGhlIGdlbmVyaWMgY29kZQ0KPiA+IGluwqBk
cml2ZXJzL29mL2ZkdC5jDQo+ID4gZGlkIHdoYXQgSSBuZWVkLiBGb3IgZWFybHkgb3B0aW9ucyBv
ciBwbGF0Zm9ybXMgdGhhdCBkb24ndCB1c2UgYQ0KPiA+IGRldmljZQ0KPiA+IHRyZWUgdGhlbiBJ
IGNhbiBzZWUgd2h5IEknZCBuZWVkIHRoZSB1cGRhdGUgdG8gdXBkYXRlIHRvIHByb21faW5pdC4N
Cj4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBNYXliZSBsb29rIGF0IGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcGF0Y2gvMTA3NDEyNi8NCj4gPiA+IA0KPiA+IERvIHlvdSBtaW5kIGlm
IEkgdGFrZSB0aGlzIGFuZCBmb2xkIGl0IGludG8gYSB2MiBvZiBteSBwYXRjaD8gQW55DQo+ID4g
cGFydGljdWxhciByZWFzb24gaXQgZGlkbid0IGdldCBwaWNrZWQgdXAgaW4gQXByaWw/DQo+IFN1
cmUsIHRha2UgaXQsIEkgZG9uJ3QgbWluZC4NCj4gDQo+IFR3byByZWFzb25zIGl0IHdhcyBub3Qg
cGlja2VkIHVwIGluIEFwcmlsIEkgYmVsaWV2ZToNCj4gLSBJdCB3YXMgcGFydCBvZiBhIGxhcmdl
ciBzZXJpZXPCoA0KPiAoaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4
cHBjLWRldi9saXN0Lz9zZXJpZXM9MTAwNTENCj4gOCnCoA0KPiBhbmQgd2FzIGludGVuZGVkIHRv
IGNoYWxsZW5nZSB0aGUgc2VyaWVzIHByb3Bvc2VkIGJ5IERhbmllbMKgDQo+IChodHRwczovL3Bh
dGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXhwcGMtZGV2L2xpc3QvP3Nlcmllcz05ODEw
Ng0KPiApwqANCj4gYnV0IG5vdGhpbmcgaGFwcGVuZWQuDQo+IC0gSXQgd2FzIGNvbmZsaWN0aW5n
IHdpdGggdGhlIG9uZ29pbmcgY2hhbmdlcyBmb3IgaW1wbGVtZW50aW5nIEtBU0FOLg0KPiANCj4g
V2hhdCB5b3Ugd2lsbCBoYXZlIHRvIGRvIGlzIHRvIGRlZmluZSBwcm9tX3N0cmxjYXQoKSBpbiB0
aGUgc2FtZQ0KPiBzcGlyaXTCoA0KPiBhcyBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Bh
dGNoLzEwOTE2MjEvIGJ5IGNvcHlpbmcgaXQgZnJvbcKgDQo+IGxpYi9zdHJpbmcuYyBhbmQgDQoN
CklzIGl0IE9LIHRvIHVzZSBCVUdfT04gaW4gcHJvbV9pbml0PyBJZiBJIGNvcHkgaXQgdmVyYmF0
aW0gdGhlbiB0aGUNCmNvZGUgZnJvbSBsaWIvc3RyaW5nLmMgaGFzIGEgQlVHX09OLiBJIGNvdWxk
IHByb2JhYmx5IGNoYW5nZSB0aGF0IHRvDQppZih4KSByZXR1cm4gLTEgaWYgQlVHX09OIGlzIG5v
dCBhcHByb3ByaWF0ZS4NCg0KPiBJIHRoaW5rIHlvdSdsbCBiZSBhYmxlIHRvIGRyb3AgcHJvbV9z
dHJsY3B5KCkgYXMgdGhhdMKgDQo+IGZ1bmN0aW9uIHdoYXQgb25seSB1c2VkIHRoZXJlLg0KDQpJ
IHRoaW5rIEkgbmVlZCB0byBrZWVwwqBwcm9tX3N0cmxjcHkgdG8gaGFuZGxlIHRoZSBDTURMSU5F
X0ZPUkNFIGNhc2UuDQoNCj4gDQo+IENocmlzdG9waGUNCj4gDQo+ID4gDQo+ID4gDQo+ID4gPiAN
Cj4gPiA+IENocmlzdG9waGUNCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IMKg
wqAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvS2NvbmZpZyBiL2FyY2gvcG93ZXJwYy9LY29uZmlnDQo+
ID4gPiA+IGluZGV4IGQ4ZGNkODgyMDM2OS4uY2Q5YjM5NzRhYTM2IDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9hcmNoL3Bvd2VycGMvS2NvbmZpZw0KPiA+ID4gPiArKysgYi9hcmNoL3Bvd2VycGMvS2Nv
bmZpZw0KPiA+ID4gPiBAQCAtODUxLDYgKzg1MSwxMSBAQCBjb25maWcgQ01ETElORQ0KPiA+ID4g
PiDCoMKgwqAJwqDCoHNvbWUgY29tbWFuZC1saW5lIG9wdGlvbnMgYXQgYnVpbGQgdGltZSBieQ0K
PiA+ID4gPiBlbnRlcmluZw0KPiA+ID4gPiB0aGVtIGhlcmUuwqDCoEluDQo+ID4gPiA+IMKgwqDC
oAnCoMKgbW9zdCBjYXNlcyB5b3Ugd2lsbCBuZWVkIHRvIHNwZWNpZnkgdGhlIHJvb3QNCj4gPiA+
ID4gZGV2aWNlDQo+ID4gPiA+IGhlcmUuDQo+ID4gPiA+IMKgwqDCoA0KPiA+ID4gPiArY2hvaWNl
DQo+ID4gPiA+ICsJcHJvbXB0ICJLZXJuZWwgY29tbWFuZCBsaW5lIHR5cGUiIGlmIENNRExJTkUg
IT0gIiINCj4gPiA+ID4gKwlkZWZhdWx0IENNRExJTkVfRk9SQ0UNCj4gPiA+ID4gKwlkZXBlbmRz
IG9uIENNRExJTkVfQk9PTA0KPiA+ID4gPiArDQo+ID4gPiA+IMKgwqAgY29uZmlnIENNRExJTkVf
Rk9SQ0UNCj4gPiA+ID4gwqDCoMKgCWJvb2wgIkFsd2F5cyB1c2UgdGhlIGRlZmF1bHQga2VybmVs
IGNvbW1hbmQgc3RyaW5nIg0KPiA+ID4gPiDCoMKgwqAJZGVwZW5kcyBvbiBDTURMSU5FX0JPT0wN
Cj4gPiA+ID4gQEAgLTg2MCw2ICs4NjUsMTMgQEAgY29uZmlnIENNRExJTkVfRk9SQ0UNCj4gPiA+
ID4gwqDCoMKgCcKgwqBUaGlzIGlzIHVzZWZ1bCBpZiB5b3UgY2Fubm90IG9yIGRvbid0IHdhbnQg
dG8NCj4gPiA+ID4gY2hhbmdlDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiDCoMKgwqAJwqDCoGNvbW1h
bmQtbGluZSBvcHRpb25zIHlvdXIgYm9vdCBsb2FkZXIgcGFzc2VzIHRvDQo+ID4gPiA+IHRoZQ0K
PiA+ID4gPiBrZXJuZWwuDQo+ID4gPiA+IMKgwqDCoA0KPiA+ID4gPiArY29uZmlnIENNRExJTkVf
RVhURU5EDQo+ID4gPiA+ICsJYm9vbCAiRXh0ZW5kIGJvb3Rsb2FkZXIga2VybmVsIGFyZ3VtZW50
cyINCj4gPiA+ID4gKwloZWxwDQo+ID4gPiA+ICsJwqDCoFRoZSBjb21tYW5kLWxpbmUgYXJndW1l
bnRzIHByb3ZpZGVkIGJ5IHRoZSBib290DQo+ID4gPiA+IGxvYWRlcg0KPiA+ID4gPiB3aWxsIGJl
DQo+ID4gPiA+ICsJwqDCoGFwcGVuZGVkIHRvIHRoZSBkZWZhdWx0IGtlcm5lbCBjb21tYW5kIHN0
cmluZy4NCj4gPiA+ID4gK2VuZGNob2ljZQ0KPiA+ID4gPiArDQo+ID4gPiA+IMKgwqAgY29uZmln
IEVYVFJBX1RBUkdFVFMNCj4gPiA+ID4gwqDCoMKgCXN0cmluZyAiQWRkaXRpb25hbCBkZWZhdWx0
IGltYWdlIHR5cGVzIg0KPiA+ID4gPiDCoMKgwqAJaGVscA==
