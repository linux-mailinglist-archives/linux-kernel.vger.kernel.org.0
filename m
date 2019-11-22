Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A2E106FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfKVLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 06:17:38 -0500
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:34373
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729941AbfKVKsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:48:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZN/zFh93FKWLJf24kzCz7NED+mnYZ+zbtDD7cW0bwe9nxDF4c7fk3bkP6b7mxDTleD9Oit7Yxxf54nl1RxL/5UVqzkdne11mJLKO+6N88z89dwlhdVt/FO/hCIGfuodmx9hJoqWj1kCYKo4QlwsYp+CyhHYHb3kLCDcxDmFXS+a9XwK/fLVF+Mu3Tho/HITex4LnGa49UZXpWvuyFKVW70uqJ93CM8zvHwWbAoo0R/aAPFN7mxuwiYQsgGF88bDrQKX9CVldlM4VW9aT+vo1vW4B+gjqe+DoeE5dbms0QUD7uP7Nun3XPhPUE+XJxdNU55iYCbrYGCXfhPybbmRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47lDHV+5aiv2jdXqfwkm8wIcEOSkK2VfBXZ2VatH224=;
 b=b9PylZFJfnGca5gNBMwsQt3ayBiXVYrHLXmivsx1Xi5fPGAdNK8/FG7BJKLJSX9CGpqZk25NzTRiJ62b0xsimBe7tJ4Yr0D2Y2SvF2knkuHg9pdcs+W6eH23db1ztfWwki+KuGy5BzfMhp33NTGKHW+jmudS2xunIfN8689/Nkugudo2V+KzdiILLkiqzWE9CiRvz230YZxn+hcDJ4QM6du9bRm++6oGZB8mw8/Qeqnrybilg6fV7Znsi4xKjbh9nu+hdHCEwxJ2xqUwhbG/MXH7+vJg5L8iXpcsIJcptjEeKqZJL5I8E0CcXdhAaWkSdd5TW1k1Kw/dmXnL50n41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47lDHV+5aiv2jdXqfwkm8wIcEOSkK2VfBXZ2VatH224=;
 b=o8tAxHJcH+5gXTscxg6tLH4DDlVwYl8gZN/Aulfsi5SD4EFKkDts42QjCzkgqlPTsuWKAXh/T9GVHN1DkGa1klAUXU0vh8r8GNk1Wfb0OksC11Vyrngdooty9y7Sf1okrdXP8AUVsFyxj21ACad7Vgnp7aiIEjacPQLOowOTrL0=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5074.eurprd04.prod.outlook.com (20.177.42.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 10:48:17 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 10:48:17 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 06/11] clk: imx: imx7ulp composite: Rename to show is
 clk_hw based
Thread-Topic: [PATCH v2 06/11] clk: imx: imx7ulp composite: Rename to show is
 clk_hw based
