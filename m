Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AD58A0C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfHLOVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 10:21:38 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:46656
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728144AbfHLOVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSxoFTT7VH1PUFzj1cC6sM8KG/EFzr4KOeQWPZG6TulVLyGDzKKUSNOnbDlYFpDq7AE/Oc0i5HTjGYQNgtKmAostSYmZ58U0jSaKV5+ZAnRS3ssUUgcfLRZzPSyCKbLyAlonkKrWn2a4pDnvebKJYTN+WlMfBq/ooQ1alhjVchjHDTGaR4SnsO8w/99bpbRcuLvqthTYU91751G2lAMD3eAER3K6G3bz3LDj2pfeVtFGdRgv77wMzjwIaVajXxeGukylAt8HW70Y3ngqUqAKuo20CtLGZjpyJsrU767LO7bjua0zjGBKOafPtkzvXXpwBGk+y+QQcq8cR2Bh6X30rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYxYVQUVs6EdAcbGY9vZo+d0IZ1XggSfUz0Indt7Qi0=;
 b=mpyCy2Yj6fWw3Gwjuo3IOVAUv7HA+TQ463nVneuNNpih1ggQ5Q2ipyfeSyOeqvjpFD6b+NqEL2nDO2013Ickr55spzerSZiql658xO6U+jjqkFj6gMIZfZTOSgYrr+L7z/k2qFNAftieR2krsbSAUdr+wMeu3xvBndUNDr6QN5n6ko50As1AK8wntT0BtgDoDzxUlsdyt+UvaGjMbJv0BTe/FjZebWB1mr/qoCWFkcXAVJbNQRaGJCExkumtLPH4OgHhxb+LDi2A1WEZXUxGqIOcnzmXpO5dcTx8cB4osaEia6gYOnjaI66UflE8jPgF05C06jpk9fxUVwWji7ZAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYxYVQUVs6EdAcbGY9vZo+d0IZ1XggSfUz0Indt7Qi0=;
 b=vC2w5dflWqbr5YguvFH6RXBhdR2tsjsUy7Nng2dbGYmu56jibpEsc9+S0Po4E1wMuf8L7vHB6wUd33sZEAhMpKQtW/GBxsnY2vRyp1avNmid3FsMX+J+/c0GUsPsK9VXDQPiUfiNsQ6f1YZnShAQXYqrKSlTEVuQ1kzV8P4SoL4=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3808.eurprd05.prod.outlook.com (52.134.9.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 14:21:30 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:30 +0000
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
Subject: [PATCH v4 10/21] ARM: dts: imx6qdl-colibri: Add missing pin
 declaration in iomuxc
Thread-Topic: [PATCH v4 10/21] ARM: dts: imx6qdl-colibri: Add missing pin
 declaration in iomuxc
Thread-Index: AQHVURk7mreCb1Qy5EOccuHZ/IyKAw==
Date:   Mon, 12 Aug 2019 14:21:29 +0000
Message-ID: <20190812142105.1995-11-philippe.schenker@toradex.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e0ff810-8e1e-40df-acd1-08d71f305e48
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3808;
x-ms-traffictypediagnostic: VI1PR0502MB3808:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB38083EDA3A0809CFC72E754BF4D30@VI1PR0502MB3808.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(71190400001)(2906002)(71200400001)(66946007)(478600001)(256004)(66556008)(66476007)(7416002)(6116002)(3846002)(1076003)(14454004)(81156014)(81166006)(8676002)(4326008)(8936002)(50226002)(36756003)(99286004)(26005)(386003)(6506007)(66066001)(76176011)(305945005)(25786009)(110136005)(316002)(54906003)(102836004)(44832011)(52116002)(64756008)(6486002)(66446008)(5660300002)(53936002)(6512007)(7736002)(2501003)(4744005)(446003)(2201001)(186003)(86362001)(476003)(486006)(11346002)(2616005)(6436002)(32563001)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3808;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HxWlxxtmliRMnVGOlizPz5Aa8wUDwlWL+Y22aMGp3IafWyKSY1NF+IbG6/mqlYmNFbEi/GFW2EAAwzVfCfA83vURO5YzqpoUWoi83nqAwxYsOVub4erWkjXbIBO5S+XbmDve9xynKKulbRJ1UE0lKIOyTRC9Nztm+fmjGpqOVhPjdCJ50jWkOF+Gj8Ak3zMKWYQFD/gSAh/mggOUgTXlfG8LnyIPRE2Sse1Gcu+hSYN+meeW8H/ZmFLA62F0F9QQou1uyHE7T6SFJRwsmk7B2dtj2DzMJGNUJRHLzonGIHgwdOMLXhAHy6GL8p0iy6InNaZ/9q3BAS2lPTRsce03OupnsDlU+/3QW+zJqZIBhMd5v4K03PC63ut96+l8KD4glqrYVesKkVjHovcWYCNSpj8N2N/A7fxY9uTlFeERZiI=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0ff810-8e1e-40df-acd1-08d71f305e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:29.8815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPlbkxKddRgYeMkh7glmGByjMKMomqYQWezb4ZkUPM1UK5GMycN2Ea1xhLYOCEUvlWalW6WwuhHI4gUTqgNVcmDWrOu7fLH1Nq+osfOYfSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the muxing for the optional pins usb-oc (overcurrent) and
usb-id.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx=
6qdl-colibri.dtsi
index 019dda6b88ad..9a63debab0b5 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -615,6 +615,13 @@
 		>;
 	};
=20
+	pinctrl_usbh_oc_1: usbh_oc-1 {
+		fsl,pins =3D <
+			/* USBH_OC */
+			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x1b0b0
+		>;
+	};
+
 	pinctrl_spdif: spdifgrp {
 		fsl,pins =3D <
 			MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0
@@ -681,6 +688,13 @@
 		>;
 	};
=20
+	pinctrl_usbc_id_1: usbc_id-1 {
+		fsl,pins =3D <
+			/* USBC_ID */
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x1b0b0
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins =3D <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x17071
--=20
2.22.0

