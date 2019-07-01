Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FECB1B4AD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfEMLPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 07:15:47 -0400
Received: from mail-eopbgr60122.outbound.protection.outlook.com ([40.107.6.122]:15428
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729303AbfEMLPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+8Kgzm9ZzUSGh/sqgH4zHXiaGOchvRxgwWj8JNneO4=;
 b=l9vGglx1dMIFFOzP3xDXscmFb78V0HBmIDxPULOjiEke9vVogpJYFcyPbK/0xtyK6Y2/Cj0Ge6A/kCgPlvYW0aA8Sq344+gbPk5hQsENDP4LrNm2HfQ1sr6EKu4JDt6MPlVg/RXMx9LKSNUmPPrB/yMLIesPp6r5YtmVByWYSVg=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB1950.EURPRD10.PROD.OUTLOOK.COM (52.134.27.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 13 May 2019 11:14:54 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48b8:9cff:182:f3d8]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::48b8:9cff:182:f3d8%2]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 11:14:54 +0000
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
Subject: [PATCH v3 1/6] soc/fsl/qe: qe.c: drop useless static qualifier
Thread-Topic: [PATCH v3 1/6] soc/fsl/qe: qe.c: drop useless static qualifier
Thread-Index: AQHVCX0XqWweYTTW4Ui0pvWYzLl4aw==
Date:   Mon, 13 May 2019 11:14:54 +0000
Message-ID: <20190513111442.25724-2-rasmus.villemoes@prevas.dk>
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
x-ms-office365-filtering-correlation-id: d8673d95-778f-4240-5171-08d6d79439c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR10MB1950;
x-ms-traffictypediagnostic: VI1PR10MB1950:
x-microsoft-antispam-prvs: <VI1PR10MB1950EE05FF8094316F0C181E8A0F0@VI1PR10MB1950.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(366004)(376002)(136003)(396003)(189003)(199004)(6512007)(66066001)(53936002)(107886003)(52116002)(68736007)(256004)(14444005)(71200400001)(71190400001)(76176011)(6436002)(478600001)(4744005)(6486002)(1076003)(36756003)(5660300002)(72206003)(74482002)(446003)(81156014)(8676002)(14454004)(99286004)(2501003)(66946007)(66476007)(66556008)(64756008)(66446008)(73956011)(54906003)(11346002)(2616005)(42882007)(476003)(81166006)(44832011)(50226002)(486006)(8936002)(110136005)(8976002)(6116002)(7416002)(316002)(3846002)(2906002)(305945005)(7736002)(186003)(25786009)(102836004)(6506007)(386003)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB1950;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fbA/ERyrEYvUSXkEukIoMKq5Xr5HmpRlg9OAIUuBpj4wDPD/Vb1S0rAJVJ2ezzoe+5K30sKDDcQuY7a9stY7FDsBAisT0Kui9kC/o3AtVh/jm+3TvY75+jDxsZt7mwoB5SqHT+Kth1nWjNILh+Tj2gLv2A9HlIQ85ZXTsyw9kyzxQd0oS6c2cUFKRPTWjux0Xdmiz16hvH5tJW3j+aa3Lo7xfWN4z3/z5gk1qh8cwBtJraaPeSh5baHxHJErxXe6iZiiSxjo1PQuBiDAs8n6PA6hg8xAX3oip1c91bW/3Kzf4FI2SlrJ6aszBC+Icipu4HmaMMqYQC+9D15un4ROFzl5VThzA7zSbOsb1YMFSK+grsvpGNq7R9gabnXvOwM5ojMRpLIpqTN0RzklYuknZeEqOYxFHOEKjGPDnnGlByo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d8673d95-778f-4240-5171-08d6d79439c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 11:14:54.6923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1950
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGxvY2FsIHZhcmlhYmxlIHNudW1faW5pdCBoYXMgbm8gcmVhc29uIHRvIGhhdmUgc3RhdGlj
IHN0b3JhZ2UgZHVyYXRpb24uDQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJp
c3RvcGhlLmxlcm95QGMtcy5mcj4NClJldmlld2VkLWJ5OiBRaWFuZyBaaGFvIDxxaWFuZy56aGFv
QG54cC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSYXNtdXMgVmlsbGVtb2VzIDxyYXNtdXMudmlsbGVt
b2VzQHByZXZhcy5kaz4NCi0tLQ0KIGRyaXZlcnMvc29jL2ZzbC9xZS9xZS5jIHwgMiArLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zb2MvZnNsL3FlL3FlLmMgYi9kcml2ZXJzL3NvYy9mc2wvcWUvcWUuYw0KaW5k
ZXggNjEyZDljNTUxYmU1Li44NTUzNzNkZWI3NDYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9m
c2wvcWUvcWUuYw0KKysrIGIvZHJpdmVycy9zb2MvZnNsL3FlL3FlLmMNCkBAIC0zMDYsNyArMzA2
LDcgQEAgc3RhdGljIHZvaWQgcWVfc251bXNfaW5pdCh2b2lkKQ0KIAkJMHgyOCwgMHgyOSwgMHgz
OCwgMHgzOSwgMHg0OCwgMHg0OSwgMHg1OCwgMHg1OSwNCiAJCTB4NjgsIDB4NjksIDB4NzgsIDB4
NzksIDB4ODAsIDB4ODEsDQogCX07DQotCXN0YXRpYyBjb25zdCB1OCAqc251bV9pbml0Ow0KKwlj
b25zdCB1OCAqc251bV9pbml0Ow0KIA0KIAlxZV9udW1fb2Zfc251bSA9IHFlX2dldF9udW1fb2Zf
c251bXMoKTsNCiANCi0tIA0KMi4yMC4xDQoNCg==
