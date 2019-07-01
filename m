Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584AC2B414
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfE0ME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 08:04:26 -0400
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:33794
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727080AbfE0MEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2kJI0bnG9vYr0Dv9257snPjYQvX9ItSIa4yQA+mCIM=;
 b=gEnJMmJuw1c+OQBepqLJA/72UwTcm0kvlZrf+k8MBPggjDVyOZReF6KkTnnDp6PKA/YlJJ3IckkfuJxCk4Z8UuZC4HfBOhwG3v2mkTwdSr74IUy9kQtuNE8VRZJhW6Lv6HnveBNiv/p+AitRzHOHl+J4+mNZQXrCHwSpvEdEjSE=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6421.eurprd04.prod.outlook.com (20.179.244.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Mon, 27 May 2019 12:04:21 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21%4]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 12:04:20 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 1/3] dt-bindings: arm: nxp: Add device tree binding for
 ls1046a-frwy board
Thread-Topic: [PATCH 1/3] dt-bindings: arm: nxp: Add device tree binding for
 ls1046a-frwy board
Thread-Index: AQHVFIRRpMWsXBrg60uRsn27aYR0sw==
Date:   Mon, 27 May 2019 12:04:20 +0000
Message-ID: <20190527120619.30546-2-pramod.kumar_1@nxp.com>
References: <20190527120619.30546-1-pramod.kumar_1@nxp.com>
In-Reply-To: <20190527120619.30546-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: BMXPR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::26) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33617f59-cadf-42e1-7a0b-08d6e29b7360
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6421;
x-ms-traffictypediagnostic: AM6PR04MB6421:
x-microsoft-antispam-prvs: <AM6PR04MB64213FC5E0941CEE710A256FF61D0@AM6PR04MB6421.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(6636002)(4326008)(6486002)(256004)(102836004)(99286004)(3846002)(6436002)(8676002)(478600001)(71200400001)(71190400001)(53936002)(305945005)(2501003)(1076003)(2201001)(54906003)(6116002)(4744005)(8936002)(110136005)(5660300002)(36756003)(14454004)(66446008)(73956011)(186003)(52116002)(86362001)(7736002)(26005)(486006)(2616005)(386003)(446003)(11346002)(81156014)(81166006)(6506007)(476003)(316002)(76176011)(25786009)(6512007)(2906002)(66946007)(66476007)(66556008)(64756008)(66066001)(50226002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6421;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KXVMh+SNnWnkyesMXW5IJcgWmyh/rt74zEmkzEoyvzmVVyFZAEM8bwZWTAomqzcVhj9KWimwTZuisTCvR3WwgK6A6fVrHZWHFxHrvODqSSn9nNJPnw1MoZCv6jaaO31+yBYznBkZpNk9mgyPgCGKLtYzG9pZ5Wlo8NoORjsRxJTi2wJF7zWXdG/vy1VHPDFj5P1LgGKZRTYVyybNmpfdcKWsnF7XUkDt6CorcgmBLejSQw8v7dVntrtvX0Uq9wacnqS+OCb9pQiC4jrddZGmaeuabnk3e9fgiolJ0z+H7tmaJ8t7MK2XdQEt1Ha+uohSDlDI4Mexi2iEZyZh7tSMUOk/CnDiYfOIzQcOlXILfYyY28bIfd4/FVg3CHMmGpnZEqFDlBuvXVSsjXiPXgEAde5kQqpYDePB6dAw4Nj4R3M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33617f59-cadf-42e1-7a0b-08d6e29b7360
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 12:04:20.8251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pramod.kumar_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICJmc2wsbHMxMDQ2YS1mcnd5IiBiaW5kaW5ncyBmb3IgbHMxMDQ2YWZyd3kgYm9hcmQgYmFz
ZWQgb24gbHMxMDQ2YSBTb0MNCg0KU2lnbmVkLW9mZi1ieTogVmFiaGF2IFNoYXJtYSA8dmFiaGF2
LnNoYXJtYUBueHAuY29tPg0KU2lnbmVkLW9mZi1ieTogUHJhbW9kIEt1bWFyIDxwcmFtb2Qua3Vt
YXJfMUBueHAuY29tPg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sIHwg
MSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KaW5kZXggNDA3MTM4ZWJjMGQwLi4w
OWZmMTk5OWNlOTYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2ZzbC55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL2ZzbC55YW1sDQpAQCAtMjQxLDYgKzI0MSw3IEBAIHByb3BlcnRpZXM6DQogICAgICAgICAg
IC0gZW51bToNCiAgICAgICAgICAgICAgIC0gZnNsLGxzMTA0NmEtcWRzDQogICAgICAgICAgICAg
ICAtIGZzbCxsczEwNDZhLXJkYg0KKyAgICAgICAgICAgICAgLSBmc2wsbHMxMDQ2YS1mcnd5DQog
ICAgICAgICAgIC0gY29uc3Q6IGZzbCxsczEwNDZhDQogDQogICAgICAgLSBkZXNjcmlwdGlvbjog
TFMxMDg4QSBiYXNlZCBCb2FyZHMNCi0tIA0KMi4xNy4xDQoNCg==