Thread-Index: AQHVoSJY0pntNPhTwUGCj9LqvBpqnQ==
Date:   Fri, 22 Nov 2019 10:48:15 +0000
Message-ID: <1574419679-3813-7-git-send-email-abel.vesa@nxp.com>
References: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:15::33) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d83ad8d6-fdd5-481e-e700-08d76f397a8f
x-ms-traffictypediagnostic: AM0PR04MB5074:|AM0PR04MB5074:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5074016007BEBA997B9F65F0F6490@AM0PR04MB5074.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(478600001)(14444005)(256004)(6506007)(54906003)(30864003)(7736002)(305945005)(316002)(71200400001)(5660300002)(110136005)(102836004)(186003)(86362001)(66066001)(71190400001)(2906002)(4326008)(76176011)(99286004)(36756003)(26005)(52116002)(386003)(8936002)(3846002)(2616005)(446003)(44832011)(11346002)(66556008)(66476007)(66446008)(64756008)(6486002)(66946007)(6436002)(81166006)(8676002)(81156014)(6636002)(6512007)(25786009)(14454004)(50226002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5074;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yf/RpvKXqwgY6XqZDrANJvRzS8aw0qsADOYRtxuxzLLSbqg2cIxiX6dT4pV++ztBPP/5Eu+GxVXURFSKMRDexYx+PS761qDNAu9T5aO19cxwi3xOhK6hJt8vMYGuAo3fZDukXJujyHAc8B8YpBErrPiTLP7G2uZxmJ2eJ/z97WVX0hh+d1iqIZuSqthxSqKTifA36WG9buepgPVi7Ow/1xtelmznucqzmPJFNjBKA4sxVjVyIQOk2+kFw6YNHfpgSxXQjPCtbd1/7dTpWkBu+tvrTjibFpdGOlp9m9AHeD0/oItZWnVmgJAtr7E/Sau1/QNJ030siUI+alvN5k7Deg78DAjZR7ZiTDWh7IDzrqqYzuGU8geZpkPPQDfh374JQwMWkZpJ6Y5lmkqQ4+xchXlVnWYShk7Yqt8b8MgdWkDKqBI97nEPGqWTWUkCNA2m
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83ad8d6-fdd5-481e-e700-08d76f397a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 10:48:15.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1J9I1x1k8KqwuO9xxhB7XKH+/ZIYjdWZYD7hW4wRj3xeG5ujHRVScezYbKNGRbIpPvbbn23Aq5Iehx8LDFn+Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming the imx7ulp_clk_composite register function to
imx7ulp_clk_hw_composite to show it is clk_hw based.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-7ulp.c |  2 +-
 drivers/clk/imx/clk-imx7ulp.c        | 52 ++++++++++++++++++--------------=
----
 drivers/clk/imx/clk.h                |  2 +-
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-com=
posite-7ulp.c
index 060f860..b9efcc8 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -21,7 +21,7 @@
 #define PCG_PCD_WIDTH	3
 #define PCG_PCD_MASK	0x7
=20
-struct clk_hw *imx7ulp_clk_composite(const char *name,
+struct clk_hw *imx7ulp_clk_hw_composite(const char *name,
 				     const char * const *parent_names,
 				     int num_parents, bool mux_present,
 				     bool rate_present, bool gate_present,
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 3fdf3d4..64b79a8 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -165,23 +165,23 @@ static void __init imx7ulp_clk_pcc2_init(struct devic=
e_node *np)
 	clks[IMX7ULP_CLK_RGPIO2P1]	=3D imx_clk_hw_gate("rgpio2p1", "nic1_bus_clk"=
, base + 0x3c, 30);
 	clks[IMX7ULP_CLK_DMA_MUX1]	=3D imx_clk_hw_gate("dma_mux1", "nic1_bus_clk"=
, base + 0x84, 30);
 	clks[IMX7ULP_CLK_CAAM]		=3D imx_clk_hw_gate("caam", "nic1_clk", base + 0x=
90, 30);
-	clks[IMX7ULP_CLK_LPTPM4]	=3D imx7ulp_clk_composite("lptpm4",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
-	clks[IMX7ULP_CLK_LPTPM5]	=3D imx7ulp_clk_composite("lptpm5",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
-	clks[IMX7ULP_CLK_LPIT1]		=3D imx7ulp_clk_composite("lpit1",   periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
-	clks[IMX7ULP_CLK_LPSPI2]	=3D imx7ulp_clk_composite("lpspi2",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa4);
-	clks[IMX7ULP_CLK_LPSPI3]	=3D imx7ulp_clk_composite("lpspi3",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa8);
-	clks[IMX7ULP_CLK_LPI2C4]	=3D imx7ulp_clk_composite("lpi2c4",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xac);
-	clks[IMX7ULP_CLK_LPI2C5]	=3D imx7ulp_clk_composite("lpi2c5",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb0);
-	clks[IMX7ULP_CLK_LPUART4]	=3D imx7ulp_clk_composite("lpuart4", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb4);
-	clks[IMX7ULP_CLK_LPUART5]	=3D imx7ulp_clk_composite("lpuart5", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb8);
-	clks[IMX7ULP_CLK_FLEXIO1]	=3D imx7ulp_clk_composite("flexio1", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xc4);
-	clks[IMX7ULP_CLK_USB0]		=3D imx7ulp_clk_composite("usb0",    periph_plat_=
sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xcc);
-	clks[IMX7ULP_CLK_USB1]		=3D imx7ulp_clk_composite("usb1",    periph_plat_=
sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xd0);
+	clks[IMX7ULP_CLK_LPTPM4]	=3D imx7ulp_clk_hw_composite("lptpm4",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPTPM5]	=3D imx7ulp_clk_hw_composite("lptpm5",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPIT1]		=3D imx7ulp_clk_hw_composite("lpit1",   periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	clks[IMX7ULP_CLK_LPSPI2]	=3D imx7ulp_clk_hw_composite("lpspi2",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa4);
+	clks[IMX7ULP_CLK_LPSPI3]	=3D imx7ulp_clk_hw_composite("lpspi3",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa8);
+	clks[IMX7ULP_CLK_LPI2C4]	=3D imx7ulp_clk_hw_composite("lpi2c4",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xac);
+	clks[IMX7ULP_CLK_LPI2C5]	=3D imx7ulp_clk_hw_composite("lpi2c5",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb0);
+	clks[IMX7ULP_CLK_LPUART4]	=3D imx7ulp_clk_hw_composite("lpuart4", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb4);
+	clks[IMX7ULP_CLK_LPUART5]	=3D imx7ulp_clk_hw_composite("lpuart5", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb8);
+	clks[IMX7ULP_CLK_FLEXIO1]	=3D imx7ulp_clk_hw_composite("flexio1", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xc4);
+	clks[IMX7ULP_CLK_USB0]		=3D imx7ulp_clk_hw_composite("usb0",    periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xcc);
+	clks[IMX7ULP_CLK_USB1]		=3D imx7ulp_clk_hw_composite("usb1",    periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xd0);
 	clks[IMX7ULP_CLK_USB_PHY]	=3D imx_clk_hw_gate("usb_phy", "nic1_bus_clk", =
base + 0xd4, 30);
-	clks[IMX7ULP_CLK_USDHC0]	=3D imx7ulp_clk_composite("usdhc0",  periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xdc);
-	clks[IMX7ULP_CLK_USDHC1]	=3D imx7ulp_clk_composite("usdhc1",  periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xe0);
-	clks[IMX7ULP_CLK_WDG1]		=3D imx7ulp_clk_composite("wdg1",    periph_bus_s=
els, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xf4);
-	clks[IMX7ULP_CLK_WDG2]		=3D imx7ulp_clk_composite("sdg2",    periph_bus_s=
els, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0x10c);
+	clks[IMX7ULP_CLK_USDHC0]	=3D imx7ulp_clk_hw_composite("usdhc0",  periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xdc);
+	clks[IMX7ULP_CLK_USDHC1]	=3D imx7ulp_clk_hw_composite("usdhc1",  periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xe0);
+	clks[IMX7ULP_CLK_WDG1]		=3D imx7ulp_clk_hw_composite("wdg1",    periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xf4);
+	clks[IMX7ULP_CLK_WDG2]		=3D imx7ulp_clk_hw_composite("sdg2",    periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0x10c);
=20
 	imx_check_clk_hws(clks, clk_data->num);
=20
@@ -216,17 +216,17 @@ static void __init imx7ulp_clk_pcc3_init(struct devic=
e_node *np)
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
-	clks[IMX7ULP_CLK_LPTPM6]	=3D imx7ulp_clk_composite("lptpm6",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x84);
-	clks[IMX7ULP_CLK_LPTPM7]	=3D imx7ulp_clk_composite("lptpm7",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x88);
+	clks[IMX7ULP_CLK_LPTPM6]	=3D imx7ulp_clk_hw_composite("lptpm6",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x84);
+	clks[IMX7ULP_CLK_LPTPM7]	=3D imx7ulp_clk_hw_composite("lptpm7",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x88);
=20
 	clks[IMX7ULP_CLK_MMDC]		=3D clk_hw_register_gate(NULL, "mmdc", "nic1_clk"=
, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 							       base + 0xac, 30, 0, &imx_ccm_lock);
-	clks[IMX7ULP_CLK_LPI2C6]	=3D imx7ulp_clk_composite("lpi2c6",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x90);
-	clks[IMX7ULP_CLK_LPI2C7]	=3D imx7ulp_clk_composite("lpi2c7",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
-	clks[IMX7ULP_CLK_LPUART6]	=3D imx7ulp_clk_composite("lpuart6", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
-	clks[IMX7ULP_CLK_LPUART7]	=3D imx7ulp_clk_composite("lpuart7", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
-	clks[IMX7ULP_CLK_DSI]		=3D imx7ulp_clk_composite("dsi",     periph_bus_se=
ls, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xa4);
-	clks[IMX7ULP_CLK_LCDIF]		=3D imx7ulp_clk_composite("lcdif",   periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xa8);
+	clks[IMX7ULP_CLK_LPI2C6]	=3D imx7ulp_clk_hw_composite("lpi2c6",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x90);
+	clks[IMX7ULP_CLK_LPI2C7]	=3D imx7ulp_clk_hw_composite("lpi2c7",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPUART6]	=3D imx7ulp_clk_hw_composite("lpuart6", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPUART7]	=3D imx7ulp_clk_hw_composite("lpuart7", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	clks[IMX7ULP_CLK_DSI]		=3D imx7ulp_clk_hw_composite("dsi",     periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xa4);
+	clks[IMX7ULP_CLK_LCDIF]		=3D imx7ulp_clk_hw_composite("lcdif",   periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xa8);
=20
 	clks[IMX7ULP_CLK_VIU]		=3D imx_clk_hw_gate("viu",   "nic1_clk",	   base +=
 0xa0, 30);
 	clks[IMX7ULP_CLK_PCTLC]		=3D imx_clk_hw_gate("pctlc", "nic1_bus_clk", bas=
e + 0xb8, 30);
@@ -234,8 +234,8 @@ static void __init imx7ulp_clk_pcc3_init(struct device_=
node *np)
 	clks[IMX7ULP_CLK_PCTLE]		=3D imx_clk_hw_gate("pctle", "nic1_bus_clk", bas=
e + 0xc0, 30);
 	clks[IMX7ULP_CLK_PCTLF]		=3D imx_clk_hw_gate("pctlf", "nic1_bus_clk", bas=
e + 0xc4, 30);
=20
-	clks[IMX7ULP_CLK_GPU3D]		=3D imx7ulp_clk_composite("gpu3d",   periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
-	clks[IMX7ULP_CLK_GPU2D]		=3D imx7ulp_clk_composite("gpu2d",   periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
+	clks[IMX7ULP_CLK_GPU3D]		=3D imx7ulp_clk_hw_composite("gpu3d",   periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
+	clks[IMX7ULP_CLK_GPU2D]		=3D imx7ulp_clk_hw_composite("gpu2d",   periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
=20
 	imx_check_clk_hws(clks, clk_data->num);
=20
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 331f5ab..d6c65f0 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -202,7 +202,7 @@ struct clk_hw *imx_clk_hw_busy_mux(const char *name, vo=
id __iomem *reg, u8 shift
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char * const *parent_names, int num_parents);
=20
-struct clk_hw *imx7ulp_clk_composite(const char *name,
+struct clk_hw *imx7ulp_clk_hw_composite(const char *name,
 				     const char * const *parent_names,
 				     int num_parents, bool mux_present,
 				     bool rate_present, bool gate_present,
--=20
2.7.4

