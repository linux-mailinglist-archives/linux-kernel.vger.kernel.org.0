Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96370FB06E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 13:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfKMMZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 07:25:24 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:47362
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfKMMZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:25:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoLgUAiiM/O8UW8m2nVdmSUIW0YWkOLSLh5Y6F5laMmXzZonDqiLBxfkrq+DR1++6PKJ5teXnMXOohUrK49ScpCAUpHXDe1XoPQJ4VoUzekth3aDFDP8ystRnhyJZr2TRl7+lVmzp9qVW/8VXGRVHrVFtUbkCqtwRgPx5ll7lNInlMd5XPCG1z134ej7GX5ZrnCVd6+8V95iXI5ozRtrP5GgMHYzEhulkKCRlbHGaKB3CEC6xdrCrllqhmpQOoiV3lwdKg20+cQIbLThcsLDU/Px5ywhfzaPuqQBbj1KlRhKaxdWz/lw9LlSnBaDHWlwG449QgiL2q5XL/4dcv3jKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiCPVLPoPd62HIFYqSRX44JE/Zmcu6NsCRTi5VFraLU=;
 b=emQHZuXa/k4ovSdMvlOBZWxnoy9AYqXz1SiiaGvmiW9MrRQ0V5lo5xLtd9+SxVTsor3ox2KexutwDOOlZJC/KY2NXfMc8f0MWGEoOrJQykbGm8MGXn2Iyly3YADvriT8Zv+tFyR5OgkRWtDIxfkC+ysipD+GIPKRGa3RxKbNvHaUMK0meAWg6vN/kB/wVcrbfHQZkI+SYaz8MN0rpHOjQxOplEDjEjRCpQ+ytGghQsPcjK/8mXrcZCWHGN4JAkCqBUKwJZKVBJK9zEKVxnmMXfgpAuDOg0/Ow9WmTZZLAgh5twXUmHHo0ACoDVwpXfoRLUeBAR+ohv2xiTkQL1Zk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiCPVLPoPd62HIFYqSRX44JE/Zmcu6NsCRTi5VFraLU=;
 b=JPKJz8jm2M3nabG02btXm5kTuC8d33r6aQxo+me44dSdpjZJNiL6Wr/VNqd9uF7qfkUR8CJ3ir7wKy3jJ3ib15akV3anzNKwy79RflqwhVfLdXy+vg01SLUrPXayvZJomiDlfscsyyb4DVtSu4gW77foZUiUcx4pLju8uv8z9bE=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4499.eurprd04.prod.outlook.com (52.135.151.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Wed, 13 Nov 2019 12:25:14 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 12:25:14 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH 2/3] clk: imx8qxp: Add ADMA clocks
