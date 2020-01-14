Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFC213A21C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 08:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgANH1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 02:27:35 -0500
Received: from mail-eopbgr20048.outbound.protection.outlook.com ([40.107.2.48]:38189
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728865AbgANH1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:27:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goUWKkEJ6drdYvd4PMPI9pAyiHy9qurZjyCfIGkzD+kKNvWPpSnW9FxwPzFPbHlLTno2NfqUoXLYedHbODdHDcsEb4QDkShKfa+KK5jKW+OotGfMFnizAW+nBbmWQBe1nB9Y+4tu495OsPOSxFO9zNxHmfTA19ZRlEGqlict/kvvxmsy3zb7hYh0jginoj3/acRk/rxA4DLfecJYMsMiBammvnpjOKO8K09iuD3E3mKS1Wd2Sh60hjuViamPsWbqozKmysY7iJN7IqIaCPNBM536Ufk6Ytmz8XQLKdWtjF7WEF0xQCiO+9QgwYvoHSxncRo8wlCHRosuceRnU6FKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK6yFKoFbv0aXo0ZRn+ZGh/E6xI672a2cOacdy+wb08=;
 b=S7NFtcCHt8koW5UEG7MPBrLZnTuKhiNwOyHqNSkzQQoj7aaIqABQtCFZifbZlmCMp78p6KtHrfvMJBgmuDunsXtgKD0B92JCgVAqw9rfGjokvOYR8sQf7FIjcAXKIrnPCTtduRufnDNBD3gI3hCyUXRFlZ4doreQHiP7lHMB5Z7XXZSyjTKBhMwqr6aCPv9KR1Wbx3lSG1mX+44x6dnqgTXHMl8k+ONvbpI5Nds5Xmi6HvBg3H4UxAnIwDGBuOgzpxs+LRIoZJLPqjIn3jc9KZKvqGgntaM2ve/nUNAssEoLZE8FtHTiEco27AUv1vh/de5+5n8BW1EpYnCEmUtHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK6yFKoFbv0aXo0ZRn+ZGh/E6xI672a2cOacdy+wb08=;
 b=AkhE2Axohwp/QBh0T0hu394qPcH+qvGQEpP9yYIGh7fTolSUytAY/Vev47Zhf4MsjkJ0k8EatAp0WXYXoE7MNdvPeIIEXmKdjOrUFUUSfGLYg/QkOIWLln6CaEZRFR6N1bJw0QKB0bzoiEuVF4JSTr97NoI64bQMTl+/e7HwPy0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6211.eurprd04.prod.outlook.com (20.179.34.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 14 Jan 2020 07:27:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 07:27:26 +0000
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 07:27:21 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/4] clk: imx: imx8mn: fix a53 cpu clock
Thread-Topic: [PATCH V2 3/4] clk: imx: imx8mn: fix a53 cpu clock
Thread-Index: AQHVyqwSB+4Euu8GwkSELrq47uqCZA==
Date:   Tue, 14 Jan 2020 07:27:26 +0000
Message-ID: <1578986576-6168-4-git-send-email-peng.fan@nxp.com>
References: <1578986576-6168-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1578986576-6168-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83580931-c581-4b51-d87d-08d798c33481
x-ms-traffictypediagnostic: AM0PR04MB6211:|AM0PR04MB6211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB62112F4D054AEC134147D36788340@AM0PR04MB6211.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(64756008)(66446008)(6512007)(26005)(66946007)(6486002)(956004)(2616005)(66556008)(52116002)(66476007)(6506007)(86362001)(110136005)(316002)(54906003)(2906002)(36756003)(44832011)(5660300002)(4326008)(478600001)(6636002)(186003)(16526019)(8676002)(81156014)(71200400001)(8936002)(69590400006)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6211;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vzYrGz/p5hznGH8rwd570iP7DPFMau1llCUPJdo9BJ+dQIh4ALEraArAikklT0851Cg+eKfOBfVKQeb6/rKxmX5Pl6enKzodBo2QgLOJWaUSv8AIIk3FGSLqHxfDFOq9G4CZ8tRyyQGLbO721wm+Cay+zkv85aeoN9U/b7qy0NgIIn6Goe1Bp55VS/pFdiXCufQNkLNsyARgPpAvYStLvoSYldDbD+cPkC3C9dBjnIw91xpYan/v50BM6xSE1YPf51z0Hjawo67aEt6wBP5FK/V0LqoQ9QcEJL1WAa/M2wX4lmYPRG5IQ2V1HyrXIudiJAQBgFDS965w/jyHIrBbEZLOpjohNlhuuYSwHc92Uxz0Puhb+RxbBUWaEDAYvcgWK9/SjfAytHGPST/KovgXuqts9vPLWfguYAwzYlOaDxKDugOpScayfz5prn5kw1uWXMMecLZDNxnNd+MniYKHQZIaxn1FIKBMskd30XSnKRdfEb15our4ild0Atf69zebBWju62hkW1E9WanH87GlA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83580931-c581-4b51-d87d-08d798c33481
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 07:27:26.9370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkZIcpGDEoD5HdVN3tUgF0TLzYj1OemOJPPLdUJS4Yrg2zjq9F+bqwx5v+K3+LG3P4hzSPWPC++G6I2R5gZ3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root
signoff timing is 1Ghz, however the A53 core which sources from CCM
root could run above 1GHz which voilates the CCM.

There is a CORE_SEL slice before A53 core, we need configure the
CORE_SEL slice source from ARM PLL, not A53 CCM clk root.

The A53 CCM clk root should only be used when need to change ARM PLL
frequency.

Add arm_a53_core clk that could source from arm_a53_div and arm_pll_out.
Configure a53 ccm root sources from 800MHz sys pll
Configure a53 core sources from arm_pll_out
Mark arm_a53_core as critical clk.

Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/clk/imx/clk-imx8mn.c             | 16 ++++++++++++----
 include/dt-bindings/clock/imx8mn-clock.h |  4 +++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index ce2ba3dce483..01c1034834fc 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -40,6 +40,8 @@ static const char * const imx8mn_a53_sels[] =3D {"osc_24m=
", "arm_pll_out", "sys_pl
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
=20
+static const char * const imx8mn_a53_core_sels[] =3D {"arm_a53_div", "arm_=
pll_out", };
+
 static const char * const imx8mn_gpu_core_sels[] =3D {"osc_24m", "gpu_pll_=
out", "sys_pll1_800m",
 						    "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
 						    "video_pll1_out", "audio_pll2_out", };
@@ -419,6 +421,9 @@ static int imx8mn_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MN_CLK_GPU_CORE_DIV] =3D imx8m_clk_hw_composite_core("gpu_core_di=
v", imx8mn_gpu_core_sels, base + 0x8180);
 	hws[IMX8MN_CLK_GPU_SHADER_DIV] =3D imx8m_clk_hw_composite_core("gpu_shade=
r_div", imx8mn_gpu_shader_sels, base + 0x8200);
=20
+	/* CORE SEL */
+	hws[IMX8MN_CLK_A53_CORE] =3D imx_clk_hw_mux2_flags("arm_a53_core", base +=
 0x9880, 24, 1, imx8mn_a53_core_sels, ARRAY_SIZE(imx8mn_a53_core_sels), CLK=
_IS_CRITICAL);
+
 	/* BUS */
 	hws[IMX8MN_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
imx8mn_main_axi_sels, base + 0x8800);
 	hws[IMX8MN_CLK_ENET_AXI] =3D imx8m_clk_hw_composite("enet_axi", imx8mn_en=
et_axi_sels, base + 0x8880);
@@ -547,11 +552,14 @@ static int imx8mn_clocks_probe(struct platform_device=
 *pdev)
=20
 	hws[IMX8MN_CLK_DRAM_ALT_ROOT] =3D imx_clk_hw_fixed_factor("dram_alt_root"=
, "dram_alt", 1, 4);
=20
-	hws[IMX8MN_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_div",
-					   hws[IMX8MN_CLK_A53_DIV]->clk,
-					   hws[IMX8MN_CLK_A53_SRC]->clk,
+	clk_hw_set_parent(hws[IMX8MN_CLK_A53_SRC], hws[IMX8MN_SYS_PLL1_800M]);
+	clk_hw_set_parent(hws[IMX8MN_CLK_A53_CORE], hws[IMX8MN_ARM_PLL_OUT]);
+
+	hws[IMX8MN_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_core",
+					   hws[IMX8MN_CLK_A53_CORE]->clk,
+					   hws[IMX8MN_CLK_A53_CORE]->clk,
 					   hws[IMX8MN_ARM_PLL_OUT]->clk,
-					   hws[IMX8MN_SYS_PLL1_800M]->clk);
+					   hws[IMX8MN_CLK_A53_DIV]->clk);
=20
 	imx_check_clk_hws(hws, IMX8MN_CLK_END);
=20
diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings=
/clock/imx8mn-clock.h
index 0f2b8423ce1d..7ec4c24d6e06 100644
--- a/include/dt-bindings/clock/imx8mn-clock.h
+++ b/include/dt-bindings/clock/imx8mn-clock.h
@@ -228,6 +228,8 @@
 #define IMX8MN_SYS_PLL2_333M_CG			209
 #define IMX8MN_SYS_PLL2_500M_CG			210
=20
-#define IMX8MN_CLK_END				211
+#define IMX8MN_CLK_A53_CORE			211
+
+#define IMX8MN_CLK_END				212
=20
 #endif
--=20
2.16.4

