Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF581AB84
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfELJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 05:57:29 -0400
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:13798
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbfELJ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 05:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FiWF1BRZnxp0XeTDdtClK3W5u13NHm1O+qwtUUk3KA=;
 b=sKbcJ/s+o3Cb6ntSCbpwbWkama+GxJ5yPiFjcu/nqWhSKWDt4RTpJpfiPRZorW4dOZ3w3WeS/HRg++YHeznqPTQYFvGUl5uxFF/Og+BE1NUgFJcNKYzrh2ce+JkwwbPr1QR9RRhyeYKppdFegdSWpCq8MWrRPpyiwdfKTDV7Y9U=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Sun, 12 May 2019 09:57:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 09:57:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND 2/5] ARM: dts: imx7d-sdb: Assign corresponding power
 supply for LDOs
Thread-Topic: [PATCH RESEND 2/5] ARM: dts: imx7d-sdb: Assign corresponding
 power supply for LDOs
Thread-Index: AQHVCKkZhfxt7jnKxUqx2zVaOAuHUg==
Date:   Sun, 12 May 2019 09:57:24 +0000
Message-ID: <1557654739-12564-2-git-send-email-Anson.Huang@nxp.com>
References: <1557654739-12564-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557654739-12564-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39ed92e5-a61d-4e55-9ccf-08d6d6c03b4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-microsoft-antispam-prvs: <DB3PR0402MB3899127A8CFE2A56A8D24B67F50E0@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(446003)(66476007)(66556008)(25786009)(486006)(66446008)(8676002)(11346002)(2616005)(476003)(73956011)(4326008)(14454004)(64756008)(8936002)(50226002)(66946007)(6512007)(53936002)(2201001)(7736002)(26005)(102836004)(71190400001)(86362001)(71200400001)(6506007)(478600001)(386003)(81166006)(81156014)(305945005)(316002)(2906002)(110136005)(6116002)(3846002)(66066001)(256004)(5660300002)(4744005)(68736007)(36756003)(186003)(76176011)(2501003)(99286004)(6436002)(52116002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z5E7IMLhYMasXPxIAf5G+pBkMZRmnAYrlTYtaPNlZ/2RLYb2+JjkY9WF+sEP0wsG8Ir45rr9DBindb/Dfr5EojjMLvebvVcqsmMyXtutL5k8hwHQoo9AtFEqeag2Yeu5LlLRy8x9UfJziXYDi4KEd/Pmnn60pQGjSbfjJrWrDmePcbE+xlmTgPW8xLxGrQhCPhDDRKV7F7OjWTrINuTU6Oh0/0vA+78m/LtK7tKwEHtsAiF8RtIuoufnZ/3eptgMPhowRh4TzvEMbPNGWKg86LH54cC8j+Kh31Q3vraB+7815okZIJzyUfgOUlmrGBieQoJ760UyKJ7X0nC373b3c1BmLjJvoyjSQv5M401YUAOiYg4tgRuwubV6FTYXsvFU7OZ3fvvc4P+UEJPC2uciyOYAn6MaB0YbLDF5A+1rHGo=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <028EE5896BAD984DB30BB8836620C386@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ed92e5-a61d-4e55-9ccf-08d6d6c03b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 09:57:24.0853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX7D SDB board, sw2 supplies 1p0d/1p2 LDO, this patch assigns
corresponding power supply for 1p0d/1p2 LDO to avoid confusion by
below log:

vdd1p0d: supplied by regulator-dummy
vdd1p2: supplied by regulator-dummy

With this patch, the power supply is more accurate:

vdd1p0d: supplied by SW2
vdd1p2: supplied by SW2

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No code change, just resend patch with correct encoding.
---
 arch/arm/boot/dts/imx7d-sdb.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.=
dts
index 202922e..efc83bc 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -379,6 +379,14 @@
 	status =3D "okay";
 };
=20
+&reg_1p0d {
+	vin-supply =3D <&sw2_reg>;
+};
+
+&reg_1p2 {
+	vin-supply =3D <&sw2_reg>;
+};
+
 &uart1 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_uart1>;
--=20
2.7.4

