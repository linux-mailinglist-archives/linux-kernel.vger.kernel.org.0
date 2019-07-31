Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1737C178
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbfGaMiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:38:10 -0400
Received: from mail-eopbgr50111.outbound.protection.outlook.com ([40.107.5.111]:36399
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387662AbfGaMiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfmOnnvl6oONxi3TZXiyOarPFLpTKAPlzAXLgn3jWwQMT2MomVpmpovrR7cXdMa9KAAUkt9tTHsVs/XPOvRKLbIC9PmjuHsPYkGKi6TO4TFh8SMcGjO2N6PiXnut4NE0E5cLizrc273k620LcSxSbtXsmKznNN1HTP0dbXb1gja320Yn3P25DVocALjVvX7BdrQLOBf6FJdviHPjnCDiKaXa9fzAI3MhOBNRezYOz0SItCpltykiK9DzelqraJNyS+wpo4cQfUnJdK3gab0pZ6p5CLM8mKaQwfyCNVVInfHM+pvGXv8BdIRN6IO4PugFmB9qmjWmYERIO+9TitHe7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvTSlKwlyM3A4JjJZOWeFx3QtVyJcCpEY4tgRXDZoNo=;
 b=BM+rmO6wjVyhQxpyxRz805DBQKhHIxmr8YDdASfp+x+f8RdflX7WAjEVZJkSWjWlivLqCfdkXEuMf2XZZPjL5B5V9udTvEDHmND3DGbsK0qGEd8HqzkIImGWU3ThNBoc5SGLZOfBF2NcJvH0GqItrbEX+pOjL+TKFxh7tvmfaNll9fjHgrttqWuTQ/FmKcIAQwLlTilmHtYQF86xp2cMh+llv3qSqnn0XIyMPnxRY84JNfOjvZMwTf0fmkBgltMwNuES1V+kevoAui4nJDO2DdAlu+v4Ml8jtNuiOuFeTH2F0E/NUHcv3EeLN6oqChpurHwCvuKZVdEH6btWfjw+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvTSlKwlyM3A4JjJZOWeFx3QtVyJcCpEY4tgRXDZoNo=;
 b=ikmpWOvpZzpxrZXQD6Lu7+ezK0OEQsfXEoZVSOBUV6p/JWe4+rMtKbBYID+CVOROsyk14V5XDvbG7otyX1fuK+XbohwmMc3kAxfm8FLjJQp8j6Zd12aDuEftrMNJiZsqlG8dBwziINnhFBJnONftRgVVz2Se0kT3niOBZhVo+ms=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2944.eurprd05.prod.outlook.com (10.175.25.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 12:38:03 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:03 +0000
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
Subject: [PATCH v2 02/20] ARM: dts: imx7-colibri: disable HS400
Thread-Topic: [PATCH v2 02/20] ARM: dts: imx7-colibri: disable HS400
Thread-Index: AQHVR5zLnUdQa6E7rUWjJNiDWooPFA==
Date:   Wed, 31 Jul 2019 12:38:03 +0000
Message-ID: <20190731123750.25670-3-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 394ca94e-46c1-431a-7b5c-08d715b3edf3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2944;
x-ms-traffictypediagnostic: VI1PR0502MB2944:
x-microsoft-antispam-prvs: <VI1PR0502MB2944803C3BE746E7F3EB0CCBF4DF0@VI1PR0502MB2944.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(189003)(199004)(66066001)(305945005)(26005)(2906002)(81166006)(81156014)(7736002)(52116002)(1076003)(36756003)(476003)(64756008)(66446008)(186003)(66556008)(66946007)(66476007)(256004)(2501003)(14444005)(71200400001)(8676002)(86362001)(68736007)(5660300002)(71190400001)(8936002)(4744005)(76176011)(478600001)(54906003)(110136005)(14454004)(6486002)(2201001)(6436002)(3846002)(99286004)(6116002)(446003)(11346002)(6512007)(2616005)(7416002)(386003)(486006)(102836004)(44832011)(6506007)(316002)(25786009)(53936002)(50226002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2944;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UdWY6FxhYQwHh0Ol4NTTCPFrlOdfokbrNMZWAVxuH8g57YNGpYlH4XYAPWwSrU/MneF5uf9l9KzlHh7QDafBAQLzpV+4Y3U8XOQ6kkDT0Sa12SiiKu/V8BznJ3AGOoS414n5VZ8i5EQltv7r+Wcninnk9vHq7kUgn7I1ZO/qkNM8MqxdcpVHnZD9RWYC/jILkFHAYLx1La0NOt/nFN4JxEn6dOxXMjjjYi7jgttZIwCIdUmFMkoq2wtPuMxxQf+OLrEIoucs0XllpgzM18aSbWwm2kjR24Ftpec0KrT0mVlPp11ZJqzMs2jJKPKRUd5kERBbJQMNP0ZlMskYuQI/4jUD2AtZNpmU6v3r8QFeaYNHZhq7aFx4Lpscda8EdmqU1Sb5wlLIWvYSA5PtSlH3+vvONRmflzDmg+2OprlnpNk=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394ca94e-46c1-431a-7b5c-08d715b3edf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:03.3689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Force HS200 by masking bit 63 of the SDHCI capability register.
The i.MX ESDHC driver uses SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400. With
that the stack checks bit 63 to descide whether HS400 is available.
Using sdhci-caps-mask allows to mask bit 63. The stack then selects
HS200 as operating mode.

This prevents rare communication errors with minimal effect on
performance:
	sdhci-esdhc-imx 30b60000.usdhc: warning! HS400 strobe DLL
		status REF not lock!

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index f1c1971f2160..f7c9ce5bed47 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -325,6 +325,7 @@
 	vmmc-supply =3D <&reg_module_3v3>;
 	vqmmc-supply =3D <&reg_DCDC3>;
 	non-removable;
+	sdhci-caps-mask =3D <0x80000000 0x0>;
 };
=20
 &iomuxc {
--=20
2.22.0

