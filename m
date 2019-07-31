Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730287C182
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfGaMiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:38:25 -0400
Received: from mail-eopbgr140114.outbound.protection.outlook.com ([40.107.14.114]:6722
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387718AbfGaMiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JskwM7RVDjSHugjyO2rS5PunYWVblqZjDCWZpN3O4DlS2FSbj7jB4SAXIXBEURth+nhvYj6aosO1MX71+4SrJe2SloU4FjEFomjYxg8dKTsUPYeORnjMhVwLQ+S+Nqb5uPECy+pdhfP2JFYtfMbVqNIZXCWrchDYj6L35/TV1S/Jic5QBdPOzkOH2NRTScUPgD06r0pxRN9tNB26PnfBkSbFMFYc7EbufxN2E5CMb42WQCKfMD5ANGj2c+YZlT2YQeHSZEGKd1FWnXY4Gjev3+tFe+cFPKg310DN13e3aOZXImvKlDnJiT+ZFoDMD9XbEmMxenALyXT9HQMem6j4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ynj49jq0JWfo/7/PgIzXzyfU7mQKz36lCHCyByvSHEg=;
 b=Or2x+/FrbYD/76vTLB0kdp7NUrHcDCLw25+JZwMa9ZB7WuH3R1V7UKX4iebFWJQGfe4Ck1SLbsnzEdS2FZFiFWqusYd8Z5znqGJMUAyP2oBFadu1fRjnJxc1Gjp8593sbRETAHPiZJ1NxEmpIABboZRtSCHUMLFDKWbbQXQmpGYF5zMHJ6YRlBA7vE/Q1E+8hr0xrL2Qttv69xWSxPSWYr6+DKb7cjYbhWFiuy3y0Pcw3YSl2C+bWLqHjFvFeZyFDQXnakUG/DlSpuw//+IvpryaBagpJ1+Aw+ziRFKEET+RSRMwqUtqRKa6gslM0Ne0GKSlT+9jCbIVthVpbn1I5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ynj49jq0JWfo/7/PgIzXzyfU7mQKz36lCHCyByvSHEg=;
 b=o1hVn0ITtGOExY1Mq0ffG3CArP4t/Y5ZSkQ7h6Qazh2806auaq+sZojSEEAPu7gAXc9ftDNZx/lLurGHMz+9zvuFJoQ8KRoRgNzRCaZ2dODolJE/432Q+T34daVopKDHyyPCltRdRjDue/ASZuJ12QenW1qhSjrcV5mMs7xuDqg=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3648.eurprd05.prod.outlook.com (52.134.7.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 12:38:12 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:12 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Stefan Agner <stefan.agner@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 07/20] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Topic: [PATCH v2 07/20] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Index: AQHVR5zQtB0dzN8FYEudcspMVKQYmQ==
Date:   Wed, 31 Jul 2019 12:38:12 +0000
Message-ID: <20190731123750.25670-8-philippe.schenker@toradex.com>
References: <20190731123750.25670-1-philippe.schenker@toradex.com>
In-Reply-To: <20190731123750.25670-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::25) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f5c2145-6234-4378-2011-08d715b3f352
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB3648;
x-ms-traffictypediagnostic: VI1PR0502MB3648:
x-microsoft-antispam-prvs: <VI1PR0502MB3648861B9CEF00DDF10CEBAFF4DF0@VI1PR0502MB3648.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(189003)(199004)(64756008)(66446008)(66476007)(66946007)(6512007)(476003)(66556008)(8676002)(86362001)(36756003)(44832011)(478600001)(5660300002)(71190400001)(71200400001)(1076003)(53936002)(6486002)(486006)(6436002)(2201001)(446003)(52116002)(50226002)(11346002)(316002)(99286004)(66066001)(2616005)(305945005)(256004)(26005)(14444005)(14454004)(102836004)(7736002)(3846002)(25786009)(6116002)(76176011)(2906002)(81156014)(81166006)(68736007)(386003)(6506007)(2501003)(4326008)(8936002)(110136005)(54906003)(186003)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3648;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /nXeR9y+k5ibf1RPYy2txQ+YwYBMygwZI/rt2OQRSnC9Qq6DBN8dbjDpgewJjGTgeRXBMFR+0DeZAZcuHw49SwbUlenjfEB32mc+SbSlcmyiA6PzwMMuIlJa9b2zra3bZoJPrrbmcAnsCrI2/02bycjE2M9d76IO0tTLfJYPBLsC/z1xMfdRnIbPEj+UOWYpf0bGXTPI8ah2O5IaIMtweCWpR6cAYjK7vP/JpwDPZZGLIBRZnoU8CyG6MEake110afj3Bsws52Y7NvU89Sl/0TbxDHOdzvpMLa8UM1R3Qe/vM7JFyVTSsUyIZ/T7rH2gD7RSyLBQ44MCP2KN41tKhTv8q9wlMoYfhivSvp5/4N2k/yKRhtnSpEbTPvbbRVy8EFJZKN1xWwIla4+GL/woQPPkWEAV6So7Vme/kLX1R3o=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5c2145-6234-4378-2011-08d715b3f352
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:12.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Add pinmuxing and do not specify voltage restrictions in the
module level device tree.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index 16d1a1ed1aff..67f5e0c87fdc 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -326,7 +326,6 @@
 &usdhc1 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
-	no-1-8-v;
 	cd-gpios =3D <&gpio1 0 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	vqmmc-supply =3D <&reg_LDO2>;
@@ -671,6 +670,28 @@
 		>;
 	};
=20
+	pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
+		fsl,pins =3D <
+			MX7D_PAD_SD1_CMD__SD1_CMD	0x5a
+			MX7D_PAD_SD1_CLK__SD1_CLK	0x1a
+			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x5a
+			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x5a
+			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x5a
+			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x5a
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
+		fsl,pins =3D <
+			MX7D_PAD_SD1_CMD__SD1_CMD	0x5b
+			MX7D_PAD_SD1_CLK__SD1_CLK	0x1b
+			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x5b
+			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x5b
+			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x5b
+			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x5b
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins =3D <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
--=20
2.22.0