Thread-Topic: [PATCH 2/3] clk: imx8qxp: Add ADMA clocks
Thread-Index: AQHVmh1m/CD8hexFlUOApoZF4kzv+Q==
Date:   Wed, 13 Nov 2019 12:25:14 +0000
Message-ID: <1573647909-31081-2-git-send-email-abel.vesa@nxp.com>
References: <1573647909-31081-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1573647909-31081-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:208:15::27) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b93f1e2-5781-4236-300e-08d7683488c4
x-ms-traffictypediagnostic: AM0PR04MB4499:|AM0PR04MB4499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB449947015B398804CE12349EF6760@AM0PR04MB4499.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(446003)(486006)(44832011)(2616005)(71200400001)(66446008)(66476007)(102836004)(76176011)(86362001)(6506007)(386003)(71190400001)(64756008)(256004)(6512007)(476003)(66066001)(5660300002)(36756003)(66946007)(11346002)(4326008)(66556008)(6636002)(6436002)(26005)(186003)(2906002)(7736002)(110136005)(8676002)(52116002)(99286004)(8936002)(316002)(478600001)(54906003)(14454004)(6116002)(3846002)(50226002)(25786009)(6486002)(305945005)(81156014)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4499;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u8IBLKrLuvDlNx3ywwC0UJRRf+cu8bKqmogsendfB0hOCBRW0WKSzOi86XtJxMY7yNBpOYHKZ4OIlZv3PK2KMuGoMnYHxSppo55k9vjqiVe5tkX/cfaOUZBZgTamQe9j68wewfhDjJncnfNSkyEiRUXkcmssjGujBbpWFh2mXmtjnjlABSgh5w0CTuuAh3Qj+bvbhaFgPmu/XHOVUddsuA7GjTkZOylt0/97I6z2knCgKAUYLHhoZ3DT0udwjBSdS3fAyYRBQSr8jSnZuO1N+aE1DV/uO3ZvvEqHdxcY3QDKc4WLHWt/AOkquhR5YzAbCE/roFPXI8q4eKmfWqlZ6M8god1w3E2pmMH3mEkpoH6YCn1t5WM89vkCGCsEXk62Lyqoc56Nsk4CGvl87pnLZ4lSh9PXSCZcybqogxAUV9ukblWQcxfFrpITN6V3hmB3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b93f1e2-5781-4236-300e-08d7683488c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:25:14.1309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fz+2Tox06KR5BeXHRwA0tyZkp5/pZUi6YKQ/j7tiVrq2Af01ckHcIMIq5hrKJ3gQ22gva2mSZC7k/l0NWHKK8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the RM, the Audio and DMA (ADMA) subsystem is a collection
of audio peripherals and some system modules.
Register all the ADMA specific clocks through the LPCG and CCM driver.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 42 ++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk-imx8qxp.c      |  8 ++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8q=
xp-lpcg.c
index c0aff7c..78a9064 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -77,6 +77,48 @@ static const struct imx8qxp_lpcg_data imx8qxp_lpcg_adma[=
] =3D {
 	{ IMX_ADMA_LPCG_DSP_IPG_CLK, "dsp_lpcg_ipg_clk", "dma_ipg_clk_root", 0, A=
DMA_HIFI_LPCG, 20, 0, },
 	{ IMX_ADMA_LPCG_DSP_ADB_CLK, "dsp_lpcg_adb_clk", "dma_ipg_clk_root", 0, A=
DMA_HIFI_LPCG, 16, 0, },
 	{ IMX_ADMA_LPCG_OCRAM_IPG_CLK, "ocram_lpcg_ipg_clk", "dma_ipg_clk_root", =
0, ADMA_OCRAM_LPCG, 16, 0, },
+
+	{ IMX_ADMA_LPCG_AUD_PLL_DIV_CLK0_CLK, "aud_pll_div_clk0_lpcg_clk", "audio=
_pll_div_clk0_clk", 0, ADMA_PLL_CLK0_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_AUD_PLL_DIV_CLK1_CLK, "aud_pll_div_clk1_lpcg_clk", "audio=
_pll_div_clk1_clk", 0, ADMA_PLL_CLK1_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_AUD_REC_CLK0_CLK, "aud_rec_clk0_lpcg_clk", "audio_rec_clk=
0_clk", 0, ADMA_REC_CLK0_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_AUD_REC_CLK1_CLK, "aud_rec_clk1_lpcg_clk", "audio_rec_clk=
1_clk", 0, ADMA_REC_CLK1_LPCG, 0, 0, },
+
+	{ IMX_ADMA_LPCG_AMIX_IPG_CLK, "amix_lpcg_ipg_clk", "dma_ipg_clk_root", 0,=
 ADMA_AMIX_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_ESAI_0_IPG_CLK, "esai0_lpcg_ipg_clk", "dma_ipg_clk_root",=
 0, ADMA_ESAI_0_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_ESAI_0_EXTAL_CLK, "esai0_lpcg_extal_clk", "acm_esai0_mclk=
_sel", 0, ADMA_ESAI_0_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_SAI_0_IPG_CLK, "sai0_lpcg_ipg_clk", "dma_ipg_clk_root", 0=
, ADMA_SAI_0_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_SAI_0_MCLK, "sai0_lpcg_mclk", "acm_sai0_mclk_sel", 0, ADM=
A_SAI_0_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_SAI_1_IPG_CLK, "sai1_lpcg_ipg_clk", "dma_ipg_clk_root", 0=
, ADMA_SAI_1_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_SAI_1_MCLK, "sai1_lpcg_mclk", "acm_sai1_mclk_sel", 0, ADM=
A_SAI_1_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_SAI_2_IPG_CLK, "sai2_lpcg_ipg_clk", "dma_ipg_clk_root", 0=
, ADMA_SAI_2_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_SAI_3_MCLK, "sai2_lpcg_mclk", "acm_sai2_mclk_sel", 0, ADM=
A_SAI_2_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_SAI_3_IPG_CLK, "sai3_lpcg_ipg_clk", "dma_ipg_clk_root", 0=
, ADMA_SAI_3_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_SAI_3_MCLK, "sai3_lpcg_mclk", "acm_sai3_mclk_sel", 0, ADM=
A_SAI_3_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_SAI_4_IPG_CLK, "sai4_lpcg_ipg_clk", "dma_ipg_clk_root", 0=
, ADMA_SAI_4_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_SAI_4_MCLK, "sai4_lpcg_mclk", "acm_sai4_mclk_sel", 0, ADM=
A_SAI_4_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_SAI_5_IPG_CLK, "sai5_lpcg_ipg_clk", "dma_ipg_clk_root", 0=
, ADMA_SAI_5_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_SAI_5_MCLK, "sai5_lpcg_mclk", "acm_sai5_mclk_sel", 0, ADM=
A_SAI_5_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_MQS_IPG_CLK, "mqs_lpcg_ipg_clk", "dma_ipg_clk_root", 0, A=
DMA_MQS_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_MQS_MCLK, "mqs_lpcg_mclk", "acm_mqs_mclk_sel", 0, ADMA_MQ=
S_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_GPT5_IPG_CLK, "gpt5_lpcg_ipg_clk", "dma_ipg_clk_root", 0,=
 ADMA_GPT_5_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_GPT5_CLKIN, "gpt5_lpcg_clkin", "dma_ipg_clk_root", 0, ADM=
A_GPT_5_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_GPT6_IPG_CLK, "gpt6_lpcg_ipg_clk", "dma_ipg_clk_root", 0,=
 ADMA_GPT_6_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_GPT6_CLKIN, "gpt6_lpcg_clkin", "dma_ipg_clk_root", 0, ADM=
A_GPT_6_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_GPT7_IPG_CLK, "gpt7_lpcg_ipg_clk", "dma_ipg_clk_root", 0,=
 ADMA_GPT_7_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_GPT7_CLKIN, "gpt7_lpcg_clkin", "dma_ipg_clk_root", 0, ADM=
A_GPT_7_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_GPT8_IPG_CLK, "gpt8_lpcg_ipg_clk", "dma_ipg_clk_root", 0,=
 ADMA_GPT_8_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_GPT8_CLKIN, "gpt8_lpcg_clkin", "dma_ipg_clk_root", 0, ADM=
A_GPT_8_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_GPT9_IPG_CLK, "gpt9_lpcg_ipg_clk", "dma_ipg_clk_root", 0,=
 ADMA_GPT_9_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_GPT9_CLKIN, "gpt9_lpcg_clkin", "dma_ipg_clk_root", 0, ADM=
A_GPT_9_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_GPT10_IPG_CLK, "gpt10_lpcg_ipg_clk", "dma_ipg_clk_root", =
0, ADMA_GPT_10_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_GPT10_CLKIN, "gpt10_lpcg_clkin", "dma_ipg_clk_root", 0, A=
DMA_GPT_10_LPCG, 0, 0, },
+
+	{ IMX_ADMA_LPCG_MCLKOUT0, "mclkout0_lpcg", "acm_mclkout0_sel", 0, ADMA_MC=
LKOUT0_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_MCLKOUT1, "mclkout1_lpcg", "acm_mclkout1_sel", 0, ADMA_MC=
LKOUT1_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_SPDIF_0_GCLKW, "spdif0_lpcg_gclkw", "dma_ipg_clk_root", 0=
, ADMA_SPDIF_0_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_SPDIF_0_TX_CLK, "spdif0_lpcg_tx_clk", "acm_spdif0_mclk_se=
l", 0, ADMA_SPDIF_0_LPCG, 0, 0, },
+	{ IMX_ADMA_LPCG_ASRC_0_IPG_CLK, "asrc0_lpcg_ipg_clk", "dma_ipg_clk_root",=
 0, ADMA_ASRC_0_LPCG, 16, 0, },
+	{ IMX_ADMA_LPCG_ASRC_1_IPG_CLK, "asrc1_lpcg_ipg_clk", "dma_ipg_clk_root",=
 0, ADMA_ASRC_1_LPCG, 16, 0, },
 };
=20
 static const struct imx8qxp_ss_lpcg imx8qxp_ss_adma =3D {
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 5e2903e..5e92577 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -94,6 +94,14 @@ static int imx8qxp_clk_probe(struct platform_device *pde=
v)
 	clks[IMX_ADMA_PWM_CLK]		=3D imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0=
, IMX_SC_PM_CLK_PER);
 	clks[IMX_ADMA_LCD_CLK]		=3D imx_clk_scu("lcd_clk",   IMX_SC_R_LCD_0, IMX_=
SC_PM_CLK_PER);
=20
+	clks[IMX_ADMA_AUD_PLL0]		=3D imx_clk_scu("audio_pll0_clk", IMX_SC_R_AUDIO=
_PLL_0, IMX_SC_PM_CLK_PLL);
+	clks[IMX_ADMA_AUD_PLL1]		=3D imx_clk_scu("audio_pll1_clk", IMX_SC_R_AUDIO=
_PLL_1, IMX_SC_PM_CLK_PLL);
+
+	clks[IMX_ADMA_AUD_PLL_DIV_CLK0_CLK]	=3D imx_clk_scu("audio_pll_div_clk0_c=
lk", IMX_SC_R_AUDIO_PLL_0, IMX_SC_PM_CLK_MISC0);
+	clks[IMX_ADMA_AUD_PLL_DIV_CLK1_CLK]	=3D imx_clk_scu("audio_pll_div_clk1_c=
lk", IMX_SC_R_AUDIO_PLL_1, IMX_SC_PM_CLK_MISC0);
+	clks[IMX_ADMA_AUD_REC_CLK0_CLK]	=3D imx_clk_scu("audio_rec_clk0_clk", IMX=
_SC_R_AUDIO_PLL_0, IMX_SC_PM_CLK_MISC1);
+	clks[IMX_ADMA_AUD_REC_CLK1_CLK]	=3D imx_clk_scu("audio_rec_clk1_clk", IMX=
_SC_R_AUDIO_PLL_1, IMX_SC_PM_CLK_MISC1);
+
 	/* Connectivity */
 	clks[IMX_CONN_SDHC0_CLK]	=3D imx_clk_scu("sdhc0_clk", IMX_SC_R_SDHC_0, IM=
X_SC_PM_CLK_PER);
 	clks[IMX_CONN_SDHC1_CLK]	=3D imx_clk_scu("sdhc1_clk", IMX_SC_R_SDHC_1, IM=
X_SC_PM_CLK_PER);
--=20
2.7.4

