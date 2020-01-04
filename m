Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E291300CB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 05:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgADEoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 23:44:06 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:26636 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgADEoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 23:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578113046; x=1609649046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6PbhxeTDWYd0BHsgnPYTKzEdogHiPsarjxMpVsbqZlg=;
  b=Q35szfhcjGMpirU96+XKAmpZOBMjGjVu6fCD0GLHndH4AdhoH/C1yRcW
   togd6zDizPjoqrPY3VAg8TKn2oJB5Vl1qkpeMZYxc4eArjVCnAh9X/vsQ
   XuFW6xPQa8LQjFFNLKEvj1VkqerYi7mmVXWBef2Lim0QlTi+cNqBuIouD
   Y=;
IronPort-SDR: TC7lly0pc+bSxupt3pGE5Cft10567HDJooGTlo64P63jna1Ra/d1nDhyo5Ap9RjqexATMd83a9
 wJG+mtW+MlrA==
X-IronPort-AV: E=Sophos;i="5.69,393,1571702400"; 
   d="scan'208";a="10045365"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 04 Jan 2020 04:44:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id C2A70A1FD5;
        Sat,  4 Jan 2020 04:44:02 +0000 (UTC)
Received: from EX13D11UWB003.ant.amazon.com (10.43.161.206) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 4 Jan 2020 04:44:02 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D11UWB003.ant.amazon.com (10.43.161.206) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sat, 4 Jan 2020 04:44:02 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1367.000;
 Sat, 4 Jan 2020 04:44:02 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [resend v1 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVwUGyydawp/BwQkuXvP0PUEOjWqfZ8KeA
Date:   Sat, 4 Jan 2020 04:44:01 +0000
Message-ID: <e5d7e25798d679ea4ba070950cdb5a14f9818eff.camel@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-2-sblbir@amazon.com>
         <BYAPR04MB5749EE1549B30FCECEC1154B86230@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5749EE1549B30FCECEC1154B86230@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.115]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B534D67D190ADB40B32312F45C0A7A7E@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTAzIGF0IDA2OjE2ICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQo+IE9uIDAxLzAxLzIwMjAgMTE6NTMgUE0sIEJhbGJpciBTaW5naCB3cm90ZToNCj4gPiBB
bGxvdyBibG9jay9nZW5oZCB0byBub3RpZnkgdXNlciBzcGFjZSAodmlhIHVkZXYpIGFib3V0IGRp
c2sgc2l6ZSBjaGFuZ2VzDQo+ID4gdXNpbmcgYSBuZXcgaGVscGVyIGRpc2tfc2V0X2NhcGFjaXR5
KCksIHdoaWNoIGlzIGEgd3JhcHBlciBvbiB0b3ANCj4gPiBvZiBzZXRfY2FwYWNpdHkoKS4gZGlz
a19zZXRfY2FwYWNpdHkoKSB3aWxsIG9ubHkgbm90aWZ5IHZpYSB1ZGV2IGlmDQo+ID4gdGhlIGN1
cnJlbnQgY2FwYWNpdHkgb3IgdGhlIHRhcmdldCBjYXBhY2l0eSBpcyBub3QgemVyby4NCj4gPiAN
Cj4gPiBTdWdnZXN0ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnPGhjaEBsc3QuZGU+DQo+ID4gU2ln
bmVkLW9mZi1ieTogU29tZXN3YXJ1ZHUgU2FuZ2FyYWp1PHNzb21lc2hAYW1hem9uLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBCYWxiaXIgU2luZ2g8c2JsYmlyQGFtYXpvbi5jb20+DQo+ID4gLS0t
DQo+IA0KPiBTaW5jZSBkaXNrX3NldF9jYXBhY2l0eSgoKSBpcyBvbiB0aGUgc2FtZSBsaW5lIGFz
IHNldF9jYXBhY2l0eSgpDQo+IHdlIHNob3VsZCBmb2xsb3cgdGhlIHNhbWUgY29udmVudGlvbiwg
d2hpY2ggaXMgOi0NCj4gDQo+IDEuIEF2b2lkIGV4cG9ydGluZyBzeW1ib2wuDQo+IDIuIE1hcmsg
bmV3IGZ1bmN0aW9uIGluLWxpbmUuDQo+IA0KPiBVbmxlc3MgdGhlcmUgaXMgYSB2ZXJ5IHNwZWNp
ZmljIHJlYXNvbiBmb3IgYnJlYWtpbmcgdGhlIHBhdHRlcm4uDQo+IA0KDQpJIGRvbid0IHNlZSB0
aGUgYmVuZWZpdCBvZiBtYXJraW5nIGl0IGFzIGlubGluZS4gSSBleHBlY3QgdGhpcyBjb2RlIHRv
IGJlDQpwb3RlbnRpYWxseSBleHBhbmRlZCB0byBwcm92aWRlIGNhbGxiYWNrcyBpbnRvIGZpbGUg
c3lzdGVtIGNvZGUgZm9yIGV4cGFuc2lvbg0KKHNvbWV0aGluZyB5b3UgYnJvdWdodCB1cCksIG1h
cmtpbmcgaXQgYXMgaW5saW5lIG1pZ2h0IGJlIGEgbGltaXRhdGlvbi4NCg0KSSdkIHJhdGhlciBu
b3QgY2x1dHRlciB0aGUgaGVhZGVycyB3aXRoIHRoaXMgY29kZSwgYnV0IEkgYW0gb3BlbiB0byB3
aGF0IHRoZQ0KbWFpbnRhaW5lcnMgdGhpbmsgYXMgd2VsbC4NCg0KQmFsYmlyIFNpbmdoLg0KDQo=
