Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31B91B4A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 13:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfEMLPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 07:15:07 -0400
Received: from mail-eopbgr60122.outbound.protection.outlook.com ([40.107.6.122]:15428
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729326AbfEMLPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo+O+Ii8OjvSUslmDWw61z/f9fV+jOgr8GgArqpHKfw=;
 b=aqkUGtatxVjttxBZ+t+QTNz64cj3yK/rkJ2bzYdu2raifP1n3OhPgAqA3bLGdkwlwv0O977ilpKxz8KFeZQZxC23nfc/s+EFoURG1+ZhclRtFpcA/EFNKOVosKYMhdn69GjLsKidXz5Us7p9WG6BovIYvg8tLMUp1JKSiFDj7PA=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB1950.EURPRD10.PROD.OUTLOOK.COM (52.134.27.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 13 May 2019 11:14:57 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48b8:9cff:182:f3d8]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48b8:9cff:182:f3d8%2]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 11:14:57 +0000
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
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH v3 3/6] soc/fsl/qe: qe.c: introduce qe_get_device_node helper
Thread-Topic: [PATCH v3 3/6] soc/fsl/qe: qe.c: introduce qe_get_device_node
 helper
Thread-Index: AQHVCX0ZmfxjQSeIP0i7kbKp8jFn9w==
Date:   Mon, 13 May 2019 11:14:57 +0000
Message-ID: <20190513111442.25724-4-rasmus.villemoes@prevas.dk>
References: <20190501092841.9026-1-rasmus.villemoes@prevas.dk>
 <20190513111442.25724-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190513111442.25724-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::32) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f06e736-9291-4630-cb62-08d6d7943b77
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR10MB1950;
x-ms-traffictypediagnostic: VI1PR10MB1950:
x-microsoft-antispam-prvs: <VI1PR10MB1950451F180E09105A4F087E8A0F0@VI1PR10MB1950.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(366004)(376002)(136003)(396003)(189003)(199004)(6512007)(66066001)(53936002)(107886003)(52116002)(68736007)(256004)(71200400001)(71190400001)(76176011)(6436002)(478600001)(6486002)(1076003)(36756003)(5660300002)(72206003)(74482002)(446003)(81156014)(8676002)(14454004)(99286004)(2501003)(66946007)(66476007)(66556008)(64756008)(66446008)(73956011)(54906003)(11346002)(2616005)(42882007)(476003)(81166006)(44832011)(50226002)(486006)(8936002)(110136005)(8976002)(6116002)(7416002)(316002)(3846002)(2906002)(305945005)(7736002)(186003)(25786009)(102836004)(6506007)(386003)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB1950;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ArtsQHOM0nwZbifYlvn6D8HfGnYeem7j6DNy57LCKPip+6AzhUJnsxVJah7P4pb5hAd9XoOxN+otW3l09psRgWNMGdGYvlmlIezYQXD3TVwuWd2fNh+/F7TjJmMWFXE1JVifDLtuiB8F0I8rJFegC4M/76k/OOwB1bP4kA09j6klALCbOQ6MTi55efL3IjH51MQM8o9z1jeg8CK3uXbAgaWW44zG3+ngTRRgx1j8afZhD1iYMJ4Bk+S2PAQeoBr6swUjmVhmzimQoIytlHd3lS1a1bt3oPLUGnjZA0xfaz7JyBRTwogNgQZX9D8yEEuPuVG86pFofzkT6TB0gZXqlaZIPy+xeHsYpt/HBS/u2lnEQm7Wuh32A+jtX/BS+7NVvgAUW6Be+uqs3gk7WW/twTK+8CgLnrVqBXf6VOhWj9c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f06e736-9291-4630-cb62-08d6d7943b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 11:14:57.4903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1950
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlICd0cnkgb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgImZzbCxxZSIpLCBm
YWxsIGJhY2sgdG8NCm9mX2ZpbmRfbm9kZV9ieV90eXBlKE5VTEwsICJxZSIpJyBwYXR0ZXJuIGlz
IHJlcGVhdGVkIGZpdmUNCnRpbWVzLiBGYWN0b3IgaXQgaW50byBhIGNvbW1vbiBoZWxwZXIuDQoN
ClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGMtcy5mcj4N
ClJldmlld2VkLWJ5OiBRaWFuZyBaaGFvIDxxaWFuZy56aGFvQG54cC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBSYXNtdXMgVmlsbGVtb2VzIDxyYXNtdXMudmlsbGVtb2VzQHByZXZhcy5kaz4NCi0tLQ0K
IGRyaXZlcnMvc29jL2ZzbC9xZS9xZS5jIHwgNzEgKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgNDIgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9mc2wvcWUvcWUuYyBiL2RyaXZl
cnMvc29jL2ZzbC9xZS9xZS5jDQppbmRleCA0YjU5MTA5ZGYyMmIuLjRiNDQ0ODQ2ZDU5MCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvc29jL2ZzbC9xZS9xZS5jDQorKysgYi9kcml2ZXJzL3NvYy9mc2wv
cWUvcWUuYw0KQEAgLTU2LDYgKzU2LDIwIEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgcWVfbnVtX29m
X3NudW07DQogDQogc3RhdGljIHBoeXNfYWRkcl90IHFlYmFzZSA9IC0xOw0KIA0KK3N0YXRpYyBz
dHJ1Y3QgZGV2aWNlX25vZGUgKnFlX2dldF9kZXZpY2Vfbm9kZSh2b2lkKQ0KK3sNCisJc3RydWN0
IGRldmljZV9ub2RlICpxZTsNCisNCisJLyoNCisJICogTmV3ZXIgZGV2aWNlIHRyZWVzIGhhdmUg
YW4gImZzbCxxZSIgY29tcGF0aWJsZSBwcm9wZXJ0eSBmb3IgdGhlIFFFDQorCSAqIG5vZGUsIGJ1
dCB3ZSBzdGlsbCBuZWVkIHRvIHN1cHBvcnQgb2xkZXIgZGV2aWNlIHRyZWVzLg0KKwkgKi8NCisJ
cWUgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiZnNsLHFlIik7DQorCWlm
IChxZSkNCisJCXJldHVybiBxZTsNCisJcmV0dXJuIG9mX2ZpbmRfbm9kZV9ieV90eXBlKE5VTEws
ICJxZSIpOw0KK30NCisNCiBzdGF0aWMgcGh5c19hZGRyX3QgZ2V0X3FlX2Jhc2Uodm9pZCkNCiB7
DQogCXN0cnVjdCBkZXZpY2Vfbm9kZSAqcWU7DQpAQCAtNjUsMTIgKzc5LDkgQEAgc3RhdGljIHBo
eXNfYWRkcl90IGdldF9xZV9iYXNlKHZvaWQpDQogCWlmIChxZWJhc2UgIT0gLTEpDQogCQlyZXR1
cm4gcWViYXNlOw0KIA0KLQlxZSA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEws
ICJmc2wscWUiKTsNCi0JaWYgKCFxZSkgew0KLQkJcWUgPSBvZl9maW5kX25vZGVfYnlfdHlwZShO
VUxMLCAicWUiKTsNCi0JCWlmICghcWUpDQotCQkJcmV0dXJuIHFlYmFzZTsNCi0JfQ0KKwlxZSA9
IHFlX2dldF9kZXZpY2Vfbm9kZSgpOw0KKwlpZiAoIXFlKQ0KKwkJcmV0dXJuIHFlYmFzZTsNCiAN
CiAJcmV0ID0gb2ZfYWRkcmVzc190b19yZXNvdXJjZShxZSwgMCwgJnJlcyk7DQogCWlmICghcmV0
KQ0KQEAgLTE2NCwxMiArMTc1LDkgQEAgdW5zaWduZWQgaW50IHFlX2dldF9icmdfY2xrKHZvaWQp
DQogCWlmIChicmdfY2xrKQ0KIAkJcmV0dXJuIGJyZ19jbGs7DQogDQotCXFlID0gb2ZfZmluZF9j
b21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgImZzbCxxZSIpOw0KLQlpZiAoIXFlKSB7DQotCQlx
ZSA9IG9mX2ZpbmRfbm9kZV9ieV90eXBlKE5VTEwsICJxZSIpOw0KLQkJaWYgKCFxZSkNCi0JCQly
ZXR1cm4gYnJnX2NsazsNCi0JfQ0KKwlxZSA9IHFlX2dldF9kZXZpY2Vfbm9kZSgpOw0KKwlpZiAo
IXFlKQ0KKwkJcmV0dXJuIGJyZ19jbGs7DQogDQogCXByb3AgPSBvZl9nZXRfcHJvcGVydHkocWUs
ICJicmctZnJlcXVlbmN5IiwgJnNpemUpOw0KIAlpZiAocHJvcCAmJiBzaXplID09IHNpemVvZigq
cHJvcCkpDQpAQCAtNTU4LDE2ICs1NjYsOSBAQCBzdHJ1Y3QgcWVfZmlybXdhcmVfaW5mbyAqcWVf
Z2V0X2Zpcm13YXJlX2luZm8odm9pZCkNCiANCiAJaW5pdGlhbGl6ZWQgPSAxOw0KIA0KLQkvKg0K
LQkgKiBOZXdlciBkZXZpY2UgdHJlZXMgaGF2ZSBhbiAiZnNsLHFlIiBjb21wYXRpYmxlIHByb3Bl
cnR5IGZvciB0aGUgUUUNCi0JICogbm9kZSwgYnV0IHdlIHN0aWxsIG5lZWQgdG8gc3VwcG9ydCBv
bGRlciBkZXZpY2UgdHJlZXMuDQotCSovDQotCXFlID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUo
TlVMTCwgTlVMTCwgImZzbCxxZSIpOw0KLQlpZiAoIXFlKSB7DQotCQlxZSA9IG9mX2ZpbmRfbm9k
ZV9ieV90eXBlKE5VTEwsICJxZSIpOw0KLQkJaWYgKCFxZSkNCi0JCQlyZXR1cm4gTlVMTDsNCi0J
fQ0KKwlxZSA9IHFlX2dldF9kZXZpY2Vfbm9kZSgpOw0KKwlpZiAoIXFlKQ0KKwkJcmV0dXJuIE5V
TEw7DQogDQogCS8qIEZpbmQgdGhlICdmaXJtd2FyZScgY2hpbGQgbm9kZSAqLw0KIAlmdyA9IG9m
X2dldF9jaGlsZF9ieV9uYW1lKHFlLCAiZmlybXdhcmUiKTsNCkBAIC02MTMsMTYgKzYxNCw5IEBA
IHVuc2lnbmVkIGludCBxZV9nZXRfbnVtX29mX3Jpc2Modm9pZCkNCiAJdW5zaWduZWQgaW50IG51
bV9vZl9yaXNjID0gMDsNCiAJY29uc3QgdTMyICpwcm9wOw0KIA0KLQlxZSA9IG9mX2ZpbmRfY29t
cGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJmc2wscWUiKTsNCi0JaWYgKCFxZSkgew0KLQkJLyog
T2xkZXIgZGV2aWNlcyB0cmVlcyBkaWQgbm90IGhhdmUgYW4gImZzbCxxZSINCi0JCSAqIGNvbXBh
dGlibGUgcHJvcGVydHksIHNvIHdlIG5lZWQgdG8gbG9vayBmb3INCi0JCSAqIHRoZSBRRSBub2Rl
IGJ5IG5hbWUuDQotCQkgKi8NCi0JCXFlID0gb2ZfZmluZF9ub2RlX2J5X3R5cGUoTlVMTCwgInFl
Iik7DQotCQlpZiAoIXFlKQ0KLQkJCXJldHVybiBudW1fb2ZfcmlzYzsNCi0JfQ0KKwlxZSA9IHFl
X2dldF9kZXZpY2Vfbm9kZSgpOw0KKwlpZiAoIXFlKQ0KKwkJcmV0dXJuIG51bV9vZl9yaXNjOw0K
IA0KIAlwcm9wID0gb2ZfZ2V0X3Byb3BlcnR5KHFlLCAiZnNsLHFlLW51bS1yaXNjcyIsICZzaXpl
KTsNCiAJaWYgKHByb3AgJiYgc2l6ZSA9PSBzaXplb2YoKnByb3ApKQ0KQEAgLTY0MiwxNiArNjM2
LDkgQEAgdW5zaWduZWQgaW50IHFlX2dldF9udW1fb2Zfc251bXModm9pZCkNCiAJY29uc3QgdTMy
ICpwcm9wOw0KIA0KIAludW1fb2Zfc251bXMgPSAyODsgLyogVGhlIGRlZmF1bHQgbnVtYmVyIG9m
IHNudW0gZm9yIHRocmVhZHMgaXMgMjggKi8NCi0JcWUgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9k
ZShOVUxMLCBOVUxMLCAiZnNsLHFlIik7DQotCWlmICghcWUpIHsNCi0JCS8qIE9sZGVyIGRldmlj
ZXMgdHJlZXMgZGlkIG5vdCBoYXZlIGFuICJmc2wscWUiDQotCQkgKiBjb21wYXRpYmxlIHByb3Bl
cnR5LCBzbyB3ZSBuZWVkIHRvIGxvb2sgZm9yDQotCQkgKiB0aGUgUUUgbm9kZSBieSBuYW1lLg0K
LQkJICovDQotCQlxZSA9IG9mX2ZpbmRfbm9kZV9ieV90eXBlKE5VTEwsICJxZSIpOw0KLQkJaWYg
KCFxZSkNCi0JCQlyZXR1cm4gbnVtX29mX3NudW1zOw0KLQl9DQorCXFlID0gcWVfZ2V0X2Rldmlj
ZV9ub2RlKCk7DQorCWlmICghcWUpDQorCQlyZXR1cm4gbnVtX29mX3NudW1zOw0KIA0KIAlwcm9w
ID0gb2ZfZ2V0X3Byb3BlcnR5KHFlLCAiZnNsLHFlLW51bS1zbnVtcyIsICZzaXplKTsNCiAJaWYg
KHByb3AgJiYgc2l6ZSA9PSBzaXplb2YoKnByb3ApKSB7DQotLSANCjIuMjAuMQ0KDQo=
