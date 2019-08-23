Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B639AD16
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392169AbfHWK1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 06:27:35 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50830 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731002AbfHWK1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:27:35 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CEF3E200314;
        Fri, 23 Aug 2019 12:27:33 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 360BE20070E;
        Fri, 23 Aug 2019 12:27:29 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 44783402B3;
        Fri, 23 Aug 2019 18:27:23 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-devel@linux.nxdi.nxp.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, Wen He <wen.he_1@nxp.com>
Subject: [v1] arm64: dts: ls1028a: Remove some fixed-clock definiation
Date:   Fri, 23 Aug 2019 18:17:31 +0800
Message-Id: <20190823101731.12609-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace pclk/aclk/mclk fixed-clock clock provider with platform clockgen
pre-divider provider, those clocks should be driven by the CGA_PLL2/2.

More details please refer Reference Manual.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 024d6fbd07ea..0fa3e29cb603 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -90,20 +90,6 @@
 		clocks = <&osc_27m>;
 	};
 
-	aclk: clock-axi {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <650000000>;
-		clock-output-names= "aclk";
-	};
-
-	pclk: clock-apb {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <650000000>;
-		clock-output-names= "pclk";
-	};
-
 	reboot {
 		compatible ="syscon-reboot";
 		regmap = <&dcfg>;
@@ -885,7 +871,8 @@
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 223 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "DE", "SE";
-		clocks = <&dpclk>, <&aclk>, <&aclk>, <&pclk>;
+		clocks = <&dpclk>, <&clockgen 2 2>, <&clockgen 2 2>,
+			 <&clockgen 2 2>;
 		clock-names = "pxlclk", "mclk", "aclk", "pclk";
 		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
 		arm,malidp-arqos-value = <0xd000d000>;
-- 
2.17.1

