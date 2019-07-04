Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDDAF5F68F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 12:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfGDKYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 06:24:38 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48774 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfGDKYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:24:38 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 82D8A1A0597;
        Thu,  4 Jul 2019 12:24:36 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 76B121A0581;
        Thu,  4 Jul 2019 12:24:36 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EAC24205D9;
        Thu,  4 Jul 2019 12:24:35 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] arm64: dts: imx8mq: Default parents for PCIE1 clocks
Date:   Thu,  4 Jul 2019 13:24:24 +0300
Message-Id: <1562235864-12953-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set default parents for PCIE1_CTRL and PCIE1_PHY clocks.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index e3df9b8..23bf85f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -235,6 +235,10 @@
 		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
 		 <&pcie0_refclk>;
 	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+	assigned-clocks = <&clk IMX8MQ_CLK_PCIE1_CTRL>,
+			  <&clk IMX8MQ_CLK_PCIE1_PHY>;
+	assigned-clock-parents = <&clk IMX8MQ_SYS2_PLL_250M>,
+				 <&clk IMX8MQ_SYS2_PLL_100M>;
 	status = "okay";
 };
 
-- 
2.7.4

