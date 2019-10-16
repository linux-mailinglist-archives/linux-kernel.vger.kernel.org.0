Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7ECDD85CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 04:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390031AbfJPCRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 22:17:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39434 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389292AbfJPCRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:17:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B2A4020093F;
        Wed, 16 Oct 2019 04:17:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 68038200880;
        Wed, 16 Oct 2019 04:17:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 331BE40314;
        Wed, 16 Oct 2019 10:17:04 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        jun.li@nxp.com, ping.bai@nxp.com, daniel.baluta@nxp.com,
        leonard.crestez@nxp.com, daniel.lezcano@linaro.org,
        l.stach@pengutronix.de, ccaione@baylibre.com, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, jon@solid-run.com, baruch@tkos.co.il,
        angus@akkea.ca, pavel@ucw.cz, agx@sigxcpu.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        dafna.hirschfeld@collabora.com, richard.hu@technexion.com,
        andradanciu1997@gmail.com, manivannan.sadhasivam@linaro.org,
        aisheng.dong@nxp.com, peng.fan@nxp.com, fugang.duan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/5] arm64: dts: imx8mm: Move usdhc clocks assignment to board DT
Date:   Wed, 16 Oct 2019 10:14:25 +0800
Message-Id: <1571192067-19600-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
References: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usdhc's clock rate is different according to different devices
connected, so clock rate assignment should be placed in board
DT according to different devices connected on each usdhc port.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi    | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index faefb71..ac91f6d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -293,6 +293,8 @@
 };
 
 &usdhc2 {
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
@@ -304,6 +306,8 @@
 };
 
 &usdhc3 {
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
+	assigned-clock-rates = <400000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 8aafad2..9258150 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -698,8 +698,6 @@
 					 <&clk IMX8MM_CLK_NAND_USDHC_BUS>,
 					 <&clk IMX8MM_CLK_USDHC1_ROOT>;
 				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX8MM_CLK_USDHC1>;
-				assigned-clock-rates = <400000000>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
 				bus-width = <4>;
@@ -728,8 +726,6 @@
 					 <&clk IMX8MM_CLK_NAND_USDHC_BUS>,
 					 <&clk IMX8MM_CLK_USDHC3_ROOT>;
 				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
-				assigned-clock-rates = <400000000>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
 				bus-width = <4>;
-- 
2.7.4

