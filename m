Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EE1771C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 10:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgCCJDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 04:03:48 -0500
Received: from inva021.nxp.com ([92.121.34.21]:39904 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbgCCJDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:03:47 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C2DB201322;
        Tue,  3 Mar 2020 10:03:44 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BFAB201314;
        Tue,  3 Mar 2020 10:03:44 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F96320414;
        Tue,  3 Mar 2020 10:03:43 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 07/11] dt-bindings: clocks: imx8mp: Add ids for audiomix clocks
Date:   Tue,  3 Mar 2020 11:03:22 +0200
Message-Id: <1583226206-19758-8-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the clock ids for the audiomix clocks.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 include/dt-bindings/clock/imx8mp-clock.h | 62 ++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 47ab082..305433f 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -298,4 +298,66 @@
 
 #define IMX8MP_CLK_END				289
 
+#define IMX8MP_CLK_AUDIOMIX_SAI1_IPG		0
+#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1		1
+#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK2		2
+#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK3		3
+#define IMX8MP_CLK_AUDIOMIX_SAI2_IPG		4
+#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1		5
+#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK2		6
+#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK3		7
+#define IMX8MP_CLK_AUDIOMIX_SAI3_IPG		8
+#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1		9
+#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK2		10
+#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK3		11
+#define IMX8MP_CLK_AUDIOMIX_SAI5_IPG		12
+#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK1		13
+#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK2		14
+#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK3		15
+#define IMX8MP_CLK_AUDIOMIX_SAI6_IPG		16
+#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK1		17
+#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK2		18
+#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK3		19
+#define IMX8MP_CLK_AUDIOMIX_SAI7_IPG		20
+#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK1		21
+#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK2		22
+#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK3		23
+#define IMX8MP_CLK_AUDIOMIX_ASRC_IPG		24
+#define IMX8MP_CLK_AUDIOMIX_PDM_IPG		25
+#define IMX8MP_CLK_AUDIOMIX_SDMA2_ROOT		26
+#define IMX8MP_CLK_AUDIOMIX_SDMA3_ROOT		27
+#define IMX8MP_CLK_AUDIOMIX_SPBA2_ROOT		28
+#define IMX8MP_CLK_AUDIOMIX_DSP_ROOT		29
+#define IMX8MP_CLK_AUDIOMIX_DSPDBG_ROOT		30
+#define IMX8MP_CLK_AUDIOMIX_EARC_IPG		31
+#define IMX8MP_CLK_AUDIOMIX_OCRAMA_IPG		32
+#define IMX8MP_CLK_AUDIOMIX_AUD2HTX_IPG		33
+#define IMX8MP_CLK_AUDIOMIX_EDMA_ROOT		34
+#define IMX8MP_CLK_AUDIOMIX_AUDPLL_ROOT		35
+#define IMX8MP_CLK_AUDIOMIX_MU2_ROOT		36
+#define IMX8MP_CLK_AUDIOMIX_MU3_ROOT		37
+#define IMX8MP_CLK_AUDIOMIX_EARC_PHY		38
+#define IMX8MP_CLK_AUDIOMIX_PDM_ROOT		39
+#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1_SEL	40
+#define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK2_SEL	41
+#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1_SEL	42
+#define IMX8MP_CLK_AUDIOMIX_SAI2_MCLK2_SEL	43
+#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1_SEL	44
+#define IMX8MP_CLK_AUDIOMIX_SAI3_MCLK2_SEL	45
+#define IMX8MP_CLK_AUDIOMIX_SAI4_MCLK1_SEL	46
+#define IMX8MP_CLK_AUDIOMIX_SAI4_MCLK2_SEL	47
+#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK1_SEL	48
+#define IMX8MP_CLK_AUDIOMIX_SAI5_MCLK2_SEL	49
+#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK1_SEL	50
+#define IMX8MP_CLK_AUDIOMIX_SAI6_MCLK2_SEL	51
+#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK1_SEL	52
+#define IMX8MP_CLK_AUDIOMIX_SAI7_MCLK2_SEL	53
+#define IMX8MP_CLK_AUDIOMIX_PDM_SEL		54
+#define IMX8MP_CLK_AUDIOMIX_SAI_PLL_REF_SEL	55
+#define IMX8MP_CLK_AUDIOMIX_SAI_PLL		56
+#define IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS	57
+#define IMX8MP_CLK_AUDIOMIX_SAI_PLL_OUT		58
+
+#define IMX8MP_CLK_AUDIOMIX_END			59
+
 #endif
-- 
2.7.4

