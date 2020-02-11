Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08458158CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 11:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgBKKef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 05:34:35 -0500
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:41344
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727805AbgBKKef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:34:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIF+qCGISHG0ywYoh2pgegbZ3koWpKi600ugXPrYX8GMLwoY6rf337D4CH9D+/j1Bz2AUQL15CaotDE+ijfAPYvEARmVqdgFTeAcTOh9s3nkweyc10kSkcxC3HwaF/qwcoWWW11x6A96UAPJMuOZSkWKxar2kk7cuTZL0T1R4rUNoOXmL6k5JtPjSkf4xEKmgy8BjbFf2aq0G3yytNFp7OAEBVeuh99TLbkM+r4ZwJSAH8chkWjC+h8/F2sAUP8OS7l/meMIPmhNFO7/7CZem7N6HgGwB7rnUJjXLBQie7vv9ROkHa2ynIL+CvEqDhhSAUxEWbcnXS8xqNDkH7cYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l05o7LwNO/wkfIrus0yzJ54TrfHCdHpJzusPtMFUmVo=;
 b=TowarZPwZTzGmkCWf7C+nj1uefWvWGnW1bKTAoQxZhJazrss7PZSEWCjrVWfNqJIgg32ws1n09cDaHXhhZPvVjSn5fQTboeHvZF7O2hrOHvxClDDXMeGHE9pbRs65InIXsiG5qQT+J77Z1rhIzQX0hKN3oE/ikZySJUilYp3BjNuVIflwl2UpkAyzHqOsy76b4GQFA+KCc5gPoA0ll2lUR6BMxE6kreagbSDnkps6KE0q1zk3+k8KZY307D1hKQf6osNgRmOBDFn/8xGhs5otPLq2UrzXSwbeCfSAUiBchcz53EIXJuYnCkjr3GEitUWtJ4fueO7Bhxuijl75/FOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l05o7LwNO/wkfIrus0yzJ54TrfHCdHpJzusPtMFUmVo=;
 b=aPcBktN50veutItac+qCOp5eDLs03H4WxHrUAtmSP+C3zrcWvis4sUVjQOdUWYU5bT0YqvVwdMnmIzHVH/KRyUvLHQIIcM9KDWK0rtjPwF6CiZjEKBHUcnxA+HNZ4+uBgA+xTfkp4eDPRF4dveT0tt4/6SkN4yrQW3DVoWva/Pg=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4414.namprd11.prod.outlook.com (52.135.36.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 10:34:31 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 10:34:30 +0000
From:   =?utf-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [[PATCH staging] 4/7] staging: wfx: annotate nested gc_list vs tx
 queue locking
Thread-Topic: [[PATCH staging] 4/7] staging: wfx: annotate nested gc_list vs
 tx queue locking
Thread-Index: AQHV4LfUhYDoPleUp06rRNfId7+sbagVzD6A
Date:   Tue, 11 Feb 2020 10:34:30 +0000
Message-ID: <263570919.qXAG0u9DAH@pc-42>
References: <cover.1581410026.git.mirq-linux@rere.qmqm.pl>
 <c47c0b645071aff141fa0d39d92184b6dc5e4f52.1581410026.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <c47c0b645071aff141fa0d39d92184b6dc5e4f52.1581410026.git.mirq-linux@rere.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26d63a16-c219-4aa5-e64f-08d7aeddfa78
x-ms-traffictypediagnostic: MN2PR11MB4414:
x-microsoft-antispam-prvs: <MN2PR11MB44140498FF4700061D806F2493180@MN2PR11MB4414.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(189003)(4326008)(8936002)(85202003)(66574012)(6506007)(86362001)(71200400001)(186003)(26005)(81166006)(8676002)(2906002)(81156014)(66446008)(5660300002)(9686003)(66946007)(76116006)(91956017)(316002)(6512007)(6486002)(6916009)(64756008)(66556008)(66476007)(85182001)(33716001)(54906003)(478600001)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4414;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vhz3aOCCrpmV0HeI5v/GHBit6SMpFXEJFQb0NuMFrHK4yFkdoc/JjVbYqBzIwbGgwDoKhEqFk2sR7s0YVbp/eTnQGo2sMZzJoXkb6BOOG/k0WQ7H2wCSDAKrlG7UiAUG9mSBR5Pc+MVT5rWsYl4UgtTmTyKC7LRsYuwJcXtFUB+eGbz2XI42LoqnmVh5ze6uO0lr5FPPI3JE2JR9ErPhs1Qx+bomaXeLZF3D/PK6t2WnLqs0RKMaubQesRycFG64tJCgRF+MMtJtfcllpAvECKFgsNQcMFjNzrVfrg0q8Hr1/TGyYj7Jsvgp25GmOt+q+b5Do4t00GtKkGAlui4qTO22SCKZ15/HfgmpcjafSx59TrWTX1B7dIoorhWdiUprI4FcTM/EwZsfFq7KOsNw5MLej1DdrVPT7s3Z/PqqPCY4JbIzpG5sVWKvq2nD8s79IWwM5zoJksv40kWnCQym/X7UN1qwsZmyZd424IlrYZ95bgRX5Y1HMg6oy1SgDEmq
x-ms-exchange-antispam-messagedata: Vdq66eoTiWj3j1HMbsT/vNmTZI3EitBceqnOPJGEvLRGxbiH24lh+7RbSQkNBSPvdSOKHsqz0Tz9naggWQ65dCYYTU3LPc8wXPkuqMVUDZAHJd/fuQfX8HTUq2X2N5eGDeO2RiWEwRYjDsEAT8bKVQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1942344462BBA408C1BA9352E1F7F2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d63a16-c219-4aa5-e64f-08d7aeddfa78
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 10:34:30.6259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXtuxx1YDizDukWryDrgMT1pAmBDJBSgA/LMXOB/pRUeUmg5t8FQHu5TSjhmYu/HLYXsbX0Hp+uAhjvcqd6zbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlc2RheSAxMSBGZWJydWFyeSAyMDIwIDA5OjQ2OjU1IENFVCBNaWNoYcWCIE1pcm9zxYJh
dyB3cm90ZToNCj4gTG9ja2RlcCBpcyBjb21wbGFpbmluZyBhYm91dCByZWN1cnNpdmUgbG9ja2lu
ZywgYmVjYXVzZSBpdCBjYW4ndCBtYWtlDQo+IGEgZGlmZmVyZW5jZSBiZXR3ZWVuIGxvY2tlZCBz
a2JfcXVldWVzLiBBbm5vdGF0ZSBuZXN0ZWQgbG9ja3MgYW5kIGF2b2lkDQo+IGRvdWJsZSBiaF9k
aXNhYmxlL2VuYWJsZS4NCj4gDQo+IFsuLi5dDQo+IGluc21vZC84MTUgaXMgdHJ5aW5nIHRvIGFj
cXVpcmUgbG9jazoNCj4gY2I3ZDY0MTggKCYoJmxpc3QtPmxvY2spLT5ybG9jayl7Ky4uLn0sIGF0
OiB3ZnhfdHhfcXVldWVzX2NsZWFyKzB4ZmMvMHgxOTggW3dmeF0NCj4gDQo+IGJ1dCB0YXNrIGlz
IGFscmVhZHkgaG9sZGluZyBsb2NrOg0KPiBjYjdkNjFmNCAoJigmbGlzdC0+bG9jayktPnJsb2Nr
KXsrLi4ufSwgYXQ6IHdmeF90eF9xdWV1ZXNfY2xlYXIrMHhhMC8weDE5OCBbd2Z4XQ0KPiANCj4g
Wy4uLl0NCj4gUG9zc2libGUgdW5zYWZlIGxvY2tpbmcgc2NlbmFyaW86DQo+IA0KPiAgICAgICBD
UFUwDQo+ICAgICAgIC0tLS0NCj4gIGxvY2soJigmbGlzdC0+bG9jayktPnJsb2NrKTsNCj4gIGxv
Y2soJigmbGlzdC0+bG9jayktPnJsb2NrKTsNCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJxLWxpbnV4QHJlcmUu
cW1xbS5wbD4NCj4gLS0tDQo+ICBkcml2ZXJzL3N0YWdpbmcvd2Z4L3F1ZXVlLmMgfCAxNiArKysr
KysrKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy93ZngvcXVldWUuYyBi
L2RyaXZlcnMvc3RhZ2luZy93ZngvcXVldWUuYw0KPiBpbmRleCAwYmNjNjFmZWVlMWQuLjUxZDZj
NTVhZTkxZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dmeC9xdWV1ZS5jDQo+ICsr
KyBiL2RyaXZlcnMvc3RhZ2luZy93ZngvcXVldWUuYw0KPiBAQCAtMTMwLDEyICsxMzAsMTIgQEAg
c3RhdGljIHZvaWQgd2Z4X3R4X3F1ZXVlX2NsZWFyKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBzdHJ1
Y3Qgd2Z4X3F1ZXVlICpxdWV1ZSwNCj4gICAgICAgICBzcGluX2xvY2tfYmgoJnF1ZXVlLT5xdWV1
ZS5sb2NrKTsNCj4gICAgICAgICB3aGlsZSAoKGl0ZW0gPSBfX3NrYl9kZXF1ZXVlKCZxdWV1ZS0+
cXVldWUpKSAhPSBOVUxMKQ0KPiAgICAgICAgICAgICAgICAgc2tiX3F1ZXVlX2hlYWQoZ2NfbGlz
dCwgaXRlbSk7DQo+IC0gICAgICAgc3Bpbl9sb2NrX2JoKCZzdGF0cy0+cGVuZGluZy5sb2NrKTsN
Cj4gKyAgICAgICBzcGluX2xvY2tfbmVzdGVkKCZzdGF0cy0+cGVuZGluZy5sb2NrLCAxKTsNCj4g
ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzdGF0cy0+bGlua19tYXBfY2FjaGUp
OyArK2kpIHsNCj4gICAgICAgICAgICAgICAgIHN0YXRzLT5saW5rX21hcF9jYWNoZVtpXSAtPSBx
dWV1ZS0+bGlua19tYXBfY2FjaGVbaV07DQo+ICAgICAgICAgICAgICAgICBxdWV1ZS0+bGlua19t
YXBfY2FjaGVbaV0gPSAwOw0KPiAgICAgICAgIH0NCj4gLSAgICAgICBzcGluX3VubG9ja19iaCgm
c3RhdHMtPnBlbmRpbmcubG9jayk7DQo+ICsgICAgICAgc3Bpbl91bmxvY2soJnN0YXRzLT5wZW5k
aW5nLmxvY2spOw0KPiAgICAgICAgIHNwaW5fdW5sb2NrX2JoKCZxdWV1ZS0+cXVldWUubG9jayk7
DQo+ICB9DQo+IA0KPiBAQCAtMjA3LDkgKzIwNyw5IEBAIHZvaWQgd2Z4X3R4X3F1ZXVlX3B1dChz
dHJ1Y3Qgd2Z4X2RldiAqd2Rldiwgc3RydWN0IHdmeF9xdWV1ZSAqcXVldWUsDQo+IA0KPiAgICAg
ICAgICsrcXVldWUtPmxpbmtfbWFwX2NhY2hlW3R4X3ByaXYtPmxpbmtfaWRdOw0KPiANCj4gLSAg
ICAgICBzcGluX2xvY2tfYmgoJnN0YXRzLT5wZW5kaW5nLmxvY2spOw0KPiArICAgICAgIHNwaW5f
bG9ja19uZXN0ZWQoJnN0YXRzLT5wZW5kaW5nLmxvY2ssIDEpOw0KPiAgICAgICAgICsrc3RhdHMt
PmxpbmtfbWFwX2NhY2hlW3R4X3ByaXYtPmxpbmtfaWRdOw0KPiAtICAgICAgIHNwaW5fdW5sb2Nr
X2JoKCZzdGF0cy0+cGVuZGluZy5sb2NrKTsNCj4gKyAgICAgICBzcGluX3VubG9jaygmc3RhdHMt
PnBlbmRpbmcubG9jayk7DQo+ICAgICAgICAgc3Bpbl91bmxvY2tfYmgoJnF1ZXVlLT5xdWV1ZS5s
b2NrKTsNCj4gIH0NCj4gDQo+IEBAIC0yMzcsMTEgKzIzNywxMSBAQCBzdGF0aWMgc3RydWN0IHNr
X2J1ZmYgKndmeF90eF9xdWV1ZV9nZXQoc3RydWN0IHdmeF9kZXYgKndkZXYsDQo+ICAgICAgICAg
ICAgICAgICBfX3NrYl91bmxpbmsoc2tiLCAmcXVldWUtPnF1ZXVlKTsNCj4gICAgICAgICAgICAg
ICAgIC0tcXVldWUtPmxpbmtfbWFwX2NhY2hlW3R4X3ByaXYtPmxpbmtfaWRdOw0KPiANCj4gLSAg
ICAgICAgICAgICAgIHNwaW5fbG9ja19iaCgmc3RhdHMtPnBlbmRpbmcubG9jayk7DQo+ICsgICAg
ICAgICAgICAgICBzcGluX2xvY2tfbmVzdGVkKCZzdGF0cy0+cGVuZGluZy5sb2NrLCAxKTsNCj4g
ICAgICAgICAgICAgICAgIF9fc2tiX3F1ZXVlX3RhaWwoJnN0YXRzLT5wZW5kaW5nLCBza2IpOw0K
PiAgICAgICAgICAgICAgICAgaWYgKCEtLXN0YXRzLT5saW5rX21hcF9jYWNoZVt0eF9wcml2LT5s
aW5rX2lkXSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgd2FrZXVwX3N0YXRzID0gdHJ1ZTsN
Cj4gLSAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2JoKCZzdGF0cy0+cGVuZGluZy5sb2NrKTsN
Cj4gKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZzdGF0cy0+cGVuZGluZy5sb2NrKTsNCj4g
ICAgICAgICB9DQo+ICAgICAgICAgc3Bpbl91bmxvY2tfYmgoJnF1ZXVlLT5xdWV1ZS5sb2NrKTsN
Cj4gICAgICAgICBpZiAod2FrZXVwX3N0YXRzKQ0KPiBAQCAtMjU5LDEwICsyNTksMTAgQEAgaW50
IHdmeF9wZW5kaW5nX3JlcXVldWUoc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCBza19idWZm
ICpza2IpDQo+ICAgICAgICAgc3Bpbl9sb2NrX2JoKCZxdWV1ZS0+cXVldWUubG9jayk7DQo+ICAg
ICAgICAgKytxdWV1ZS0+bGlua19tYXBfY2FjaGVbdHhfcHJpdi0+bGlua19pZF07DQo+IA0KPiAt
ICAgICAgIHNwaW5fbG9ja19iaCgmc3RhdHMtPnBlbmRpbmcubG9jayk7DQo+ICsgICAgICAgc3Bp
bl9sb2NrX25lc3RlZCgmc3RhdHMtPnBlbmRpbmcubG9jaywgMSk7DQo+ICAgICAgICAgKytzdGF0
cy0+bGlua19tYXBfY2FjaGVbdHhfcHJpdi0+bGlua19pZF07DQo+ICAgICAgICAgX19za2JfdW5s
aW5rKHNrYiwgJnN0YXRzLT5wZW5kaW5nKTsNCj4gLSAgICAgICBzcGluX3VubG9ja19iaCgmc3Rh
dHMtPnBlbmRpbmcubG9jayk7DQo+ICsgICAgICAgc3Bpbl91bmxvY2soJnN0YXRzLT5wZW5kaW5n
LmxvY2spOw0KPiAgICAgICAgIF9fc2tiX3F1ZXVlX3RhaWwoJnF1ZXVlLT5xdWV1ZSwgc2tiKTsN
Cj4gICAgICAgICBzcGluX3VubG9ja19iaCgmcXVldWUtPnF1ZXVlLmxvY2spOw0KPiAgICAgICAg
IHJldHVybiAwOw0KPiAtLQ0KPiAyLjIwLjENCj4gDQoNClJldmlld2VkLWJ5OiBKw6lyw7RtZSBQ
b3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+DQoNCi0tIA0KSsOpcsO0bWUgUG91
aWxsZXINCg0K
