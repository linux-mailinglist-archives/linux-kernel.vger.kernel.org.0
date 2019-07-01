Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F981065D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEAJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 05:29:27 -0400
Received: from mail-eopbgr20106.outbound.protection.outlook.com ([40.107.2.106]:43822
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbfEAJ3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUYEFJ/d9CzBlIQmgaigVK06BHrlyUyeyA0ldcLlxps=;
 b=EIKqxYr7ppxqIK7gwQd5FjEIXoxTrbFMaPE1Y+nV1MifWA2Dr7H4YZrWYQDyjpRv6Z0VNiuxwn/xuUNMgBV4B7FdCoJPQ0rOhxbkNGvHLK/4dGP/PMdLOH3vRs36YFhgUT7zrI0Ej3rHxQEgsNKUCXjpqteMnjVXUhIJiZysQHk=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2143.EURPRD10.PROD.OUTLOOK.COM (20.177.60.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Wed, 1 May 2019 09:29:11 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48b8:9cff:182:f3d8]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48b8:9cff:182:f3d8%2]) with mapi id 15.20.1856.008; Wed, 1 May 2019
 09:29:11 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH v2 6/6] soc/fsl/qe: qe.c: fold qe_get_num_of_snums into
 qe_snums_init
Thread-Topic: [PATCH v2 6/6] soc/fsl/qe: qe.c: fold qe_get_num_of_snums into
 qe_snums_init
Thread-Index: AQHVAABVwy8gTssBaU2it9Xt8hlR9w==
Date:   Wed, 1 May 2019 09:29:11 +0000
Message-ID: <20190501092841.9026-7-rasmus.villemoes@prevas.dk>
References: <20190430133615.25721-1-rasmus.villemoes@prevas.dk>
 <20190501092841.9026-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190501092841.9026-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::29) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e836d97-bd8c-46fa-76d8-08d6ce1777cb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR10MB2143;
