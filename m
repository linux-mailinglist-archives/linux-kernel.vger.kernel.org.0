Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E2F1BAA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfEMQKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 12:10:06 -0400
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:56750
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731370AbfEMQKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YHAB7hm+2Qkl+vJndcW7OvIuXz3XCzRggxl87yNBWA=;
 b=Eud+SEZ+DkOJcIRFftpJvoPDyivpjN6MZzCIVXu4By+wEgMxJKxQIXomufGftl3VlZ5uxPSQIlR/A5bncg5FOegFZdkqY43wHBzLXIZkOTbKFXDQfhuW/Qcz33JxcSId0QEc0/ES5Dt+5UaVf0mUAdjqntdazFkg2MU3FKGY2KY=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2709.eurprd04.prod.outlook.com (10.172.246.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Mon, 13 May 2019 16:09:50 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e194:a71a:3497:783e]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e194:a71a:3497:783e%8]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 16:09:50 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v1 6/8] soc/fsl/qbman: Disable interrupts during portal
 recovery
Thread-Topic: [PATCH v1 6/8] soc/fsl/qbman: Disable interrupts during portal
 recovery
Thread-Index: AQHVCaZK9cvLv/ldPUKlp6HGmAvNlw==
Date:   Mon, 13 May 2019 16:09:50 +0000
Message-ID: <1557763756-24118-7-git-send-email-roy.pledge@nxp.com>
References: <1557763756-24118-1-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1557763756-24118-1-git-send-email-roy.pledge@nxp.com>
Reply-To: Roy Pledge <roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SN4PR0501CA0144.namprd05.prod.outlook.com
 (2603:10b6:803:2c::22) To DB6PR0402MB2727.eurprd04.prod.outlook.com
 (2603:10a6:4:98::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc9e0975-9111-41d4-b3dc-08d6d7bd6d15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR0402MB2709;
x-ms-traffictypediagnostic: DB6PR0402MB2709:
x-microsoft-antispam-prvs: <DB6PR0402MB270990D90222DCAB26AB9531860F0@DB6PR0402MB2709.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(8936002)(2201001)(110136005)(54906003)(316002)(476003)(2501003)(86362001)(2616005)(50226002)(2906002)(66556008)(64756008)(66446008)(66946007)(66476007)(73956011)(478600001)(3450700001)(6636002)(305945005)(5660300002)(386003)(6506007)(102836004)(43066004)(6486002)(7736002)(26005)(186003)(6436002)(66066001)(4326008)(446003)(36756003)(99286004)(486006)(25786009)(11346002)(76176011)(52116002)(53936002)(44832011)(6512007)(8676002)(14454004)(68736007)(71200400001)(14444005)(256004)(3846002)(71190400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2709;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PuTVDgPh6SPFdy8Z60cRIlF+kt/LXulCyxMot3Ef9B2SwhtbQodArXMWDVcXrqjvdmzbpeNe/A9k+xttUNHvZbs2EKmgP9epKWoW9S1XuyX1DMJKX3XSrmRJBy1Geo7WsRPGPq8q/SIIrzzG24zAZ08vdQSbTrsRiAzl1JSbFmseuno+qwXOLverl+7pgRn+3m0qEiZ+1W4W1IyuhxXA3r5C0aWhxPNGx2in6fWxu4+UBu3YzhE7UFjmma8cLJukBHxidR0rpWbBwBzIPjYpPdBnVTRX2RzTxyky+I30DkPMEHNkdsHkP0bzl1+GNspa76xs/KgudhxlGMEmWnHVQ8wbvvvpVgm0NIC75Yd+L+5wweJaH0ft05kMtq5QToCXtoCeaxz0dw3HFwsizyGjvPyDernrSxm1pcc3DDW4Szs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9e0975-9111-41d4-b3dc-08d6d7bd6d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 16:09:50.2176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2709
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGlzYWJsZSB0aGUgUUJNYW4gaW50ZXJydXB0cyBkdXJpbmcgcmVjb3ZlcnkuDQoNClNpZ25lZC1v
ZmYtYnk6IFJveSBQbGVkZ2UgPHJveS5wbGVkZ2VAbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29j
L2ZzbC9xYm1hbi9xbWFuLmMgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKystLS0NCiBkcml2
ZXJzL3NvYy9mc2wvcWJtYW4vcW1hbl9jY3NyLmMgfCAgMSArDQogZHJpdmVycy9zb2MvZnNsL3Fi
bWFuL3FtYW5fcHJpdi5oIHwgIDEgKw0KIDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9x
bWFuLmMgYi9kcml2ZXJzL3NvYy9mc2wvcWJtYW4vcW1hbi5jDQppbmRleCAyOTg5NTA0Li40YTk5
Y2U1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvZnNsL3FibWFuL3FtYW4uYw0KKysrIGIvZHJp
dmVycy9zb2MvZnNsL3FibWFuL3FtYW4uYw0KQEAgLTEwNzAsNiArMTA3MCwyMCBAQCBpbnQgcW1h
bl93cV9hbGxvYyh2b2lkKQ0KIAlyZXR1cm4gMDsNCiB9DQogDQorDQordm9pZCBxbWFuX2VuYWJs
ZV9pcnFzKHZvaWQpDQorew0KKwlpbnQgaTsNCisNCisJZm9yIChpID0gMDsgaSA8IG51bV9wb3Nz
aWJsZV9jcHVzKCk7IGkrKykgew0KKwkJaWYgKGFmZmluZV9wb3J0YWxzW2ldKSB7DQorCQkJcW1f
b3V0KCZhZmZpbmVfcG9ydGFsc1tpXS0+cCwgUU1fUkVHX0lTUiwgMHhmZmZmZmZmZik7DQorCQkJ
cW1fb3V0KCZhZmZpbmVfcG9ydGFsc1tpXS0+cCwgUU1fUkVHX0lJUiwgMCk7DQorCQl9DQorDQor
CX0NCit9DQorDQogLyoNCiAgKiBUaGlzIGlzIHdoYXQgZXZlcnl0aGluZyBjYW4gd2FpdCBvbiwg
ZXZlbiBpZiBpdCBtaWdyYXRlcyB0byBhIGRpZmZlcmVudCBjcHUNCiAgKiB0byB0aGUgb25lIHdo
b3NlIGFmZmluZSBwb3J0YWwgaXQgaXMgd2FpdGluZyBvbi4NCkBAIC0xMjY5LDggKzEyODMsOCBA
QCBzdGF0aWMgaW50IHFtYW5fY3JlYXRlX3BvcnRhbChzdHJ1Y3QgcW1hbl9wb3J0YWwgKnBvcnRh
bCwNCiAJcW1fb3V0KHAsIFFNX1JFR19JU0RSLCBpc2RyKTsNCiAJcG9ydGFsLT5pcnFfc291cmNl
cyA9IDA7DQogCXFtX291dChwLCBRTV9SRUdfSUVSLCAwKTsNCi0JcW1fb3V0KHAsIFFNX1JFR19J
U1IsIDB4ZmZmZmZmZmYpOw0KIAlzbnByaW50Zihwb3J0YWwtPmlycW5hbWUsIE1BWF9JUlFOQU1F
LCBJUlFOQU1FLCBjLT5jcHUpOw0KKwlxbV9vdXQocCwgUU1fUkVHX0lJUiwgMSk7DQogCWlmIChy
ZXF1ZXN0X2lycShjLT5pcnEsIHBvcnRhbF9pc3IsIDAsIHBvcnRhbC0+aXJxbmFtZSwJcG9ydGFs
KSkgew0KIAkJZGV2X2VycihjLT5kZXYsICJyZXF1ZXN0X2lycSgpIGZhaWxlZFxuIik7DQogCQln
b3RvIGZhaWxfaXJxOw0KQEAgLTEyOTAsNyArMTMwNCw3IEBAIHN0YXRpYyBpbnQgcW1hbl9jcmVh
dGVfcG9ydGFsKHN0cnVjdCBxbWFuX3BvcnRhbCAqcG9ydGFsLA0KIAlpc2RyICY9IH4oUU1fUElS
UV9EUVJJIHwgUU1fUElSUV9NUkkpOw0KIAlxbV9vdXQocCwgUU1fUkVHX0lTRFIsIGlzZHIpOw0K
IAlpZiAocW1fZHFycl9jdXJyZW50KHApKSB7DQotCQlkZXZfZXJyKGMtPmRldiwgIkRRUlIgdW5j
bGVhblxuIik7DQorCQlkZXZfZGJnKGMtPmRldiwgIkRRUlIgdW5jbGVhblxuIik7DQogCQlxbV9k
cXJyX2NkY19jb25zdW1lX24ocCwgMHhmZmZmKTsNCiAJfQ0KIAlpZiAocW1fbXJfY3VycmVudChw
KSAmJiBkcmFpbl9tcl9mcXJuaShwKSkgew0KQEAgLTEzMDMsOCArMTMxNywxMCBAQCBzdGF0aWMg
aW50IHFtYW5fY3JlYXRlX3BvcnRhbChzdHJ1Y3QgcW1hbl9wb3J0YWwgKnBvcnRhbCwNCiAJfQ0K
IAkvKiBTdWNjZXNzICovDQogCXBvcnRhbC0+Y29uZmlnID0gYzsNCisJcW1fb3V0KHAsIFFNX1JF
R19JU1IsIDB4ZmZmZmZmZmYpOw0KIAlxbV9vdXQocCwgUU1fUkVHX0lTRFIsIDApOw0KLQlxbV9v
dXQocCwgUU1fUkVHX0lJUiwgMCk7DQorCWlmICghcW1hbl9yZXF1aXJlc19jbGVhbnVwKCkpDQor
CQlxbV9vdXQocCwgUU1fUkVHX0lJUiwgMCk7DQogCS8qIFdyaXRlIGEgc2FuZSBTRFFDUiAqLw0K
IAlxbV9kcXJyX3NkcWNyX3NldChwLCBwb3J0YWwtPnNkcWNyKTsNCiAJcmV0dXJuIDA7DQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zb2MvZnNsL3FibWFuL3FtYW5fY2Nzci5jIGIvZHJpdmVycy9zb2Mv
ZnNsL3FibWFuL3FtYW5fY2Nzci5jDQppbmRleCBiZWUyZDBlLi4zODk0MTcyIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9zb2MvZnNsL3FibWFuL3FtYW5fY2Nzci5jDQorKysgYi9kcml2ZXJzL3NvYy9m
c2wvcWJtYW4vcW1hbl9jY3NyLmMNCkBAIC03MzUsNiArNzM1LDcgQEAgaW50IHFtYW5fcmVxdWly
ZXNfY2xlYW51cCh2b2lkKQ0KIA0KIHZvaWQgcW1hbl9kb25lX2NsZWFudXAodm9pZCkNCiB7DQor
CXFtYW5fZW5hYmxlX2lycXMoKTsNCiAJX19xbWFuX3JlcXVpcmVzX2NsZWFudXAgPSAwOw0KIH0N
CiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9mc2wvcWJtYW4vcW1hbl9wcml2LmggYi9kcml2
ZXJzL3NvYy9mc2wvcWJtYW4vcW1hbl9wcml2LmgNCmluZGV4IGJmNTFjMTcuLjlkMzdkZGQgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9mc2wvcWJtYW4vcW1hbl9wcml2LmgNCisrKyBiL2RyaXZl
cnMvc29jL2ZzbC9xYm1hbi9xbWFuX3ByaXYuaA0KQEAgLTI3MiwzICsyNzIsNCBAQCBpbnQgcW1h
bl9zaHV0ZG93bl9mcSh1MzIgZnFpZCk7DQogDQogaW50IHFtYW5fcmVxdWlyZXNfY2xlYW51cCh2
b2lkKTsNCiB2b2lkIHFtYW5fZG9uZV9jbGVhbnVwKHZvaWQpOw0KK3ZvaWQgcW1hbl9lbmFibGVf
aXJxcyh2b2lkKTsNCi0tIA0KMi43LjQNCg0K
