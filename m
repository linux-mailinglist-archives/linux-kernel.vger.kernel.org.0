Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D466CBD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbfGRJYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 05:24:33 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41458 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfGRJYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:24:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 78B741A011D;
        Thu, 18 Jul 2019 11:24:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 333E41A00EE;
        Thu, 18 Jul 2019 11:24:24 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6FD70402CF;
        Thu, 18 Jul 2019 17:24:17 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/4] ARM: dts: imx6sl: move GIC to right location in DT
Date:   Thu, 18 Jul 2019 17:15:06 +0800
Message-Id: <20190718091508.3248-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190718091508.3248-1-Anson.Huang@nxp.com>
References: <20190718091508.3248-1-Anson.Huang@nxp.com>
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
 arch/arm/boot/dts/imx6sl.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index b36fc01..3a96b55 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -77,15 +77,6 @@
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
 	clocks {
 		ckil {
 			compatible = "fixed-clock";
@@ -133,6 +124,15 @@
 			clocks = <&clks IMX6SL_CLK_OCRAM>;
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

