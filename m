Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C634A180547
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCJRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgCJRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:14 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0BDC2146E;
        Tue, 10 Mar 2020 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583862432;
        bh=yEVqSVzjSrlW03t5Uobt/12zNzyYOKdExRRlDrrKUNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTwcoteXlhPI4lyJgviLHnEf8uRhovlKa30fr68qYMQc7fzq1uwEH+p9V9FeXUJ8X
         2QMS5aUIecXbxGl3iy/hAhJohWHqWu0j3BCBmYCliTQr1jPww21H2QRiOr8xlyqsPT
         /iTc2G5/PKwqhFXOdMqXThGDDjftjDjkrUtREdnA=
Received: by wens.tw (Postfix, from userid 1000)
        id 14A9960308; Wed, 11 Mar 2020 01:47:10 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: sun8i: r40: Move SPI device nodes based on address order
Date:   Wed, 11 Mar 2020 01:47:09 +0800
Message-Id: <20200310174709.24174-4-wens@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310174709.24174-1-wens@kernel.org>
References: <20200310174709.24174-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

When the SPI device nodes were added, they were added in the wrong
location in the device tree file. The device nodes should be sorted
by register address.

Move the devices node to their correct positions within the file.

Fixes: 554581b79139 ("ARM: dts: sun8i: R40: Add SPI controllers nodes and pinmuxes")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 104 +++++++++++++++----------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 81cc92ddc78b..f0ede4f52aa3 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -198,6 +198,32 @@ nmi_intc: interrupt-controller@1c00030 {
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		spi0: spi@1c05000 {
+			compatible = "allwinner,sun8i-r40-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c05000 0x1000>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@1c06000 {
+			compatible = "allwinner,sun8i-r40-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c06000 0x1000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		csi0: csi@1c09000 {
 			compatible = "allwinner,sun8i-r40-csi0",
 				     "allwinner,sun7i-a20-csi0";
@@ -307,6 +333,19 @@ crypto: crypto@1c15000 {
 			resets = <&ccu RST_BUS_CE>;
 		};
 
+		spi2: spi@1c17000 {
+			compatible = "allwinner,sun8i-r40-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c17000 0x1000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI2>, <&ccu CLK_SPI2>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		ahci: sata@1c18000 {
 			compatible = "allwinner,sun8i-r40-ahci";
 			reg = <0x01c18000 0x1000>;
@@ -364,6 +403,19 @@ ohci2: usb@1c1c400 {
 			status = "disabled";
 		};
 
+		spi3: spi@1c1f000 {
+			compatible = "allwinner,sun8i-r40-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c1f000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI3>, <&ccu CLK_SPI3>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI3>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		ccu: clock@1c20000 {
 			compatible = "allwinner,sun8i-r40-ccu";
 			reg = <0x01c20000 0x400>;
@@ -692,58 +744,6 @@ i2c4: i2c@1c2c000 {
 			#size-cells = <0>;
 		};
 
-		spi0: spi@1c05000 {
-			compatible = "allwinner,sun8i-r40-spi",
-				     "allwinner,sun8i-h3-spi";
-			reg = <0x01c05000 0x1000>;
-			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
-			clock-names = "ahb", "mod";
-			resets = <&ccu RST_BUS_SPI0>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		spi1: spi@1c06000 {
-			compatible = "allwinner,sun8i-r40-spi",
-				     "allwinner,sun8i-h3-spi";
-			reg = <0x01c06000 0x1000>;
-			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
-			clock-names = "ahb", "mod";
-			resets = <&ccu RST_BUS_SPI1>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		spi2: spi@1c17000 {
-			compatible = "allwinner,sun8i-r40-spi",
-				     "allwinner,sun8i-h3-spi";
-			reg = <0x01c17000 0x1000>;
-			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_SPI2>, <&ccu CLK_SPI2>;
-			clock-names = "ahb", "mod";
-			resets = <&ccu RST_BUS_SPI2>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		spi3: spi@1c1f000 {
-			compatible = "allwinner,sun8i-r40-spi",
-				     "allwinner,sun8i-h3-spi";
-			reg = <0x01c1f000 0x1000>;
-			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_SPI3>, <&ccu CLK_SPI3>;
-			clock-names = "ahb", "mod";
-			resets = <&ccu RST_BUS_SPI3>;
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
-- 
2.25.1

