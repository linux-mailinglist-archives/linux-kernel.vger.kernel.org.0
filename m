Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A7E6CBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 11:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfGRJYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 05:24:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44656 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfGRJYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:24:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F98E200125;
        Thu, 18 Jul 2019 11:24:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1A58A20013E;
        Thu, 18 Jul 2019 11:24:23 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 58D3440296;
        Thu, 18 Jul 2019 17:24:16 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/4] ARM: dts: imx6sx: move GIC to right location in DT
Date:   Thu, 18 Jul 2019 17:15:05 +0800
Message-Id: <20190718091508.3248-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

GIC is inside of SoC from architecture perspective, it should
be located inside of soc node in DT.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index bb25add..fe00f9a 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -90,15 +90,6 @@
 		};
 	};
 
-	intc: interrupt-controller@a01000 {
-		compatible = "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x00a01000 0x1000>,
-		      <0x00a00100 0x100>;
-		interrupt-parent = <&intc>;
-	};
-
 	ckil: clock-ckil {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -181,6 +172,15 @@
 			clocks = <&clks IMX6SX_CLK_OCRAM>;
 		};
 
+		intc: interrupt-controller@a01000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x00a01000 0x1000>,
+			      <0x00a00100 0x100>;
+			interrupt-parent = <&intc>;
+		};
+
 		L2: l2-cache@a02000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x00a02000 0x1000>;
-- 
2.7.4