x-ms-traffictypediagnostic: VI1PR10MB2143:
x-microsoft-antispam-prvs: <VI1PR10MB2143428AEB0092BC33890EA48A3B0@VI1PR10MB2143.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39850400004)(346002)(396003)(366004)(189003)(199004)(14454004)(81166006)(110136005)(54906003)(26005)(68736007)(8676002)(6512007)(4326008)(8976002)(486006)(74482002)(71200400001)(2906002)(7416002)(6486002)(72206003)(186003)(316002)(478600001)(2501003)(36756003)(6436002)(71190400001)(25786009)(1076003)(6506007)(2616005)(305945005)(3846002)(44832011)(256004)(11346002)(6116002)(5660300002)(8936002)(446003)(476003)(50226002)(76176011)(42882007)(7736002)(99286004)(66446008)(64756008)(53936002)(52116002)(107886003)(386003)(66066001)(66946007)(66476007)(102836004)(66556008)(81156014)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2143;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qhtg5M63n5P1md+BVAQm+hKvEjikUdMaUTcJaH0w8SqLKDIXU7pMHpXu1P5bm7rKwuZ21bFPGIHiGLIRZbPAyev4K95W3dW2ZhdGXqsqKRai3NP1JEyIhloraDesi7ZayHOGpo/s7wneVxc4pygWwbSeGylLv5uJcn52AxOVBiB+QVYSAIwggn0fSWciCJWPSm3gzTAbtOhiE7tdSL4vIdqQDjHZoh804xuSheu1u74uTRC1bmCPNQxeSJKG9V3SukB/KN5YICbE4HS+0KeJP9KAe0CNQKCG/6oBaX6wvI1PL4XvRcHLD3MseXmv9+WzGU2yWL1PLBPUZXQgtFLtI7w+gEiAoj8vPXH3J9mXZjj0H8LlL+SE6LwKfuu4vaO47auYekpljmpfsVfwCsjnz3vTaKrTk3TSy3ZWxkyxnmk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e836d97-bd8c-46fa-76d8-08d6ce1777cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 09:29:11.7492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNvbW1lbnQgIk5vIFFFIGV2ZXIgaGFzIGZld2VyIHRoYW4gMjggU05VTXMiIGlzIGZhbHNl
OyBlLmcuIHRoZQ0KTVBDODMwOSBoYXMgMTQuIFRoZSBjb2RlIHBhdGggcmV0dXJuaW5nIC1FSU5W
QUwgaXMgYWxzbyBhIHJlY2lwZSBmb3INCmluc3RhbnQgZGlzYXN0ZXIsIHNpbmNlIHRoZSBjYWxs
ZXIgKHFlX3NudW1zX2luaXQpIHVuY3JpdGljYWxseQ0KYXNzaWducyB0aGUgcmV0dXJuIHZhbHVl
IHRvIHRoZSB1bnNpZ25lZCBxZV9udW1fb2Zfc251bSwgYW5kIHdvdWxkDQp0aHVzIHByb2NlZWQg
dG8gYXR0ZW1wdCB0byBjb3B5IDRHQiBmcm9tIHNudW1faW5pdF80NltdIHRvIHRoZSBzbnVtW10N
CmFycmF5Lg0KDQpTbyBmb2xkIHRoZSBoYW5kbGluZyBvZiB0aGUgbGVnYWN5IGZzbCxxZS1udW0t
c251bXMgaW50bw0KcWVfc251bXNfaW5pdCwgYW5kIG1ha2Ugc3VyZSB3ZSBkbyBub3QgZW5kIHVw
IHVzaW5nIHRoZSBzbnVtX2luaXRfNDYNCmFycmF5IGluIGNhc2VzIG90aGVyIHRoYW4gdGhlIHR3
byB3aGVyZSB3ZSBrbm93IGl0IG1ha2VzIHNlbnNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBSYXNtdXMg
VmlsbGVtb2VzIDxyYXNtdXMudmlsbGVtb2VzQHByZXZhcy5kaz4NCi0tLQ0KIGRyaXZlcnMvc29j
L2ZzbC9xZS9xZS5jIHwgNDYgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9mc2wvcWUvcWUuYyBiL2RyaXZlcnMvc29jL2ZzbC9x
ZS9xZS5jDQppbmRleCAzMjVkNjg5Y2JmNWMuLjI3NmQ3ZDc4ZWJmYyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvc29jL2ZzbC9xZS9xZS5jDQorKysgYi9kcml2ZXJzL3NvYy9mc2wvcWUvcWUuYw0KQEAg
LTMwOCwyNCArMzA4LDMzIEBAIHN0YXRpYyB2b2lkIHFlX3NudW1zX2luaXQodm9pZCkNCiAJaW50
IGk7DQogDQogCWJpdG1hcF96ZXJvKHNudW1fc3RhdGUsIFFFX05VTV9PRl9TTlVNKTsNCisJcWVf
bnVtX29mX3NudW0gPSAyODsgLyogVGhlIGRlZmF1bHQgbnVtYmVyIG9mIHNudW0gZm9yIHRocmVh
ZHMgaXMgMjggKi8NCiAJcWUgPSBxZV9nZXRfZGV2aWNlX25vZGUoKTsNCiAJaWYgKHFlKSB7DQog
CQlpID0gb2ZfcHJvcGVydHlfcmVhZF92YXJpYWJsZV91OF9hcnJheShxZSwgImZzbCxxZS1zbnVt
cyIsDQogCQkJCQkJICAgICAgIHNudW1zLCAxLCBRRV9OVU1fT0ZfU05VTSk7DQotCQlvZl9ub2Rl
X3B1dChxZSk7DQogCQlpZiAoaSA+IDApIHsNCisJCQlvZl9ub2RlX3B1dChxZSk7DQogCQkJcWVf
bnVtX29mX3NudW0gPSBpOw0KIAkJCXJldHVybjsNCiAJCX0NCisJCS8qDQorCQkgKiBGYWxsIGJh
Y2sgdG8gbGVnYWN5IGJpbmRpbmcgb2YgdXNpbmcgdGhlIHZhbHVlIG9mDQorCQkgKiBmc2wscWUt
bnVtLXNudW1zIHRvIGNob29zZSBvbmUgb2YgdGhlIHN0YXRpYyBhcnJheXMNCisJCSAqIGFib3Zl
Lg0KKwkJICovDQorCQlvZl9wcm9wZXJ0eV9yZWFkX3UzMihxZSwgImZzbCxxZS1udW0tc251bXMi
LCAmcWVfbnVtX29mX3NudW0pOw0KKwkJb2Zfbm9kZV9wdXQocWUpOw0KIAl9DQogDQotCXFlX251
bV9vZl9zbnVtID0gcWVfZ2V0X251bV9vZl9zbnVtcygpOw0KLQ0KLQlpZiAocWVfbnVtX29mX3Nu
dW0gPT0gNzYpDQorCWlmIChxZV9udW1fb2Zfc251bSA9PSA3Nikgew0KIAkJc251bV9pbml0ID0g
c251bV9pbml0Xzc2Ow0KLQllbHNlDQorCX0gZWxzZSBpZiAocWVfbnVtX29mX3NudW0gPT0gMjgg
fHwgcWVfbnVtX29mX3NudW0gPT0gNDYpIHsNCiAJCXNudW1faW5pdCA9IHNudW1faW5pdF80NjsN
Ci0NCisJfSBlbHNlIHsNCisJCXByX2VycigiUUU6IHVuc3VwcG9ydGVkIHZhbHVlIG9mIGZzbCxx
ZS1udW0tc251bXM6ICV1XG4iLCBxZV9udW1fb2Zfc251bSk7DQorCQlyZXR1cm47DQorCX0NCiAJ
bWVtY3B5KHNudW1zLCBzbnVtX2luaXQsIHFlX251bV9vZl9zbnVtKTsNCiB9DQogDQpAQCAtNjQx
LDMwICs2NTAsNyBAQCBFWFBPUlRfU1lNQk9MKHFlX2dldF9udW1fb2ZfcmlzYyk7DQogDQogdW5z
aWduZWQgaW50IHFlX2dldF9udW1fb2Zfc251bXModm9pZCkNCiB7DQotCXN0cnVjdCBkZXZpY2Vf
bm9kZSAqcWU7DQotCWludCBzaXplOw0KLQl1bnNpZ25lZCBpbnQgbnVtX29mX3NudW1zOw0KLQlj
b25zdCB1MzIgKnByb3A7DQotDQotCW51bV9vZl9zbnVtcyA9IDI4OyAvKiBUaGUgZGVmYXVsdCBu
dW1iZXIgb2Ygc251bSBmb3IgdGhyZWFkcyBpcyAyOCAqLw0KLQlxZSA9IHFlX2dldF9kZXZpY2Vf
bm9kZSgpOw0KLQlpZiAoIXFlKQ0KLQkJcmV0dXJuIG51bV9vZl9zbnVtczsNCi0NCi0JcHJvcCA9
IG9mX2dldF9wcm9wZXJ0eShxZSwgImZzbCxxZS1udW0tc251bXMiLCAmc2l6ZSk7DQotCWlmIChw
cm9wICYmIHNpemUgPT0gc2l6ZW9mKCpwcm9wKSkgew0KLQkJbnVtX29mX3NudW1zID0gKnByb3A7
DQotCQlpZiAoKG51bV9vZl9zbnVtcyA8IDI4KSB8fCAobnVtX29mX3NudW1zID4gUUVfTlVNX09G
X1NOVU0pKSB7DQotCQkJLyogTm8gUUUgZXZlciBoYXMgZmV3ZXIgdGhhbiAyOCBTTlVNcyAqLw0K
LQkJCXByX2VycigiUUU6IG51bWJlciBvZiBzbnVtIGlzIGludmFsaWRcbiIpOw0KLQkJCW9mX25v
ZGVfcHV0KHFlKTsNCi0JCQlyZXR1cm4gLUVJTlZBTDsNCi0JCX0NCi0JfQ0KLQ0KLQlvZl9ub2Rl
X3B1dChxZSk7DQotDQotCXJldHVybiBudW1fb2Zfc251bXM7DQorCXJldHVybiBxZV9udW1fb2Zf
c251bTsNCiB9DQogRVhQT1JUX1NZTUJPTChxZV9nZXRfbnVtX29mX3NudW1zKTsNCiANCi0tIA0K
Mi4yMC4xDQoNCg==
