Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF089B01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 12:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfHLKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 06:12:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56136 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbfHLKMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:12:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C3D01A02B0;
        Mon, 12 Aug 2019 12:12:12 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 89F3A1A02E3;
        Mon, 12 Aug 2019 12:12:07 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0E0DE402D2;
        Mon, 12 Aug 2019 18:12:00 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leoyang.li@nxp.com, liviu.dudau@arm.com, Wen He <wen.he_1@nxp.com>
Subject: [v1 3/3] arm64: dts: ls1028a: Add properties node for Display output pixel clock
Date:   Mon, 12 Aug 2019 18:02:24 +0800
Message-Id: <20190812100224.34502-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1028A has a clock domain PXLCLK0 used for the Display output
interface in the display core, independent of the system bus frequency,
for flexible clock design. This display core has its own pixel clock.

This patch enable the pixel clock provider on the LS1028A.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 2d31e1c09e74..0c54ba3214af 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -70,11 +70,18 @@
 		clock-output-names = "sysclk";
 	};
 
-	dpclk: clock-dp {
+	osc_27m: clock-osc-27m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
-		clock-output-names= "dpclk";
+		clock-output-names = "phy_27m";
+	};
+
+	dpclk: clock-controller@f1f0000 {
+		compatible = "fsl,ls1028a-plldig";
+		reg = <0x0 0xf1f0000 0x0 0xffff>;
+		#clock-cells = <1>;
+		clocks = <&osc_27m>;
 	};
 
 	aclk: clock-axi {
@@ -557,7 +564,7 @@
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 223 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "DE", "SE";
-		clocks = <&dpclk>, <&aclk>, <&aclk>, <&pclk>;
+		clocks = <&dpclk 0>, <&aclk>, <&aclk>, <&pclk>;
 		clock-names = "pxlclk", "mclk", "aclk", "pclk";
 		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
 		arm,malidp-arqos-value = <0xd000d000>;
-- 
2.17.1

