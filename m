Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8631BAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfEMQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 12:09:57 -0400
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:56750
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731370AbfEMQJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBouiMCe0HxcmNbAaeTUbmnGzYQrU3TluQCQL9haies=;
 b=UjTgtuY5Qat1gIG+czQtdNK64XfpJM9wEM9RFdWnrlWEGF8+DGMCk6irU4SJNQWx8DzV1j2vIn5hy7TovTIhe3DDX1jeSe2Vb8OuUvH3xMI8EPn8zT7T+9bIZAQ+BnWxF6cx9RM7/UfkWP+2hm3Lnrxk89xh652Y9MpL85WQfHk=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2709.eurprd04.prod.outlook.com (10.172.246.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Mon, 13 May 2019 16:09:46 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e194:a71a:3497:783e]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e194:a71a:3497:783e%8]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 16:09:46 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v1 4/8] soc/fsl/qbman: Use index when accessing device tree
 properties
Thread-Topic: [PATCH v1 4/8] soc/fsl/qbman: Use index when accessing device
 tree properties
Thread-Index: AQHVCaZIiomHQCI79kqjC6Wc0PXpqw==
Date:   Mon, 13 May 2019 16:09:46 +0000
Message-ID: <1557763756-24118-5-git-send-email-roy.pledge@nxp.com>
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
x-ms-office365-filtering-correlation-id: fcd24972-31a0-4d2c-4a98-08d6d7bd6ad2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR0402MB2709;
x-ms-traffictypediagnostic: DB6PR0402MB2709:
x-microsoft-antispam-prvs: <DB6PR0402MB2709665ACB947B911DC59907860F0@DB6PR0402MB2709.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(8936002)(2201001)(110136005)(54906003)(316002)(476003)(2501003)(86362001)(4744005)(2616005)(50226002)(2906002)(66556008)(64756008)(66446008)(66946007)(66476007)(73956011)(478600001)(3450700001)(6636002)(305945005)(5660300002)(386003)(6506007)(102836004)(43066004)(6486002)(7736002)(26005)(186003)(6436002)(66066001)(4326008)(446003)(36756003)(99286004)(486006)(25786009)(11346002)(76176011)(52116002)(53936002)(44832011)(6512007)(8676002)(14454004)(68736007)(71200400001)(14444005)(256004)(3846002)(71190400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2709;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CZJMRkMBz8PWHxTIY40fYLplYCjYgZko07TbeuzCm6M8DAVKBa2ocC4j16LJGBRXLEKaMrRSgu1Uj714tZd7odIOBq79OSp5ilblPBy61v7iEtrZryVYlYGVqNIoMNgBWiXSUiDZl8J3L3VQ326vrp/oOscLsTN8iatBMBfjA/NgsKoMlAkk/YcUO1q4f8SmJ5uJHUrmu0XjqCHVFYh2UxU6uIym9UB2LQ0wV9c4NKlvKOL28g6PqEElE/0gNVvLhyA0oemTZJKkKr66+R5v+QkVpW9Bn4X/2FvlcAYdJwDXhgfMNOBlsKAOscHA6FRXvw75kmzQfkGd3BMVz7qMLiKKLVWNUqxqg4wOedkuJz4zWHCDzd8eTdm7uU7sJuKtYwrGYdEz0+iTn26oQUeUd12aYT2u4tGu3GRuGkEebBA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd24972-31a0-4d2c-4a98-08d6d7bd6ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 16:09:46.4024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2709
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGluZGV4IHZhbHVlIHNob3VsZCBiZSBwYXNzZWQgdG8gdGhlIG9mX3BhcnNlX3BoYW5kbGUo
KQ0KZnVuY3Rpb24gdG8gZW5zdXJlIHRoZSBjb3JyZWN0IHByb3BlcnR5IGlzIHJlYWQuDQoNClNp
Z25lZC1vZmYtYnk6IFJveSBQbGVkZ2UgPHJveS5wbGVkZ2VAbnhwLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvc29jL2ZzbC9xYm1hbi9kcGFhX3N5cy5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvZnNs
L3FibWFuL2RwYWFfc3lzLmMgYi9kcml2ZXJzL3NvYy9mc2wvcWJtYW4vZHBhYV9zeXMuYw0KaW5k
ZXggM2UwYTdmMy4uMGI5MDFhOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL2ZzbC9xYm1hbi9k
cGFhX3N5cy5jDQorKysgYi9kcml2ZXJzL3NvYy9mc2wvcWJtYW4vZHBhYV9zeXMuYw0KQEAgLTQ5
LDcgKzQ5LDcgQEAgaW50IHFibWFuX2luaXRfcHJpdmF0ZV9tZW0oc3RydWN0IGRldmljZSAqZGV2
LCBpbnQgaWR4LCBkbWFfYWRkcl90ICphZGRyLA0KIAkJCWlkeCwgcmV0KTsNCiAJCXJldHVybiAt
RU5PREVWOw0KIAl9DQotCW1lbV9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUs
ICJtZW1vcnktcmVnaW9uIiwgMCk7DQorCW1lbV9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYt
Pm9mX25vZGUsICJtZW1vcnktcmVnaW9uIiwgaWR4KTsNCiAJaWYgKG1lbV9ub2RlKSB7DQogCQly
ZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3U2NChtZW1fbm9kZSwgInNpemUiLCAmc2l6ZTY0KTsNCiAJ
CWlmIChyZXQpIHsNCi0tIA0KMi43LjQNCg0K
