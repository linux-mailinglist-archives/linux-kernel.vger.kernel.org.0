Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A180CFA93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfD3Ng4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 09:36:56 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com ([40.107.8.102]:31555
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfD3Ngz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnO0q2oPfxnnC3fB8XigbmuveP9dsgWT5X45K2MEwPA=;
 b=iL3toJ5Z9tJf+kM8s8Y9v4IioJeRo2R+pbkqvV16FlEk+5KFNIPd6mBYTszw8JlGslfbuhYbxdw1WN0ALCD///vKwS2zPyreKPR7okhWYkJRedz2kQZ2JtKz1cr+iixfjJ0s4efiGOGzXktnyKVf4nlgydoJ/eyxqdiJrNq+uy4=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB0735.EURPRD10.PROD.OUTLOOK.COM (10.167.203.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 13:36:33 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48b8:9cff:182:f3d8]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48b8:9cff:182:f3d8%2]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 13:36:33 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH 4/5] soc/fsl/qe: qe.c: support fsl,qe-snums property
Thread-Topic: [PATCH 4/5] soc/fsl/qe: qe.c: support fsl,qe-snums property
Thread-Index: AQHU/1m5/ppidONGckmXHq9mm5btWw==
Date:   Tue, 30 Apr 2019 13:36:33 +0000
Message-ID: <20190430133615.25721-5-rasmus.villemoes@prevas.dk>
References: <20190430133615.25721-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190430133615.25721-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::15) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [5.186.118.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80a6e09c-05d1-4323-12b5-08d6cd70dc17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR10MB0735;
x-ms-traffictypediagnostic: VI1PR10MB0735:
x-microsoft-antispam-prvs: <VI1PR10MB0735F4C16E547E7B7B20B7DF8A3A0@VI1PR10MB0735.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39850400004)(366004)(376002)(346002)(40224003)(199004)(189003)(81156014)(36756003)(8676002)(6436002)(478600001)(81166006)(107886003)(50226002)(52116002)(8976002)(8936002)(74482002)(72206003)(4326008)(7736002)(6486002)(6506007)(386003)(25786009)(1076003)(53936002)(54906003)(76176011)(305945005)(110136005)(316002)(99286004)(14454004)(6512007)(476003)(11346002)(446003)(5660300002)(44832011)(66446008)(26005)(73956011)(42882007)(2616005)(6116002)(2906002)(71200400001)(66556008)(66476007)(64756008)(66066001)(97736004)(66946007)(3846002)(256004)(68736007)(71446004)(186003)(486006)(102836004)(71190400001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB0735;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +U02E9WoIVtOiHzYRRORe2YnVu1SS4BWueGXCxA1AqOSLAM2KfX1b6RvQFF16GXSe6hxlp2K/cpXWG9KkWgeo+aIKh4570AjJuKhMFWDgxzVk+JRTOomi/doY87Q49Ps9oP0NzK6r+5AuExyFTrPJonmMpLieG2ai+HlJVLMq8sowgJFF39JJyoXHGTPhN94sZRBYhjbPRPAUeZDfASmfdVvfQO/mwgu9zYEvogdHvn69iHUrFiJIPFJ3VE+NY9viVlhIw659Qsgx76xqhKCjsGI837vi/HaITpxlemMVNrp0gQyOMQRhtEXR87Ah6sP2V9HmGKFd4xEmJpsAE7EH1XbZzLp46+UNWUO7MKuNrsNicB9MvPfSDauGRO4FGXHMszlvzqikKOyabFvmzOzrS4DKYGfFTdvU4q2vV8UdbY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a6e09c-05d1-4323-12b5-08d6cd70dc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 13:36:33.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGN1cnJlbnQgY29kZSBhc3N1bWVzIHRoYXQgdGhlIHNldCBvZiBzbnVtIF92YWx1ZXNfIHRv
IHBvcHVsYXRlIHRoZQ0Kc251bXNbXSBhcnJheSB3aXRoIGlzIGEgZnVuY3Rpb24gb2YgdGhlIF9u
dW1iZXJfIG9mIHNudW1zDQphbG9uZS4gSG93ZXZlciwgcmVhZGluZyB0YWJsZSA0LTMwLCBhbmQg
aXRzIGZvb3Rub3Rlcywgb2YgdGhlIFFVSUNDDQpFbmdpbmUgQmxvY2sgUmVmZXJlbmNlIE1hbnVh
bCBzaG93cyB0aGF0IHRoYXQgaXMgYSBiaXQgdG9vIG5haXZlLg0KDQpBcyBhbiBhbHRlcm5hdGl2
ZSwgdGhpcyBpbnRyb2R1Y2VzIGEgbmV3IGJpbmRpbmcgZnNsLHFlLXNudW1zLCB3aGljaA0KYXV0
b21hdGljYWxseSBlbmNvZGVzIGJvdGggdGhlIG51bWJlciBvZiBzbnVtcyBhbmQgdGhlIGFjdHVh
bCB2YWx1ZXMgdG8NCnVzZS4gQ29udmVuaWVudGx5LCBvZl9wcm9wZXJ0eV9yZWFkX3ZhcmlhYmxl
X3U4X2FycmF5IGRvZXMgZXhhY3RseQ0Kd2hhdCB3ZSBuZWVkLg0KDQpGb3IgZXhhbXBsZSwgZm9y
IHRoZSBNUEM4MzA5LCBvbmUgd291bGQgc3BlY2lmeSB0aGUgcHJvcGVydHkgYXMNCg0KICAgICAg
ICAgICAgICAgZnNsLHFlLXNudW1zID0gL2JpdHMvIDggPA0KICAgICAgICAgICAgICAgICAgICAg
ICAweDg4IDB4ODkgMHg5OCAweDk5IDB4YTggMHhhOSAweGI4IDB4YjkNCiAgICAgICAgICAgICAg
ICAgICAgICAgMHhjOCAweGM5IDB4ZDggMHhkOSAweGU4IDB4ZTk+Ow0KDQpTaWduZWQtb2ZmLWJ5
OiBSYXNtdXMgVmlsbGVtb2VzIDxyYXNtdXMudmlsbGVtb2VzQHByZXZhcy5kaz4NCi0tLQ0KIC4u
Li9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9mc2wvY3BtX3FlL3FlLnR4dCAgICAgIHwgIDggKysr
KysrKy0NCiBkcml2ZXJzL3NvYy9mc2wvcWUvcWUuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8IDE0ICsrKysrKysrKysrKystDQogMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvYy9mc2wvY3BtX3FlL3FlLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb2MvZnNsL2NwbV9xZS9xZS50eHQNCmluZGV4IGQ3YWZhZmY1ZmFmZi4uMDVm
NWY0ODU1NjJhIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9mc2wvY3BtX3FlL3FlLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvYy9mc2wvY3BtX3FlL3FlLnR4dA0KQEAgLTE4LDcgKzE4LDggQEAgUmVxdWlyZWQg
cHJvcGVydGllczoNCiAtIHJlZyA6IG9mZnNldCBhbmQgbGVuZ3RoIG9mIHRoZSBkZXZpY2UgcmVn
aXN0ZXJzLg0KIC0gYnVzLWZyZXF1ZW5jeSA6IHRoZSBjbG9jayBmcmVxdWVuY3kgZm9yIFFVSUND
IEVuZ2luZS4NCiAtIGZzbCxxZS1udW0tcmlzY3M6IGRlZmluZSBob3cgbWFueSBSSVNDIGVuZ2lu
ZXMgdGhlIFFFIGhhcy4NCi0tIGZzbCxxZS1udW0tc251bXM6IGRlZmluZSBob3cgbWFueSBzZXJp
YWwgbnVtYmVyKFNOVU0pIHRoZSBRRSBjYW4gdXNlIGZvciB0aGUNCistIGZzbCxxZS1zbnVtczog
VGhpcyBwcm9wZXJ0eSBoYXMgdG8gYmUgc3BlY2lmaWVkIGFzICcvYml0cy8gOCcgdmFsdWUsDQor
ICBkZWZpbmluZyB0aGUgYXJyYXkgb2Ygc2VyaWFsIG51bWJlciAoU05VTSkgdmFsdWVzIGZvciB0
aGUgdmlydHVhbA0KICAgdGhyZWFkcy4NCiANCiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KQEAgLTM0
LDYgKzM1LDExIEBAIFJlY29tbWVuZGVkIHByb3BlcnRpZXMNCiAtIGJyZy1mcmVxdWVuY3kgOiB0
aGUgaW50ZXJuYWwgY2xvY2sgc291cmNlIGZyZXF1ZW5jeSBmb3IgYmF1ZC1yYXRlDQogICBnZW5l
cmF0b3JzIGluIEh6Lg0KIA0KK0RlcHJlY2F0ZWQgcHJvcGVydGllcw0KKy0gZnNsLHFlLW51bS1z
bnVtczogZGVmaW5lIGhvdyBtYW55IHNlcmlhbCBudW1iZXIoU05VTSkgdGhlIFFFIGNhbiB1c2UN
CisgIGZvciB0aGUgdGhyZWFkcy4gVXNlIGZzbCxxZS1zbnVtcyBpbnN0ZWFkIHRvIG5vdCBvbmx5
IHNwZWNpZnkgdGhlDQorICBudW1iZXIgb2Ygc251bXMsIGJ1dCBhbHNvIHRoZWlyIHZhbHVlcy4N
CisNCiBFeGFtcGxlOg0KICAgICAgcWVAZTAxMDAwMDAgew0KIAkjYWRkcmVzcy1jZWxscyA9IDwx
PjsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9mc2wvcWUvcWUuYyBiL2RyaXZlcnMvc29jL2Zz
bC9xZS9xZS5jDQppbmRleCBhZmY5ZDEzNzM1MjkuLmFmM2MyYjJiMjY4ZiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvc29jL2ZzbC9xZS9xZS5jDQorKysgYi9kcml2ZXJzL3NvYy9mc2wvcWUvcWUuYw0K
QEAgLTI4Myw3ICsyODMsNiBAQCBFWFBPUlRfU1lNQk9MKHFlX2Nsb2NrX3NvdXJjZSk7DQogICov
DQogc3RhdGljIHZvaWQgcWVfc251bXNfaW5pdCh2b2lkKQ0KIHsNCi0JaW50IGk7DQogCXN0YXRp
YyBjb25zdCB1OCBzbnVtX2luaXRfNzZbXSA9IHsNCiAJCTB4MDQsIDB4MDUsIDB4MEMsIDB4MEQs
IDB4MTQsIDB4MTUsIDB4MUMsIDB4MUQsDQogCQkweDI0LCAweDI1LCAweDJDLCAweDJELCAweDM0
LCAweDM1LCAweDg4LCAweDg5LA0KQEAgLTMwNCw5ICszMDMsMjIgQEAgc3RhdGljIHZvaWQgcWVf
c251bXNfaW5pdCh2b2lkKQ0KIAkJMHgyOCwgMHgyOSwgMHgzOCwgMHgzOSwgMHg0OCwgMHg0OSwg
MHg1OCwgMHg1OSwNCiAJCTB4NjgsIDB4NjksIDB4NzgsIDB4NzksIDB4ODAsIDB4ODEsDQogCX07
DQorCXN0cnVjdCBkZXZpY2Vfbm9kZSAqcWU7DQogCWNvbnN0IHU4ICpzbnVtX2luaXQ7DQorCWlu
dCBpOw0KIA0KIAliaXRtYXBfemVybyhzbnVtX3N0YXRlLCBRRV9OVU1fT0ZfU05VTSk7DQorCXFl
ID0gcWVfZ2V0X2RldmljZV9ub2RlKCk7DQorCWlmIChxZSkgew0KKwkJaSA9IG9mX3Byb3BlcnR5
X3JlYWRfdmFyaWFibGVfdThfYXJyYXkocWUsICJmc2wscWUtc251bXMiLA0KKwkJCQkJCSAgICAg
ICBzbnVtcywgMSwgUUVfTlVNX09GX1NOVU0pOw0KKwkJb2Zfbm9kZV9wdXQocWUpOw0KKwkJaWYg
KGkgPiAwKSB7DQorCQkJcWVfbnVtX29mX3NudW0gPSBpOw0KKwkJCXJldHVybjsNCisJCX0NCisJ
fQ0KKw0KIAlxZV9udW1fb2Zfc251bSA9IHFlX2dldF9udW1fb2Zfc251bXMoKTsNCiANCiAJaWYg
KHFlX251bV9vZl9zbnVtID09IDc2KQ0KLS0gDQoyLjIwLjENCg0K
