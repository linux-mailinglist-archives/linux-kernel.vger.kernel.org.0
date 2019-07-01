Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42BE1AB87
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfELJ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 05:57:35 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:65085
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbfELJ5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 05:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaBZiv4cVgWt9lRZrvPeyRh79C5GRw4xhcEM84ip4f0=;
 b=mgtFpnVrJbNVSD3Ws59qWaePOtLmoJx7SOEL6T/sJZmviPhVGoAEa7JFZSV0MzTw7zAB5qRd8c5kptsEsRSS57V4e6u5joYcuT51cslMPCVfCLVRiwGfF05y6u5mdQR9lSJ4RojK/KTtyLGiieheBYnRs3moMwdjRiFU6QWdW6I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Sun, 12 May 2019 09:57:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 09:57:28 +0000
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
Subject: [PATCH RESEND 3/5] ARM: dts: imx6sl-evk: Assign corresponding power
 supply for LDOs
Thread-Topic: [PATCH RESEND 3/5] ARM: dts: imx6sl-evk: Assign corresponding
 power supply for LDOs
Thread-Index: AQHVCKkbhKpEmIDoP0OOERKaSqBh8Q==
Date:   Sun, 12 May 2019 09:57:27 +0000
Message-ID: <1557654739-12564-3-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 23d39c44-474e-4331-f0c0-08d6d6c03d99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-microsoft-antispam-prvs: <DB3PR0402MB3899097B78CCDF0AE3483555F50E0@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(446003)(66476007)(66556008)(25786009)(486006)(66446008)(8676002)(11346002)(2616005)(476003)(73956011)(4326008)(14454004)(64756008)(8936002)(50226002)(66946007)(6512007)(53936002)(2201001)(7736002)(26005)(102836004)(71190400001)(86362001)(71200400001)(6506007)(478600001)(386003)(81166006)(81156014)(305945005)(316002)(2906002)(110136005)(6116002)(3846002)(66066001)(256004)(5660300002)(68736007)(36756003)(186003)(76176011)(2501003)(99286004)(6436002)(52116002)(6486002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /QIefisFtEnF/V+hMwUfdFJmlC3dcBTeCUa7Ca7M/MDIC3zMHbCznhbIgpZHqNYuhjtH2mLM07Vt7n/xNiGIm2RwZKHgJDsdSjn+4IIfoBryuDUrTrv4WnEAHhsc9NW5X82cm3lz0UTqeKWnFVZOx/niBmCcE9BqC9e7l2m9s0duvPmSvhuaPP1pHSPgJvby4c2bt9Q8VIUXvOMFP7ONjQBc5FnM8+KHogXwrIrxBg1pBf9vhs5VsLB/qbYuvLgIiecm3kpDB/828x4bHW4cE4vE/wxjXxjF+ixxhY7jU+X5guPPG8Tuwn2JLk0MTxTEymBMjw3AsdwzkaISv0sxINsXqb9+WydfvwiCI5IAR3KMTWpBJNPtWALcu7jwP/h5FJKucWibCxxW7Av73c/NASs3LGr5qXlB7tiMNiQwxGA=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0339B2D2C2B32840B8F5C36DF9D97845@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d39c44-474e-4331-f0c0-08d6d6c03d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 09:57:28.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SL EVK board, sw2 supplies vdd1p1/vdd2p5/vdd3p0 LDO, this
patch assigns corresponding power supply for vdd1p1/vdd2p5/vdd3p0
to avoid confusion by below log:

vdd1p1: supplied by regulator-dummy
vdd3p0: supplied by regulator-dummy
vdd2p5: supplied by regulator-dummy

With this patch, the power supply is more accurate:

vdd1p1: supplied by SW2
vdd3p0: supplied by SW2
vdd2p5: supplied by SW2

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No code change, just resend patch with correct encoding.
---
 arch/arm/boot/dts/imx6sl-evk.dts | 12 ++++++++++++
 arch/arm/boot/dts/imx6sl.dtsi    |  6 +++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-ev=
k.dts
index f7a48e4..4829aa6 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -580,6 +580,18 @@
 	status =3D "okay";
 };
=20
+&reg_vdd1p1 {
+	vin-supply =3D <&sw2_reg>;
+};
+
+&reg_vdd3p0 {
+	vin-supply =3D <&sw2_reg>;
+};
+
+&reg_vdd2p5 {
+	vin-supply =3D <&sw2_reg>;
+};
+
 &snvs_poweroff {
 	status =3D "okay";
 };
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 9393f03..b36fc01 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -531,7 +531,7 @@
 					     <0 54 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 127 IRQ_TYPE_LEVEL_HIGH>;
=20
-				regulator-1p1 {
+				reg_vdd1p1: regulator-1p1 {
 					compatible =3D "fsl,anatop-regulator";
 					regulator-name =3D "vdd1p1";
 					regulator-min-microvolt =3D <1000000>;
@@ -546,7 +546,7 @@
 					anatop-enable-bit =3D <0>;
 				};
=20
-				regulator-3p0 {
+				reg_vdd3p0: regulator-3p0 {
 					compatible =3D "fsl,anatop-regulator";
 					regulator-name =3D "vdd3p0";
 					regulator-min-microvolt =3D <2800000>;
@@ -561,7 +561,7 @@
 					anatop-enable-bit =3D <0>;
 				};
=20
-				regulator-2p5 {
+				reg_vdd2p5: regulator-2p5 {
 					compatible =3D "fsl,anatop-regulator";
 					regulator-name =3D "vdd2p5";
 					regulator-min-microvolt =3D <2250000>;
--=20
2.7.4

