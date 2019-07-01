Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD965504C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 15:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfFYN0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 09:26:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53564 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfFYN0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:26:39 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 850BD200BEC;
        Tue, 25 Jun 2019 15:26:37 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7461C20077B;
        Tue, 25 Jun 2019 15:26:37 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E7B6B2061E;
        Tue, 25 Jun 2019 15:26:36 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] arm64: dts: imx8mm: Init rates and parents configs for clocks
Date:   Tue, 25 Jun 2019 16:26:31 +0300
Message-Id: <1561469191-26840-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial configuration for clocks that need default parent and rate
setting. This is based on the vendor tree clock provider parents and rates
configuration except this is doing the setup in dts rather than using clock
consumer API in a clock provider driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 232a741..ab92108 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -451,6 +451,42 @@
 					 <&clk_ext3>, <&clk_ext4>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
 					      "clk_ext3", "clk_ext4";
+				assigned-clocks = <&clk IMX8MM_CLK_AUDIO_AHB>,
+						<&clk IMX8MM_CLK_IPG_AUDIO_ROOT>,
+						<&clk IMX8MM_SYS_PLL3>,
+						<&clk IMX8MM_VIDEO_PLL1>,
+						<&clk IMX8MM_CLK_NOC>,
+						<&clk IMX8MM_CLK_PCIE1_CTRL>,
+						<&clk IMX8MM_CLK_PCIE1_PHY>,
+						<&clk IMX8MM_CLK_CSI1_CORE>,
+						<&clk IMX8MM_CLK_CSI1_PHY_REF>,
+						<&clk IMX8MM_CLK_CSI1_ESC>,
+						<&clk IMX8MM_CLK_DISP_AXI>,
+						<&clk IMX8MM_CLK_DISP_APB>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>,
+						<0>,
+						<0>,
+						<0>,
+						<&clk IMX8MM_SYS_PLL3_OUT>,
+						<&clk IMX8MM_SYS_PLL2_250M>,
+						<&clk IMX8MM_SYS_PLL2_100M>,
+						<&clk IMX8MM_SYS_PLL2_1000M>,
+						<&clk IMX8MM_SYS_PLL2_1000M>,
+						<&clk IMX8MM_SYS_PLL1_800M>,
+						<&clk IMX8MM_SYS_PLL2_1000M>,
+						<&clk IMX8MM_SYS_PLL1_800M>;
+				assigned-clock-rates = <400000000>,
+							<400000000>,
+							<750000000>,
+							<594000000>,
+							<0>,
+							<0>,
+							<0>,
+							<0>,
+							<0>,
+							<0>,
+							<500000000>,
+							<200000000>;
 			};
 
 			src: reset-controller@30390000 {
-- 
2.7.4

