Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 939BD7C190
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbfGaMiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:38:55 -0400
Received: from mail-eopbgr140114.outbound.protection.outlook.com ([40.107.14.114]:6722
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387827AbfGaMij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8BxGPb0S/4utIbaEYF6fxCv/a98WW/y6GUMCFahqhaFpKArjWVRMSd/mpNbBkPxfYen77KwpXnhOIOgi2rGlwGw1m+N03nBkhtlU5ZlnwGN9KcpLtSE6l2P+y41+YsmFz8rHrLIYksBXNJ2QKgkSQtvtEjBlKMGz4EUztZNdzgiYXUmcSWYnp1DGlnfm0DIMxMfr8McnQZPxNvbMP+4dgkIXGwaKQydiiLteMLeW+i2EpMoxb5iZoPypvPq1x4UQwahV+x4Lt2+KrBaEUNGHm/KrP5smXkrO0cxcXRRkCwvqBDoxflEjoFX0J5anoLX9bJo3UJIEUP/P07JIEQdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLaUM9sGjgpBqCAajpFnF7oYEYmdNAwrx2yDwRhJ4/s=;
 b=e80qmCWLtp3U3jRuklZ0fWSOf/2j2fcpZCffBbZl8yTt93sc9UJ4MFBlnCbyjAOxV6AWMPSILfvrpiMAvARbBbBLDSsJBZsRiwRAURRoMtmq/5M71BUwrSOHXS32Q6PfqzF9S/KUKsw1s07Xk9m19WIMUYNMvBe55S+0JSY/zI0Nqep7bFVK+ui9SrU2zPcXqinfKJQIfCxFnnxF+E+lCeTEG3wwUTT7GJZCiTydBlsdYl9BXO7pKwHTKFqvAa7bBqqqfrnSx6sXEBL0okm7C+Xio6/ILlT4Mc/KwNv0oAcCNeEBw+OlguR2KXgV6Q6uW6eUyUzgJfEyCCyTjYSciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLaUM9sGjgpBqCAajpFnF7oYEYmdNAwrx2yDwRhJ4/s=;
 b=uhbcmuToWA3zpEXZY595MpVAEHIMWDUw2Ko0oB5sKDXInbDVBj5ScZxeP93KvO1/1O9tXs0u10Z/N9MHPYTaUZo+OEFEW18LwArVtUpN2Jpz9PfszZKdigt4o9PTOeRNzKnXGamnowJa2L/CV3fpUa1Az+2Zn3fG1naC+8YG680=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3648.eurprd05.prod.outlook.com (52.134.7.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 12:38:32 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:32 +0000
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
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 16/20] ARM: dts: imx6ull-colibri: Add watchdog
Thread-Topic: [PATCH v2 16/20] ARM: dts: imx6ull-colibri: Add watchdog
Thread-Index: AQHVR5za7tPRG9XuSkWa1a+kvLOLrg==
Date:   Wed, 31 Jul 2019 12:38:28 +0000
Message-ID: <20190731123750.25670-17-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 8e563862-8ca4-4e2f-d85d-08d715b3fcf2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB3648;
x-ms-traffictypediagnostic: VI1PR0502MB3648:
x-microsoft-antispam-prvs: <VI1PR0502MB3648B1E33162637F2FCEF894F4DF0@VI1PR0502MB3648.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(189003)(199004)(64756008)(66446008)(66476007)(66946007)(6512007)(476003)(66556008)(8676002)(86362001)(36756003)(44832011)(478600001)(6666004)(5660300002)(71190400001)(71200400001)(4744005)(1076003)(53936002)(6486002)(486006)(6436002)(2201001)(446003)(52116002)(50226002)(11346002)(316002)(99286004)(66066001)(2616005)(305945005)(256004)(26005)(14454004)(102836004)(7736002)(3846002)(25786009)(6116002)(76176011)(2906002)(81156014)(81166006)(68736007)(386003)(6506007)(2501003)(4326008)(8936002)(110136005)(54906003)(186003)(7416002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3648;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bmQvUnSS8zQMZrTBMHlCZMBrNpxOfKU7YVDYfC0l3l2MxOWfCC5SXpLpzspdPUwynnkDyJCxFXYlzgPO+QGIGIenWmePGx0tpo7WoEaUrEQvjrZJPbdR1lNjaY8eG4ZgZgyGE0VeoiFBblbaIIPF6EJLyZgc4C4D6PjQGud/o4jpIRCdaLfDUX8LXt5NggsRtLsAqLdAl5+ptq21Uj0rnpTYUMAwX1+YvAr7DqHd2+rK1EbiOrI3KLQAnv9WJLsGDgOy/fh4vbvofmIgr3kfAXN5yfjZUUePRJoWk/ipA5sYBqkViz8djdhBvNZ+PBVI3arnHEqYexzj3+lNGX6B4DdYpwuCf3EJ63iVUXshZk5kt1ix0THLbpyAsWR3tPJE8n0Ivxxf1mvhp/a/4CvlJ4zjCy2thZPktsh3t+Rj70I=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e563862-8ca4-4e2f-d85d-08d715b3fcf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:28.5376
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

This patch adds the watchdog to the imx6ull-colibri devicetree

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx=
6ull-colibri.dtsi
index 1f112ec55e5c..e3220298dd6f 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -199,6 +199,12 @@
 	assigned-clock-rates =3D <0>, <198000000>;
 };
=20
+&wdog1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	pinctrl_can_int: canint-grp {
 		fsl,pins =3D <
@@ -506,6 +512,12 @@
 			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT	0x14
 		>;
 	};
+
+	pinctrl_wdog: wdog-grp {
+		fsl,pins =3D <
+			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
+		>;
+	};
 };
=20
 &iomuxc_snvs {
--=20
2.22.0

