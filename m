Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F01BF19DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfEJNAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 09:00:30 -0400
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:13566
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727819AbfEJNA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMh2dT54Zz2ZM1+k1fF92eeqE30jDoYTH6oIYeKXGlw=;
 b=VTuxrWAlfNosMlt/XXTpcHH9vDzAJMhUeZYwYVuc5mb5KVvwixOD2/rO2vVINF2t4XXRCs4BL+0faDtR7wnFe9EdiZk9EUFecKtyxA/GTZlHddu5KuNN4Ucpt7jyzk/iVIiU9gnT8t8x87yYsUCezf+P2uHK00J3MoAkjMYkZX0=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6229.eurprd04.prod.outlook.com (20.179.7.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Fri, 10 May 2019 13:00:25 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda%6]) with mapi id 15.20.1856.016; Fri, 10 May 2019
 13:00:25 +0000
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
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: [PATCH v2 3/3] arm64: dts: nxp: frwy-ls1046a: add support for micron
 nor flash
Thread-Topic: [PATCH v2 3/3] arm64: dts: nxp: frwy-ls1046a: add support for
 micron nor flash
Thread-Index: AQHVBzBVDZ2P0laX5UKits2uWIUXBw==
Date:   Fri, 10 May 2019 13:00:24 +0000
Message-ID: <20190510130207.14330-4-pramod.kumar_1@nxp.com>
References: <20190510130207.14330-1-pramod.kumar_1@nxp.com>
In-Reply-To: <20190510130207.14330-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8c28f58-9f8e-40e7-0352-08d6d547778f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6229;
x-ms-traffictypediagnostic: AM6PR04MB6229:
x-microsoft-antispam-prvs: <AM6PR04MB622971173DCB80E74107AD4FF60C0@AM6PR04MB6229.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(11346002)(2501003)(476003)(446003)(73956011)(66556008)(2906002)(66946007)(66476007)(64756008)(25786009)(50226002)(2616005)(486006)(14454004)(8936002)(478600001)(68736007)(66446008)(186003)(52116002)(76176011)(99286004)(5660300002)(6636002)(26005)(102836004)(386003)(6506007)(6486002)(6436002)(4326008)(3846002)(6116002)(2201001)(305945005)(66066001)(256004)(6512007)(71190400001)(53936002)(71200400001)(110136005)(86362001)(54906003)(36756003)(7736002)(316002)(81156014)(8676002)(4744005)(81166006)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6229;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sg1OjkXiRV+9SsdayrXfyMaZq13Fkuj5SUQpEDBmM6K2pSOkysIquFcNfxbPzi0y0tF5WXh22LpOxh4JFid9iuSpLXu6tcTVzVG1XmGQNjqYNKJ3RGS1iNN4Mh5AlT4JWDMd/PjER6bOhpJB39j4YY3Lyl9LoYNHHy+aC97lC4rqM2EUiUwJoYmXZkxxjatWOTI8zaay1Iu/JojytFfgVwOYnhkdjjBB35mr5YvemUXhApq/Lz4ssAbC3kD4rk/KQGLoXFVQYFktcYhlBeGLEA1ZXxydYtFFcOcJHOk5C8YXNFynT/utk4hNHLzfdf2O4+wYyYhaI1dENXYB7I8xuzPFmNhPvPIUq/My9XdxdBXLdLazONdtCoMBeyW4nOw+U/RkShLNZij6qTjBb2jVjFW7IOo2N9IumJQsIc8S9mQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c28f58-9f8e-40e7-0352-08d6d547778f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 13:00:24.8832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIG1pY3JvbiBub3IgZmxhc2ggc3VwcG9ydCBmb3IgbHMxMDQ2YSBmcnd5IGJvYXJkLg0KDQpT
aWduZWQtb2ZmLWJ5OiBBc2hpc2ggS3VtYXIgPGFzaGlzaC5rdW1hckBueHAuY29tPg0KU2lnbmVk
LW9mZi1ieTogUHJhbW9kIEt1bWFyIDxwcmFtb2Qua3VtYXJfMUBueHAuY29tPg0KLS0tDQogLi4u
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS1mcnd5LmR0cyAgICAgfCAxNyArKysrKysr
KysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS1mcnd5LmR0cyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLWZyd3kuZHRzDQppbmRl
eCBkZTBkMTljMDI5NDQuLjg5MGYwNzEyMmRkMCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLWZyd3kuZHRzDQorKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS1mcnd5LmR0cw0KQEAgLTExMyw2ICsxMTMsMjMg
QEANCiANCiB9Ow0KIA0KKw0KKyZxc3BpIHsNCisJbnVtLWNzID0gPDE+Ow0KKwlidXMtbnVtID0g
PDA+Ow0KKwlzdGF0dXMgPSAib2theSI7DQorDQorCXFmbGFzaDA6IGZsYXNoQDAgew0KKwkJY29t
cGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsNCisJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKwkJ
I3NpemUtY2VsbHMgPSA8MT47DQorCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDw1MDAwMDAwMD47DQor
CQlyZWcgPSA8MD47DQorCQlzcGktcngtYnVzLXdpZHRoID0gPDQ+Ow0KKwkJc3BpLXR4LWJ1cy13
aWR0aCA9IDw0PjsNCisJfTsNCit9Ow0KKw0KICNpbmNsdWRlICJmc2wtbHMxMDQ2LXBvc3QuZHRz
aSINCiANCiAmZm1hbjAgew0KLS0gDQoyLjE3LjENCg0K
